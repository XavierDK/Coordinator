//
//  AppCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import Coordinator

/// Main coordinator of your app
/// In this case, it is a TabBarCoordinator 
/// This type of coordinator is used to manage a TabBarController
final class AppCoordinator: TabBarCoordinator {
  
  var controller: UIViewController?
  
  let context: Context
  let navigationController: UINavigationController
  var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  /// The TabBarController
  let tabBarController = UITabBarController()
  
  /// The coordinators array used to fill the tabBar
  let tabs: [Coordinator.Type] = [SampleNavigationCoordinator.self, SampleNavigationCoordinator.self, SampleNavigationCoordinator.self]
  
  required init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context) {
    
    self.navigationController = navigationController
    self.parentCoordinator = parentCoordinator
    self.context = context
  }
}
