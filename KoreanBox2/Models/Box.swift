//
//  Box.swift
//  KoreanBox
//
//  Created by Igor Ogai on 09.11.2021.
//

import Foundation

class Box {
    
    var docId: String
    var number: Int
    var weightNetto: Double
    var cost: Int
    var departureDate: String
    var recivedDate: String
    var buildDate: String
    var sent: Bool
    var recived: Bool
    var recipient: String
    
    var dictionary: [String: Any] {
        return [
            "docId": docId,
            "number": number,
            "weightNetto": weightNetto,
            "cost": cost,
            "departureDate": departureDate,
            "recivedDate": recivedDate,
            "buildDate": buildDate,
            "sent": sent,
            "recived": recived,
            "recipient": recipient
        ]
    }
    
    init(docId: String, number: Int, weightNetto: Double, cost: Int, departureDate: String, recivedDate: String, buildDate: String, sent: Bool, recived: Bool, recipient: String) {
        self.docId = docId
        self.number = number
        self.weightNetto = weightNetto
        self.cost = cost
        self.departureDate = departureDate
        self.recivedDate = recivedDate
        self.buildDate = buildDate
        self.sent = sent
        self.recived = recived
        self.recipient = recipient
    }
    
    convenience init() {
        self.init(docId: "", number: 0, weightNetto: 0, cost: 0, departureDate: "", recivedDate: "", buildDate: "", sent: false, recived: false, recipient: "")
    }
    
    convenience init(dictionary: [String : Any]) {
        let docId = dictionary["docId"] as! String? ?? ""
        let number = dictionary["number"] as! Int? ?? 0
        let weightNetto = dictionary["weightNetto"] as! Double? ?? 0
        let cost = dictionary["cost"] as! Int? ?? 0
        let departureDate = dictionary["departureDate"] as! String? ?? ""
        let recivedDate = dictionary["recivedDate"] as! String? ?? ""
        let buildDate = dictionary["buildDate"] as! String? ?? ""
        let sent = dictionary["sent"] as! Bool? ?? false
        let recived = dictionary["recived"] as! Bool? ?? false
        let recipient = dictionary["recipient"] as! String? ?? ""
        
        self.init(docId: docId, number: number, weightNetto: weightNetto, cost: cost, departureDate: departureDate, recivedDate: recivedDate, buildDate: buildDate, sent: sent, recived: recived, recipient: recipient)
    }
}
