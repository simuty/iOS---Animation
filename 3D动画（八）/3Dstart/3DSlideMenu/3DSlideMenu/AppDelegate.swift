//
//  AppDelegate.swift
//  3DSlideMenu
//
//  Created by 51Testing on 15/12/8.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

//
//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//
//        application.statusBarStyle = UIStatusBarStyle.LightContent
// 
//        //设置程序入口为main
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        //初始化导航控制器
//        let centerNav = storyboard.instantiateViewControllerWithIdentifier("CenterNav") as! UINavigationController
//        
//        //左侧菜单
//        let menuVC = storyboard.instantiateViewControllerWithIdentifier("SideMenu") as! SideMenuViewController
//     //
//        menuVC.centerViewController = centerNav.viewControllers.first as! CenterViewController
//        //存储左侧菜单和主屏幕的容器
//       let containerVC = ContainerViewController(sideMenu: menuVC, center: centerNav)
//       
//        
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        self.window?.rootViewController = containerVC
//        self.window?.backgroundColor = UIColor.whiteColor()
//        self.window?.makeKeyAndVisible()
//        
//        return true
//    }

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        application.statusBarStyle = UIStatusBarStyle.LightContent
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let centerNav = storyboard.instantiateViewControllerWithIdentifier("CenterNav") as! UINavigationController
        //   let centerVC = centerNav.viewControllers.first as! CenterViewController
        
        
        let menuVC = storyboard.instantiateViewControllerWithIdentifier("SideMenu") as! SideMenuViewController
        menuVC.centerViewController = centerNav.viewControllers.first as! CenterViewController
        
        let containerVC = ContainerViewController(sideMenu: menuVC, center: centerNav)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = containerVC
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        return true
    }

}

