//
//  ViewController.swift
//  GruzRazbor66
//
//  Created by Настя on 16.05.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var scanerButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
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

