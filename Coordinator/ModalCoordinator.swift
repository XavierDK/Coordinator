//
//  ModalCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

open class ModalCoordinator: Coordinator {
  
  public var controller: UIViewController?
  
  public let context: Context
  public let parentNavigationController: UINavigationController
  public let navigationController = UINavigationController()
  public weak var parentCoordinator: Coordinator?
  public var childCoordinators: [Coordinator] = []
  
  required public init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context) {
    
    self.context = context
    self.parentCoordinator = parentCoordinator
    self.parentNavigationController = navigationController
  }
  
  open func setup() {
    fatalError("Method `setup` should be overriden for the coordinator \(self)")
  }
}

extension ModalCoordinator {
  
  public func start(withCallback completion: CoordinatorCallback? = nil) {
    
    setup()
    
    guard let controller = controller else { return }
    
    navigationController.tabBarItem = controller.tabBarItem
    navigationController.pushViewController(controller, animated: false) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.parentNavigationController.present(strongSelf.navigationController, animated: true) { [weak self] in
        guard let strongSelf = self else { return }
        completion?(strongSelf)
      }
    }
  }
  
  public func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    if let _ = controller,
      parentNavigationController.presentedViewController == navigationController {
      navigationController.dismiss(animated: true) { [weak self] in
        guard let strongSelf = self else { return }
        completion?(strongSelf)
      }
    }
  }
}
