//
//  DeliveryViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 11.11.2021.
//

import UIKit

class DeliveryViewController: UIViewController {
    
    //MARK:- Private Properties
    
    private var dbService: DatabaseService!
    private(set) lazy var customView = view as! DeliveryView
    private var boxesArray = [Box]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredBoxes = [Box]()
    private var isSearchIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchIsEmpty
    }
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = DeliveryView()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Боксы"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        dbService?.getBoxes {
            DispatchQueue.main.async {
                self.customView.tableView.reloadData()
            }
        }
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        dbService = DatabaseService()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(DeliveryBoxCell.self, forCellReuseIdentifier: DeliveryBoxCell.reuseIdentifier)
        searchBarSetup()
    }
    
    private func searchBarSetup() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Поиск бокса по номеру или дате", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        definesPresentationContext = true
    }
    
}

//MARK:- UITableViewDataSource & UITableViewDelegate

extension DeliveryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredBoxes.count
        }
        return dbService.boxesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: Box
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryBoxCell.reuseIdentifier, for: indexPath) as? DeliveryBoxCell else { return UITableViewCell() }
        
        if isFiltering {
            model = filteredBoxes[indexPath.row]
            cell.configure(boxModel: model)
        } else {
            model = dbService.boxesArray[indexPath.row]
            cell.configure(boxModel: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let formBoxVC = FormBoxViewController()
        var model: Box
        
        if isFiltering {
            model = filteredBoxes[indexPath.row]
            formBoxVC.box = model
        } else {
            model = dbService.boxesArray[indexPath.row]
            formBoxVC.box = model
        }

        self.navigationController?.pushViewController(formBoxVC, animated: true)
    }
}

//MARK:- UISearchBarDelegate & UISearchResultsUpdating

extension DeliveryViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        
        filterForSearch(searhText: searchText)
    }
    
    private func filterForSearch(searhText: String) {
        filteredBoxes = dbService.boxesArray.filter { box in
            let number = String(box.number) + box.departureDate + box.buildDate
            let match = number
            return match.contains(searhText)
        }
        customView.tableView.reloadData()
    }

}
