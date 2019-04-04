//
//  FunctionViewController.swift
//  Shop-List-Filter
//
//  Created by Peter Jang on 04/04/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import UIKit

class FunctionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var constraintContentHeight: NSLayoutConstraint!
    var activeField: UITextField?
    var lastOffset: CGPoint?
    var keyboardHeight: CGFloat?
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var dateIntervalTextVField: UITextField!
    
    @IBOutlet weak var bowlingTextField: UITextField!
    @IBOutlet weak var bowlingTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateTextField.delegate = self
        bowlingTextField.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() { view.endEditing(true) }
    
    @IBAction func testFunctions(_ sender: Any) {
        let button: UIButton = sender as! UIButton
        
        switch button.tag {
        case 1:
            dateTextView.text = testAlterDate()
        case 2:
            bowlingTextView.text = testBowling()
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1, 3:
            if (dateTextField.text?.count)! > 0 && (dateIntervalTextVField.text?.count)! > 0 {
                dateTextView.text = "Result : \(solve(timeString: dateTextField.text!, N: Int(dateIntervalTextVField.text!)!))"
            }
            
        case 2:
            if textField.text?.count == 0 { break }
            let bowling: Bowling = Bowling(input: textField.text!)
            bowlingTextView.text = "Result : \(bowling.calculate())"
            
        default:
            break
        }
    }
}
