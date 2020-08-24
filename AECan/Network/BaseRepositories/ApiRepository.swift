//
//  ApiRepository.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

class ApiRepository: HttpRepository<ApiRequestBuilder, ApiRepositoryError> {
    
    init() {
        let requestBiulder = ApiRequestBuilder(baseUrl: App.apiBaseUrl, defaultSessionManager: HttpManager.shared)
        super.init(requestBuilder: requestBiulder)
    }
}
