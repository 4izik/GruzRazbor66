//
//  ViewController.swift
//  GruzRazbor66
//
//  Created by Настя on 16.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    let property = ["Автомобиль","Цена","Остаток","Код","Артикул"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanerButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var basketButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    

    
    func setupUI() {
        scanerButton.layer.cornerRadius = 6
        scanerButton.clipsToBounds = true
        scanerButton.setTitle("", for: .normal)
        customizeSearchField()
        
        basketButton.clipsToBounds = true
        basketButton.layer.cornerRadius = 6
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
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.propertyLabel.text = property[indexPath.row]
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.imageView.image = UIImage(named: "Rectangle\(indexPath.row + 1)")
        return cell
    }
    
    
}
