//
//  Price.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 29.06.2022.
//

import Foundation

struct Price {
    let vendor: String
    let vendorCode: String
    let name: String
    let price: Int
}

extension Price {
    init(dto: PriceDto) {
        self.vendor = dto.vendor ?? "Поставщик отсутствует"
        self.vendorCode = dto.vendorCode ?? "Артикул отсутствует"
        self.name = dto.name ?? "Наименование отсутствует"
        self.price = dto.price ?? 0
    }
}
