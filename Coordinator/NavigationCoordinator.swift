//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

public protocol NavigationCoordinator: Coordinator {}

public extension NavigationCoordinator {
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    guard let controller = controller else { return }
        
    navigationController.tabBarItem = controller.tabBarItem
    navigationController.pushViewController(controller, animated: true)
    completion?(self)
  }
  
  func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    navigationController.popViewController(animated: true)
    completion?(self)
  }
}
