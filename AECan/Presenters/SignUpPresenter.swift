//
//  SignUpPresenter.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol SignUpPresenterProtocol: class {
    func signUp(email: String, password: String?, firstName: String?, lastName: String?, phone: String?)
}

protocol SignUpViewProtocol: class {
    func signUpSuccess(email: String?, message: String?)
    func showError(message: String?)
}

class SignUpPresenter: SignUpPresenterProtocol {
    
    private weak var view: SignUpViewProtocol?
    
    init(view: SignUpViewProtocol) {
        self.view = view
    }
    
    func signUp(email: String, password: String?, firstName: String?, lastName: String?, phone: String?) {
        let user = User()
        user.email = email
        user.password = password
        user.firstName = firstName
        user.lastName = lastName
        user.phone = phone
        
        SignUpRepository().signUp(user: user) { [weak self] (success, response, error) in
            guard success, let response = response else {
                self?.view?.showError(message: error?.message)
                return
            }
            self?.view?.signUpSuccess(email: response.email, message: response.successMessage)
        }
    }
}
