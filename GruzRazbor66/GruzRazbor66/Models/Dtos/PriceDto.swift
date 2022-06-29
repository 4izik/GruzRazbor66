//
//  PriceDto.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 29.06.2022.
//

import Foundation

struct PriceDto: Codable {
    
    let vendor: String?
    let vendorCode: String?
    let name: String?
    let price: Int?
    
    enum CodingKeys: String, CodingKey {
        case vendor = "Поставщик"
        case vendorCode = "Артикул"
        case name = "Наименование"
        case price = "Цена"
    }
}
