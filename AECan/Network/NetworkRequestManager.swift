//
//  NetworkRequestManager.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 28/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import Reqres

class NetworkRequestManager {
    var sessionManager: SessionManager!
    var retryRequest: DataRequest!
}

extension NetworkRequestManager: RequestAdapter {
    
    // Sends the access token in the Authorization header for every request
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        let appModeValue = Environment.currentUserRole.headerValue
        urlRequest.setValue(appModeValue, forHTTPHeaderField: "app-mode")
        
        let timeZoneOffsetInHours = TimeZone.current.secondsFromGMT() / 60 / 60
        urlRequest.setValue("\(timeZoneOffsetInHours)", forHTTPHeaderField: "time-zone")
        
        if let accessToken = SessionHelper.shared.getAccessToken() {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
}

extension NetworkRequestManager: RequestRetrier {

    // Tries to request a new access token using the refresh token when the server responds with a 401
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {

        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {

            // Retry when error="invalid_token" in www-authenticate header
            // www-authenticate: Bearer realm="Doorkeeper", error="invalid_token", error_description="The access token is invalid"
            guard (response.allHeaderFields["Www-Authenticate"] as? String)?.contains("invalid_token") ?? false else {
                completion(false, 0.0)
                return
            }

            if request.retryCount < 3 {
                refreshToken(completion: completion)
            } else {
                DispatchQueue.main.async {
                    completion(false, 0.0)
                    SessionHelper.shared.clearAll()
                    AppInitializer.goToLogin()
                }
            }
        } else {
            completion(false, 0.0)
        }
    }

    func refreshToken(completion: @escaping RequestRetryCompletion){
        guard let refreshToken = LocalAuthTokenStorage.shared.getRefreshToken() else {
            DispatchQueue.main.async {
                completion(false, 0.0)
                SessionHelper.shared.clearAll()
                AppInitializer.goToLogin()
            }
            return
        }

        // It has to be done with a different SessionManager
        let configuration = Reqres.defaultSessionConfiguration()
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        sessionManager = SessionManager(configuration: configuration)
        sessionManager.adapter = self

        retryRequest = ApiRequestBuilder(baseUrl: App.apiBaseUrl, defaultSessionManager: HttpManager.shared).refreshToken(refreshToken: refreshToken)

        retryRequest?.responseJSON(completionHandler: { (response) in
            if let result = response.result.value as? NSDictionary {
                if let token = result["access_token"] as? String {
                    print("NEW access_token: \(token)")
                    LocalAuthTokenStorage.shared.store(accessToken: token)
                }
                if let refreshToken = result["refresh_token"] as? String {
                    print("NEW refresh_token: \(refreshToken)")
                    LocalAuthTokenStorage.shared.store(refreshToken: refreshToken)
                }
            }
            completion(true, 0.2)
        })
    }
}

fileprivate extension Environment.UserRole {
    
    var headerValue: String {
        switch self {
        case .operario:
            return "operator"
        case .usuario:
            return "final"
        }
    }
}
