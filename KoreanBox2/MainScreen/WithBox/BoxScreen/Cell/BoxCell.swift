//
//  BoxCell.swift
//  KoreanBox
//
//  Created by Igor Ogai on 28.10.2021.
//

import UIKit
import Foundation
import RealmSwift
import Kingfisher

protocol BoxCellDelegate: AnyObject {
    func plusPressed(product: ProductRealm)
    func minusPressed(product: ProductRealm)
    func changeCostButtonPressed(product: ProductRealm, cost: Int)
}

class BoxCell: UITableViewCell {
    
    //MARK:- Public Properties
    
    weak var delegate: BoxCellDelegate?
    static var reuseIdentifier = "boxCell"
    
    //MARK:- Private Properties
    
    private var realm = try! Realm()
    private var count = 1
    private var product: ProductRealm?
    private var isEdit = false
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var changeCostButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .regular, scale: .large) ), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена за единицу:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var costTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.backgroundColor = .white
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .none
        textField.keyboardType = .numberPad
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var totalCost: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK:- Public Methods
    
    func configure(productModel: ProductRealm) {
        let imageURL = URL(string: productModel.imageURL)
        
        product = productModel
        let totalCostProduct = productModel.count * productModel.cost
        
        backgroundColor = .white
        
        productImage.kf.setImage(with: imageURL)
        nameLabel.text = productModel.name
        numberValueLabel.text = "\(productModel.number)"
        costTextField.text = "\(productModel.cost)"
        countLabel.text = "\(productModel.count)"
        totalCost.text = "\(totalCostProduct)"
        
        if productModel.count == 1 {
            minusButton.isEnabled = false
            minusButton.alpha = 0.5
        }
        
        plusButton.addTarget(self, action: #selector(plusPressed), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusPressed), for: .touchUpInside)
        changeCostButton.addTarget(self, action: #selector(changePressed), for: .touchUpInside)
        
        costTextField.delegate = self
    }
    
    //MARK:- Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: BoxProductCell.reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Private Methods
    
    private func setup() {
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(numberValueLabel)
        contentView.addSubview(countStackView)
        countStackView.addArrangedSubview(minusButton)
        countStackView.addArrangedSubview(countLabel)
        countStackView.addArrangedSubview(plusButton)
        contentView.addSubview(changeCostButton)
        contentView.addSubview(costLabel)
        contentView.addSubview(costTextField)
        contentView.addSubview(totalCost)
        
        NSLayoutConstraint.activate([
            productImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            minusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor),
            plusButton.heightAnchor.constraint(equalTo: minusButton.heightAnchor),
            plusButton.widthAnchor.constraint(equalTo: minusButton.widthAnchor),
            countLabel.heightAnchor.constraint(equalTo: minusButton.heightAnchor),
            countLabel.widthAnchor.constraint(equalTo: minusButton.widthAnchor),
            numberLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            numberValueLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 5),
            numberValueLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            costLabel.leftAnchor.constraint(equalTo: numberLabel.leftAnchor),
            costLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5),
            costTextField.leftAnchor.constraint(equalTo: costLabel.rightAnchor, constant: 5),
            costTextField.centerYAnchor.constraint(equalTo: costLabel.centerYAnchor),
            costTextField.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            countStackView.leftAnchor.constraint(equalTo: costLabel.leftAnchor),
            countStackView.topAnchor.constraint(equalTo: changeCostButton.bottomAnchor, constant: 10),
            countStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            changeCostButton.leftAnchor.constraint(equalTo: costTextField.rightAnchor, constant: 8),
            changeCostButton.centerYAnchor.constraint(equalTo: costTextField.centerYAnchor),
            changeCostButton.heightAnchor.constraint(equalToConstant: 50),
            changeCostButton.widthAnchor.constraint(equalToConstant: 50),
            changeCostButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            totalCost.centerYAnchor.constraint(equalTo: countStackView.centerYAnchor),
            totalCost.leftAnchor.constraint(greaterThanOrEqualTo: costLabel.rightAnchor, constant: 10),
            totalCost.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
    }
    
    @objc private func plusPressed() {
        delegate?.plusPressed(product: product!)
        count = product!.count
        countLabel.text = "\(count)"
        totalCost.text = "\((product!.cost * count))"
        if count == 2 {
            minusButton.isEnabled = true
            minusButton.alpha = 1
        }
    }
    
    @objc private func minusPressed() {
        delegate?.minusPressed(product: product!)
        count = product!.count
        countLabel.text = "\(count)"
        totalCost.text = "\((product!.cost * count))"
        if count == 1 {
            minusButton.isEnabled = false
            minusButton.alpha = 0.5
        }
    }
    
    @objc private func changePressed() {
        if isEdit {
            editCost()
            
        } else {
            costTextField.isUserInteractionEnabled = true
            costTextField.borderStyle = .roundedRect
            costTextField.backgroundColor = .lightGray
            isEdit = true
            costTextField.becomeFirstResponder()
        }
    }
    
    private func editCost() {
        costTextField.isUserInteractionEnabled = false
        costTextField.borderStyle = .none
        costTextField.backgroundColor = .none
        isEdit = false
        let newCost = Int(costTextField.text!)!
        delegate?.changeCostButtonPressed(product: product!, cost: newCost)
        count = product!.count
        totalCost.text = "\((newCost * count))"
    }
}

//MARK:- UITextFieldDelegate

extension BoxCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == costTextField {
            editCost()
        }
    }
}
