//
//  SampleModalCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import Coordinator

final class SampleModalCoordinator: ModalCoordinator {
  
  override func setup() {

    controller = UIStoryboard(name: "SampleViewController", bundle: nil).instantiateInitialViewController()
    
    print("=> ❇️ Setup of \(self) containing controller: \(String(describing: controller!))")
    
    let action: () -> () = { [weak self] in
      
      let coordType: Coordinator.Type
      if arc4random() % 2 == 0 {
        coordType = SampleNavigationCoordinator.self
      }
      else {
        coordType = SampleModalCoordinator.self
      }
      
      let config = CoordinatorConfiguration(type: coordType)
      self?.startChildCoordinator(forConfiguration: config)
    }
    
    if let controller = controller as? SampleViewController {
      controller.action = action
      
      let stop = stopChildAction
      stop.elements
        .subscribe(onNext: { coord in
          print("=> 🛑 Stop as been asked for \(coord)")
        })
        .addDisposableTo(disposeBag)
      
      controller.stop = stop
    }
  }
  
  deinit {
    if let controller = controller {
      print("=> ⭕️ Deinit of \(self) containing controller: \(String(describing: controller))")
    }
  }
}
