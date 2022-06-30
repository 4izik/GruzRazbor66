//
//  APIController.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 25.06.2022.
//

import Alamofire

class APIController {
    let shared = APIController()
    private init() {}
    
    func getProductInfo(params: [String: String], completion: @escaping ((Result<PriceDto, NSError>) -> Void)) {
        AF.request((NetworkConstants.host + NetworkConstants.getProductInfo), method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ProductDto.self) { response in
                print(response.response)
            }
    }
    
    func getProductPrices(params: [String: String], completion: @escaping ((Result<PriceDto, NSError>) -> Void)) {
        AF.request((NetworkConstants.host + NetworkConstants.getSuppliersPrices), method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PriceDto.self) { response in
                print(response.response)
            }
    }
    
}
