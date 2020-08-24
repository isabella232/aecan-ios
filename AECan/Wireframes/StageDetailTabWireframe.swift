//
//  StageDetailComponentWireframe.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 12/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class StageDetailTabWireframe {
    
    static func getViewController(tab: StageDetailTab, delegate: StageDetailTabPresenterDelegate?) -> StageDetailTabViewController {
        let vc = StageDetailTabViewController.instantiateFromStoryboard()
        let presenter = StageDetailTabPresenter(view: vc, tab: tab)
        vc.presenter = presenter
        presenter.delegate = delegate
        return vc
    }
}
