//
//  ShopListCell.swift
//  Shop-List-Filter
//
//  Created by Peter Jang on 03/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class ShopListCell: UICollectionViewCell {
    @IBOutlet var rank: UILabel!
    @IBOutlet var shopName: UILabel!
    @IBOutlet var shopListImageView: UIImageView!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var styleLabel: UILabel!
    
    private var shopStyle: Shop = Shop()
    
    
    var list: [String:Any]? {
        didSet {
            shopStyle = Shop()
            
            var homepage: String = ""
            var imageURL: String = ""
            
            shopName.text = list!["n"] as? String
            homepage = list!["u"] as! String
            
            imageURL = getImageURL(homepage)
            setShopImage(imageURL)
            
            let ageGroup: [Int] = list!["A"] as! [Int]
            let style: String = list!["S"] as! String
            
            setAgeGroup(ageGroup)
            showAgeGroup()
            
            showStyle(style)
        }
    }
    
    
    private func getImageURL(_ homepage: String) -> String {
        var domain = homepage.split(separator: ".").map{ String($0) }[0]
        var fileName: String = ""
        
        if domain.last == "w" {
            fileName = homepage.split(separator: ".").map{ String($0) }[1] + ".jpg"
        } else {
            domain = (domain as NSString).substring(from: 7)
            fileName = domain + ".jpg"
        }
        return "https://cf.shop.s.zigzag.kr/images/" + fileName
    }
    
    
    private func setShopImage(_ url: String?) {
        
        shopListImageView.image = nil
        
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            shopListImageView.image = image
        } else {
            URLSession.shared.dataTask(with: URL(string: url!)!, completionHandler: {(data, response, error) in
                
                if error != nil { return }
                
                let image = UIImage(data: data!)
                
                imageCache.setObject(image ?? UIImage(), forKey: url as AnyObject)
                
                DispatchQueue.main.async {
                    self.shopListImageView.image = image
                }
            }).resume()
        }
        
//        shopListImageView.kf.setImage(with: url)
        shopListImageView.clipsToBounds = true
        shopListImageView.layer.cornerRadius = shopListImageView.bounds.width / 2
    }
    
    
    private func showAgeGroup() {
        var ageString: String = ""
        
        shopStyle.ageGroup.forEach{ ageString += " " + $0.rawValue }
        
        ageString += " "
        ageLabel.text = ageString
        
        ageLabel.layer.cornerRadius = 5
        ageLabel.layer.borderWidth = 0.5
    }
    
    
    private func setAgeGroup(_ array: [Int]) {
        if array[0] == 1{
            shopStyle.ageGroup.append(Shop.AgeGroup.Teen)
        }
        if array[1] == 1 || array[2] == 1 || array[3] == 3 {
            shopStyle.ageGroup.append(Shop.AgeGroup.Twenty)
        }
        if array[4] == 1 || array[5] == 1 || array[6] == 3 {
            shopStyle.ageGroup.append(Shop.AgeGroup.Thirty)
        }
    }
    
    
    private func showStyle(_ style: String) {
        var styleString: String = ""
        
        Shop.Style.allCases.forEach{
            if style.contains($0.rawValue) {
                styleString += $0.rawValue
                shopStyle.styles.append($0)
            }
        }
        setAttribution(styleString)
    }
    
    
    private func setAttribution(_ styleString: String) {
        let attributedString = NSMutableAttributedString(string: styleString)
        
        for shopStyle in shopStyle.styles {
            let range = styleString.nsRange(of: styleString.range(of: shopStyle.rawValue)!)
            attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: shopStyle.getColor(), range: range)
        }
        
        styleLabel.attributedText = attributedString
        styleLabel.layer.cornerRadius = 5
        
    }
}
