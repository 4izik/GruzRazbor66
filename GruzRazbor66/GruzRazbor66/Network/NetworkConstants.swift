//
//  NetworkConstants.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 29.06.2022.
//

import Foundation

struct NetworkConstants {
    
    // MARK: - Host
    static let host = "https://10.10.1.2:4381/gr66_unf16/hs/v1"
    
    // MARK: - Endpoints
    static let getProductInfo = "/getproductinfo"
    static let getProductPictures = "/getproductpictures"
    static let getSuppliersPrices = "/getsuppliersprices"
    static let setupLoadToAvito = "/setuploadtoavito"
    static let setPicture = "/setpicture"
    static let createSale = "/createsale"
    static let testSecureConnection = "/testconnection"
}
