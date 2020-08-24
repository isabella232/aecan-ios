//
//  Environment.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 15/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

enum Environment {
    
    enum ServerEnv: String {
        case development
        case staging
    }
    
    enum UserRole: String {
        case operario
        case usuario
    }
    
    static var bundleInfo: [String: Any] {
        return Bundle.main.infoDictionary ?? [:]
    }
    
    static var bundleIdentifier: String {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            fatalError("Bundle.main.bundleIdentifier returned nil")
        }
        
        return bundleIdentifier
    }
    
    static var currentServerEnv: ServerEnv {
        guard let serverEnvValue = bundleInfo["SERVER_ENV"] as? String else {
            fatalError("SERVER_ENV variable not defined. Check Info.plist and User Defined Build Settings")
        }
        
        switch serverEnvValue {
        case "DEVELOPMENT":
            return .development
        case "STAGING":
            return .staging
        default:
            fatalError("SERVER_ENV variable value is invalid. Check Info.plist and User Defined Build Settings")
        }
    }
    
    static var currentUserRole: UserRole {
        guard let serverEnvValue = bundleInfo["USER_ROLE"] as? String else {
            fatalError("USER_ROLE variable not defined. Check Info.plist and User Defined Build Settings")
        }
        
        switch serverEnvValue {
        case "OPERARIO":
            return .operario
        case "USUARIO":
            return .usuario
        default:
            fatalError("USER_ROLE variable value is invalid. Check Info.plist and User Defined Build Settings")
        }
    }
}
