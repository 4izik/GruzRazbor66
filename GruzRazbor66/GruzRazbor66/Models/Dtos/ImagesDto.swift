//
//  ImagesDto.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 04.07.2022.
//

import Foundation

struct ImagesDto: Codable {
    let id: String?
    let name: String?
    let fileType: String?
    let base64String: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ИдентификаторИзображения"
        case name = "ИмяФайла"
        case fileType = "РасширениеФайла"
        case base64String = "ДанныеФайлаBase64"
    }
}
