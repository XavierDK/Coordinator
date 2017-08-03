//
//  AppCoordinator_iPad.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 02/08/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import Coordinator

/// Main coordinator of your app
/// In this case, it is a TabBarCoordinator
/// This type of coordinator is used to manage a TabBarController
final class AppCoordinator_iPad: SplitCoordinator {
  
  override func setup() {
    masterCoordinator = SampleNavigationCoordinator.self
    detailCoordinator = SampleNavigationCoordinator.self
  }
}
