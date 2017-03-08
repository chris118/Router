//
//  PTRouterProtocal.swift
//  PTRouterApp
//
//  Created by xiaopeng on 06/03/2017.
//  Copyright © 2017 putao. All rights reserved.
//

import UIKit

extension UIViewController {

  /// Returns the current application's top most view controller.
  open class var topMost: UIViewController? {
    var rootViewController: UIViewController?
    let currentWindows = UIApplication.shared.windows
    
    for window in currentWindows {
      if let windowRootViewController = window.rootViewController {
        rootViewController = windowRootViewController
        break
      }
    }
    
    return self.topMost(of: rootViewController)
  }

  /// Returns the top most view controller from given view controller's stack.
  class func topMost(of viewController: UIViewController?) -> UIViewController? {
    // UITabBarController
    if let tabBarController = viewController as? UITabBarController,
      let selectedViewController = tabBarController.selectedViewController {
      return self.topMost(of: selectedViewController)
    }

    // UINavigationController
    if let navigationController = viewController as? UINavigationController,
      let visibleViewController = navigationController.visibleViewController {
      return self.topMost(of: visibleViewController)
    }

    // presented view controller
    if let presentedViewController = viewController?.presentedViewController {
      return self.topMost(of: presentedViewController)
    }

    // child view controller
    for subview in viewController?.view?.subviews ?? [] {
      if let childViewController = subview.next as? UIViewController {
        return self.topMost(of: childViewController)
      }
    }

    return viewController
  }

}
