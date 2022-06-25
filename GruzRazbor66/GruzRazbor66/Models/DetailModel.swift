//
//  Model.swift
//  GruzRazbor66
//
//  Created by Настя on 24.05.2022.
//

import Foundation
import UIKit

class DetailModel {
    var auto: String
    var price: String
    var balance: String
    var id: String
    var vendorСode: String
    var photos: [UIImage] = []
    
    init(auto: String, price: String, balance: String, id: String, vendorCode: String) {
        self.auto = auto
        self.price = price
        self.balance = balance
        self.id = id
        self.vendorСode = vendorCode
    }
    
    func addPhotos(photos: [UIImage]) {
        self.photos = photos
    }
}
