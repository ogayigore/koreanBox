//
//  FormBoxCell.swift
//  KoreanBox
//
//  Created by Igor Ogai on 09.11.2021.
//

import UIKit
import RealmSwift

class FormBoxCell: UITableViewCell {
    
    //MARK:- Public Properties
    
    static var reuseIdentifier = "formBoxCell"
    
    //MARK:- Private Properties
    
    private var product: ProductRealm?
    
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
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.numberOfLines = 0
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
    
    private lazy var countCostLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
//        let imageURL = URL(string: productModel.imageURL)
        
        product = productModel
        let totalCostProduct = productModel.count * productModel.cost
        
        backgroundColor = .white
        
//        productImage.kf.setImage(with: imageURL)
        nameLabel.text = productModel.name
        numberValueLabel.text = "\(productModel.number)"
        countCostLabel.text = "\(productModel.count)X\(productModel.cost)"
        totalCost.text = "\(totalCostProduct)"

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
//        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(numberValueLabel)
        contentView.addSubview(countCostLabel)
        contentView.addSubview(totalCost)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            numberLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            numberValueLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            numberValueLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 5),
            countCostLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countCostLabel.leftAnchor.constraint(greaterThanOrEqualTo: nameLabel.rightAnchor, constant: 5),
            totalCost.centerYAnchor.constraint(equalTo: countCostLabel.centerYAnchor),
            totalCost.leftAnchor.constraint(equalTo: countCostLabel.rightAnchor, constant: 8),
            totalCost.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ])
    }
}
