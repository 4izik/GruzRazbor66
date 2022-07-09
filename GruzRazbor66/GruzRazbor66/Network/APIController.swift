//
//  APIController.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 25.06.2022.
//

import Alamofire

class APIController {
    
    static let shared = APIController()!
    
    static let manager: Alamofire.Session = {
        let manager = ServerTrustManager(evaluators: ["10.10.1.2": DisabledTrustEvaluator()])
        let session = Session(serverTrustManager: manager)
        return session
    }()
    
    private init?() {}
    
    func getProductInfo(params: [String: String], headers: HTTPHeaders? = nil, completion: @escaping ((Result<Product, NSError>) -> Void)) {
        APIController.manager.request((NetworkConstants.host + NetworkConstants.getProductInfo), method: .get, parameters: params, headers: headers)
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
    
    func getProductPrices(params: [String: String], headers: HTTPHeaders? = nil, completion: @escaping ((Result<Price, NSError>) -> Void)) {
        APIController.manager.request((NetworkConstants.host + NetworkConstants.getSuppliersPrices), method: .get, parameters: params, headers: headers)
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
    
    func getProductImages(params: [String:String], headers: HTTPHeaders? = nil, completion: @escaping ((Result<[String], NSError>) -> Void)) {
        APIController.manager.request(NetworkConstants.host + NetworkConstants.getProductPictures, method: .get, parameters: params, headers: headers)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let dto):
                    if let data = dto as? [[String: String]] {
                        var photos: [String] = []
                        for model in data {
                            if let photosString = model["ДанныеФайлаBase64"] {
                                photos.append(photosString)
                            }
                        }
                        completion(.success(photos))
                    }
                case .failure(let error):
                    completion(.failure(NSError.makeEror(description: error.localizedDescription)))
                }
            }
    }
    
}
