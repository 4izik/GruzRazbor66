//
//  CarViewController.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 26.07.2022.
//

import UIKit

class CarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var list = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let product = list[indexPath.row]
        cell.product = product
        cell.deleteDidTapped = {
            print("delete")
        }
        cell.stepperChanged = {
            print("stepper")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
}
