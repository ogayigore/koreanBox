//
//  DeliveryBoxCell.swift
//  KoreanBox
//
//  Created by Igor Ogai on 11.11.2021.
//

import UIKit

class DeliveryBoxCell: UITableViewCell {
    
    //MARK:- Public Properties
    
    static var reuseIdentifier = "deliveryBoxCell"
    
    //MARK:- Private Properties
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 16)
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
    
    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Вес:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weightValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buildDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата сборки:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buildDateValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Статус:"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) lazy var valuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK:- Public Methods
    
    func configure(boxModel: Box) {
        
        backgroundColor = .white
        
        numberValueLabel.text = "\(boxModel.number)"
        weightValueLabel.text = "\(boxModel.weightNetto / 1000) кг"
        buildDateValueLabel.text = "\(boxModel.buildDate)"
        statusValueLabel.text = "Не отправлен"
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
        contentView.addSubview(labelsStackView)
        contentView.addSubview(valuesStackView)
        
        labelsStackView.addArrangedSubview(numberLabel)
        labelsStackView.addArrangedSubview(weightLabel)
        labelsStackView.addArrangedSubview(buildDateLabel)
        labelsStackView.addArrangedSubview(statusLabel)
        valuesStackView.addArrangedSubview(numberValueLabel)
        valuesStackView.addArrangedSubview(weightValueLabel)
        valuesStackView.addArrangedSubview(buildDateValueLabel)
        valuesStackView.addArrangedSubview(statusValueLabel)
        
        contentView.addSubview(statusView)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            valuesStackView.centerYAnchor.constraint(equalTo: labelsStackView.centerYAnchor),
            valuesStackView.leftAnchor.constraint(equalTo: labelsStackView.rightAnchor, constant: 5),
            statusView.leftAnchor.constraint(greaterThanOrEqualTo: valuesStackView.rightAnchor, constant: 10),
            statusView.centerYAnchor.constraint(equalTo: valuesStackView.centerYAnchor),
            statusView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            statusView.heightAnchor.constraint(equalToConstant: 10),
            statusView.widthAnchor.constraint(equalTo: statusView.heightAnchor)
        ])
    }
}
