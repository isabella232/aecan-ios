//
//  LoginWireframe.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

class LoginWireframe {
    
    static func getViewController(email: String? = nil) -> LoginViewController {
        let vc = LoginViewController.instantiateFromStoryboard()
        let presenter = LoginPresenter(view: vc)
        vc.presenter = presenter
        vc.email = email
        return vc
    }
}
