//
//  Product.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 29.06.2022.
//

import Foundation

struct Product {
    let name: String
    let id: String
    let code: String
    let vendorCode: String
    let auto: String
    let cell: String
    let balance: Int
    let price: Int
    let isAvito: Bool
    var photo: Data?
    var steppedCount = 0
}

extension Product {
    init(dto: ProductDto) {
        self.name = dto.name ?? "Наименование отсутствует"
        self.id = dto.id ?? "Идентификатор отсутствует"
        self.code = dto.code ?? "Код отсутствует"
        self.vendorCode = dto.vendorCode ?? "Артикул отсутствует"
        self.auto = dto.auto ?? "Автомобиль отсутствует"
        self.cell = dto.cell ?? "Ячейка отсутствует"
        self.balance = dto.balance ?? 0
        self.price = dto.price ?? 0
        self.isAvito = dto.isAvito ?? false
    }
}

extension Product {
    var entity: ProductInfoEntity {
        let entity = ProductInfoEntity()
        entity.id = self.id
        entity.vendorCode = self.vendorCode
        entity.code = self.code
        entity.cell = self.cell
        entity.auto = self.auto
        entity.balance = self.balance
        entity.price = self.price
        entity.name = self.name
        entity.isAvito = self.isAvito
        entity.photo = self.photo
        return entity
    }
}
