//
//  ModalCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

public protocol ModalCoordinator: Coordinator {

  var parentNavigationController: UINavigationController { get }
}

public extension ModalCoordinator {
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    guard let controller = controller else { return }
    
    navigationController.tabBarItem = controller.tabBarItem
    navigationController.pushViewController(controller, animated: false)
    parentNavigationController.present(navigationController, animated: true)
    
    completion?(self)
  }
  
  func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    navigationController.dismiss(animated: true)
    completion?(self)
  }
}
