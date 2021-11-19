//
//  BoxView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 28.10.2021.
//

import Foundation

import UIKit

class BoxView: UIView {
    
    //MARK:- Private Properties
    
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
    
    private(set) lazy var listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.dash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return  button
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var valuseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        
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
        tableView.backgroundColor = .white
        
        addSubview(labelsStackView)
        addSubview(valuseStackView)
        labelsStackView.addArrangedSubview(nettoLabel)
        labelsStackView.addArrangedSubview(costLabel)
        valuseStackView.addArrangedSubview(nettoValueLabel)
        valuseStackView.addArrangedSubview(costValueLabel)
        addSubview(listButton)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            labelsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            valuseStackView.centerYAnchor.constraint(equalTo: labelsStackView.centerYAnchor),
            valuseStackView.leftAnchor.constraint(equalTo: labelsStackView.rightAnchor, constant: 5),
            listButton.centerYAnchor.constraint(equalTo: valuseStackView.centerYAnchor),
            listButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
