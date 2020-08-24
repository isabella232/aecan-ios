//
//  LotTabsWireframe.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotTabsWireframe {
    static func getViewController() -> LotTabsViewController {
        return LotTabsViewController.instantiateFromStoryboard()
    }
}
