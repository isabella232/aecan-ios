//
//  ComponentActionRepository.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 26/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ComponentActionRepository: ApiRepository {
    
    typealias EmptyCompletion = (_ success: Bool, _ error: ApiRepositoryError?) -> Void
    
    func sendValue(urlPath: String, value: String?, completion: @escaping EmptyCompletion) {
        requestBuilder.sendComponentValue(urlPath: urlPath, value: value).responseData { (response) in
            switch response.result {
                case .success:
                    completion(true, nil)
                case .failure:
                    completion(false, self.getError(from: response))
            }
        }
    }
}
