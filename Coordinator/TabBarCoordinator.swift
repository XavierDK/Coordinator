//
//  TabBarCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

public protocol TabBarCoordinator: Coordinator {
  
  var tabBarController: UITabBarController { get }
  var tabs: [Coordinator.Type] { get }
}

public extension TabBarCoordinator {
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    navigationController.setNavigationBarHidden(true, animated: false)
    tabBarController.viewControllers = tabs.map { childCoordinator in
      
      let navigationController = UINavigationController()
      let coordinator = childCoordinator.init(navigationController: navigationController, parentCoordinator: self, context: context)
      startChild(forCoordinator: coordinator, callback: nil)
      
      return navigationController
    }
    navigationController.pushViewController(tabBarController, animated: true)
    completion?(self)
  }
  
  func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    navigationController.popViewController(animated: true)
    completion?(self)
  }
}
