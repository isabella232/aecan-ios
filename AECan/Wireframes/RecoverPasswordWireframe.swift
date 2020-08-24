//
//  RecoverPasswordWireframe.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class RecoverPasswordWireframe {
    static func getViewController () -> RecoverPasswordViewController {
        let vc = RecoverPasswordViewController.instantiateFromStoryboard()
         let presenter = RecoverPasswordPresenter(view: vc)
         vc.presenter = presenter
        return vc
    }
}
