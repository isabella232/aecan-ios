//
//  ApiRequestBuilder.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import Alamofire

class ApiRequestBuilder: HttpRequestBuilder {

    func login(email: String, password: String) -> DataRequest {
        let params = [
            "email": email,
            "password": password,
            "grant_type": "password"
        ]
        return getRequest(path: ApiUrls.tokens, method: .post, params: params)
    }
    
    func signUp(email: String, firstName: String, lastName: String, phone: String, password: String) -> DataRequest {
        let params = [
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "phone_number": phone,
            "password": password,
            "password_confirmation": password
        ]
        return getRequest(path: ApiUrls.users, method: .post, params: params)
    }
    
    func refreshToken(refreshToken: String) -> DataRequest {
        let params = [
            "refresh_token": refreshToken,
            "grant_type": "refresh_token"
        ]
        return getRequest(path: ApiUrls.tokens, method: .post, params: params)
    }
    
    func varieties() -> DataRequest {
        return getRequest(path: ApiUrls.varieties, method: .get)
    }
    
    func recoverPassword(email: String) -> DataRequest {
        return getRequest(path: ApiUrls.recoverPassword, method: .post, params: ["email": email])
    }
    
    // MARK: - Beacons
    func beacons() -> DataRequest {
        return getRequest(path: ApiUrls.beacons, method: .get)
    }
    
    func assignBeacons(stageId: String, beaconIds: [Int]) -> DataRequest {
        let url = String(format: ApiUrls.assignBeacons, stageId)
        let params = ["beacon_ids": beaconIds]
        return getRequest(path: url, method: .post, params: params)
    }
    
    
    func lotDefaultInfo() -> DataRequest {
        return getRequest(path: ApiUrls.lotDefaultInfo, method: .get)
    }
    
    // MARK: - Lots
    func createLot(request: NewLotRequest) -> DataRequest {
        let params = request.toJSON()
        
        return getRequest(path: ApiUrls.lots, method: .post, params: params)
    }
    
    func fetchUserLots() -> DataRequest {
        return getRequest(path: ApiUrls.userLots, method: .get)
    }
    
    func fetchStartedLots() -> DataRequest {
        return getRequest(path: ApiUrls.lots, method: .get)
    }
    
    func fetchFinishedLots() -> DataRequest {
        return getRequest(path: ApiUrls.finishedLots, method: .get)
    }
    
    func fetchLotDetail(lotId: Int) -> DataRequest {
        return getRequest(path: ApiUrls.lots + "/\(lotId)", method: .get)
    }
    
    func searchLotByIdentifier(identifier: String) -> DataRequest {
        return getRequest(path: ApiUrls.searchByIdentifier, method: .get, params: ["identifier": identifier])
    }
    
    // MARK: - Stages
    
    func fetchStageDetail(stageId: Int) -> DataRequest {
        return getRequest(path: ApiUrls.stagesDetail + "/\(stageId)", method: .get)
    }
    
    func sendComponentValue(urlPath: String, value: String?) -> DataRequest {
        return getRequest(path: urlPath, method: .post, params: ["value": value as Any])
    }
    
    func checkStageFinish(stageId: Int) -> DataRequest {
        let url = String(format: ApiUrls.checkStageFinish, "\(stageId)")
        let params = ["test_finish_stage": "true"]
        return getRequest(path: url, method: .get, params: params)
    }
    
    func finishStage(stageId: Int) -> DataRequest {
        let url = String(format: ApiUrls.stageFinish, "\(stageId)")
        return getRequest(path: url, method: .post)
    }
}
