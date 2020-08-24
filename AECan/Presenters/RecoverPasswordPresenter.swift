//
//  RecoverPasswordPresenter.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

protocol RecoverPasswordProtocol: class {
    func sendInstructions(email: String)
}

protocol RecoverPasswordViewProtocol: class {
    func instructionsSent(email: String?)
    func showErrors(message: String?)
}

class RecoverPasswordPresenter: RecoverPasswordProtocol {
    
    private weak var view: RecoverPasswordViewProtocol?
    
    init(view: RecoverPasswordViewProtocol) {
        self.view = view
    }
    
    func sendInstructions(email: String) {
        RecoverPasswordRepository().recoverPassword(email: email) { [weak self] (success, error) in
            guard success else {
                self?.view?.showErrors(message: error?.message)
                return
            }
            
            self?.view?.instructionsSent(email: email)
        }
    }
}
