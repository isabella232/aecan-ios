//
//  RecoverPasswordRepository.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RecoverPasswordRepository: ApiRepository {
    typealias RecoverPasswordCompletion = (_ success: Bool, _ error: ApiRepositoryError?) -> Void
    
    func recoverPassword(email: String, completion: @escaping RecoverPasswordCompletion) {
        requestBuilder.recoverPassword(email: email).responseObject { (response: DataResponse<JsonEmptyResponse>) in
            switch response.result {
            case .success:
                completion(true, nil)
            case .failure:
                completion(false, self.getError(from: response))
            }
        }
    }
}
