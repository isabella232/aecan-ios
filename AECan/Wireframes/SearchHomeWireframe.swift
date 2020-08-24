//
//  SearchHomeWireframe.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 06/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeWireframe {
    
    static func getViewController() -> SearchHomeViewController {
        let vc = SearchHomeViewController.instantiateFromStoryboard()
        let presenter = SearchHomePresenter(view: vc)
        vc.presenter = presenter
        
        return vc
    }
}
