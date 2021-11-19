//
//  MoreView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 01.11.2021.
//

import UIKit

class MoreView: UIView {
    
    //MARK:- Private Properties
    
    private(set) lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти из аккаунта", for: .normal)
        button.tintColor = .red
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
        
        addSubview(logOutButton)
        
        NSLayoutConstraint.activate([
            logOutButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
