//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import RxSwift

open class NavigationCoordinator: Coordinator {
  
  public var controller: UIViewController?
  
  public let context: Context
  public let navigationController: UINavigationController
  public weak var parentCoordinator: Coordinator?
  public var childCoordinators: [Coordinator] = []
  
  public let disposeBag = DisposeBag()
  
  required public init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context) {
    
    self.context = context
    self.parentCoordinator = parentCoordinator
    self.navigationController = navigationController
  }
  
  open func setup() {
    fatalError("Method `setup` should be overriden for the coordinator \(self)")
  }
}

public extension NavigationCoordinator {
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    setup()
    
    guard let controller = controller else { return }
    
    navigationController.tabBarItem = controller.tabBarItem
    navigationController.pushViewController(controller, animated: true)
    completion?(self)
  }
  
  func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    if let controller = controller,
      navigationController.viewControllers.contains(controller) {
      navigationController.popViewController(animated: true)
    }
    completion?(self)
  }
}
