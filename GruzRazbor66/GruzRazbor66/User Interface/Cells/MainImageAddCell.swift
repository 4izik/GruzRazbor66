//
//  MainImageAddCell.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.06.2022.
//

import UIKit

class MainImageAddCell: UICollectionViewCell {
    // MARK: - Properties
    var imageType: ImageCellAddType = .photo
    var addButtonDidTapped: (()->())?
    // MARK: - IBOutlets
    @IBOutlet weak var addButton: UIButton!
    // MARK: - Actions
    @IBAction func addButtonDidTapped(_ sender: Any) {
        addButtonDidTapped?()
    }
}
