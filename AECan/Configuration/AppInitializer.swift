//
//  AppInitializer.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 15/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

class AppInitializer {
    
    static func initApp() {
        FirebaseInitializer.initFirebase()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .accentColor100
        setRootViewController()
    }
    
    static func setRootViewController() {
        MainWireframe.setMainViewController()
    }
    
    static func goToLogin() {
        setRootViewController()
    }
}
