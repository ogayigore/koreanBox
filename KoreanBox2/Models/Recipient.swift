//
//  Recipient.swift
//  KoreanBox
//
//  Created by Igor Ogai on 17.11.2021.
//

import Foundation

class Recipient {
    
    var docId: String
    var fullName: String
    var code: Int
    
    var dictionary: [String: Any] {
        return [
            "docId": docId,
            "fullName": fullName,
            "code": code
        ]
    }
    
    init(docId: String, fullName: String, code: Int) {
        self.docId = docId
        self.fullName = fullName
        self.code = code
    }
    
    convenience init() {
        self.init(docId: "", fullName: "", code: 0)
    }
    
    convenience init(dictionary: [String : Any]) {
        let docId = dictionary["docId"] as! String? ?? ""
        let fullName = dictionary["fullName"] as! String? ?? ""
        let code = dictionary["code"] as! Int? ?? 0
        
        self.init(docId: docId, fullName: fullName, code: code)
    }
}
