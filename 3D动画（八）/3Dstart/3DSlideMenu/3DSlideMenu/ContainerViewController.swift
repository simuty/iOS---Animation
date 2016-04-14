////
////  ContainerViewController.swift
////  3DSlideMenu
////
////  Created by 51Testing on 15/12/9.
////  Copyright © 2015年 HHW. All rights reserved.
////
//
//import UIKit
//import QuartzCore
//
//
//class ContainerViewController: UIViewController {
//
//    
//    let menuWidth: CGFloat = 80.0
//    let animationTime: NSTimeInterval = 0.5
//    
//    let menuViewController: UIViewController!
//    let centerViewController: UIViewController!
//    
//    var isOpening = false
//    
//    
//    //自定义初始化
//    init(sideMenu: UIViewController, center: UIViewController) {
//        
//    //先赋值再调父类
//        menuViewController = sideMenu
//        centerViewController = center
//        //调用父类初始化，否则报错
//        super.init(nibName: nil, bundle: nil)
//
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = UIColor.blackColor()
//        
//        //setNeedsStatusBarAppearanceUpdate，更新status bar的显示。
//        setNeedsStatusBarAppearanceUpdate()
//    
//        addChildViewController(centerViewController)
//        view.addSubview(centerViewController.view)
//        centerViewController.didMoveToParentViewController(self)
//        
//        
//        addChildViewController(menuViewController)
//        view.addSubview(menuViewController.view)
//        menuViewController.didMoveToParentViewController(self)
//        
//        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
//        
//        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("handleGesture:"))
//        view.addGestureRecognizer(panGesture)
//    
//    }
//    
//    func handleGesture(recognizer: UIPanGestureRecognizer) {
//    //利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动 --->  CGPoint
//        let translation = recognizer.translationInView(recognizer.view!.superview)
//    
//        var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)
//        progress = min(max(progress, 0.0), 1.0)
//        
//        switch recognizer.state {
//        
//        case .Began:
//            let isOpen = floor(centerViewController.view.frame.origin.x / menuWidth)
//            isOpening = isOpen == 1.0 ? false : true
//        
//        case .Changed:
//            self.setToPercent(isOpening ? progress: (1.0 - progress))
//        
//        case .Ended: fallthrough
//        case .Cancelled: fallthrough
//        case .Failed:
//            var tagetProgress: CGFloat
//            if (isOpening) {
//                tagetProgress = progress < 0.5 ? 0.0 : 1.0
//            }else {
//                tagetProgress = progress < 0.5 ? 1.0 : 0.0
//            }
//            
//            UIView.animateWithDuration(animationTime, animations: { () -> Void in
//                self.setToPercent(tagetProgress)
//            })
//        default: break
//        
//        }
//        
//    }
//    
//    
//    func toggleSlieMenu() {
//    
//        let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
//        let targetProgress: CGFloat = isOpen == 1.0 ? 0.0: 1.0
//        
//        UIView.animateWithDuration(animationTime, animations: {
//            self.setToPercent(targetProgress)
//            }, completion: { _ in
//                self.menuViewController.view.layer.shouldRasterize = false
//        })
//
//    }
//    
//    
//    
//    func setToPercent(percent: CGFloat) {
//    
//        centerViewController.view.frame.origin.x = menuWidth * CGFloat(percent)
//        menuViewController.view.frame.origin.x = menuWidth * CGFloat(percent) - menuWidth
//    }
//    
//    
//    
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}






import UIKit
import QuartzCore

class ContainerViewController: UIViewController {
    
    let menuWidth: CGFloat = 80.0
    let animationTime: NSTimeInterval = 0.5
    
    let menuViewController: UIViewController!
    let centerViewController: UIViewController!
    
    var isOpening = false
    
    init(sideMenu: UIViewController, center: UIViewController) {
        menuViewController = sideMenu
        centerViewController = center
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        setNeedsStatusBarAppearanceUpdate()
        
        addChildViewController(centerViewController)
        view.addSubview(centerViewController.view)
        centerViewController.didMoveToParentViewController(self)
        
        addChildViewController(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMoveToParentViewController(self)
        
        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        
        let panGesture = UIPanGestureRecognizer(target:self, action:Selector("handleGesture:"))
        view.addGestureRecognizer(panGesture)
    }
    
    func handleGesture(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        
        var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)
        progress = min(max(progress, 0.0), 1.0)
        
        switch recognizer.state {
        case .Began:
            let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
            isOpening = isOpen == 1.0 ? false: true
            
        case .Changed:
            self.setToPercent(isOpening ? progress: (1.0 - progress))
            
        case .Ended: fallthrough
        case .Cancelled: fallthrough
        case .Failed:
            
            var targetProgress: CGFloat
            if (isOpening) {
                targetProgress = progress < 0.5 ? 0.0 : 1.0
            } else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            
            UIView.animateWithDuration(animationTime, animations: {
                self.setToPercent(targetProgress)
                }, completion: {_ in
                    
            })
            
        default: break
        }
    }
    
    func toggleSideMenu() {
        
        let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
        let targetProgress: CGFloat = isOpen == 1.0 ? 0.0: 1.0
        
        UIView.animateWithDuration(animationTime, animations: {
            self.setToPercent(targetProgress)
            }, completion: { _ in
                self.menuViewController.view.layer.shouldRasterize = false
        })
        
    }
    
    func setToPercent(percent: CGFloat) {
        centerViewController.view.frame.origin.x = menuWidth * CGFloat(percent)
        menuViewController.view.frame.origin.x = menuWidth * CGFloat(percent) - menuWidth
    }
    
}




