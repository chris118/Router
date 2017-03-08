//
//  PTRouter.swift
//  PTRouterApp
//
//  Created by xiaopeng on 06/03/2017.
//  Copyright © 2017 putao. All rights reserved.
//

import UIKit

public enum RoutType{
    case Push
    case Present
    case None
}

public class PTRouter {
    
    // 保存所有注册过的组件
    static var g_componentMap = [String : PTRouterProtocol]()
    
    
    /// 注册组件到PTRouter
    ///
    /// - Parameter component: 实现了PTRouterProtocol的组件
    class func register(component: PTRouterProtocol) -> Void {
        print("\(component) is registed")
        let mirror = Mirror(reflecting: component)
        
        objc_sync_enter(component)
        g_componentMap["\(mirror.subjectType)"] = component
        objc_sync_exit(component)
    }
    
    /// 路由到组件的指定页面
    ///
    /// - Parameters:
    ///   - url: url
    ///   - routType: push or present
    /// - Returns: success or fail
    class func routURL(url: URL, routType: RoutType) -> Bool {
        return PTRouter.routURL(url: url, routType: routType, userInfo: Dictionary<String, AnyObject>())
    }
    
    
    /// 路由到组件的指定页面 携带参数
    ///
    /// - Parameters:
    ///   - url: url
    ///   - routType: push or present
    ///   - userInfo: 参数
    /// - Returns: success or fail
    class func routURL(url: URL, routType: RoutType, userInfo: Dictionary<String, AnyObject>) -> Bool {
        for (key, value) in g_componentMap
        {
            print("key: \(key), value:\(value)")
            let component = value as PTRouterProtocol
            
            let urlPathComponents = url.absoluteString.components(separatedBy: "/")
            if urlPathComponents[0] != "router:" || urlPathComponents.count != 4 { // TODO:应该有更严格的检查机制
                return false // 非法的路径. TODO: 应该在Router里提供导航失败的页面或者Alert，提示客户导航失败
            }
            let componentName = urlPathComponents[2]
            if componentName == key {
                if component.canRoutURL(url: url) == true {
                    guard let viewController = component.routURL(url: url, routType: routType, userInfo: userInfo)
                        else {
                            return false
                    }
                    return PTRouter.routViewController(viewController: viewController, routType: routType)
                }
            }

        }
        return false
    }
    
    
    /// 可能需要获得组件里的VC 灵活处理
    ///
    /// - Parameter url: url
    /// - Returns: 目标页面
    class func viewControllerForUrl(url: URL) -> UIViewController? {
        for (key, value) in g_componentMap
        {
            print("key: \(key), value:\(value)")
            let component = value as PTRouterProtocol
            
            if url.host == key {
                if component.canRoutURL(url: url) == true {
                    return component.routURL(url: url, routType: .None, userInfo: Dictionary<String, AnyObject>())
                }
            }
        }
        return nil
    }
    
    
    /// 根据不同服务名字，调用组件对外提供的服务
    ///
    /// - Parameters:
    ///   - serviceName: 服务名
    ///   - userInfo: 参数
    /// - Returns: success or fail
    class func routService(url: URL, serviceName: String, userInfo: Dictionary<String, AnyObject>) -> Bool{
        for (key, value) in g_componentMap
        {
            print("key: \(key), value:\(value)")
            let component = value as PTRouterProtocol
            if url.host == key {
                return component.routService(url: url, serviceName: serviceName, userInfo: userInfo)
            }
        }
        
        return false
    }
    
    /// 私有函数，根据不同的routType,做相应处理
    ///
    /// - Parameters:
    ///   - viewController: 目标页面
    ///   - routType:
    /// - Returns: success or fail
    fileprivate class func routViewController(viewController: UIViewController, routType: RoutType) -> Bool {
        if routType == .Present {
            if let fromViewController = UIViewController.topMost {
                fromViewController.present(viewController, animated: true, completion: nil)
            }
        }else if routType == .Push{
            if let navigationContrller = UIViewController.topMost?.navigationController {
                navigationContrller.pushViewController(viewController, animated: true)
                return true
            }else {
               return false
            }
        }
        return true
    }
}
