//
//  LoginVC.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import UIKit
import PKHUD


class LoginVC: UIViewController {
    
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loginButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet fileprivate weak var countryCodeLabel: UILabel!
    @IBOutlet private weak var sosialTitleLabel: UILabel!
    @IBOutlet private weak var helpLoginLabel: UILabel!
    
    private var countryList = CountryList()
    
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let users = DBManager.shared.getUserFromDB()
        if users.count != 0 {
            MainVC.show(from: self, user: users[0])
        }
    }
    
    
    //MARK: private
    
    private func setupUI() {
        alertLabel.text = "login_error".localized
        alertLabel.isHidden = true
        phoneTextField.attributedPlaceholder = NSAttributedString(
            string: "phone_number".localized,
            attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        )
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "password".localized,
            attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        )
        loginButton.setTitle("login".localized, for: .normal)
        loginButton.layer.cornerRadius = 5
        
        let tapOnCountryCode = UITapGestureRecognizer(
            target: self,
            action: #selector(clickCountryCodeLabel(tapGesture:))
        )
        countryCodeLabel.isUserInteractionEnabled = true
        countryCodeLabel.addGestureRecognizer(tapOnCountryCode)
        countryCodeLabel.textColor = UIColor.customBlue()
        let tapOnHelpLoginLabel = UITapGestureRecognizer(
            target: self,
            action: #selector(clickHelpLabel(tapGesture:))
        )
        helpLoginLabel.isUserInteractionEnabled = true
        helpLoginLabel.addGestureRecognizer(tapOnHelpLoginLabel)
        helpLoginLabel.text = "help_login".localized
        sosialTitleLabel.text = "sosial_title".localized
    }
    
    private func setup() {
        countryList.delegate = self
        disableLoginButton()
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange),
                            for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange),
                            for: UIControlEvents.editingChanged)
    }
    
    private func enableLoginButton() {
        loginButton.backgroundColor = UIColor.customBlue()
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.isUserInteractionEnabled = true
        loginButton.layer.borderWidth = 0
    }

    private func disableLoginButton() {
        loginButton.backgroundColor = UIColor.clear
        loginButton.setTitleColor(UIColor.darkGray, for: .normal)
        loginButton.isUserInteractionEnabled = false
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    //MARK: actions
    
    @IBAction private func loginButtonAction(_ sender: Any) {
        guard passwordTextField.text == "test" && phoneTextField.text == "961235555" else {
            showAlert()
            
            return
        }
        hideAlert()
        PKHUD.sharedHUD.show()
        API.shared.getUser(completion: { (result) in
            PKHUD.sharedHUD.hide()
            guard let user = result.value?.user else {
                return
            }
            MainVC.show(from: self, user: user)
        })
    }
    
    @objc private func clickCountryCodeLabel(tapGesture: UITapGestureRecognizer) {
        view.endEditing(true)
        
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc private func clickHelpLabel(tapGesture: UITapGestureRecognizer) {
        HelpLoginVC.show(from: self)
    }
    
    @objc private func textFieldDidChange() {
        guard let phone = phoneTextField.text, let pass = passwordTextField.text else {
            return
        }
        if phone.count == 9 && pass.count >= 4 {
           enableLoginButton()
        } else {
           disableLoginButton()
        }
    }
    
    private func showAlert() {
        guard alertLabel.isHidden else {
            return
        }
        loginButtonTopConstraint.constant += 60
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }) { [weak self] (finished) in
            self?.alertLabel.isHidden = false
        }
    }
    
    private func hideAlert() {
        guard !alertLabel.isHidden else {
            return
        }
        loginButtonTopConstraint.constant -= 60
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }) { [weak self] (finished) in
            self?.alertLabel.isHidden = true
        }
    }
}

extension LoginVC: CountryListDelegate {
    
    func selectedCountry(country: Country) {
        countryCodeLabel.text = "+" + country.phoneExtension
    }
}

