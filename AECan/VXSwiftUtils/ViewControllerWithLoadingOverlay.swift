//
//  UIViewController+WithLoadingOverlay.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerWithLoadingOverlay where Self:UIViewController {
    var loadingOverlay: LoadingOverlay { get }
    func showLoadingOverlay()
    func hideLoadingOverlay()
}

extension ViewControllerWithLoadingOverlay {
    func showLoadingOverlay() {
        loadingOverlay.show(over: view)
    }
    func hideLoadingOverlay() {
        loadingOverlay.hide()
    }
}
