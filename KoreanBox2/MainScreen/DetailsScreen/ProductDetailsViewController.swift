//
//  ProductDetailsViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 02.11.2021.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    //MARK:- Public Properties
    
    var dbService: DatabaseService!
    var product: Product?
    var photo: Photo?
    
    //MARK:- Private Properties
    
    private(set) lazy var customView = view as! ProductDetailsView
    private var imagePickerController = UIImagePickerController()
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = ProductDetailsView()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbService = DatabaseService()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dbService.getPhotos(product: product!) {
            DispatchQueue.main.async {
                self.customView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        
        guard let number = product?.number,
              let brutto = product?.weightBrutto,
              let netto = product?.weightNetto else { return }
        navigationItem.title = "\(product!.name)"
        
        customView.nameLabel.text = product?.name
        customView.descriptionValueLabel.text = product?.description
        customView.numberValueLabel.text = "\(number)"
        customView.compositionValueLabel.text = product?.composition
        customView.bruttoValueLabel.text = ("\(brutto) гр")
        customView.nettoValueLabel.text = ("\(netto) гр")
        
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        
        imagePickerController.delegate = self
        barButtonsConfigure()
    }
    
    private func barButtonsConfigure() {
        let addButton = UIButton()
        addButton.setBackgroundImage(UIImage(systemName: "camera", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)), for: .normal)
        addButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    @objc private func addPhoto() {
        cameraOrLibraryAlert()
    }
    
    private func cameraOrLibraryAlert() {
        var alertStyle = UIAlertController.Style.actionSheet
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertStyle = UIAlertController.Style.alert
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: alertStyle)
        
        let photoLibraryAction = UIAlertAction(title: "Галерея", style: .default) { _ in
            self.accessPhotoLibrary()
        }
        
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { _ in
            self.accessCamera()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//MARK:- UICollectionViewDelegate & UICollectionViewDataSource

extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dbService.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseIdentifier, for: indexPath) as? ImagesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.product = product
        cell.photo = dbService.photosArray[indexPath.row]
        
        cell.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: customView.collectionView.frame.width, height: customView.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        customView.pageControl.numberOfPages = dbService.photosArray.count
        customView.pageControl.currentPage = indexPath.row
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let photoDetailsVC = PhotoDetailsViewController()
//        photoDetailsVC.photo = dbService.photosArray[indexPath.row]
//        self.navigationController?.pushViewController(photoDetailsVC, animated: true)
//    }
//
}

//MARK:- UINavigationControllerDelegate & UIImagePickerControllerDelegate

extension ProductDetailsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        photo = Photo()
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photo?.image = editedImage
            customView.collectionView.reloadData()
        } else if let originalImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photo?.image = originalImage
            customView.collectionView.reloadData()
        }
        dismiss(animated: true) {
            let addPhotoVC = AddPhotoViewController()
            addPhotoVC.product = self.product
            addPhotoVC.photo = self.photo
            self.navigationController?.pushViewController(addPhotoVC, animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
        } else {
            
        }
    }
}
