//
//  BoxProductCell.swift
//  KoreanBox
//
//  Created by Igor Ogai on 25.10.2021.
//

import UIKit
import Foundation
import Kingfisher

protocol BoxProductCellDelegate: AnyObject {
    func plusPressed()
    func minusPressed()
    func addButtonPressed(product: Product)
}

class BoxProductCell: UITableViewCell {
    
    //MARK:- Public Properties
    
    var dbService: DatabaseService?
    weak var delegate: BoxProductCellDelegate?
    static var reuseIdentifier = "boxProductCell"
    
    //MARK:- Private Properties
    
    private var count = 1
    private var product: Product?
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
//        label.textAlignment = .left
//        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bruttoLabel: UILabel = {
        let label = UILabel()
        label.text = "Брутто:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bruttoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nettoLabel: UILabel = {
        let label = UILabel()
        label.text = "Нетто:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nettoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12)
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
        button.isEnabled = false
        button.alpha = 0.5
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
    
    private(set) lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
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
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var countStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK:- Public Methods
    
    func configure(productModel: Product) {
        let imageURL = URL(string: productModel.imageURL)
        product = productModel
        
        backgroundColor = .white
        
        productImage.kf.setImage(with: imageURL)
        nameLabel.text = productModel.name
        bruttoValueLabel.text = "\(productModel.weightBrutto)"
        nettoValueLabel.text = "\(productModel.weightNetto)"
        numberValueLabel.text = "\(productModel.number)"
        countLabel.text = "\(count)"
        
        plusButton.addTarget(self, action: #selector(plusPressed), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusPressed), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
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
        contentView.addSubview(labelStackView)
        contentView.addSubview(valueStackView)
        contentView.addSubview(countStackView)
        contentView.addSubview(buttonsStackView)
        countStackView.addArrangedSubview(minusButton)
        countStackView.addArrangedSubview(countLabel)
        countStackView.addArrangedSubview(plusButton)
        labelStackView.addArrangedSubview(bruttoLabel)
        labelStackView.addArrangedSubview(nettoLabel)
        labelStackView.addArrangedSubview(numberLabel)
        valueStackView.addArrangedSubview(bruttoValueLabel)
        valueStackView.addArrangedSubview(nettoValueLabel)
        valueStackView.addArrangedSubview(numberValueLabel)
        buttonsStackView.addArrangedSubview(countStackView)
        buttonsStackView.addArrangedSubview(addButton)
        
        NSLayoutConstraint.activate([
            productImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 8),
            minusButton.heightAnchor.constraint(equalToConstant: 30),
            minusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor),
            plusButton.heightAnchor.constraint(equalTo: minusButton.heightAnchor),
            plusButton.widthAnchor.constraint(equalTo: minusButton.widthAnchor),
            countLabel.heightAnchor.constraint(equalTo: minusButton.heightAnchor),
            countLabel.widthAnchor.constraint(equalTo: minusButton.widthAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonsStackView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8),
            buttonsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            labelStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            labelStackView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            valueStackView.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            valueStackView.leftAnchor.constraint(equalTo: labelStackView.rightAnchor, constant: 8),
            valueStackView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor)
        ])
    }
    
    @objc private func plusPressed() {
        delegate?.plusPressed()
        if count >= 1 {
            count += 1
            countLabel.text = "\(count)"
            minusButton.isEnabled = true
            minusButton.alpha = 1
        }
    }
    
    @objc private func minusPressed() {
        delegate?.minusPressed()
        count -= 1
        countLabel.text = "\(count)"
        
        if count == 1 {
            minusButton.isEnabled = false
            minusButton.alpha = 0.5
        }
    }
    
    @objc private func addPressed() {
        delegate?.addButtonPressed(product: product!)
        count = 1
        countLabel.text = "\(count)"
        minusButton.isEnabled = false
        minusButton.alpha = 0.5
    }
}
