//
//  BoxViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 28.10.2021.
//

import UIKit
import RealmSwift

class BoxViewController: UIViewController {
    
    //MARK:- Private Properties
    
    private var totalNetto = 0.0
    private var totalCost = 0
    private var boxNumber = 0
    private var newBox: Box?
    
    private var realm = try! Realm()
    private var dbService: DatabaseService?
    
    private(set) lazy var customView = view as! BoxView
    private var boxArray: Results<ProductRealm>!
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = BoxView()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Бокс"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        boxArray = realm.objects(ProductRealm.self)
        dbService = DatabaseService()
        calculateNetto()
        calculateTotalCost()
        getBoxNumber { number in
            self.boxNumber = number + 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(BoxCell.self, forCellReuseIdentifier: BoxCell.reuseIdentifier)
        customView.listButton.addTarget(self, action: #selector(listPressed), for: .touchUpInside)
        
    }
    
    @objc private func listPressed() {
        if boxArray.isEmpty {
            let alert = UIAlertController(title: "Бокс пуст!", message: "Добавьте товары для сборки бокса", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            createBox(boxNumber: boxNumber)
        }
        
        goToFormBoxVC()
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
    
    private func getInfoBy(number: Int) -> ProductRealm? {
        let realm = try! Realm()
        let scope = realm.objects(ProductRealm.self).filter("number == %@", number)
        return scope.first
    }
    
    private func getBoxNumber(completion: @escaping (Int) -> (Void)?) {
        self.dbService?.getBoxes {
            guard let lastBox = self.dbService?.boxesArray.last else { return }
            completion(lastBox.number)
        }
    }
    
    private func createBox(boxNumber: Int) {
        let currentDate = getCurrentDate()
        
        let newBox = Box(docId: "",
                         number: boxNumber,
                         weightNetto: totalNetto,
                         cost: totalCost,
                         departureDate: "",
                         recivedDate: "",
                         buildDate: currentDate,
                         sent: false,
                         recived: false,
                         recipient: "")
        
        dbService?.addBox(boxDict: newBox.dictionary, box: newBox, completion: { success in
            if success {
                print("OK")
            } else {
                print("ERROR")
            }
        })
    }
    
    private func goToFormBoxVC() {
        let formBoxVC = FormBoxViewController()
        formBoxVC.boxArray = self.boxArray
        formBoxVC.boxVC = self
        formBoxVC.modalPresentationStyle = .formSheet
        self.navigationController?.present(formBoxVC, animated: true, completion: nil)
    }
    
    private func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        
        return dateString
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource

extension BoxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if boxArray.count != 0 {
            return boxArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: ProductRealm
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxCell.reuseIdentifier, for: indexPath) as? BoxCell else { return UITableViewCell() }
        
        model = boxArray[indexPath.row]
        cell.configure(productModel: model)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Удалить?", message: "Вы действительно хотите удалить товар из бокса?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Удалить", style: UIAlertAction.Style.destructive, handler: { (_: UIAlertAction!) in
                let productDelete = self.boxArray[indexPath.row]
                try! self.realm.write({
                    self.realm.delete(productDelete)
                })
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.calculateNetto()
                self.calculateTotalCost()
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}

//MARK:- BoxCellDelegate

extension BoxViewController: BoxCellDelegate {
    
    func plusPressed(product: ProductRealm) {
        if let updateProduct = getInfoBy(number: product.number) {
            try! realm.write {
                updateProduct.count += 1
            }
        }
        calculateNetto()
        calculateTotalCost()
    }
    
    func minusPressed(product: ProductRealm) {
        if let updateProduct = getInfoBy(number: product.number) {
            if updateProduct.count >= 1 {
                try! realm.write {
                    updateProduct.count -= 1
                    self.calculateNetto()
                    self.calculateTotalCost()
                }
            }
        }
    }

    
    func changeCostButtonPressed(product: ProductRealm, cost: Int) {
        if let updateProduct = getInfoBy(number: product.number) {
            try! realm.write {
                updateProduct.cost = cost
            }
        }
        calculateTotalCost()
    }
    
    
}
