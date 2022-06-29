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
