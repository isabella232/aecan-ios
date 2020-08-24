//
//  LocalAuthTokenStorage.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 28/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import KeychainSwift

class LocalAuthTokenStorage {
    
    public static let shared = LocalAuthTokenStorage()
    
    lazy private var keychain = KeychainSwift()
    
    private init() { }
    
    func store(accessToken: String) {
        keychain.set(accessToken, forKey: .accessToken)
    }
    
    func store(refreshToken: String) {
        keychain.set(refreshToken, forKey: .refreshToken)
    }
    
    func isAccessTokenStored() -> Bool {
        return keychain.get(.accessToken) != nil
    }
    
    func isRefreshTokenStored() -> Bool {
        return keychain.get(.refreshToken) != nil
    }
    
    func getAccessToken() -> String? {
        return keychain.get(.accessToken)
    }
    
    func getRefreshToken() -> String? {
        return keychain.get(.refreshToken)
    }
    
    func deleteTokens() {
        keychain.clear()
    }
}

// Keys
fileprivate extension String {
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
}
