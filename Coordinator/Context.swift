//
//  Context.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation

public struct Context {
  
  private let valueStored: Any
  
  public init(value: Any) {
    
    self.valueStored = value
  }
  
  public func value<T>() throws -> T {
    
    guard let value = valueStored as? T else {            
      throw ContextError.badType(T.self, type(of: valueStored))
    }
    return value
  }
  
  public enum ContextError: Error, CustomStringConvertible {
    
    case badType(Any, Any)
    
    public var description: String {
      
      switch self {
      case .badType(let bad, let good):
        return "WARNING! ⚠️ : Context value is not type of: \(bad) but type of \(good)!"
      }
    }
  }
}
