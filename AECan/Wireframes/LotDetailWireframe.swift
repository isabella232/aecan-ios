//
//  LotDetailWireframe.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 10/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotDetailWireframe {
    
    static func getViewController(lotId: Int) -> LotDetailViewController {
        let vc = LotDetailViewController.instantiateFromStoryboard()
        let presenter = LotDetailPresenter(view: vc, lotId: lotId)
        vc.presenter = presenter
        return vc
    }
}
