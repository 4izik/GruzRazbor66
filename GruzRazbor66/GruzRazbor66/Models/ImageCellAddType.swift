//
//  ImageCellType.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.06.2022.
//

import Foundation


enum ImageCellAddType {
    case photo

    var actionAddTitle: String {
        return "Сфотографировать"
    }
    
    var actionAddFromLibraryTitle: String {
        return "Выбрать из медиатеки"
    }
}

