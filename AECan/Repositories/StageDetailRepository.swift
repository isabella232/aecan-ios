//
//  StageDetailRepository.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class StageDetailRepository: ApiRepository {
    typealias StageDetailCompletion = (_ success: Bool, _ result: StageDetailResponse? , _ error: ApiRepositoryError?) -> Void
    
    func fetchStageDetail(stageId: Int, completion: @escaping StageDetailCompletion) {
        requestBuilder.fetchStageDetail(stageId: stageId).responseObject(completionHandler: { (response: DataResponse<StageDetailResponse>) in
            
            switch response.result {
            case .success(let value):
                completion(true, value, nil)
            case .failure:
                completion(false, nil, self.getError(from: response))
            }
        })
    }
}
