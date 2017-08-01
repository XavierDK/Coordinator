//
//  RxCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 01/08/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import Coordinator
import RxSwift
import RxCocoa
import Action

protocol RxCoordinator: Coordinator {
    
  /// The rx dispose bag to manage the sequences resources
  /// @see https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md#disposing for more information
  var disposeBag: DisposeBag { get }
  
  /// Rx Action implementation of stop to use it as a sequence
  /// Call `startChild` under the hood
  var startChildAction: Action<CoordinatorConfiguration, Coordinator> { get }
  
  /// Rx Action implementation of stop to use it as a sequence
  /// Call `stopFromParent` under the hood
  var stopChildAction: Action<Void, Coordinator> { get }
}

extension RxCoordinator {
  
  var startChildAction: Action<CoordinatorConfiguration, Coordinator> {
    
    return Action { [weak self] _ in
      return Observable.create { [weak self] (observer) in
        self?.stopFromParent({ _ in
          if let strongSelf = self {
            observer.onNext(strongSelf)
          }
          observer.onCompleted()
        })
        return Disposables.create()
      }
    }
  }
  
  var stopChildAction: Action<Void, Coordinator> {
    
    return Action { [weak self] _ in
      return Observable.create { [weak self] (observer) in
        self?.stopFromParent({ _ in
          if let strongSelf = self {
            observer.onNext(strongSelf)
          }
          observer.onCompleted()
        })
        return Disposables.create()
      }
    }
  }
}
