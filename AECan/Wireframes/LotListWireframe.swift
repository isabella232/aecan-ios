//
//  LotListWireframe.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 03/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotListWireframe {
    
    static func getViewController(mode: LotListPresenter.ListMode) -> LotListViewController {
        let vc = LotListViewController.instantiateFromStoryboard()
        let presenter = LotListPresenter(view: vc)
        vc.presenter = presenter
        presenter.mode = mode
        
        return vc
    }
}
