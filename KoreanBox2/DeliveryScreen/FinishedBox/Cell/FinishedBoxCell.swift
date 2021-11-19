//
//  FinishedBoxCell.swift
//  KoreanBox
//
//  Created by Igor Ogai on 12.11.2021.
//

import UIKit

class FinishedBoxCell: UITableViewCell {
    
    //MARK:- Public Properties
    
    static var reuseIdentifier = "FinishedBoxCell"
    
    //MARK:- Private Properties
    
    private var product: Product?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
    
    private lazy var countCostStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK:- Public Methods
    
    func configure(productModel: Product) {
        
        product = productModel
        let totalCostProduct = productModel.count * productModel.cost
        
        backgroundColor = .white
        
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
        
        countCostStackView.addArrangedSubview(countCostLabel)
        countCostStackView.addArrangedSubview(totalCost)

        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(numberValueLabel)
        contentView.addSubview(countCostStackView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            numberLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            numberValueLabel.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            numberValueLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 5),
            countCostStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countCostStackView.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 8),
            countCostStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ])
    }
}
