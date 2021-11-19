//
//  FinishedBoxViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 12.11.2021.
//

import UIKit
import SPAlert

class FinishedBoxViewController: UIViewController {
    
    //MARK:- Public Properties
    
    var box: Box!
    
    //MARK:- Private Properties
    
    private(set) lazy var customView = view as! FinishedBoxView
    private var dbService: DatabaseService!
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = FinishedBoxView()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Бокс \(box.number)"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dbService = DatabaseService()
        configure()
        barButtonsConfigure()
        dbService.getBoxProducts(box: box) {
            DispatchQueue.main.async {
                self.customView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(FinishedBoxCell.self, forCellReuseIdentifier: FinishedBoxCell.reuseIdentifier)
        
        customView.buildDateValueLabel.text = "\(box.buildDate)"
        customView.nettoValueLabel.text = "\(box.weightNetto / 1000) кг"
        customView.costValueLabel.text = "\(box.cost)"
        
        if box.recipient == "" {
            customView.recipientValueLabel.text = "не выбран"
        } else {
            customView.recipientValueLabel.text = "\(box.recipient)"
        }
        
        if box.sent == true {
            customView.statusValueLabel.text = "Отправлен \(box.departureDate)"
        } else {
            customView.statusValueLabel.text = "Не отправлен"
        }
        
        if box.recived == true {
            customView.statusValueLabel.text = "Доставлен \(box.recivedDate)"
        }
    }
    
    private func barButtonsConfigure() {
        let settings = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingsPressed))
        
        let csv = UIBarButtonItem(image: UIImage(named: "csv2"), style: .plain, target: self, action: #selector(createCSV))
        
        self.navigationItem.rightBarButtonItems = [settings, csv]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func settingsPressed() {
        let boxSettingsVC = BoxSettingsViewController()
        boxSettingsVC.box = self.box
        boxSettingsVC.finishedBoxVC = self
        self.navigationController?.pushViewController(boxSettingsVC, animated: true)
    }
    
    @objc private func createCSV() {
        let fileName = "box_\(box.number).csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        var csvHead = "Номер, Название, Количество, Цена за штуку, Общая цена\n"
        
        for product in dbService.productArray {
            csvHead.append("\(product.number),\(product.name),\(product.count),\(product.cost),\(product.cost * product.count)\n")
        }
        
        csvHead.append("Итоговая стоимость:, \(box.cost)\n")
        csvHead.append("Итоговый вес:, \(box.weightNetto / 1000) кг\n")
        csvHead.append("Получатель:, \(box.recipient)")
        
        do {
            try csvHead.write(to: path!, atomically: true, encoding: .utf8)
            let exportSheet = UIActivityViewController(activityItems: [path as Any] as [Any], applicationActivities: nil)
            self.present(exportSheet, animated: true, completion: nil)
            print("Export successful!")
        } catch {
            print("ERROR!!!")
        }
    }
    
}

//MARK:- UITableViewDelegate & UITableViewDataSource

extension FinishedBoxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbService.productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: Product
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FinishedBoxCell.reuseIdentifier, for: indexPath) as? FinishedBoxCell else { return UITableViewCell() }
        
        model = dbService.productArray[indexPath.row]
        cell.configure(productModel: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
