//
//  StageDetailWireframe.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 11/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailWireframe {
    
    static func getViewController(stageId: Int?, lotIdentifier: String?) -> StageDetailViewController {
        let vc = StageDetailViewController.instantiateFromStoryboard()
        let presenter = StageDetailPresenter(view: vc, stageId: stageId)
        vc.presenter = presenter
        vc.lotIdentifierText = lotIdentifier
        return vc
    }
}
