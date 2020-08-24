//
//  LotRepository.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class LotRepository: ApiRepository {
    typealias LotCompletion = (_ success: Bool, _ response: Lot?, _ error: ApiRepositoryError?) -> Void
    typealias LotListsCompletion = (_ success: Bool, _ response: [Lot]?, _ error: ApiRepositoryError?) -> Void
    
    func fetchDefaultData(completion: @escaping LotCompletion) {
        requestBuilder.lotDefaultInfo().responseObject { (response: DataResponse<LotResponse>) in
            switch response.result {
                case .success(let value):
                    completion(true, value.lot, nil)
                case .failure:
                    completion(false, nil, self.getError(from: response))
            }
        }
    }
    
    func createLot(request: NewLotRequest, completion: @escaping LotCompletion) {
        requestBuilder.createLot(request: request).responseObject { (response: DataResponse<LotResponse>) in
            switch response.result {
            case .success(let value):
                completion(true, value.lot, nil)
            case .failure:
                completion(false, nil, self.getError(from: response))
            }
        }
    }
    
    func fetchUserLots(completion: @escaping LotListsCompletion) {
        requestBuilder.fetchUserLots().responseObject { (response: DataResponse<LotsResponse>) in
            self.processLotsListResponse(response: response, completion: completion)
        }
    }
    
    func fetchStartedLots(completion: @escaping LotListsCompletion) {
        requestBuilder.fetchStartedLots().responseObject { (response: DataResponse<LotsResponse>) in
            self.processLotsListResponse(response: response, completion: completion)
        }
    }
    
    func fetchFinishedLots(completion: @escaping LotListsCompletion) {
        requestBuilder.fetchFinishedLots().responseObject { (response: DataResponse<LotsResponse>) in
           self.processLotsListResponse(response: response, completion: completion)
        }
    }
    
    private func processLotsListResponse(response: DataResponse<LotsResponse>, completion: @escaping LotListsCompletion) {
        switch response.result {
        case .success(let value):
            completion(true, value.lots, nil)
        case .failure:
            completion(false, nil, self.getError(from: response))
        }
    }
    
    func fetchLotDetail(lotId: Int, completion: @escaping LotCompletion) {
        requestBuilder.fetchLotDetail(lotId: lotId).responseObject { (response: DataResponse<LotResponse>) in
            switch response.result {
            case .success(let value):
                completion(true, value.lot, nil)
            case .failure:
                completion(false, nil, self.getError(from: response))
            }
        }
    }
}
