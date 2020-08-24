//
//  SearchHomeRepository.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 06/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class SearchHomeRepository: ApiRepository {
    typealias SearchLotCompletion = (_ success: Bool, _ response: Lot?, _ error: ApiRepositoryError?) -> Void
    
    func searchLotByIdentifier(identifier: String, completion: @escaping SearchLotCompletion) {
        requestBuilder.searchLotByIdentifier(identifier: identifier).responseObject { (response: DataResponse<LotResponse>) in
            switch response.result {
            case .success(let value):
                completion(true, value.lot, nil)
            case .failure:
                completion(false, nil, self.getError(from: response))
            }
        }
    }
}
