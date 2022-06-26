//
//  MainImageAddCell.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.06.2022.
//

import UIKit

class MainImageAddCell: UICollectionViewCell {
    
    var imageType: ImageCellAddType = .photo
    var addButtonDidTapped: (()->())?
    @IBOutlet weak var addButton: UIButton!
    
   
    @IBAction func addButtonDidTapped(_ sender: Any) {
        addButtonDidTapped?()
    }
}
