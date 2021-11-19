//
//  ProductRealm.swift
//  KoreanBox
//
//  Created by Igor Ogai on 29.10.2021.
//

import Foundation
import RealmSwift

class ProductRealm: Object {
    @objc dynamic var docId = ""
    @objc dynamic var number = 0
    @objc dynamic var name = ""
    @objc dynamic var descrip = ""
    @objc dynamic var composition = ""
    @objc dynamic var weightBrutto = 0
    @objc dynamic var weightNetto = 0
    @objc dynamic var count = 0
    @objc dynamic var cost = 0
    @objc dynamic var imageURL = ""
}
