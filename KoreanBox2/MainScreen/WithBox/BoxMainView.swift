//
//  BoxMainView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 25.10.2021.
//

import UIKit

class BoxMainView: UIView {
    
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
    
    private(set) lazy var boxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "shippingbox", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .large)), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return  button
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
        
        addSubview(nettoLabel)
        addSubview(nettoValueLabel)
        addSubview(boxButton)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            boxButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            boxButton.leftAnchor.constraint(greaterThanOrEqualTo: nettoValueLabel.rightAnchor, constant: 30),
            boxButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            nettoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            nettoLabel.centerYAnchor.constraint(equalTo: boxButton.centerYAnchor),
            nettoValueLabel.centerYAnchor.constraint(equalTo: nettoLabel.centerYAnchor),
            nettoValueLabel.leftAnchor.constraint(equalTo: nettoLabel.rightAnchor, constant: 5),
            tableView.topAnchor.constraint(equalTo: boxButton.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
