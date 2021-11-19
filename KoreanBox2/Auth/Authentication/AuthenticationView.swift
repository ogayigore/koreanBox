//
//  AuthenticationView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 22.10.2021.
//

import UIKit
import FlagPhoneNumber

class AuthenticationView: UIView {
    
    //MARK:- Private Properties
    
    private(set) lazy var numberTextField: FPNTextField = {
        let textField = FPNTextField()
        textField.setFlag(key: .RU)
        textField.flagButtonSize = CGSize(width: 60, height: 60)
        textField.hasPhoneNumberExample = false
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        textField.placeholder = " Введите номер"
        textField.textColor = .white
        textField.tintColor = .white
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 35
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .phonePad
        textField.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private(set) lazy var fetchCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить код", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.layer.cornerRadius = 35
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK:- Initializers
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private Methods
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(numberTextField)
        addSubview(fetchCodeButton)
        
        NSLayoutConstraint.activate([
            numberTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberTextField.heightAnchor.constraint(equalToConstant: 70),
            numberTextField.widthAnchor.constraint(equalToConstant: 300),
            numberTextField.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            numberTextField.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16),
            fetchCodeButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 8),
            fetchCodeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            fetchCodeButton.heightAnchor.constraint(equalToConstant: 70),
            fetchCodeButton.widthAnchor.constraint(equalToConstant: 300),
            fetchCodeButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            fetchCodeButton.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16)
        ])
        
        fetchCodeButton.alpha = 0.5
        fetchCodeButton.isEnabled = false
        
        numberTextField.displayMode = .list
        
    }
    
}

