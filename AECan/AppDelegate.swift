//
//  AppDelegate.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 14/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // App initialization
        AppInitializer.initApp()
        
        // Override point for customization after application launch.
        Log.configureLog()
        
        log.debug(SessionHelper.shared.isSessionStored())
        log.debug(SessionHelper.shared.getAccessToken())
        log.debug(SessionHelper.shared.getRefreshToken())
        
        return true
    }
}
