//
//  SampleViewController.swift
//  Coordinator
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import UIKit
import Coordinator
import RxSwift
import RxCocoa
import Action

final class SampleViewController: UIViewController {
  
  var action: (() -> ())?
  var stop: Action<Void, Coordinator>?
  
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var closeButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    print("=> ✅ Setup of \(self)")
    
    view.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    
    if navigationController?.viewControllers.first === self && !(navigationController!.isBeingPresented) {
      navigationItem.rightBarButtonItem = nil
    }
    
    setupButtons()
  }
  
  func setupButtons() {
    
    if let stop = stop {
      closeButton.rx.tap
        .bind(to: stop.inputs)
        .addDisposableTo(disposeBag)
    }
  }
  
  @IBAction func actionPressed(sender: UIButton) {
    action?()
  }
  
  deinit {
    print("=> ❌ Deinit of \(self)")
  }
}
