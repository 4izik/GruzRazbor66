//
//  ProductEntity.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.07.2022.
//

import RealmSwift

class ProductInfo: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var code: String = ""
    @objc dynamic var vendorCode: String = ""
    @objc dynamic var auto: String = ""
    @objc dynamic var cell: String = ""
    @objc dynamic var balance: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var isAvito: Bool = false
}
