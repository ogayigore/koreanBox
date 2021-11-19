//
//  FormBoxView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 09.11.2021.
//

import UIKit

class FormBoxView: UIView {
    //MARK:- Private Properties
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Бокс собран!"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nettoLabel: UILabel = {
        let label = UILabel()
        label.text = "Нетто:"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var nettoValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0.000 кг"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость:"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var costValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var valuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        tableView.keyboardDismissMode = .onDrag
        
        addSubview(infoLabel)
        addSubview(closeButton)
        addSubview(labelsStackView)
        addSubview(valuesStackView)
        labelsStackView.addArrangedSubview(nettoLabel)
        labelsStackView.addArrangedSubview(costLabel)
        valuesStackView.addArrangedSubview(nettoValueLabel)
        valuesStackView.addArrangedSubview(costValueLabel)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            labelsStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            labelsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            valuesStackView.centerYAnchor.constraint(equalTo: labelsStackView.centerYAnchor),
            valuesStackView.leftAnchor.constraint(equalTo: labelsStackView.rightAnchor, constant: 5),
            tableView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
