//
//  SessionHelper.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 28/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

class SessionHelper {
    
    public static let shared = SessionHelper()
    
    let defaults = UserDefaults.standard
    let sessionDefaultsKey = "SessionHelper.Session"
    let userDefaultsKey = "SessionHelper.User"
    
    private init() { }
    
    func save(accessToken: String, refreshToken: String) {
        LocalAuthTokenStorage.shared.store(accessToken: accessToken)
        LocalAuthTokenStorage.shared.store(refreshToken: refreshToken)
        defaults.set(true, forKey: sessionDefaultsKey)
    }
    
    func save(user: User) {
        defaults.set(user.toJSONString(), forKey: userDefaultsKey)
    }
    
    func isSessionStored() -> Bool {
        return defaults.bool(forKey: sessionDefaultsKey)
    }
    
    func getAccessToken() -> String? {
        LocalAuthTokenStorage.shared.getAccessToken()
    }
    
    func getRefreshToken() -> String? {
        LocalAuthTokenStorage.shared.getRefreshToken()
    }
    
    func getUser() -> User? {
        guard
            let userJson = defaults.string(forKey: userDefaultsKey),
            let user = User(JSONString: userJson)
            else { return nil }
        
        return user
    }
    
    func clearAll() {
        LocalAuthTokenStorage.shared.deleteTokens()
        defaults.removeObject(forKey: userDefaultsKey)
        defaults.removeObject(forKey: sessionDefaultsKey)
    }
}
