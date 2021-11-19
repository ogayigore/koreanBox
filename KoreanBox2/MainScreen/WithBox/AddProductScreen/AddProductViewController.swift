//
//  AddProductViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 04.11.2021.
//

import UIKit

class AddProductViewController: UIViewController {
    
    //MARK:- Private Properties
    
    private lazy var customView = view as! AddProductView
    private var dbService: DatabaseService?
    private var productNumber = 0
    
    //MARK:- Lifecycle
    
    override func viewDidLayoutSubviews() {
        customView.addButton.layer.cornerRadius = customView.addButton.frame.height / 2
        customView.addButton.clipsToBounds = true
    }
    
    override func loadView() {
        view = AddProductView()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Добавить"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbService = DatabaseService()
        configure()
        getProductNumber()
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        customView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        guard let name = customView.nameTextView.text,
              let description = customView.descriptionTextView.text,
              let composition = customView.compositionTextView.text,
              let brutto = customView.bruttoTextField.text,
              let netto = customView.nettoTextField.text else { return }
        
        if name == "" || description == "" || composition == "" || brutto == "" || netto == "" {
            
            let alert = UIAlertController(title: "Заполните пустые поля!", message: "Все поля должны быть заполнены", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
            present(alert, animated: true, completion: nil)
        } else {
            let newProduct = Product(docId: "", number: productNumber, name: name, description: description, composition: composition, weightBrutto: Int(brutto)!, weightNetto: Int(netto)!, count: 0, cost: 0, imageURL: "")
            
            dbService?.addProduct(productDict: newProduct.dictionary, product: newProduct, completion: { success in
                if success {
                    print("OK")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("ERROR")
                }
            })
        }
    }
    
    private func getProductNumber() {
        self.dbService?.getProducts { [weak self] in
            guard let lastProduct = self?.dbService?.productArray.last else { return }
            self?.productNumber = lastProduct.number + 1
        }
    }
}
