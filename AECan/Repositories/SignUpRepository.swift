//
//  SignUpRepository.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 29/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class SignUpRepository: ApiRepository {
    
    typealias EmptyCompletion = (_ success: Bool, _ response: SignUpResponse?, _ error: ApiRepositoryError?) -> Void
    
    func signUp(user: User, completion: @escaping EmptyCompletion) {
        let email = user.email ?? ""
        let firstName = user.firstName ?? ""
        let lastName = user.lastName ?? ""
        let phone = user.phone ?? ""
        let password = user.password ?? ""
        
        requestBuilder.signUp(email: email, firstName: firstName, lastName: lastName, phone: phone, password: password).responseObject { (response: DataResponse<SignUpResponse>) in
            switch response.result {
                case .success(let value):
                    completion(true, value, nil)
                case .failure(_):
                    completion(false, nil, self.getError(from: response))
            }
        }
    }
}
