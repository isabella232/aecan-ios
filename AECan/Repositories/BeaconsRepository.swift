//
//  BeaconsRepository.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class BeaconsRepository: ApiRepository {
    
    typealias FetchBeaconsCompletion = (_ success: Bool, _ response: [Beacon]?, _ error: ApiRepositoryError?) -> Void
    
    func fetchBeacons(completion: @escaping FetchBeaconsCompletion) {
        requestBuilder.beacons().responseObject { (response: DataResponse<BeaconsResponse>) in
            switch response.result {
                case .success(let value):
                    completion(true, value.beacons, nil)
                case .failure:
                    completion(false, nil, self.getError(from: response))
            }
        }
    }
    
    typealias EmptyCompletion = (_ success: Bool, _ error: ApiRepositoryError?) -> Void
    
    func updateBeacons(_ beacons: [Beacon], forLotStageId lotStageId: String, completion: @escaping EmptyCompletion) {
        let beaconIds = beacons.compactMap({$0.id})
        requestBuilder.assignBeacons(stageId: lotStageId, beaconIds: beaconIds).responseData { (response) in
            switch response.result {
            case .success:
                completion(true, nil)
            case .failure:
                completion(false, self.getError(from: response))
            }
        }
    }
}
