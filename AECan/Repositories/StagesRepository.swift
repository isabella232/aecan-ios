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

class StagesRepository: ApiRepository {
    
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
    
    typealias StageFinishCheckCompletion = (_ success: Bool, _ result: StageFinishCheckResponse? , _ error: ApiRepositoryError?) -> Void
    
    func checkIfStageCanBeFinished(stageId: Int, completion: @escaping StageFinishCheckCompletion) {
        requestBuilder.checkStageFinish(stageId: stageId).responseObject { (response: DataResponse<StageFinishCheckResponse>) in
         
            switch response.result {
            case .success(let value):
                completion(true, value, nil)
            case .failure:
                completion(false, nil, self.getError(from: response))
            }
        }
    }
    
    typealias EmptyCompletion = (_ success: Bool, _ error: ApiRepositoryError?) -> Void
    
    func finishStage(stageId: Int, completion: @escaping EmptyCompletion) {
        requestBuilder.finishStage(stageId: stageId).responseData { (response) in
            switch response.result {
            case .success:
                completion(true, nil)
            case .failure:
                completion(false, self.getError(from: response))
            }
        }
    }
}
