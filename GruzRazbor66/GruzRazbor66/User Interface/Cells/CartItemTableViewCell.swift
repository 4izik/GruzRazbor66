//
//  CartItemTableViewCell.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.07.2022.
//

import Foundation
import UIKit

class CartItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var vendorCodeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var deleteDidTapped: (()->())?
    var stepperChanged: (()->())?
    
    var product: Product! {
        didSet {
            titleLabel.text = product.name
            vendorCodeLabel.text = "Артикул: \(product.vendorCode)"
            priceLabel.text = "\(Double(product.price)) руб."
            if let photo = product.photo, let image = UIImage(data: photo) {
                imgView.image = image
            }
        }
    }
    
    
    
    @IBAction func deleteButtonDidTapped(_ sender: Any) {
        deleteDidTapped?()
    }
    
    
    @IBAction func stepperValueDidChange(_ sender: Any) {
        stepperChanged?()
    }
    
}
