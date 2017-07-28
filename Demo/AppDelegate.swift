//
//  AppDelegate.swift
//  Demo
//
//  Created by Xavier De Koninck on 27/07/2017.
//  Copyright © 2017 PagesJaunes. All rights reserved.
//

import UIKit
import Coordinator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: AppCoordinator!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    /// Create a window manually
    window = UIWindow()
    
    /// Init your main navigation controller
    let navigationController = UINavigationController()
    window?.rootViewController = navigationController
    
    /// Create your main coordinator for your app
    appCoordinator = AppCoordinator(navigationController: navigationController, parentCoordinator: nil, context: Context(value: ()))
    
    /// And start it
    appCoordinator.start()
    
    window?.makeKeyAndVisible()
    
    return true
  }
}

