//
//  BoxSettingsViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 16.11.2021.
//

import UIKit
import DropDown
import SPAlert

class BoxSettingsViewController: UIViewController {
    
    //MARK:- Public Properties
    
    var box: Box!
    weak var finishedBoxVC: FinishedBoxViewController?
    
    //MARK:- Private Properties
    
    private(set) lazy var customView = view as! BoxSettingsView
    private var dbService: DatabaseService!
    private var sent = false
    private var recived = false
    private var departureDate = ""
    private var recivedDate = ""
    private var recipients = [String]()
    private var recipient = ""
    
    private var dropDown: DropDown!
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = BoxSettingsView()
        self.title = "Настройки"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbService = DatabaseService()
        dropDown = DropDown()
        configure()
        dbService.getRecipients {
            self.recipients = self.dbService.recipientArray
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dropDown.dataSource = recipients
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        dropDown.anchorView = customView.recipientView
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            barButtonsConfigure()
            self.customView.recipientNameLabel.text = dropDown.dataSource[index]
            recipient = dropDown.dataSource[index]
        }
        
        customView.dropButton.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        
        customView.shippedSwitch.addTarget(self, action: #selector(shippedSwitchDidChanged(_:)), for: .valueChanged)
        customView.recivedSwitch.addTarget(self, action: #selector(recivedSwitchDidChanged(_:)), for: .valueChanged)
        
        if box.recipient == "" {
            customView.recipientNameLabel.text = "Выберите получателя"
        } else {
            customView.recipientNameLabel.text = "\(box.recipient)"
        }
        
        if box!.sent {
            customView.shippedSwitch.isOn = true
        } else {
            customView.shippedSwitch.isOn = false
            self.departureDate = ""
        }
        
        if box!.recived {
            customView.recivedSwitch.isOn = true
        } else {
            customView.recivedSwitch.isOn = false
            self.recivedDate = ""
        }
    }
    
    private func barButtonsConfigure() {
        let save = UIButton()
        save.setTitle("Сохранить", for: .normal)
        save.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: save)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func shippedSwitchDidChanged(_ sender: UISwitch!) {
        
        barButtonsConfigure()
        
        if sender.isOn {
            sent = true
        } else {
            sent = false
        }
    }
    
    @objc private func recivedSwitchDidChanged(_ sender: UISwitch!) {
        
        barButtonsConfigure()
        
        if sender.isOn {
            recived = true
        } else {
            recived = false
        }
    }
    
    @objc private func savePressed() {
        guard let docId = box?.docId,
              let number = box?.number,
              let weightNetto = box?.weightNetto,
              let cost = box?.weightNetto,
              let buildDate = box?.buildDate else { return }
        
        departureDate = getCurrentDate()
        recivedDate = getCurrentDate()
        
        let newBox = Box(docId: docId,
                         number: number,
                         weightNetto: weightNetto,
                         cost: Int(cost),
                         departureDate: departureDate,
                         recivedDate: recivedDate,
                         buildDate: buildDate,
                         sent: sent,
                         recived: recived,
                         recipient: recipient)
        
        dbService.addBox(boxDict: newBox.dictionary, box: newBox) { success in
            if success {
                print("OK")
            } else {
                print("ERROR")
            }
        }
        SPAlert.present(title: "Сохранено", preset: .done)
        finishedBoxVC?.box = newBox
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
    
    @objc private func didTapMenu() {
        dropDown!.show()
    }
}
