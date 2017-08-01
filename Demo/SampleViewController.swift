//
//  SampleViewController.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import UIKit
import Coordinator

final class SampleViewController: UIViewController {
  
  var action: (() -> ())?
  var stop: (() -> ())?
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    print("=> ✅ Setup of \(self)")
    
    view.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    
    if navigationController?.viewControllers.first === self && !(navigationController!.isBeingPresented) {
      navigationItem.rightBarButtonItem = nil
    }
  }
  
  @IBAction func actionPressed(sender: UIButton) {
    action?()
  }
  
  @IBAction func closePressed(sender: UIButton) {
    stop?()
  }
  
  deinit {
    print("=> ❌ Deinit of \(self)")
  }
}
