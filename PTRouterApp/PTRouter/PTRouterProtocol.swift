//
//  PTRouterProtocal.swift
//  PTRouterApp
//
//  Created by xiaopeng on 06/03/2017.
//  Copyright © 2017 putao. All rights reserved.
//

import UIKit

public protocol PTRouterProtocol {
    func canRoutURL(url: URL) -> Bool
    func routURL(url: URL, routType: RoutType) -> UIViewController?
    func routURL(url: URL, routType: RoutType, userInfo: Dictionary<String, AnyObject>) -> UIViewController?
    func routService(url: URL, serviceName: String, userInfo: Dictionary<String, AnyObject>) -> Bool
}
