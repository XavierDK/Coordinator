//
//  RxCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 01/08/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import NeoCoordinator
import RxSwift
import RxCocoa
import Action

public protocol RxCoordinator: Coordinator {
  
  /// The rx dispose bag to manage the sequences resources
  /// @see https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md#disposing for more information
  var disposeBag: DisposeBag { get }
  
  func startRxChildCoordinator(forConfiguration config: CoordinatorConfiguration) -> Observable<Coordinator>
  
  func stopRxChild(forCoordinator coordinator: Coordinator) -> Observable<Coordinator>
  
  /// Rx Action implementation of stop to use it as a sequence
  /// Call `stopFromParent` under the hood
  var stopChildAction: CocoaAction { get }
}

public extension RxCoordinator {
  
  // MARK: Action
  
  var stopChildAction: CocoaAction {
    
    return Action { [weak self] _ in
      return Observable.create { [weak self] (observer) in
        self?.stopFromParent({ _ in
          observer.onNext()
          observer.onCompleted()
        })
        return Disposables.create()
      }
    }
  }
  
  // MARK: Start Rx wrapper
  
  func startRxChildCoordinator(forConfiguration config: CoordinatorConfiguration) -> Observable<Coordinator> {
    
    return Observable.create { [weak self] (observer) in
      
      self?.startChildCoordinator(forConfiguration: config, callback: { coordinator in
        observer.onNext(coordinator)
        observer.onCompleted()
      })
      
      return Disposables.create()
    }
  }
  
  // MARK: Stop Rx wrapper
  
  func stopRxChild(forCoordinator coordinator: Coordinator) -> Observable<Coordinator> {
    
    return Observable.create { [weak self, weak coordinator] (observer) in
      
      if let coordinator = coordinator {
        self?.stopChild(forCoordinator: coordinator, callback: { coordinator in
          observer.onNext(coordinator)
          observer.onCompleted()
        })
      }
      
      return Disposables.create()
    }
  }
}
