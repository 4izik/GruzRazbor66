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
    init(dto: ImagesDto) {
        self.id = dto.id ?? ""
        self.name = dto.name ?? ""
        self.fileType = dto.fileType ?? ""
        self.base64String = dto.base64String ?? ""
    }
}
