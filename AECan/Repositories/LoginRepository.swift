//
//  LoginRepository.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class LoginRepository: OAuthRepository {
    
    typealias UserCompletion = (_ success: Bool, _ response: LoginResponse?, _ error: OAuthRepositoryError?) -> Void
    
    func login(email: String, password: String, completion: @escaping UserCompletion) {
        requestBuilder.login(email: email, password: password).responseObject { (response: DataResponse<LoginResponse>) in
            switch response.result {
            case .success(let value):
                completion(true, value, nil)
            case .failure(_):
                completion(false, nil, self.getError(from: response))
            }
        }
    }
}
