//
//  ViewController.swift
//  ZIGZAG_task (shop-login)
//
//  Created by Peter Jang on 27/03/2019.
//  Copyright © 2019 Peter Jang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var constraintContentHeight: NSLayoutConstraint!
    var activeField: UITextField?
    var lastOffset: CGPoint?
    var keyboardHeight: CGFloat?
    
    @IBOutlet weak var loginStatusTextField: UITextView!
    @IBOutlet weak var loginNotiTextField: UITextView!
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var passwordIcon: UIImageView!
    
    @IBOutlet var agreementLabel: UILabel!
    @IBOutlet var agreementCheckButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var findIdButton: UIButton!
    @IBOutlet var agreementReadButton: UIButton!
    
    lazy var isUserAgreeWithAgreement = UserDefaults().bool(forKey: "agree")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIApplication.keyboardWillHideNotification, object: nil)
        
        
    }
    
    
    func setupViews() {
        if isUserAgreeWithAgreement {
            agreementLabel.removeFromSuperview()
            agreementCheckButton.removeFromSuperview()
        } else {
            agreementReadButton.removeFromSuperview()
        }
        
        userIdTextField.givePadding(width: 45)
        passwordTextField.givePadding(width: 45)
        userIdTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        
        loginIndicatorView.isHidden = true
        
        flowerImage.clipsToBounds = true
        flowerImage.layer.cornerRadius = 15
    }
    
    
    
    @objc func dismissKeyboard() { view.endEditing(true) }
    
    @IBAction func pressCheckButton(_ sender: Any) {
        agreementCheckButton.isSelected = !agreementCheckButton.isSelected
        
    }
    
    
    @IBAction func pressLoginButton(_ sender: Any) {
        
        switch checkLoginAvailable() {
        case Login.noId:
            showAlert(message: "아이디를 입력해 주세요")
            
        case Login.noPassword:
            showAlert(message: "비밀번호를 입력해 주세요")
            
        case Login.noAgreement:
            showAlert(message: "약관 동의가 필요합니다")
            
        case Login.available:
            tryLogin()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { self.loginSuccess() }
        }
        
    }
    
    
    func tryLogin() {
        flowerImage.alpha = 0.5
        passwordIcon.alpha = 0.5
        userIdTextField.alpha = 0.5
        passwordTextField.alpha = 0.5
        agreementLabel.alpha = 0.5
        agreementCheckButton.alpha = 0.5
        findIdButton.alpha = 0.5
        agreementReadButton.alpha = 0.5
        
        loginButton.setTitle("", for: .normal)
        
        loginStatusTextField.text = "로그인 중입니다.."
        loginNotiTextField.text = ""
        
        loginIndicatorView.isHidden = false
        loginIndicatorView.startAnimating()
    }
    
    
    
    
    func loginSuccess() {
        loginStatusTextField.text = "로그인 성공!"
        loginIndicatorView.stopAnimating()
        UserDefaults.standard.set(true, forKey: "agree")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.performSegue(withIdentifier: "unwind", sender: self)
        }
    }
    
    
    
    
    
    func checkLoginAvailable() -> Login  {
        if userIdTextField.text?.count == 0 { return Login.noId }
            
        else if passwordTextField.text?.count == 0 {return Login.noPassword }
            
        else if (agreementCheckButton.isSelected ||
            isUserAgreeWithAgreement) == false { return Login.noAgreement }
        
        return Login.available
    }
    
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alertMessage = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "확인", style: .cancel)
            
            alertMessage.addAction(confirmAction)
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
    
    
}


class InitialViewController: UIViewController {
    @IBAction func unwindSegue (segue : UIStoryboardSegue) {}
    
    @IBAction func initializeAgreement(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "agree")
    }
    
}



