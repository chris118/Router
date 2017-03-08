//
//  ViewController.swift
//  PTRouterApp
//
//  Created by xiaopeng on 06/03/2017.
//  Copyright © 2017 putao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentComponent(_ sender: Any) {
        let ret = PTRouter.routURL(url: URL(string:"router://PTComponentA/PTViewControllerA")!, routType: .Present)
        print("rout result : \(ret)")
    }

    @IBAction func presentComponentWithParameter(_ sender: Any) {
        let ret = PTRouter.routURL(url: URL(string:"router://PTComponentA/PTViewControllerA")!, routType: .Push, userInfo: ["Hi" : "ComponentA" as AnyObject])
        print("rout result : \(ret)")
    }
    
    @IBAction func invokeService(_ sender: Any) {
        let ret = PTRouter.routService(url: URL(string:"router://PTComponentA")!, serviceName: "ServiceA", userInfo: ["Hi" : "ComponentA" as AnyObject])
        print("rout result : \(ret)")
    }
}

