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
    init?(dto: [String: Any]) {
        
        guard let vendor = dto["Поставщик"] as? String,
              let vendorCode = dto["Артикул"] as? String,
              let name = dto["Наименование"] as? String,
              let price = dto["Цена"] as? Int else { return nil}
        
        self.vendor = vendor
        self.vendorCode = vendorCode
        self.name = name
        self.price = price
    }
    
    static func getArray(from jsonArray: Any) -> [Price]? {
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        return jsonArray.compactMap { Price.init(dto: $0) }
    }
    
}



