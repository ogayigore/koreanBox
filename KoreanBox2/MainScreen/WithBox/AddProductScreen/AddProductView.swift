//
//  AddProductView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 04.11.2021.
//

import UIKit

class AddProductView: UIView {
    
    //MARK:- Private Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название:"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var nameTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var compositionLabel: UILabel = {
        let label = UILabel()
        label.text = "Состав:"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var compositionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private(set) lazy var weigthLabel: UILabel = {
        let label = UILabel()
        label.text = "Масса:"
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var bruttoTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textField.adjustsFontSizeToFitWidth = true
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "Брутто в граммах", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private(set) lazy var nettoTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textField.adjustsFontSizeToFitWidth = true
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "Нетто в граммах", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.layoutMargins.left = 5
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private(set) lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
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
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        addSubview(UIView(frame: .zero))
        addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextView)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(compositionLabel)
        scrollView.addSubview(compositionTextView)
        scrollView.addSubview(weigthLabel)
        scrollView.addSubview(bruttoTextField)
        scrollView.addSubview(nettoTextField)
        scrollView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8),
            nameTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            nameTextView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            nameTextView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8),
            nameTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
            nameTextView.heightAnchor.constraint(equalToConstant: 100),
            descriptionLabel.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: nameTextView.leftAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 2),
            descriptionTextView.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor),
            descriptionTextView.rightAnchor.constraint(equalTo: nameTextView.rightAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: nameTextView.widthAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            compositionLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 8),
            compositionLabel.leftAnchor.constraint(equalTo: descriptionTextView.leftAnchor),
            compositionTextView.topAnchor.constraint(equalTo: compositionLabel.bottomAnchor, constant: 2),
            compositionTextView.leftAnchor.constraint(equalTo: compositionLabel.leftAnchor),
            compositionTextView.rightAnchor.constraint(equalTo: descriptionTextView.rightAnchor),
            compositionTextView.widthAnchor.constraint(equalTo: descriptionTextView.widthAnchor),
            compositionTextView.heightAnchor.constraint(equalTo: descriptionTextView.heightAnchor),
            weigthLabel.topAnchor.constraint(equalTo: compositionTextView.bottomAnchor, constant: 8),
            weigthLabel.leftAnchor.constraint(equalTo: compositionTextView.leftAnchor),
            bruttoTextField.topAnchor.constraint(equalTo: weigthLabel.bottomAnchor, constant: 2),
            bruttoTextField.leftAnchor.constraint(equalTo: weigthLabel.leftAnchor),
            bruttoTextField.rightAnchor.constraint(equalTo: compositionTextView.rightAnchor),
            bruttoTextField.widthAnchor.constraint(equalTo: compositionTextView.widthAnchor),
            bruttoTextField.heightAnchor.constraint(equalToConstant: 30),
            nettoTextField.topAnchor.constraint(equalTo: bruttoTextField.bottomAnchor, constant: 8),
            nettoTextField.leftAnchor.constraint(equalTo: bruttoTextField.leftAnchor),
            nettoTextField.rightAnchor.constraint(equalTo: bruttoTextField.rightAnchor),
            nettoTextField.widthAnchor.constraint(equalTo: bruttoTextField.widthAnchor),
            nettoTextField.heightAnchor.constraint(equalTo: bruttoTextField.heightAnchor),
            addButton.topAnchor.constraint(equalTo: nettoTextField.bottomAnchor, constant: 16),
            addButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])
    }
}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
