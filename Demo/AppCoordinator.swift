//
//  AppCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import NeoCoordinator

/// Main coordinator of your app
/// In this case, it is a TabBarCoordinator 
/// This type of coordinator is used to manage a TabBarController
final class AppCoordinator: TabBarCoordinator {
  
  override func setup() {
    tabs = [SampleNavigationCoordinator.self, SampleNavigationCoordinator.self, SampleNavigationCoordinator.self]
  }
}
