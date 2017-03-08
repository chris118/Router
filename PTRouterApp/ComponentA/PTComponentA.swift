//
//  PTComponentA.swift
//  PTRouterApp
//
//  Created by xiaopeng on 06/03/2017.
//  Copyright © 2017 putao. All rights reserved.
//

import UIKit

class PTComponentA: NSObject, PTRouterProtocol {
    
    static let sharedInstance = PTComponentA()
    
    override public class func initialize() {
//        PTRouter.register(component: PTComponentA.sharedInstance)
    }
    
    func canRoutURL(url: URL) -> Bool {
        if url.host == "PTComponentA" { // TODO: 哪些页面可以对外开放逻辑, 这里只简单判断了组件名字
            return true
        }
        return false
    }
    func routURL(url: URL, routType: RoutType) -> UIViewController? {
        //根据不同的url,组件应该实现提供导航到不同页面的能力
        let vc_a = PTViewControllerA(nibName: "PTViewControllerA", bundle: nil)
        return vc_a
    }
    
    func routURL(url: URL, routType: RoutType, userInfo: Dictionary<String, AnyObject>) -> UIViewController? {
        print(userInfo)
        //根据不同的url,组件应该实现提供导航到不同页面的能力
        let vc_a = PTViewControllerA(nibName: "PTViewControllerA", bundle: nil)
        return vc_a
    }
    
    func routService(url: URL, serviceName: String, userInfo: Dictionary<String, AnyObject>) -> Bool{
        switch serviceName {
        case "ServiceA":
            print("\(serviceName): \(userInfo)")
            break
        default:
            return false
        }
        return true
    }

}
