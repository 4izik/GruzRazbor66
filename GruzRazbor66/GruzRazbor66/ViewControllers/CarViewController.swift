//
//  CarViewController.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.07.2022.
//

import UIKit

class CarViewController: UIViewController {
    
    let realmManager = ProductFileManager()
    private let networkManager = APIController.shared

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    var list = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()
        updateUI()
        updateTotalPriceLabel()
    }
    
    private func loadProducts() {
        list = realmManager.loadProducts()
    }
    private func updateUI() {
        buyButton.isHidden = list.isEmpty
        totalLabel.isHidden = list.isEmpty
        totalPriceLabel.isHidden = list.isEmpty
    }
    
    private func updateTotalPriceLabel() {
        var price = 0
        for product in list {
            price += (product.price * product.steppedCount)
        }
        totalPriceLabel.text = "\(Double(price)) руб."
    }
}

// MARK: - TableViewDelegate & TableViewDataSource

extension CarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(list.count, 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if list.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "NoItemTableViewCell", for: indexPath) as! NoItemCartTableViewCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
        var product = list[indexPath.row]
        cell.product = product
        cell.deleteDidTapped = {
            self.realmManager.deleteProduct(product: product)
            self.list.remove(at: indexPath.item)
            DispatchQueue.main.async {
                tableView.reloadData()
                self.updateUI()
            }
        }
        cell.stepperChanged = {
            product.steppedCount = Int(cell.stepper.value)
            self.list.insert(product, at: indexPath.row)
            DispatchQueue.main.async {
                cell.counterLabel.text = "\(Int(cell.stepper.value))"
                self.updateTotalPriceLabel()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
}
