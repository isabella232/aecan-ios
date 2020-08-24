//
//  SignUpWireframe.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

class SignUpWireframe {
    
    static func getViewController() -> SignUpViewController {
        let vc = SignUpViewController.instantiateFromStoryboard()
        let presenter = SignUpPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
}
