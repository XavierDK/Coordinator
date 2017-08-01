//
//  CoordinatorConfiguration.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 31/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

/// The configuration needed to create a child coordinator
public struct CoordinatorConfiguration {
  
  /// The coordinator type to be created
  let type: Coordinator.Type
  
  /// The basic navigationController user by the child coordinator
  let navigationController: UINavigationController?
  
  /// The optionnal context containing important value for the child
  let context: Context?
  
  
  /// <#Description#>
  ///
  /// - Parameters:
  ///   - type: <#type description#>
  ///   - navigationController: <#navigationController description#>
  ///   - context: <#context description#>
  public init(type: Coordinator.Type, navigationController: UINavigationController? = nil, context: Context? = nil) {
    
    self.type = type
    self.navigationController = navigationController
    self.context = context
  }
}
