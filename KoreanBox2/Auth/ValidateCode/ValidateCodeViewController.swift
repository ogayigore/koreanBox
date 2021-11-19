//
//  ValidateCodeViewController.swift
//  MedDesktop
//
//  Created by Igor Ogai on 02.07.2021.
//

import UIKit
import FirebaseAuth

class ValidateCodeViewController: UIViewController {
    
    //MARK:- Properties
    
    var verificationID: String!
    var phoneNumber: String!
    
    //MARK:- Private Properties
    
    private lazy var customView = view as! ValidateCodeView
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = ValidateCodeView()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK:- Methods
    
    private func configureView() {
        
        self.customView.codeTextView.delegate = self
        customView.checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
    }
    
    @objc func checkButtonPressed() {
        guard let code = customView.codeTextView.text else { return }
        let credentional = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        Auth.auth().signIn(with: credentional) { _, error in
            if error != nil {
                self.customView.codeTextView.text = ""
                self.customView.codeTextView.layer.borderColor = UIColor.red.cgColor
                self.customView.label.text = "Неверный код"
                self.customView.label.textColor = .red
            } else {
                self.showMainVC()
            }
        }

    }
    
    private func showMainVC() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
}

//MARK:- UITextViewDelegate
extension ValidateCodeViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLenght = currentCharacterCount + text.count - range.length
        return newLenght <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if self.customView.codeTextView.text?.count == 6 {
            self.customView.checkButton.alpha = 1
            self.customView.checkButton.isEnabled = true
        } else {
            self.customView.checkButton.alpha = 0.5
            self.customView.checkButton.isEnabled = false
        }
    }
    
}
