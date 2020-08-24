//
//  RecoverPasswordViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class RecoverPasswordViewController : UIViewController, ViewControllerWithLoadingOverlay {
    
    var loadingOverlay: LoadingOverlay = LoadingOverlay()
    
    // presenter
    var presenter: RecoverPasswordProtocol?
    
    // Outlets
    @IBOutlet private var emailTextField: FormTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // Actions
    @IBAction private func recoverPasswordTapped() {
        performRecoverPassword()
    }
    
    private func performRecoverPassword() {
        showLoadingOverlay()
        presenter?.sendInstructions(email: emailTextField?.textField?.text ?? "")
    }
    
    private func setupUI() {
        emailTextField?.textField?.keyboardType = .emailAddress
        emailTextField?.textField?.autocorrectionType = .no
    }
}

extension RecoverPasswordViewController: RecoverPasswordViewProtocol {
    func instructionsSent(email: String?) {
        hideLoadingOverlay()
        showOkDialog(title: "", message: "Instrucciones enviadas al correo indicado.") { _ in
            let vc = LoginWireframe.getViewController(email: email)
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    func showErrors(message: String?) {
        hideLoadingOverlay()
        displayError(message)
    }
}
