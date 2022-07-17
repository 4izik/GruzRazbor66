//
//  SettingsViewController.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 14.07.2022.
//

import UIKit
import Alamofire
import SwiftValidator
import Toast_Swift

class SettingsViewController: UIViewController, ValidationDelegate {
    
    // MARK: - Properties
    
    private let apiController = APIController.shared
    private let validator = Validator()
    
    // MARK: - IBOutlets
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var disconnectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidator()
    }
    
    private func setupValidator() {
        validator.registerField(loginTF, rules: [RequiredRule()])
        validator.registerField(passwordTF, rules: [RequiredRule()])
    }
    
    private func logIn() {
        self.view.makeToastActivity(.center)
        guard let password = passwordTF.text, let login = loginTF.text else { return }
        let strBase64 = "\(login):\(password)".encodeBase64()
        let headers: HTTPHeaders = ["Authorization":"Basic \(strBase64)"]
        apiController.testSecureConnection(headers: headers) { result in
            self.view.hideToastActivity()
            switch result {
            case .success(_):
                UserDefaults.standard.set(strBase64, forKey: "loginAndPass")
                DispatchQueue.main.async {
                    self.updateUI(isConnected: true)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription, duration: 3.0, position: .top)
                DispatchQueue.main.async {
                    self.updateUI(isConnected: false)
                }
            }
        }
    }
    
    private func updateUI(isConnected: Bool) {
        connectedLabel.isHidden = !isConnected
        connectButton.isHidden = !connectedLabel.isHidden
        disconnectButton.isHidden = !connectButton.isHidden
    }
    
    @IBAction func connectDidTapped(_ sender: Any) {
        validator.validate(self)
    }
    
    @IBAction func disconnectButtonDidTaped(_ sender: Any) {
        updateUI(isConnected: false)
        self.view.makeToast("Successfully disconnected")
        UserDefaults.standard.set("", forKey: "loginAndPass")
    }
    
}


// MARK: - ValidationDelegate
extension SettingsViewController {
    func validationSuccessful() {
        updateTF()
        logIn()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
                field.shakeHorizontally()
                field.placeholder = error.errorMessage
            }
        }
    }
    
    private func updateTF() {
        self.passwordTF.layer.borderColor = UIColor.black.cgColor
        self.loginTF.layer.borderColor = UIColor.black.cgColor
        self.passwordTF.placeholder = "Пароль"
        self.loginTF.placeholder = "Имя пользователя"
    }
}
