//
//  VarietiesRepository.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class VarietiesRepository: ApiRepository {
    typealias FetchVarietiesCompletion = (_ success: Bool, _ response: [Variety]?, _ error: ApiRepositoryError?) -> Void
    
    func fetchVarieties(completion: @escaping FetchVarietiesCompletion) {
        requestBuilder.varieties().responseObject { (response: DataResponse<VarietiesResponse>) in
            switch response.result {
            case .success(let value):
                completion(true, value.varieties, nil)
            case .failure:
                completion(false, nil, self.getError(from: response))
            }
        }
    }
}
