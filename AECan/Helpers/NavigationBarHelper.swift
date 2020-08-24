//
//  NavigationBarHelper.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 30/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class NavigationBarHelper {
    
    private let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func configureNavigationBar(title: String) {
        controller.navigationItem.title = title
        controller.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.montserratFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.ucBlackText100
        ]
        controller.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "navbar_back")
        controller.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "navbar_back")
        controller.navigationController?.navigationBar.tintColor = .accentColor100
        controller.navigationController?.navigationBar.barTintColor = .white
        controller.navigationController?.navigationBar.isTranslucent = false
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension UIViewController {
    
    var navBarHelper: NavigationBarHelper {
        return NavigationBarHelper(controller: self)
    }
}
