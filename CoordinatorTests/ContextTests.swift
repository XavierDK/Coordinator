//
//  ContextTests.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Quick
import Nimble

@testable import Coordinator

final class ContextSpec: QuickSpec {
  
  override func spec() {
    
    describe("the Coordinator Context") {
      test(type: "Integer", with: 42)
      test(type: "String", with: "42")
      test(type: "Float", with: Float(0.1))
      test(type: "Class", with: NewClassType())
      test(type: "Struct", with: NewStructType(value: 42))
    }
  }
  
  func test<G>(type: String, with value: G) where G : Equatable {
    
    context("if value is a \(type)") {
      
      let context = Context(value: value)
      
      it("should be able to get back the value") {
        
        let val: G? = try? context.value()
        guard let v = val else { fail(); return }
        expect(v).to(equal(value))
      }
      it("should throw an error when ask for a wrong type") {
        
        do {
          let _: FakeType = try context.value()
          fail()
        }
        catch {
          guard let err = error as? Context.ContextError else { fail(); return }
          expect(err).to(equal(Context.ContextError.badType(Any.self, Any.self)))
        }
      }
    }
  }
  
  class NewClassType: Equatable {}
  
  struct NewStructType: Equatable {
    let value: Int
  }
  
  class FakeType {}
}

func ==(lhs: ContextSpec.NewClassType, rhs: ContextSpec.NewClassType) -> Bool {
  return lhs === rhs
}

func ==(lhs: ContextSpec.NewStructType, rhs: ContextSpec.NewStructType) -> Bool {
  return lhs.value == rhs.value
}


extension Context.ContextError: Equatable {}

public func ==(lhs: Context.ContextError, rhs: Context.ContextError) -> Bool {
  
  if case .badType(_ , _) = lhs,
    case .badType(_ , _) = rhs
  { return true }
  
  return false
}
