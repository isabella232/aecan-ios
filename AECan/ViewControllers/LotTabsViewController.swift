//
//  LotTabsViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

class LotTabsViewController: UIViewController, TopTabsViewController {
    var tabBarView: TopTabBar?
    
    var tabsPageVCDataSource: PageViewControllerDataSource?
    
    var tabsPageViewController: UIPageViewController?
    
    
    // NavbarProtocol
//    @IBOutlet var headerContainer: UIView?
//    var headerView: CustomNavbarView?
    
    // TopTabsViewController
    @IBOutlet var tabBarContainer: UIView?
    @IBOutlet var tabContentContainer: UIView?
    var containedViewControllers: [UIViewController] = []
    var tabsTitles: [String] = []
    var currentContainedViewController: UIViewController?
    
    // Data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
        setupTopTabBar()
        navBarHelper.configureNavigationBar(title: "Listado de lotes")
        
        // Temporary logout - TODO has to be removed
        let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = button
    }
    
    // Temporary logout - TODO has to be removed
    @objc private func logout() {
        SessionHelper.shared.clearAll()
        let vc = LoginWireframe.getViewController()
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    private func setupControllers() {
        tabsTitles = ["En curso", "Finalizados"]
        
        // inCourse
        let vc1 = LotListWireframe.getViewController(mode: .startedList)

        // finished
        let vc2 = LotListWireframe.getViewController(mode: .finishedList)

        containedViewControllers = [vc1 , vc2]
    }
    
    func tabWasChanged(to index: Int) {
    }
    
    @IBAction private func newLotTapped() {
        let vc = NewLotWireframe.getViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
