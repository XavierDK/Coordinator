//
//  CoordinatorTests.swift
//  CoordinatorTests
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Quick
import Nimble

@testable import NeoCoordinator

final class CoordinatorSpec: QuickSpec {
  
  override func spec() {
    
    describe("the Test Coordinators") {
      
      context("before the start") {
        
        let coordContext = Context(value: 42)
        let navController = UINavigationController()
        let coordinator = TestCoordinator(navigationController: navController, parentCoordinator: nil, context: coordContext)
        
        it("should have the navigation controller set") {
          expect(coordinator.navigationController === navController).to(beTrue())
        }
        it("shouldn't have a parent coordinator") {
          expect(coordinator.parentCoordinator).to(beNil())
        }
        it("shouldn't have children coordinators") {
          expect(coordinator.childCoordinators.count).to(equal(0))
        }
        it("should have his context set") {
          
          do {
            let value: Int = try coordinator.context.value()
            expect(value).to(equal(42))
          }
          catch {
            fail()
          }
        }
      }
      
      context("after the start") {
        
        let coordContext = Context(value: 42)
        let navController = UINavigationController()
        let coordinator = TestCoordinator(navigationController: navController, parentCoordinator: nil, context: coordContext)
        coordinator.start()
        
        it("should have one child coordinator (TestChildCoordinator)") {
          expect(coordinator.childCoordinators.count).to(equal(1))
          expect(coordinator.childCoordinators.first is TestChildCoordinator).to(beTrue())
        }
        it("should have his child without children coordinators") {
          expect(coordinator.childCoordinators.first!.childCoordinators.count).to(equal(0))
        }
        it("should have the navigation controller set") {
          expect(coordinator.navigationController === navController).to(beTrue())
        }
        it("should have his child navigation controller set") {
          expect(coordinator.childCoordinators.first!.navigationController === navController).to(beTrue())
        }
        it("shouldn't have a parent coordinator") {
          expect(coordinator.parentCoordinator).to(beNil())
        }
        it("should have his child parent coordinator") {
          expect(coordinator.childCoordinators.first!.parentCoordinator === coordinator).to(beTrue())
        }
        it("should have his context set") {
          
          do {
            let value: Int = try coordinator.context.value()
            expect(value).to(equal(42))
          }
          catch {
            fail()
          }
        }
        it("should have his child context set") {
          
          do {
            let value: Int = try coordinator.childCoordinators.first!.context.value()
            expect(value).to(equal(42))
          }
          catch {
            fail()
          }
        }
      }
      
      context("after the child stop") {
        
        let coordContext = Context(value: 42)
        let navController = UINavigationController()
        let coordinator = TestCoordinator(navigationController: navController, parentCoordinator: nil, context: coordContext)
        coordinator.start()
        coordinator.childCoordinators.first!.stopFromParent()
        
        it("should have the navigation controller set") {
          expect(coordinator.navigationController === navController).to(beTrue())
        }
        it("shouldn't have a parent coordinator") {
          expect(coordinator.parentCoordinator).to(beNil())
        }
        it("shouldn't have children coordinators") {
          expect(coordinator.childCoordinators.count).to(equal(0))
        }
        it("should have his context set") {
          
          do {
            let value: Int = try coordinator.context.value()
            expect(value).to(equal(42))
          }
          catch {
            fail()
          }
        }
      }
    }
  }
}

final class TestCoordinator: Coordinator {
  
  var controller: UIViewController?
  
  let context: Context
  let navigationController: UINavigationController
  var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  required init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context) {
    
    self.navigationController = navigationController
    self.parentCoordinator = parentCoordinator
    self.context = context
  }
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    startChild(forCoordinator: TestChildCoordinator(navigationController: navigationController, parentCoordinator: self, context: context))
    completion?(self)
  }
  
  func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    completion?(self)
  }
}

final class TestChildCoordinator: Coordinator {
  
  var controller: UIViewController?
  
  let context: Context
  let navigationController: UINavigationController
  var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  
  required init(navigationController: UINavigationController, parentCoordinator: Coordinator?, context: Context) {
    
    self.navigationController = navigationController
    self.parentCoordinator = parentCoordinator
    self.context = context
  }
  
  func start(withCallback completion: CoordinatorCallback? = nil) {
    
    completion?(self)
  }
  
  func stop(withCallback completion: CoordinatorCallback? = nil) {
    
    completion?(self)
  }
}

