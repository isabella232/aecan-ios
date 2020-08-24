//
//  HttpRequestBuilder.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class HttpRequestBuilder {
    
    let baseUrl: String
    let defaultSessionManager: SessionManager
    var encodingForGetRequests: ParameterEncoding = URLEncoding.queryString
    var encodingForOtherRequests: ParameterEncoding = Alamofire.JSONEncoding.default
    
    init(baseUrl: String, defaultSessionManager: SessionManager) {
        self.baseUrl = baseUrl
        self.defaultSessionManager = defaultSessionManager
    }
    
    func getRequest(path: String, method: Alamofire.HTTPMethod) -> DataRequest {
        return getRequest(path: path, method: method, params: [:])
    }
    
    func getRequest(path: String, method: Alamofire.HTTPMethod, params: Mappable) -> DataRequest {
        return getRequest(path: path, method: method, params: params.toJSON())
    }
    
    func getRequest(path: String, method: Alamofire.HTTPMethod, params: Parameters) -> DataRequest {
        return getRequest(manager: defaultSessionManager, path: path, method: method, params: params)
    }
    
    func getRequest(manager: SessionManager, path: String, method: Alamofire.HTTPMethod, params: Parameters) -> DataRequest {
        return manager.request(getCompleteUrl(path: path),
                               method: method,
                               parameters: params,
                               encoding: getEncoding(forMethod: method),
                               headers: getHTTPHeaders(forPath: path)).validate()
    }
    
    func getCompleteUrl(path: String) -> String {
        return baseUrl + path
    }
    
    func getEncoding(forMethod method: Alamofire.HTTPMethod) -> ParameterEncoding {
        if method == .get {
            return encodingForGetRequests
        } else {
            return encodingForOtherRequests
        }
    }
    
    func getHTTPHeaders(forPath path: String) -> HTTPHeaders {
        return [:]
    }
}
