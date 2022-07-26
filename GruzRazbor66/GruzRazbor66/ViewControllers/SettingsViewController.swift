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
    @IBOutlet weak var connectTo1CLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var loginTF: UITextField! {
        didSet {
            loginTF.attributedPlaceholder = NSAttributedString(string: "Имя пользователя", attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.boldSystemFont(ofSize: 15.0)
            ])
        }
    }
    @IBOutlet weak var passwordTF: UITextField! {
        didSet {
            passwordTF.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.boldSystemFont(ofSize: 15.0)
            ])
        }
    }
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var textFieldsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidator()
        updateUI(isConnected: UserDefaults.standard.bool(forKey: "isLoggedIn"))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        loginTF.attributedPlaceholder = NSAttributedString(string: "Имя пользователя", attributes: [.foregroundColor : UIColor.lightGray, .font: UIFont.boldSystemFont(ofSize: 15)])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor : UIColor.lightGray, .font: UIFont.boldSystemFont(ofSize: 15)])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        loginTF.attributedPlaceholder = NSAttributedString(string: "Имя пользователя", attributes: [.foregroundColor : UIColor.lightGray, .font: UIFont.boldSystemFont(ofSize: 15)])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor : UIColor.lightGray, .font: UIFont.boldSystemFont(ofSize: 15)])
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
                self.view.endEditing(true)
                UserDefaults.standard.set(strBase64, forKey: "loginAndPass")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(login, forKey: "login")
                DispatchQueue.main.async {
                    self.updateUI(isConnected: true)
                }
            case .failure(let error):
                self.view.makeToast(error.localizedDescription, duration: 3.0, position: .center)
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
        textFieldsStackView.isHidden = !disconnectButton.isHidden
        secondLabel.isHidden = textFieldsStackView.isHidden
        if isConnected {
            if let login = UserDefaults.standard.value(forKey: "login") {
                connectTo1CLabel.text = "Пользователь - \(login)"
            } else {
                connectTo1CLabel.text = "Подключение к 1С"
            }
        } else {
            connectTo1CLabel.text = "Подключение к 1С"
        }
    }
    
    @IBAction func connectDidTapped(_ sender: Any) {
        validator.validate(self)
    }
    
    @IBAction func disconnectButtonDidTaped(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "loginAndPass")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.set(nil, forKey: "login")
        updateUI(isConnected: false)
        loginTF.text = ""
        passwordTF.text = ""
        self.view.makeToast("Успешный выход", duration: 3.0, position: .top)
    }
    
}


// MARK: - ValidationDelegate
extension SettingsViewController {
    func validationSuccessful() {
        loginTF.attributedPlaceholder = NSAttributedString(string: "Имя пользователя", attributes: [.foregroundColor : UIColor.lightGray, .font: UIFont.boldSystemFont(ofSize: 15)])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor : UIColor.lightGray, .font: UIFont.boldSystemFont(ofSize: 15)])
        logIn()
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, _) in errors {
            if let field = field as? UITextField {
                field.shakeHorizontally()
                field.attributedPlaceholder = NSAttributedString(string: "Это поле обязательно!", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            }
        }
    }
}
