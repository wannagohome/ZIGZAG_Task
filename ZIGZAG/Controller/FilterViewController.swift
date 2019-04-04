//
//  FilterViewController.swift
//  Shop-List-Filter
//
//  Created by Peter Jang on 02/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet var ageButton0: UIButton!
    @IBOutlet var ageButton1: UIButton!
    @IBOutlet var ageButton2: UIButton!
    @IBOutlet var ageButton3: UIButton!
    @IBOutlet var ageButton4: UIButton!
    @IBOutlet var ageButton5: UIButton!
    @IBOutlet var ageButton6: UIButton!
    
    
    @IBOutlet var styleButton0: UIButton!
    @IBOutlet var styleButton1: UIButton!
    @IBOutlet var styleButton2: UIButton!
    @IBOutlet var styleButton3: UIButton!
    @IBOutlet var styleButton4: UIButton!
    @IBOutlet var styleButton5: UIButton!
    @IBOutlet var styleButton6: UIButton!
    @IBOutlet var styleButton7: UIButton!
    @IBOutlet var styleButton8: UIButton!
    @IBOutlet var styleButton9: UIButton!
    @IBOutlet var styleButton10: UIButton!
    @IBOutlet var styleButton11: UIButton!
    @IBOutlet var styleButton12: UIButton!
    @IBOutlet var styleButton13: UIButton!
    
    var selectedAgeGroup: [Int] = UserDefaults.standard.array(forKey: "Age")  as? [Int] ?? [Int]()
    var selectedStyleGroup: [String] = UserDefaults.standard.array(forKey: "Style")  as? [String] ?? [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setupButtons() {
        let buttons: [UIButton] = [ageButton0, ageButton1, ageButton2, ageButton3, ageButton4, ageButton5, ageButton6,
                                   styleButton0, styleButton1, styleButton2, styleButton3, styleButton4, styleButton5,
                                   styleButton6, styleButton7, styleButton8, styleButton9, styleButton10, styleButton11,
                                   styleButton12, styleButton13]
        var index = 0
        for button in buttons {
            button.layer.borderColor = button.titleLabel?.textColor.cgColor
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 5
            if index < 7 {
                if selectedAgeGroup.contains(button.tag) {
                    button.isSelected = true
                    button.backgroundColor = UIColor(red: 112/255, green: 190/255, blue: 194/255, alpha: 1)
                }
            } else {
                if selectedStyleGroup.contains((button.titleLabel?.text)!) {
                    button.isSelected = true
                    button.backgroundColor = UIColor(red: 213/255, green: 57/255, blue: 100/255, alpha: 1)
                }
            }
            index += 1
        }
    }
    
    
    @IBAction func pressAgeButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            button.backgroundColor = UIColor(red: 112/255, green: 190/255, blue: 194/255, alpha: 1)
            selectedAgeGroup.append(button.tag)
        } else {
            button.backgroundColor = .white
            selectedAgeGroup.removeAll{$0 == button.tag}
        }
    }
    
    @IBAction func pressStyleButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            button.backgroundColor = UIColor(red: 213/255, green: 57/255, blue: 100/255, alpha: 1)
            selectedStyleGroup.append((button.titleLabel?.text)!)
        } else {
            button.backgroundColor = .white
            selectedStyleGroup.removeAll{$0 == button.titleLabel?.text}
        }
    }
    
    @IBAction func apply(_ sender: Any) {
        UserDefaults.standard.set(selectedAgeGroup, forKey: "Age")
        UserDefaults.standard.set(selectedStyleGroup, forKey: "Style")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
