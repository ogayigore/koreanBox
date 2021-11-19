//
//  AuthenticationViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 22.10.2021.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class AuthenticationViewController: UIViewController {

    //MARK:- Properties
    
    var phoneNumber: String?
    var listController: FPNCountryListViewController!
    
    //MARK:- Private Properties
    
    private lazy var customView = view as! AuthenticationView
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = AuthenticationView()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.numberTextField.delegate = self
        configureView()
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        }

    //MARK:- Methods
    
    private func configureView() {
        customView.fetchCodeButton.addTarget(self, action:  #selector(fetchButtonPressed), for: .touchUpInside)
        
        listController = FPNCountryListViewController(style: .grouped)
        listController.setup(repository: customView.numberTextField.countryRepository)
        listController.didSelect = { country in
            self.customView.numberTextField.setFlag(countryCode: country.code)
        }
    }
    
    @objc func fetchButtonPressed() {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        print("fetchButtonPressed()")
        guard phoneNumber != nil else { return }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { verificationID, error in
            
            if error != nil {
                print("ERROR")
                print(error?.localizedDescription ?? "is empty")
            } else {
                self.showValidateCodeVC(verificationID: verificationID!)
            }
            
        }
    }
    
    private func showValidateCodeVC(verificationID: String) {
        let validateVC = ValidateCodeViewController()
        validateVC.verificationID = verificationID
        validateVC.modalPresentationStyle = .fullScreen
        self.present(validateVC, animated: true, completion: nil)
    }
}

//MARK:- FPNTextFieldDelegate

extension AuthenticationViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            customView.fetchCodeButton.alpha = 1
            customView.fetchCodeButton.isEnabled = true
            
            phoneNumber = customView.numberTextField.getFormattedPhoneNumber(format: .International)
        } else {
            customView.fetchCodeButton.alpha = 0.5
            customView.fetchCodeButton.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        customView.numberTextField.text = ""
        customView.fetchCodeButton.alpha = 0.5
        customView.fetchCodeButton.isEnabled = false
        self.present(navigationController, animated: true)
    }
    
}

