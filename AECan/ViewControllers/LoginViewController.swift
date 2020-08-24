//
//  LoginViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, ViewControllerWithLoadingOverlay {
    
    // Presenter
    var presenter: LoginPresenterProtocol?
    
    // LoadingOverlay
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    
    var email: String?
    
    // Outlets
    @IBOutlet private var emailTextField: FormTextField?
    @IBOutlet private var passwordTextField: FormTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarHelper.configureNavigationBar(title: "")
        setupUI()
    }
    
    private func setupUI() {
        if let email = email {
            emailTextField?.textField?.text = email
        }
        emailTextField?.textField?.keyboardType = .emailAddress
        emailTextField?.textField?.autocorrectionType = .no
        passwordTextField?.textField?.autocorrectionType = .no
    }
    
    @IBAction private func loginButtonTapped() {
        performLogin()
    }
    
    @IBAction private func signUpButtonTapped() {
        let vc = SignUpWireframe.getViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func handleRecoverPasswordTapped() {
        let vc = RecoverPasswordWireframe.getViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func performLogin() {
        let email = emailTextField?.text ?? ""
        let password = passwordTextField?.text ?? ""
        
        if email == "" || password == "" {
            displayError("Email y contraseña no pueden estar en blanco.")
        } else {
            showLoadingOverlay()
            presenter?.login(email: email, password: password)
        }
    }
}

extension LoginViewController: LoginViewProtocol {
    
    func loginSuccess() {
        hideLoadingOverlay()
        MainWireframe.navigateToHome()
    }
    
    func showError(message: String?) {
        hideLoadingOverlay()
        displayError(message)
    }
}
