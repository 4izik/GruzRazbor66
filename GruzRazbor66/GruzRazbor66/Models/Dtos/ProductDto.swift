//
//  ProductDto.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 29.06.2022.
//

import Foundation

struct ProductDto: Codable {
    let name: String?
    let id: String?
    let code: String?
    let vendorCode: String?
    let auto: String?
    let cell: String?
    let balance: Int?
    let price: Int?
    let isAvito: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "Наименование"
        case id = "Идентификатор"
        case code = "Код"
        case vendorCode = "Артикул"
        case auto = "Автомобиль"
        case cell = "Ячейка"
        case balance = "Остаток"
        case price = "Цена"
        case isAvito = "ВыгружатьНаАвито"
    }
}
