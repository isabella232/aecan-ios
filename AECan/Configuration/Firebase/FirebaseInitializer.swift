//
//  FirebaseInitializer.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 15/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Firebase

class FirebaseInitializer {
    
    static func initFirebase() {
        guard let options = getFirebaseOptions() else {
            print("Firebase NOT initialized. Error getting the options to configure.")
            return
        }
        FirebaseApp.configure(options: options)
    }
    
    private static func getFirebaseOptions() -> FirebaseOptions? {
        guard let fileName = getPlistFileName(), let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            print("Error initializing Firebase. Couldn't find the appropiate configuration file. App may crash.")
            return nil
        }
        
        if let options = FirebaseOptions(contentsOfFile: path) {
            return options
        } else {
            print("Error initializing Firebase. The configuration file does not exists or is invalid.")
            return nil
        }
    }
    
    private static func getPlistFileName() -> String? {
        let env = Environment.currentServerEnv
        let user = Environment.currentUserRole
        
        switch user {
        case .operario:
            switch env {
            case .development:
                return "GoogleService-Info-Operator-Dev"
            case .staging:
                return "GoogleService-Info-Operator-Staging"
            }
        case .usuario:
            switch env {
            case .development:
                return "GoogleService-Info-User-Dev"
            case .staging:
                return "GoogleService-Info-User-Staging"
            }
        }
    }
}
