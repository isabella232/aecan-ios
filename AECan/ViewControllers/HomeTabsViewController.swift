//
//  HomeTabsViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 04/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class HomeTabsViewController: UIViewController, TopTabsViewController {
    var tabBarView: TopTabBar?
    
    var tabsPageVCDataSource: PageViewControllerDataSource?
    
    var tabsPageViewController: UIPageViewController?
    
    
    // TopTabsViewController
    @IBOutlet var tabBarContainer: UIView?
    @IBOutlet var tabContentContainer: UIView?
    var containedViewControllers: [UIViewController] = []
    var tabsTitles: [String] = []
    var currentContainedViewController: UIViewController?
    
    // Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarHelper.configureNavigationBar(title: "Búsqueda")
        setupControllers()
        setupTopTabBar()
        
        let button = UIBarButtonItem(title: "Salir", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func logout() {
        SessionHelper.shared.clearAll()
        let vc = LoginWireframe.getViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    private func setupControllers() {
        tabsTitles = ["Búsqueda", "Lotes"]
        
        let vc1 = SearchHomeWireframe.getViewController()
//        vc1.view.backgroundColor = .blue

        let vc2 = LotListWireframe.getViewController(mode: .userList)
//        vc2.view.backgroundColor = .yellow
//
        containedViewControllers = [vc1, vc2]
    }
    
    func tabWasChanged(to index: Int) {
    }
}
    
