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
    
    func getProductInfo(params: [String: String], completion: @escaping ((Result<Product, NSError>) -> Void)) {
        AF.request((NetworkConstants.host + NetworkConstants.getProductInfo), method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ProductDto.self) { response in
                switch response.result {
                case .success(let dto):
                    let model = Product(dto: dto)
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(NSError.makeEror(description: error.localizedDescription)))
                }
            }
    }
    
    func getProductPrices(params: [String: String], completion: @escaping ((Result<Price, NSError>) -> Void)) {
        AF.request((NetworkConstants.host + NetworkConstants.getSuppliersPrices), method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PriceDto.self) { response in
                switch response.result {
                case .success(let dto):
                    let model = Price(dto: dto)
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(NSError.makeEror(description: error.localizedDescription)))
                }
            }
    }
    
}
