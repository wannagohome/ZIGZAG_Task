//
//  ViewController.swift
//  Shop-List-Filter
//
//  Created by Peter Jang on 02/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import UIKit


class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var shopListCollectionView: UICollectionView!
    @IBOutlet var weekLabel: UILabel!
    
    
    var list: [[String:Any]] = [] {
        didSet {
            list = list.sorted(by: { $0["0"] as! Int > $1["0"] as! Int} )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopListCollectionView.delegate = self
        shopListCollectionView.dataSource = self
        setupNavigationBarTitle()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchJSON()
    }
    
    
    private func fetchJSON() {
        readJSONData { (result, err) in
            if let err = err { return print(err) }
            
            self.weekLabel.text = "     " + (result?.week)! + "주차 랭킹"
            self.list = filter((result?.list)!)
            
        }
        shopListCollectionView.reloadData()
    }
    
    
    private func setupNavigationBarTitle() {
        let image: UIImage = UIImage(named: "logo.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }

    
    private func readJSONData(completion: ((week: String, list: [[String:Any]])?, Error?) -> ()) -> () {
        guard let path = Bundle.main.path(forResource: "shop_list", ofType: "json") else {
            print("Invalid filename/path.")
            return completion(nil, nil)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            var json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
            
            return completion((json["week"] as! String, json["list"] as! [[String:Any]]), nil)
            
        } catch let error { return completion(nil, error) }
    }
    
    
    
    func filter(_ dic: [[String:Any]]) -> [[String:Any]] {
        var selectedAgeGroup = UserDefaults.standard.array(forKey: "Age")  as? [Int] ?? [Int]()
        if selectedAgeGroup.count == 0 { selectedAgeGroup = [0,1,2,3,4,5,6] }
        var filteredList: [[String:Any]] = []
        
        
        // 선택한 연령대의 shop들을 list에 추가
        for store in dic {
            let intArray = store["A"] as! [Int]
            for index in selectedAgeGroup {
                if intArray[index] == 1 {
                    filteredList.append(store)
                    break
                }
            }
        }
        
        let selectedStyleGroup = UserDefaults.standard.array(forKey: "Style")  as? [String] ?? [String]()
        
        if selectedStyleGroup.count == 0 {
            return filteredList
        }
        
        // 선택하지 않은 스타일의 shop들을 list에서 제거
        var index = 0
        for store in filteredList {
            let storeStyle = store["S"] as! String
            var isMatch: Bool = false
            for selectedStyle in selectedStyleGroup {
                if storeStyle.contains(selectedStyle) {
                    isMatch = true
                }
            }
            if isMatch == false {
                filteredList.remove(at: index)
            }
            index += 1
        }
        return filteredList
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopListCell", for: indexPath) as! ShopListCell
        cell.list = list[indexPath.row]
        cell.rank.text = String(indexPath.row + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
