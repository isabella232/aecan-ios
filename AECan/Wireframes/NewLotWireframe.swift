//
//  NewLotWireframe.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation

class NewLotWireframe {
    
    static func getViewController() -> NewLotViewController {
        let vc = NewLotViewController.instantiateFromStoryboard()
        let presenter = NewLotPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
}
