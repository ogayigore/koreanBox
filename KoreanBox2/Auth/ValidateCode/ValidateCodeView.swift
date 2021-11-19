//
//  ValidateCodeView.swift
//  MedDesktop
//
//  Created by Igor Ogai on 02.07.2021.
//

import UIKit

class ValidateCodeView: UIView {
    
    //MARK:- Private Properties
    
    private(set) lazy var codeTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.textColor = .white
        textView.tintColor = .white
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 35
        textView.layer.borderColor = UIColor.black.cgColor
        textView.keyboardType = .numberPad
        textView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 45)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Введите код"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Проверить код", for: .normal)
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
        
        addSubview(codeTextView)
        addSubview(label)
        addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            codeTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            codeTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            codeTextView.heightAnchor.constraint(equalToConstant: 70),
            codeTextView.widthAnchor.constraint(equalToConstant: 300),
            codeTextView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            codeTextView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16),
            checkButton.topAnchor.constraint(equalTo: codeTextView.bottomAnchor, constant: 8),
            checkButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkButton.heightAnchor.constraint(equalToConstant: 70),
            checkButton.widthAnchor.constraint(equalToConstant: 300),
            checkButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            checkButton.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 70),
            label.widthAnchor.constraint(equalToConstant: 300),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: codeTextView.topAnchor, constant: 8)
        ])
        
        checkButton.alpha = 0.5
        checkButton.isEnabled = false
    }
    
}
