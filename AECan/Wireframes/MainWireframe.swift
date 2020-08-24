//
//  MainWireframe.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class MainWireframe {
    
    static func setMainViewController() {
        if SessionHelper.shared.isSessionStored() {
            showHome()
        } else {
            showLogin()
        }
    }
    
    private static func showHome() {
        let vc = getHomeViewController()
        UIApplication.shared.setRootViewController(UINavigationController(rootViewController: vc))
    }
    
    static func navigateToHome() {
        let vc = getHomeViewController()
        (UIApplication.shared.keyWindow?.rootViewController as? UINavigationController)?.setViewControllers([vc], animated: true)
    }
    
    private static func getHomeViewController() -> UIViewController {
        switch Environment.currentUserRole {
        case .operario:
            return getOperarioHomeViewController()
        case .usuario:
            return getUsuarioHomeViewController()
        }
    }
    
    private static func getOperarioHomeViewController() -> UIViewController {
        return LotTabsWireframe.getViewController()
    }
    
    private static func getUsuarioHomeViewController() -> UIViewController {
        // TODO: instantiate from wireframe ¿?
        return HomeTabsViewController.instantiateFromStoryboard()
    }
    
    private static func showLogin() {
        let vc = LoginWireframe.getViewController()
        UIApplication.shared.setRootViewController(UINavigationController(rootViewController: vc))
    }
}
