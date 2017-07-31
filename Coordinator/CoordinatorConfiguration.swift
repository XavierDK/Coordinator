//
//  CoordinatorConfiguration.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 31/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

public struct CoordinatorConfiguration {
  
  let type: Coordinator.Type
  let navigationController: UINavigationController?
  let context: Context?
  
  public init(type: Coordinator.Type, navigationController: UINavigationController? = nil, context: Context? = nil) {
    
    self.type = type
    self.navigationController = navigationController
    self.context = context
  }
}
