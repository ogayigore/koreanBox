//
//  ProductCell.swift
//  KoreanBox
//
//  Created by Igor Ogai on 01.11.2021.
//

import UIKit
import Foundation
import Kingfisher

class ProductCell: UITableViewCell {
    
    //MARK:- Public Properties
    
    static var reuseIdentifier = "productCell"
    var dbService: DatabaseService!
    
    //MARK:- Private Properties
    
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
        label.minimumScaleFactor = 0.5
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bruttoLabel: UILabel = {
        let label = UILabel()
        label.text = "Брутто:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bruttoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nettoLabel: UILabel = {
        let label = UILabel()
        label.text = "Нетто:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nettoValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numberValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 14)
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
        labelStackView.addArrangedSubview(bruttoLabel)
        labelStackView.addArrangedSubview(nettoLabel)
        labelStackView.addArrangedSubview(numberLabel)
        valueStackView.addArrangedSubview(bruttoValueLabel)
        valueStackView.addArrangedSubview(nettoValueLabel)
        valueStackView.addArrangedSubview(numberValueLabel)
        
        NSLayoutConstraint.activate([
            productImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            productImage.widthAnchor.constraint(equalTo: productImage.heightAnchor),
            productImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            labelStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            labelStackView.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            valueStackView.topAnchor.constraint(equalTo: labelStackView.topAnchor),
            valueStackView.leftAnchor.constraint(equalTo: labelStackView.rightAnchor, constant: 8),
            valueStackView.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor)
        ])
    }
}
