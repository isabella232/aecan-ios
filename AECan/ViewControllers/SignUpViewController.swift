//
//  SignUpViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, ViewControllerWithLoadingOverlay {
    
    // Presenter
    var presenter: SignUpPresenterProtocol?
    
    // LoadingOverlay
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    
    // Outlets
    @IBOutlet private var firstNameTextField: FormTextField?
    @IBOutlet private var lastNameTextField: FormTextField?
    @IBOutlet private var emailTextField: FormTextField?
    @IBOutlet private var phoneTextField: FormTextField?
    @IBOutlet private var passwordTextField: FormTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarHelper.configureNavigationBar(title: "Registro")
        setupUI()
    }
    
    private func setupUI() {
        firstNameTextField?.textField?.autocorrectionType = .no
        firstNameTextField?.textField?.autocapitalizationType = .words
        lastNameTextField?.textField?.autocorrectionType = .no
        lastNameTextField?.textField?.autocapitalizationType = .words
        emailTextField?.textField?.keyboardType = .emailAddress
        emailTextField?.textField?.autocorrectionType = .no
        phoneTextField?.textField?.autocorrectionType = .no
        phoneTextField?.textField?.keyboardType = .phonePad
        passwordTextField?.textField?.autocorrectionType = .no
    }
    
    @IBAction private func signUpTapped() {
        let firstName = firstNameTextField?.text ?? ""
        let lastName = lastNameTextField?.text ?? ""
        let email = emailTextField?.text ?? ""
        let phone = phoneTextField?.text ?? ""
        let password = passwordTextField?.text ?? ""
            
        if (firstName == "" || lastName == "" || email == "" || phone == "" || password == "") {
            displayError("No puede haber campos en blanco.")
        } else {
            showLoadingOverlay()
            presenter?.signUp(email: email, password: password, firstName: firstName, lastName: lastName, phone: phone)
        }
    }
}

extension SignUpViewController: SignUpViewProtocol {
    func signUpSuccess(email: String?, message: String?) {
        hideLoadingOverlay()
        showOkDialog(title: "", message: message) { _ in
            let vc = LoginWireframe.getViewController(email: email)
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    func showError(message: String?) {
        hideLoadingOverlay()
        displayError(message)
    }
}
