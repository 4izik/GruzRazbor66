//
//  Model.swift
//  GruzRazbor66
//
//  Created by Настя on 24.05.2022.
//

import Foundation
import UIKit

struct DetailModel {
    var product: Product?
    var photos: [UIImage] = []
    
    mutating func addPhotos(photos: [UIImage]) {
        self.photos = photos
    }
}
