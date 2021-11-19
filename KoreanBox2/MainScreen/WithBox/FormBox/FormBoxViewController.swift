//
//  FormBoxViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 09.11.2021.
//

import UIKit
import RealmSwift
import SPAlert

class FormBoxViewController: UIViewController {
    
    //MARK:- Public Properties
    
    weak var boxVC: BoxViewController?
    var boxArray: Results<ProductRealm>!
    var box: Box?
    
    //MARK:- Private Properties
    
    private(set) lazy var customView = view as! FormBoxView
    private var totalNetto = 0.0
    private var totalCost = 0
    private var realm = try! Realm()
    private var dbService: DatabaseService?
    private var boxProd = [Product]()
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = FormBoxView()
        self.navigationController?.navigationItem.title = nil
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        calculateNetto()
        calculateTotalCost()
        getLastBox { lastBox in
            self.box = lastBox
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createProduct(box: box!)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        try! realm.write {
            realm.deleteAll()
        }
        boxVC?.customView.tableView.reloadData()
        boxVC?.customView.costValueLabel.text = "0"
        boxVC?.customView.nettoValueLabel.text = "0.0 кг"
        SPAlert.present(title: "Бокс создан", preset: .done)
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        dbService = DatabaseService()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(FormBoxCell.self, forCellReuseIdentifier: FormBoxCell.reuseIdentifier)
        customView.closeButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
    }
    
    @objc private func closePressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func calculateNetto() {
        totalNetto = 0
        for i in boxArray {
            totalNetto += Double(i.count * i.weightNetto)
        }
        
        customView.nettoValueLabel.text = "\(totalNetto/1000) кг"
    }
    
    private func calculateTotalCost() {
        totalCost = 0
        for i in boxArray {
            totalCost += i.cost * i.count
        }
        
        customView.costValueLabel.text = "\(totalCost)"
    }
    
    private func getLastBox(completion: @escaping (Box) -> (Void)?) {
        self.dbService?.getBoxes {
            guard let lastBox = self.dbService?.boxesArray.last else { return }
            completion(lastBox)
        }
    }
    
    private func createProduct(box: Box) {
        for i in boxArray {
            let number = i.number
            let name = i.name
            let description = i.descrip
            let composition = i.composition
            let brutto = i.weightBrutto
            let netto = i.weightNetto
            let count = i.count
            let cost = i.cost
            let imageURL = i.imageURL
            
            let product = Product(docId: "",
                                  number: number,
                                  name: name,
                                  description: description,
                                  composition: composition,
                                  weightBrutto: brutto,
                                  weightNetto: netto,
                                  count: count,
                                  cost: cost,
                                  imageURL: imageURL)
            
            product.saveData(box: box) { success in
                if success {
                    print("OK")
                } else {
                    print("ERROR")
                }
            }
        }
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource

extension FormBoxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: ProductRealm
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormBoxCell.reuseIdentifier, for: indexPath) as? FormBoxCell else { return UITableViewCell() }
        
        model = boxArray[indexPath.row]
        cell.configure(productModel: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
