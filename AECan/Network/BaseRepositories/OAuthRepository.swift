//
//  OAuthRepository.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

class OAuthRepository: HttpRepository<ApiRequestBuilder, OAuthRepositoryError> {
    
    init() {
        let requestBiulder = ApiRequestBuilder(baseUrl: App.apiBaseUrl, defaultSessionManager: HttpManager.shared)
        super.init(requestBuilder: requestBiulder)
    }
}
