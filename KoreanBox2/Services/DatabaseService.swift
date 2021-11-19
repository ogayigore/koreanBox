//
//  DatabaseService.swift
//  KoreanBox
//
//  Created by Igor Ogai on 25.10.2021.
//

import Foundation
import Firebase
import RealmSwift

class DatabaseService {
    
    var db: Firestore!
    var storage: Storage!
    var productArray = [Product]()
    var photosArray = [Photo]()
    var boxesArray = [Box]()
    var recipientArray = [String]()
    var ref: DocumentReference? = nil
    
    init() {
        db = Firestore.firestore()
        storage = Storage.storage()
    }
    
    func getProducts(completion: @escaping () -> ()) {
        db.collection("cosmetics").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("Error adding snapshot listener: \(error!.localizedDescription)")
                return completion()
            }
            self.productArray = []
            for document in querySnapshot!.documents {
                let product = Product(dictionary: document.data())
                product.docId = document.documentID
                self.productArray.append(product)
            }
            self.productArray.sort(by: { $0.number < $1.number })
            completion()
        }
    }
    
    func getPhotos(product: Product, completion: @escaping () -> ()) {
        db.collection("cosmetics").document(product.docId).collection("photos").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("Error adding snapshot listener: \(error!.localizedDescription)")
                return completion()
            }
            self.photosArray = []
            for document in querySnapshot!.documents {
                let photo = Photo(dictionary: document.data())
                photo.documentID = document.documentID
                self.photosArray.append(photo)
            }
            completion()
        }
    }
    
    func getBoxProducts(box: Box, completion: @escaping () -> ()) {
        db.collection("boxes").document(box.docId).collection("prod").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("Error adding snapshot listener: \(error!.localizedDescription)")
                return completion()
            }
            self.productArray = []
            for document in querySnapshot!.documents {
                let product = Product(dictionary: document.data())
                product.docId = document.documentID
                self.productArray.append(product)
            }
            self.productArray.sort(by: { $0.number < $1.number })
            completion()
        }
    }
    
    func getRecipients(completion: @escaping () -> ()) {
        db.collection("recipients").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("Error adding snapshot listener: \(error!.localizedDescription)")
                return completion()
            }
            self.recipientArray = []
            for document in querySnapshot!.documents {
                let recipient = Recipient(dictionary: document.data())
                recipient.docId = document.documentID
                self.recipientArray.append("\(recipient.fullName) \(recipient.code)")
            }
            self.recipientArray.sort(by: { $0 < $1 })
            completion()
        }
    }
    
    func addProduct(productDict: [String: Any], product: Product, completion: @escaping (Bool) -> ()) {
        
        if product.docId == "" {
            ref = db.collection("cosmetics").addDocument(data: productDict, completion: { error in
                if let error = error {
                    print("Error adding document \(error.localizedDescription)")
                } else {
                    print("Document added with ID: \(self.ref?.documentID)")
                    guard let docId = self.ref?.documentID else { return }
                    self.db.collection("cosmetics").document(docId).updateData([
                        "docId": "\(docId)"
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                    completion(true)
                }
            })
        } else {
            ref = db.collection("cosmetics").document(product.docId)
            ref?.setData(productDict) { error in
                guard error == nil else {
                    print("Error updating document - \(error!.localizedDescription)")
                    return completion(false)
                }
                print("Updated document: \(product.docId)")
                completion(true)
            }
        }
    }
    
    func getBoxes(completion: @escaping () -> ()) {
        
        db.collection("boxes").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("Error adding snapshot listener: \(error!.localizedDescription)")
                return completion()
            }
            self.boxesArray = []
            for document in querySnapshot!.documents {
                let box = Box(dictionary: document.data())
                box.docId = document.documentID
                self.boxesArray.append(box)
            }
            self.boxesArray.sort(by: { $0.number < $1.number })
            completion()
        }
    }
    
    func addBox(boxDict: [String: Any], box: Box, completion: @escaping (Bool) -> ()) {
        
        if box.docId == "" {
            ref = db.collection("boxes").addDocument(data: boxDict, completion: { error in
                if let error = error {
                    print("Error adding document \(error.localizedDescription)")
                } else {
                    print("Document added with ID: \(self.ref?.documentID)")
                    guard let docId = self.ref?.documentID else { return }
                    self.db.collection("boxes").document(docId).updateData([
                        "docId": "\(docId)"
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                    completion(true)
                }
            })
        } else {
            ref = db.collection("boxes").document(box.docId)
            ref?.setData(boxDict) { error in
                guard error == nil else {
                    print("Error updating document - \(error!.localizedDescription)")
                    return completion(false)
                }
                print("Updated document: \(box.docId)")
                completion(true)
            }
        }
    }
}
