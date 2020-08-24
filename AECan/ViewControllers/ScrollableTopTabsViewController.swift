//
//  LotTabsViewController.swift
//  AECan
//
//  Created by Edgardo Martin Gerez on 31/01/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit

protocol ScrollableTopTabsViewController: ScrollableTopTabBarDelegate where Self: UIViewController {
    
    var tabBarContainer: UIView? { get }
    var tabBarView: ScrollableTopTabBar? { get set }
    var tabContentContainer: UIView? { get }
    var tabsPageViewController: UIPageViewController? { get set }
    var containedViewControllers: [UIViewController] { get }
    var tabsTitles: [ScrollableTopTabBar.ScrollableTopTab] { get }
    var currentContainedViewController: UIViewController? { get set }
    var tabsPageVCDataSource: PageViewControllerDataSource? { get set }
    
    func tabWasChanged(to index: Int)
    func tabWasManuallyChanged(to index: Int)
}

extension ScrollableTopTabsViewController {
    
    func setupTopTabBar() {
        let tabBarView = ScrollableTopTabBar.instantiateFromXib()
        tabBarView.delegate = self
        tabBarContainer?.addEmbedded(view: tabBarView)
        tabBarView.tabsTitles = tabsTitles
        tabBarView.selectTab(at: 0)
        setupPageViewController()
        showControllerForTab(at: 0)
        self.tabBarView = tabBarView
    }
    
    func top(tabBar: ScrollableTopTabBar, didSelectTabAt index: Int) {
        tabWasManuallyChanged(to: index)
        showControllerForTab(at: index)
    }
    
    func showControllerForTab(at index: Int) {
        show(viewController: containedViewControllers[index])
        tabWasChanged(to: index)
    }
    
    private func setupPageViewController() {
        guard let tabContentContainer = tabContentContainer else { return }
        let tabsPageVCDataSource = PageViewControllerDataSource()
        
        tabsPageVCDataSource.getControllerAfter = { vc in
            return self.pageViewController(viewControllerAfter: vc)
        }
        
        tabsPageVCDataSource.getControllerBefore = { vc in
            return self.pageViewController(viewControllerBefore: vc)
        }
        
        tabsPageVCDataSource.transitionDidFinish = { vc in
            self.pageViewController(didFinishTransitionTo: vc)
        }
        
        self.tabsPageVCDataSource = tabsPageVCDataSource
        
        
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        pageVC.dataSource = tabsPageVCDataSource
        pageVC.delegate = tabsPageVCDataSource
        addChild(viewController: pageVC, in: tabContentContainer)
        self.tabsPageViewController = pageVC
    }
    
    func show(viewController: UIViewController) {
        tabsPageViewController?.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
    
    
   func pageViewController(viewControllerAfter viewController: UIViewController) -> UIViewController? {
      if let index = containedViewControllers.firstIndex(of: viewController) {
          let newIndex = index + 1
          guard newIndex < containedViewControllers.count else { return nil }
          return containedViewControllers[newIndex]
      }
      return nil
   }
          
   func pageViewController(viewControllerBefore viewController: UIViewController) -> UIViewController? {
      if let index = containedViewControllers.firstIndex(of: viewController) {
          let newIndex = index - 1
          guard newIndex >= 0 else { return nil }
          return containedViewControllers[newIndex]
      }
      return nil
   }
   
   func pageViewController(didFinishTransitionTo viewController: UIViewController) {
       if let index = containedViewControllers.firstIndex(of: viewController) {
           tabWasChanged(to: index)
           tabBarView?.selectTab(at: index)
       }
   }
    
    func tabWasChanged(to index: Int) { }
    
    func tabWasManuallyChanged(to index: Int) { }
}

