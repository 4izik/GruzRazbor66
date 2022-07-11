//
//  PricesTableViewController.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 10.07.2022.
//

import UIKit
import Alamofire

class PricesTableViewController: UITableViewController {
    
    var vendorCode: String = ""
    private var prices: [Price]? = [Price]()
    private let apiController = APIController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPrices(vendorCode: vendorCode)
    }
    
    private func loadPrices(vendorCode: String) {
        let params: [String: String] = ["Артикул": vendorCode]
        let headers: HTTPHeaders = [
            "Authorization":"Basic 0JHRg9C70LPQsNC60L7QsjpHcnV6UmF6Ym9yNjY="
        ]
        self.apiController.getProductPrices(params: params, headers: headers) { result in
            switch result {
            case .success(let prices):
                self.prices = prices
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

// MARK: - TableView Datasource & TableVeiewDelegate
extension PricesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let prices = self.prices {
            return prices.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let prices = prices else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Prices", for: indexPath) as! PricesTableViewCell
        let price = prices[indexPath.row]
        cell.setupView(model: price)
        return cell
    }
    
}
