//
//  BoxSettingsView.swift
//  KoreanBox
//
//  Created by Igor Ogai on 16.11.2021.
//

import UIKit

class BoxSettingsView: UIView {
    
    //MARK:- Private Properties
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recipientLabel: UILabel = {
        let label = UILabel()
        label.text = "Получатель"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var recipientNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Статус"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var shippedLabel: UILabel = {
        let label = UILabel()
        label.text = "Бокс отправлен"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var shippedSwitch: UISwitch = {
        let shippedSwitch = UISwitch()
        shippedSwitch.onTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        shippedSwitch.translatesAutoresizingMaskIntoConstraints = false
        return shippedSwitch
    }()
    
    private lazy var recivedLabel: UILabel = {
        let label = UILabel()
        label.text = "Бокс получен"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var recivedSwitch: UISwitch = {
        let shippedSwitch = UISwitch()
        shippedSwitch.onTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        shippedSwitch.translatesAutoresizingMaskIntoConstraints = false
        return shippedSwitch
    }()
    
    private(set) lazy var recipientView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var dropButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowtriangle.down.circle.fill"), for: .normal)
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
        
        backgroundView.addSubview(recipientLabel)
        backgroundView.addSubview(recipientView)
        backgroundView.addSubview(statusLabel)
        backgroundView.addSubview(statusView)
        
        recipientView.addSubview(recipientNameLabel)
        recipientView.addSubview(dropButton)
        
        statusView.addSubview(shippedLabel)
        statusView.addSubview(shippedSwitch)
        statusView.addSubview(separatorView)
        statusView.addSubview(recivedLabel)
        statusView.addSubview(recivedSwitch)
        
        addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipientLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            recipientLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 32),
            recipientView.topAnchor.constraint(equalTo: recipientLabel.bottomAnchor, constant: 5),
            recipientView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16),
            recipientView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -16),
            recipientNameLabel.topAnchor.constraint(equalTo: recipientView.topAnchor, constant: 16),
            recipientNameLabel.leftAnchor.constraint(equalTo: recipientView.leftAnchor, constant: 16),
            recipientNameLabel.bottomAnchor.constraint(equalTo: recipientView.bottomAnchor, constant: -16),
            dropButton.centerYAnchor.constraint(equalTo: recipientNameLabel.centerYAnchor),
            dropButton.heightAnchor.constraint(equalTo: recipientNameLabel.heightAnchor),
            dropButton.widthAnchor.constraint(equalTo: dropButton.heightAnchor),
            dropButton.leftAnchor.constraint(equalTo: recipientNameLabel.rightAnchor, constant: 5),
            dropButton.rightAnchor.constraint(equalTo: recipientView.rightAnchor, constant: -16),
            statusLabel.topAnchor.constraint(equalTo: recipientView.bottomAnchor, constant: 16),
            statusLabel.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 32),
            statusView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16),
            statusView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -16),
            shippedLabel.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 16),
            shippedLabel.leftAnchor.constraint(equalTo: statusView.leftAnchor, constant: 16),
            shippedSwitch.centerYAnchor.constraint(equalTo: shippedLabel.centerYAnchor),
            shippedSwitch.rightAnchor.constraint(equalTo: statusView.rightAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.topAnchor.constraint(equalTo: shippedLabel.bottomAnchor, constant: 16),
            separatorView.leftAnchor.constraint(equalTo: statusView.leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: statusView.rightAnchor),
            recivedLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 16),
            recivedLabel.leftAnchor.constraint(equalTo: shippedLabel.leftAnchor),
            recivedLabel.bottomAnchor.constraint(equalTo: statusView.bottomAnchor, constant: -16),
            recivedSwitch.centerYAnchor.constraint(equalTo: recivedLabel.centerYAnchor),
            recivedSwitch.rightAnchor.constraint(equalTo: shippedSwitch.rightAnchor)
        ])
    }
}
