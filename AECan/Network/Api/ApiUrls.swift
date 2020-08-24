//
//  ApiUrls.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 24/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

class ApiUrls {
    
    static var tokens = "users/token"
    static var users = "users"
    static var varieties = "varieties"
    static var beacons = "beacons"
    static var lotDefaultInfo = "lots/default_info"
    static var login = "users/token"
    static var recoverPassword = "recover_user_password_instructions"
    static var lots = "lots"
    static var userLots = "lots/index_assigned"
    static var finishedLots = "lots/index_finished"
    static var searchByIdentifier = "lots/search_by_identifier"
    static var stagesDetail = "lot_stages"
    static var checkStageFinish = "lot_stages/%@/ask_finish"
    static var stageFinish = "lot_stages/%@/finish"
    static var assignBeacons = "lot_stages/%@/assign_beacons"
}
