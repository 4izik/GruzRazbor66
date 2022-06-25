//
//  ViewController.swift
//  GruzRazbor66
//
//  Created by Настя on 16.05.2022.
//

import UIKit
import Agrume

class MainViewController: UIViewController {
    // MARK: - Properties
    let property = ["Автомобиль","Цена","Остаток","Код","Артикул"]
    var model: DetailModel?
    var selectedImage: Int?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanerButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var addPhotoViewContainer: UIView!
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = setDefaultModel()
        setupUI()
    }
    
    private func setDefaultModel() -> DetailModel {
        let detail = DetailModel(auto: "МАЗ-6430А8-370-011 Тяг...", price: "3 000,00", balance: "5", id: "00001673", vendorCode: "5430-3101012")
        detail.addPhotos(photos: [UIImage(named: "Rectangle1")!, UIImage(named: "Rectangle2")!])
        return detail
    }
    
    func setupUI() {
        guard let model = model else { return }

        scanerButton.layer.cornerRadius = 6
        scanerButton.clipsToBounds = true
        scanerButton.setTitle("", for: .normal)
        customizeSearchField()
        
        basketButton.clipsToBounds = true
        basketButton.layer.cornerRadius = 6
        
        addPhotoViewContainer.isHidden = !model.photos.isEmpty
        photosCollectionView.isHidden = !addPhotoViewContainer.isHidden
    }
    
    
    
    
    fileprivate func customizeSearchField(){
        searchBar.backgroundColor = UIColor.init(red: 237, green: 237, blue: 237, alpha: 1)
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                searchTextField.heightAnchor.constraint(equalToConstant: 48),
                searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
                searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
                searchTextField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor)
            ])
            searchTextField.clipsToBounds = true
            searchTextField.layer.cornerRadius = 6.0
        
            let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.black]
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Поиск по коду", attributes: attributeDict)
            
            let glassIconView = searchTextField.leftView as! UIImageView
            glassIconView.image = glassIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView.tintColor = UIColor.black
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addPhotoDidTapped(_ sender: UIButton) {
    }
    
    
}


// MARK: - CollectionViewDelegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.propertyLabel.text = property[indexPath.row]
    switch indexPath.row {
        case 0: cell.valueLabel.text = model?.auto
        case 1: cell.valueLabel.text = model?.price
        case 2: cell.valueLabel.text = model?.balance
        case 3: cell.valueLabel.text = model?.id
        case 4: cell.valueLabel.text = model?.vendorСode
        default: cell.valueLabel.text = "test"
    }
        return cell
    }
}


// MARK: - CollectionViewDelegate and DataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.imageView.image = model?.photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photos = model?.photos else { return }
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        button.tintColor = .white
        let agrume = Agrume(images: photos, startIndex: indexPath.row, background: .colored(.black), dismissal: .withPanAndButton(.standard, button))
        agrume.show(from: self)
    }
    
}
