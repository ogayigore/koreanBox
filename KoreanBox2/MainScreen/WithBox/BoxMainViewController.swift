//
//  BoxMainViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 25.10.2021.
//

import UIKit
import FirebaseAuth
import RealmSwift

class BoxMainViewController: UIViewController {
    
    //MARK:- Public Properties
    
    var realm: Realm!
    var dbService: DatabaseService!
    
    //MARK:- Private Properties
    
    private(set) lazy var customView = view as! BoxMainView
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredProducts = [Product]()
    private var isSearchIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchIsEmpty
    }
    
    private var photos = [Photo]()
    
    private var count = 1
    private var totalNetto = 0.0
    private var boxArray = [ProductRealm]()
    private var product: Product?
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = BoxMainView()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Товары"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calculateNetto()
        customView.nettoValueLabel.text = "\(totalNetto / 1000) кг"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbService = DatabaseService()
        realm = try! Realm()
        configure()
        dbService.getProducts {
            DispatchQueue.main.async {
                self.customView.tableView.reloadData()
            }
        }
        tabBarController?.tabBar.items![0].image = UIImage(named: "skincare")
        barButtonsConfigure()
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(BoxProductCell.self, forCellReuseIdentifier: BoxProductCell.reuseIdentifier)
        customView.boxButton.addTarget(self, action: #selector(boxPressed), for: .touchUpInside)
        searchBarSetup()
    }
    
    private func searchBarSetup() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Поиск по номеру товара", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        definesPresentationContext = true
    }
    
    private func barButtonsConfigure() {
        let addButton = UIButton()
        addButton.setBackgroundImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)), for: .normal)
        addButton.addTarget(self, action: #selector(addProduct), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func addProduct() {
        let addProductVC = AddProductViewController()
        navigationController?.pushViewController(addProductVC, animated: true)
    }
    
    @objc private func boxPressed() {
        let boxVC = BoxViewController()
        self.navigationController?.pushViewController(boxVC, animated: true)
    }
    
    private func calculateNetto() {
        let boxArray = realm.objects(ProductRealm.self)
        totalNetto = 0
        for i in boxArray {
            totalNetto += Double(i.count * i.weightNetto)
        }
        
        customView.nettoValueLabel.text = "\(totalNetto/1000) кг"
    }
    
    private func getInfoBy(number: Int) -> ProductRealm? {
        let realm = try! Realm()
        let scope = realm.objects(ProductRealm.self).filter("number == %@", number)
        return scope.first
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource

extension BoxMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredProducts.count
        }
        
        return dbService.productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: Product
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxProductCell.reuseIdentifier, for: indexPath) as? BoxProductCell else { return UITableViewCell() }
        
        if isFiltering {
            model = filteredProducts[indexPath.row]
            cell.configure(productModel: model)
            cell.delegate = self
        } else {
            model = dbService.productArray[indexPath.row]
            cell.configure(productModel: model)
            cell.delegate = self
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let productDetailsVC = ProductDetailsViewController()
        var model: Product
        if isFiltering {
            model = filteredProducts[indexPath.row]
            productDetailsVC.product = model
        } else {
            model = dbService.productArray[indexPath.row]
            productDetailsVC.product = model
        }

        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
}

//MARK:- UISearchBarDelegate & UISearchResultsUpdating

extension BoxMainViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        
        filterForSearch(searhText: searchText)
    }
    
    private func filterForSearch(searhText: String) {
        filteredProducts = dbService.productArray.filter { product in
            let number = String(product.number)
            let match = number
            return match.contains(searhText)
        }
        customView.tableView.reloadData()
    }

}

//MARK:- ProductCellDelegate

extension BoxMainViewController: BoxProductCellDelegate {
    
    func plusPressed() {
        count += 1
    }
    
    func minusPressed() {
        if count == 1 {
            count += 1
        }
    }
    
    func addButtonPressed(product: Product) {
        
        let name = product.name
        let number = product.number
        let description = product.description
        let composition = product.composition
        let weightBrutto = product.weightBrutto
        let weightNetto = product.weightNetto
        let docId = product.docId
        let cost = product.cost
        let imageURL = product.imageURL
        
        let boxProduct = ProductRealm(value: [docId, number, name, description, composition, weightBrutto, weightNetto, count, cost, imageURL])
        
        if let updateProduct = getInfoBy(number: product.number) {
            try! realm.write {
                updateProduct.count += count
            }
        } else {
            count = 1
            try! realm.write({
                realm.add(boxProduct)
            })
        }
        calculateNetto()
        count = 1
    }
}
