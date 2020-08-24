//
//  HttpRepository.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class HttpRepository<T: HttpRequestBuilder, U: HttpRepositoryError> {
        
    let requestBuilder: T
    
    init(requestBuilder: T) {
        self.requestBuilder = requestBuilder
    }
    
    func getError<T>(from response: DataResponse<T>) -> U {
        if
            let data = response.data,
            let jsonString = String(data: data, encoding: String.Encoding.utf8),
            var error = U(JSONString: jsonString) {
            error.httpStatusCode = response.response?.statusCode
            return error
        } else {
            var error = U()
            error.httpStatusCode = response.response?.statusCode
            return error
        }
    }
}
