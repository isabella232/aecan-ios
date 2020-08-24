//
//  AppVersion.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 15/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

enum AppVersion {
    
    static var version: String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? ""
    }
    
    static var build: String {
        return (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? ""
    }
    
    static var versionAndBuild: String {
        return "\(version) (\(build))"
    }
}
