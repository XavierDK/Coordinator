//
//  SampleCoordinator.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import Foundation
import Coordinator

final class SampleNavigationCoordinator: NavigationCoordinator {
  
  override func setup() {
    
    controller = UIStoryboard(name: "SampleViewController", bundle: nil).instantiateInitialViewController()
    
    let action: () -> () = { [weak self] in
      
      guard let strongSelf = self else { return }
      
      let coord: Coordinator
//      if arc4random() % 2 == 0 {
        coord = SampleNavigationCoordinator(navigationController: strongSelf.navigationController, parentCoordinator: strongSelf, context: strongSelf.context)
//      }
//      else {
//        coord = SampleModalCoordinator(navigationController: strongSelf.navigationController, parentCoordinator: strongSelf, context: strongSelf.context)
//      }
      self?.startChild(forCoordinator: coord)
    }
    
    if let controller = controller as? SampleViewController {
      controller.action = action
      controller.stop = stopBlock
    }
  }
}
