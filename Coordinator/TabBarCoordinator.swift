//
//  TabBarCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import RxSwift

open class TabBarCoordinator: Coordinator {
  
  public var controller: UIViewController?
  
  public let context: Context
  public let navigationController: UINavigationController
  public weak var parentCoordinator: Coordinator?
  public var childCoordinators: [Coordinator] = []
  
  public let disposeBag = DisposeBag()
  
  public let tabBarController = UITabBarController()
  public var tabs: [Coordinator.Type] = []
  
  required public init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context) {
    
    self.navigationController = navigationController
    self.parentCoordinator = parentCoordinator
    self.context = context
  }
  
  open func setup() {
    fatalError("Method `setup` should be overriden for the coordinator \(self)")
  }
}

public extension TabBarCoordinator {
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    setup()
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
