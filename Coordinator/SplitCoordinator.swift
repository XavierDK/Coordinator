//
//  SplitCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 02/08/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

open class SplitCoordinator: Coordinator {
  
  public var controller: UIViewController?
  
  public let context: Context
  public let navigationController: UINavigationController
  public weak var parentCoordinator: Coordinator?
  public var childCoordinators: [Coordinator] = []
  
  public var masterCoordinator: Coordinator.Type?
  public var detailCoordinator: Coordinator.Type?
  
  required public init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context) {
    
    self.navigationController = navigationController
    self.parentCoordinator = parentCoordinator
    self.context = context
  }
  
  open func setup() {
    fatalError("Method `setup` should be overriden for the coordinator \(self)")
  }
}

public extension SplitCoordinator {
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    setup()
    navigationController.setNavigationBarHidden(true, animated: false)
    
    let splitViewController = UISplitViewController()
    
    UIApplication.shared.windows.first?.rootViewController = splitViewController
    
    if let masterCoordinator = masterCoordinator {
      let navigationController = UINavigationController()
      let coordinator = masterCoordinator.init(navigationController: navigationController, parentCoordinator: self, context: context)
      startChild(forCoordinator: coordinator, callback: { [weak splitViewController] _ in
        splitViewController?.show(navigationController, sender: nil)
      })
    }
    if let detailCoordinator = detailCoordinator {
      let navigationController = UINavigationController()
      let coordinator = detailCoordinator.init(navigationController: navigationController, parentCoordinator: self, context: context)
      startChild(forCoordinator: coordinator, callback: nil)
      splitViewController.showDetailViewController(navigationController, sender: nil)
    }
    
    controller = splitViewController
  }
  
  func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    navigationController.popViewController(animated: true) { [weak self] in
      guard let strongSelf = self else { return }
      completion?(strongSelf)
    }
  }
}
