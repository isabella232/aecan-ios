//
//  LoginPresenter.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol: class {
    func login(email: String, password: String)
}

protocol LoginViewProtocol: class {
    func loginSuccess()
    func showError(message: String?)
}

class LoginPresenter: LoginPresenterProtocol {
    
    private weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol) {
        self.view = view
    }
    
    func login(email: String, password: String) {
        LoginRepository().login(email: email, password: password) { [weak self] (success, response, error) in
            guard success, let accessToken = response?.accessToken, let refreshToken = response?.refreshToken else {
                self?.view?.showError(message: error?.message)
                return
            }
            SessionHelper.shared.save(accessToken: accessToken, refreshToken: refreshToken)
            self?.view?.loginSuccess()
        }
    }
}
