//
//  Product.swift
//  KoreanBox
//
//  Created by Igor Ogai on 25.10.2021.
//

import Foundation
import CoreText

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

class Product {
    
    var dbService: DatabaseService!
    
    var docId: String
    var number: Int
    var name: String
    var description: String
    var composition: String
    var weightBrutto: Int
    var weightNetto: Int
    var count: Int
    var cost: Int
    var imageURL: String
    
    var dictionary: [String: Any] {
        return [
            "docId": docId,
            "number": number,
            "name": name,
            "description": description,
            "composition": composition,
            "weightBrutto": weightBrutto,
            "weightNetto": weightNetto,
            "count": count,
            "cost": cost,
            "image": imageURL
        ]
    }
    
    init(docId: String, number: Int, name: String, description: String, composition: String, weightBrutto: Int, weightNetto: Int, count: Int, cost: Int, imageURL: String) {
        self.docId = docId
        self.number = number
        self.name = name
        self.description = description
        self.composition = composition
        self.weightBrutto = weightBrutto
        self.weightNetto = weightNetto
        self.count = count
        self.cost = cost
        self.imageURL = imageURL
    }
    
    convenience init() {
        self.init(docId: "", number: 0, name: "", description: "", composition: "", weightBrutto: 0, weightNetto: 0, count: 0, cost: 0, imageURL: "")
    }
    
    convenience init(dictionary: [String : Any]) {
        let docId = dictionary["docId"] as! String? ?? ""
        let number = dictionary["number"] as! Int? ?? 0
        let name = dictionary["name"] as! String? ?? ""
        let description = dictionary["description"] as! String? ?? ""
        let composition = dictionary["composition"] as! String? ?? ""
        let weightBrutto = dictionary["weightBrutto"] as! Int? ?? 0
        let weightNetto = dictionary["weightNetto"] as! Int? ?? 0
        let count = dictionary["count"] as! Int? ?? 0
        let cost = dictionary["cost"] as! Int? ?? 0
        let imageURL = dictionary["image"] as! String? ?? ""
        
        self.init(docId: docId, number: number, name: name, description: description, composition: composition, weightBrutto: weightBrutto, weightNetto: weightNetto, count: count, cost: cost, imageURL: imageURL)
    }
    
    func saveData(box: Box, completion: @escaping (Bool) -> ()) {
        dbService = DatabaseService()
        let dataToSave: [String: Any] = self.dictionary
        
        if self.docId == "" {
            dbService.ref = dbService?.db.collection("boxes").document(box.docId).collection("prod").addDocument(data: dataToSave) { error in
                guard error == nil else {
                    print("Error adding document: \(error!.localizedDescription)")
                    return completion(false)
                }
                self.docId = self.dbService.ref!.documentID
                print("Added document: \(self.docId) to box: \(box.docId)")
                completion(true)
            }
        } else {
            let ref = dbService.db.collection("boxes").document(box.docId).collection("prod").document(self.docId)
            ref.setData(dataToSave) { error in
                guard error == nil else {
                    print("Error updating document: \(error!.localizedDescription)")
                    return completion(false)
                }
                print("Updated document: \(self.docId) in box: \(box.docId)")
                completion(true)
            }
        }
        
    }
}
