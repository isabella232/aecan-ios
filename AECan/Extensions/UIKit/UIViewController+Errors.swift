//
//  UIViewController+DefaultErrorMessage.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayError(_ message: String?, completion: @escaping () -> Void) {
        showOkDialog(title: "", message: errorMessage(message)) { _ in
            completion()
        }
    }
    
    func displayError(_ message: String?) {
        showOkDialog(title: "", message: errorMessage(message))
    }
    
    func errorMessage(_ message: String?) -> String {
        return message ?? App.defaultErrorMessage
    }
}
