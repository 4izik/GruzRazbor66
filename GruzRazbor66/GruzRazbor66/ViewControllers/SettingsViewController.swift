//
//  SettingsViewController.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 14.07.2022.
//

import UIKit
import Alamofire

class SettingsViewController: UIViewController {
    
    private let apiController = APIController.shared

    @IBOutlet weak var serverAdressTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var secureConnectionSwitch: UISwitch!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var disconnectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func secureSwitchDidTapped(_ sender: Any) {
        
    }
    
    @IBAction func connectDidTapped(_ sender: Any) {
        apiController.testSecureConnection(params: ["":""], headers: HTTPHeaders()) { result in
            
        }
    }
    @IBAction func disconnectButtonDidTaped(_ sender: Any) {
    }
    
}
