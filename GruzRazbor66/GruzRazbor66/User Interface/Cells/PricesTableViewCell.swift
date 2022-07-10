//
//  PricesTableViewCell.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 10.07.2022.
//

import UIKit

class PricesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setupView(model: Price) {
        priceLabel.text = "\(model.price)"
        vendorLabel.text = model.vendor
        nameLabel.text = model.name
    }
}
