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
    
    func getProductPrices(params: [String: String], headers: HTTPHeaders? = nil, completion: @escaping ((Result<[Price], NSError>) -> Void)) {
        APIController.manager.request((NetworkConstants.host + NetworkConstants.getSuppliersPrices), method: .get, parameters: params, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let dto):
                    guard let prices = Price.getArray(from: dto) else { return }
                    completion(.success(prices))
                case .failure(let error):
                    completion(.failure(NSError.makeEror(description: error.localizedDescription)))
                }
            }
    }
    
    func getProductImages(params: [String:String], headers: HTTPHeaders? = nil, completion: @escaping ((Result<[ImageModel], NSError>) -> Void)) {
        APIController.manager.request(NetworkConstants.host + NetworkConstants.getProductPictures, method: .get, parameters: params, headers: headers)
            .validate(statusCode:200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let dto):
                    guard let images = ImageModel.getArray(from: dto) else { return }
                    completion(.success(images))
                case .failure(let error):
                    completion(.failure(NSError.makeEror(description: error.localizedDescription)))
                }
            }
    }
    
    func testSecureConnection(params: [String: String], headers: HTTPHeaders, completion: @escaping ((Result<Bool, NSError>) -> Void)) {
        APIController.manager.request(NetworkConstants.host + NetworkConstants.testSecureConnection, method: .get, parameters: params, headers: headers)
            .response { response in
                switch response.result {
                case .success(_):
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(NSError.makeEror(description: error.localizedDescription)))
                }
            }
    }
    
}
