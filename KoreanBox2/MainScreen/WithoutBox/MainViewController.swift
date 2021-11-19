//
//  MainViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 01.11.2021.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    //MARK:- Public Properties
    
    var dbService: DatabaseService!
    
    //MARK:- Private Properties
    
    private(set) lazy var customView = view as! MainView
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredProducts = [Product]()
    private var isSearchIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchIsEmpty
    }
    
    private var boxArray = [ProductRealm]()
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = MainView()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Товары"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbService = DatabaseService()
        configure()
        dbService.getProducts {
            DispatchQueue.main.async {
                self.customView.tableView.reloadData()
            }
        }
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
        searchBarSetup()
    }
    
    private func barButtonsConfigure() {
        let logOutButton = UIButton()
        logOutButton.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .regular, scale: .large)), for: .normal)
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logOutButton)
    }
    
    @objc private func logOut() {
        do {
            try Auth.auth().signOut()
            
            let authVC = AuthenticationViewController()
            authVC.modalPresentationStyle = .fullScreen
            present(authVC, animated: true, completion: nil)
        } catch {
            
        }
    }
    
    private func searchBarSetup() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Поиск по номеру товара", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        definesPresentationContext = true
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredProducts.count
        }
        
        return dbService.productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: Product
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else { return UITableViewCell() }
        
        if isFiltering {
            model = filteredProducts[indexPath.row]
            cell.configure(productModel: model)
        } else {
            model = dbService.productArray[indexPath.row]
            cell.configure(productModel: model)
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

extension MainViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
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
