//
//  AddPhotoViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 03.11.2021.
//

import UIKit

class AddPhotoViewController: UIViewController {
    
    //MARK:- Public Properties
    
    var product: Product!
    var photo: Photo!
    var firstPhoto: Photo?
    
    //MARK:- Private Properties
    
    private var dbService: DatabaseService?
    private lazy var customView = view as! AddPhotoView
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = AddPhotoView()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbService = DatabaseService()
        setup()
        barButtonsConfigure()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dbService?.getPhotos(product: product, completion: {
            self.firstPhoto = self.dbService?.photosArray.first
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- Private Methods
    
    private func setup() {
        customView.photoImageView.image = photo.image
    }
    
    private func barButtonsConfigure() {
        let saveButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(savePhoto))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func savePhoto() {
        photo.saveData(product: product) { success in
            if success {
                print("SUCCESS")
                self.navigationController?.popViewController(animated: true)
            } else {
                print("ERROR")
            }
        }
    }
}
