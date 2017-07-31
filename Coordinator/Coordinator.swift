//
//  Coordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

/// A callback function used by coordinators to signal events.
public typealias CoordinatorCallback = (Coordinator) -> Void

/**
 A coordinator is an object that manages the flow and life cycle of view controllers in an application.
 It is normally used to on the navigation and also manage the dependency injection.
 See: http://khanlou.com/2015/10/coordinators-redux/ for more.
 This library provide a default implementation of it.
 */
public protocol Coordinator: class {
  
  /// Some object holding information about the application context. Database references, user settings etc.
  var context: Context { get }
  
  /// The reference of the controller which is owned by the coordinator
  /// Can be nil in case of just transition coordinator
  var controller: UIViewController? { get }
  
  /// The navigation controller used by the coordinator.
  var navigationController: UINavigationController { get }
  
  /// The optionnal parent coordinator
  weak var parentCoordinator: Coordinator? { get }
  
  // All the children of the coordinator are retained here.
  var childCoordinators: [Coordinator] { get set }
  
  /// The rx dispose bag to manage the sequences resources
  /// @see https://github.com/ReactiveX/RxSwift/blob/master/Documentation/GettingStarted.md#disposing for more information
  var disposeBag: DisposeBag { get }
  
  /// Force a uniform initializer on our implementors.
  init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context)
  
  
  //
  // MARK: Start section
  //
  
  /// Tells the coordinator to create its initial view controller and take over the user flow.
  /// Just use for your main coordinator.
  /// Prefer startChildCoordinator or startChildAction instead.
  func start(withCallback completion: CoordinatorCallback?)
  
  /**
   Add a new child coordinator and start it.
   Prefere `startChildCoordinator` if you can.
   - Parameter coordinator: The coordinator implementation to start.
   - Parameter context: The context is a box containing the informations needed by the child coordinator and his controller.
   - Parameter callback: An optional `CoordinatorCallback` passed to the coordinator's `start()` method.
   - Returns: The started coordinator.
   */
  //  func startChild(forCoordinator coordinator: Coordinator, callback: CoordinatorCallback?)
  
  func startChildCoordinator(forConfiguration configuration: CoordinatorConfiguration, callback: CoordinatorCallback?)
  
  var startChildAction: Action<CoordinatorConfiguration, Coordinator> { get }
  
  
  //
  // MARK: Stop section
  //
  
  /// Tells the coordinator that it is done and that it should rewind the view controller state to where it was before `start` was called.
  /// If the coordinator has a parent, it should never been called directly because it will create a leak on it.
  /// Prefere `stopFromParent` instead.
  func stop(withCallback completion: CoordinatorCallback?)
  
  /// Stop and remove the coordinator from is parent if he has one and call stop
  /// If not just call `stop`
  func stopFromParent(_ callback: CoordinatorCallback?)
  
  /// Rx Action implementation of stop to use it as a sequence
  /// Call `stopFromParent` under the hood
  var stopChildAction: Action<Void, Coordinator> { get }
  
  /**
   Stops the coordinator and removes our reference to it.
   - Parameter identifier: The string identifier of the coordinator to stop.
   - Parameter callback: An optional `CoordinatorCallback` passed to the coordinator's `stop()` method.
   */
  func stopChild(forCoordinator coordinator: Coordinator, callback: CoordinatorCallback?)
}


//
// MARK: Default implementation
//

/**
 A default implmentation that provides a few convenience methods for starting and stopping coordinators.
 */
public extension Coordinator {
  
  //
  // MARK: Start section
  //
  
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
  
  internal func startChild(forCoordinator coordinator: Coordinator, callback: CoordinatorCallback? = nil) {
    
    Observable<Int>.interval(3, scheduler: ConcurrentDispatchQueueScheduler(qos: .default))
      .filter({ [weak controller] _ in (controller?.isViewLoaded ?? false && controller?.view.window != nil) })
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak coordinator] _ in
        guard let coordinator = coordinator else { return }
        coordinator.stopFromParent()
      })
      .addDisposableTo(disposeBag)
    
    childCoordinators.append(coordinator)
    coordinator.start(withCallback: callback)
  }
  
  func startChildCoordinator(forConfiguration config: CoordinatorConfiguration, callback: CoordinatorCallback? = nil) {
    
    let coord = config.type.init(navigationController: config.navigationController ?? self.navigationController, parentCoordinator: self, context: config.context ?? self.context)
    startChild(forCoordinator: coord, callback: callback)
  }
  
  
  //
  // MARK: Stop section
  //
  
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
  
  func stopFromParent(_ callback: CoordinatorCallback? = nil) {
    
    if let parentCoordinator = parentCoordinator {
      parentCoordinator.stopChild(forCoordinator: self, callback: callback)
    }
    else {
      stop(withCallback: callback)
    }
  }
  
  func stopChild(forCoordinator coordinator: Coordinator, callback: CoordinatorCallback? = nil) {
    
    let childCoordinator = self.childCoordinators.filter { $0 === coordinator }
      .first
    
    self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
    
    if let childCoordinator = childCoordinator {
      childCoordinator.stop(withCallback: { coordinator in
        callback?(childCoordinator)
      })
    }
  }
}

