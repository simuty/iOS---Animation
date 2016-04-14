//
//  ContainerViewController.swift
//  3DSlideMenu
//
//  Created by 51Testing on 15/12/9.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit
import QuartzCore


class ContainerViewController: UIViewController {

    
    let menuWidth: CGFloat = 80.0
    let animationTime: NSTimeInterval = 0.5
    
    let menuViewController: UIViewController!
    let centerViewController: UIViewController!
    
    var isOpening = false
    
    
    //自定义初始化
    init(sideMenu: UIViewController, center: UIViewController) {
        
    //先赋值再调父类
        menuViewController = sideMenu
        centerViewController = center
        //调用父类初始化，否则报错
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
        
        //setNeedsStatusBarAppearanceUpdate，更新status bar的显示。
        setNeedsStatusBarAppearanceUpdate()
    
        
        /**
        View Controller中可以添加多个sub view，在需要的时候显示出来；
        可以通过viewController(parent)中可以添加多个child viewController;来控制页面中的sub view，降低代码耦合度；
        通过切换，可以显示不同的view；，替代之前的addSubView的管理
        */
        
        
        addChildViewController(centerViewController)
        view.addSubview(centerViewController.view)
/// addChildViewController回调用[child willMoveToParentViewController:self] ，但是不会调用didMoveToParentViewController，所以需要显示调用
        centerViewController.didMoveToParentViewController(self)
        
        
        addChildViewController(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMoveToParentViewController(self)
        
        
        //设置锚点，旋转动画使用，详见文档，需要在设置Frame之前
        menuViewController.view.layer.anchorPoint.x = 1.0
        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
   
        
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("handleGesture:"))
        view.addGestureRecognizer(panGesture)
        
        
         setToPercent(0.0)
    
    }
    
    func handleGesture(recognizer: UIPanGestureRecognizer) {
    //利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动 --->  CGPoint
        let translation = recognizer.translationInView(recognizer.view!.superview)
    print("translation-++++++++++++++++-----\(translation.x)")
        var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)
    print("translation-000000000-------\(progress) \n")
        
        progress = min(max(progress, 0.0), 1.0)
        
        switch recognizer.state {
        
        case .Began:
            //floor  向下取整，去掉小数部分
            let isOpen = floor(centerViewController.view.frame.origin.x / menuWidth)
            isOpening = isOpen == 1.0 ? false : true
        
            // Improve the look of the opening menu
            menuViewController.view.layer.shouldRasterize = true
            menuViewController.view.layer.rasterizationScale =
                UIScreen.mainScreen().scale
            
            
        case .Changed:
            self.setToPercent(isOpening ? progress: (1.0 - progress))
        
        case .Ended: fallthrough
        case .Cancelled: fallthrough
        case .Failed:
            var tagetProgress: CGFloat
            if (isOpening) {
                tagetProgress = progress < 0.5 ? 0.0 : 1.0
            }else {
                tagetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            
            UIView.animateWithDuration(animationTime, animations: {
                self.setToPercent(tagetProgress)
                
                }, completion: {_ in
                    self.menuViewController.view.layer.shouldRasterize = false
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
    
        print("percent----------------\(percent)")
        centerViewController.view.frame.origin.x = menuWidth * CGFloat(percent)
       // menuViewController.view.frame.origin.x = menuWidth * CGFloat(percent) - menuWidth
        menuViewController.view.layer.transform = menuTransformForPercent(percent)
        //设置透明度
        menuViewController.view.alpha = CGFloat(max(0.2, percent))
        
        
        
        //按钮旋转
        let centerVC = (centerViewController as! UINavigationController).viewControllers.first as? CenterViewController
        
        if let menuButton = centerVC?.menuButton {
            menuButton.imageView.layer.transform = buttonTransformForPercent(percent)
        }
        
    }
    
    
    
    func menuTransformForPercent(percent: CGFloat) -> CATransform3D {
    
            var identity = CATransform3DIdentity
        
        //为什么这个属性被称为m34 ?视图和层变换数学表示为二维矩阵。在一层的情况下变换矩阵,第三行第四列中的元素集你的z轴的角度。你可以设置这个元素直接应用所需的透视变换。
            identity.m34 = -1.0/1000
    
        let remainingPercent = 1.0 - percent
        let angle = remainingPercent * CGFloat(-M_PI_2)
        
        let rotationTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0)
        let translationTransform = CATransform3DMakeTranslation(menuWidth * percent, 0, 0)
        return CATransform3DConcat(rotationTransform, translationTransform)
    }
    
    
    
    
    func buttonTransformForPercent(percent: CGFloat) -> CATransform3D {
        
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        
        let angle = percent * CGFloat(-M_PI)
        let rotationTransform = CATransform3DRotate(identity, angle, 1.0, 1.0, 0.0)
        
        return rotationTransform
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



