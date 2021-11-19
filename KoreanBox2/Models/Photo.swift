//
//  Photo.swift
//  MedDesktop
//
//  Created by Igor Ogai on 01.10.2021.
//

import Foundation
import UIKit
import Firebase

class Photo {
    var dbService: DatabaseService!
    
    var image: UIImage
    var photoURL: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["photoURL": photoURL, "documentID": documentID]
    }
    
    init(image: UIImage, photoURL: String, documentID: String) {
        self.image = image
        self.photoURL = photoURL
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(image: UIImage(), photoURL: "", documentID: "")
    }
    
    convenience init(dictionary: [String : Any]) {
        let photoURL = dictionary["photoURL"] as! String? ?? ""
        self.init(image: UIImage(), photoURL: photoURL, documentID: "")
    }
    
    func saveData(product: Product, completion: @escaping (Bool) -> ()) {
        dbService = DatabaseService()
        
        guard let photoData = self.image.jpegData(compressionQuality: 0.5) else {
            print("Error convert photo.image to Data!")
            return
        }
        
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        if documentID == "" {
            documentID = UUID().uuidString
        }
        
        let storageRef = dbService.storage.reference().child(product.docId).child(documentID)
        
        let uploadTask = storageRef.putData(photoData, metadata: uploadMetaData) { metadate, error in
            if let error = error {
                print("Error upload for ref \(uploadMetaData) failed. \(error.localizedDescription)")
            }
        }
        
        uploadTask.observe(.success) { snapshot in
            print("Upload to Firebase Storage was successful!")
            
            storageRef.downloadURL { url, error in
                guard error == nil else {
                    print("Error creating a download url \(error?.localizedDescription)")
                    return completion(false)
                }
                
                guard let url = url else {
                    print("Error url was nil!")
                    return completion(false)
                }
                self.photoURL = "\(url)"
                
                let dataToSave = self.dictionary
                
                let ref = self.dbService.db.collection("cosmetics").document(product.docId).collection("photos").document(self.documentID)
                
                ref.setData(dataToSave) { error in
                    guard error == nil else {
                        print("Error updating document \(error?.localizedDescription)")
                        return completion(false)
                    }
                    let docId = product.docId
                    let number = product.number
                    let name = product.name
                    let description = product.description
                    let composition = product.composition
                    let brutto = product.weightBrutto
                    let netto = product.weightNetto
                    let count = product.count
                    let cost = product.cost
                    let imageURL = "\(url)"
                    
                    let newProduct = Product(docId: docId,
                                             number: number,
                                             name: name,
                                             description: description,
                                             composition: composition,
                                             weightBrutto: brutto,
                                             weightNetto: netto,
                                             count: count,
                                             cost: cost,
                                             imageURL: imageURL)
                    
                    self.dbService.addProduct(productDict: newProduct.dictionary, product: newProduct) { success in
                        if success {
                            print("OK")
                        } else {
                            print("ERROR")
                        }
                    }
                    
                    print("Updated document: \(self.documentID) in patient: \(product.docId)")
                    completion(true)
                }
                completion(true)
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                print("Error upload task for file \(self.documentID) failed, in patient \(product.docId), with error \(error.localizedDescription)")
            }
            completion(false)
        }
    }
    
    func loadImage(product: Product, completion: @escaping (Bool) -> ()) {
        dbService = DatabaseService()
        guard product.docId != "" else {
            print("Error valid patient into loadImage!")
            return
        }
        let storageRef = dbService.storage.reference().child(product.docId).child(documentID)
        storageRef.getData(maxSize: 25 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error reading data from file ref: \(storageRef) error - \(error.localizedDescription)")
                return completion(false)
            } else {
                self.image = UIImage(data: data!) ?? UIImage()
                return completion(true)
            }
        }
    }
}
