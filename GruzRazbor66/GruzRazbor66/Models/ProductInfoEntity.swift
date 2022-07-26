//
//  ProductInfoEntity.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.07.2022.
//

import RealmSwift

class ProductInfoEntity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var code: String = ""
    @objc dynamic var vendorCode: String = ""
    @objc dynamic var auto: String = ""
    @objc dynamic var cell: String = ""
    @objc dynamic var balance: Int = 0
    @objc dynamic var price: Int = 0
    @objc dynamic var isAvito: Bool = false
    @objc dynamic var photo: Data?
}

extension ProductInfoEntity {
    var model: Product {
        return Product(name: self.name,
                       id: self.id,
                       code: self.code,
                       vendorCode: self.vendorCode,
                       auto: self.auto,
                       cell: self.cell,
                       balance: self.balance,
                       price: self.price,
                       isAvito: self.isAvito,
                       photo: self.photo
        )
    }
}

extension Results where Element == ProductInfoEntity {
    var models: [Product] {
        return self.map{ $0.model }
    }
}
