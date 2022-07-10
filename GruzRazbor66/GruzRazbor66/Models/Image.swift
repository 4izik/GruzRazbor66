//
//  Image.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 04.07.2022.
//

import Foundation

struct ImageModel {
    let id: String
    let name: String
    let fileType: String
    let base64String: String
}

extension ImageModel {
    init?(dto: [String: String]) {
        guard let id = dto["ИдентификаторИзображения"],
              let name = dto["ИмяФайла"],
              let fileType = dto["РасширениеФайла"],
              let base64String = dto["ДанныеФайлаBase64"] else { return nil }
                
        self.id = id
        self.name = name
        self.fileType = fileType
        self.base64String = base64String
    }
    
    static func getArray(from jsonArray: Any) -> [ImageModel]? {
        guard let jsonArray = jsonArray as? Array<[String: String]> else { return nil}
        return jsonArray.compactMap {ImageModel.init(dto: $0)}
    }
}
