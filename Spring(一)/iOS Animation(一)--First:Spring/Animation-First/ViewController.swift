//
//  ViewController.swift
//  Animation-First
//
//  Created by 51Testing on 15/11/26.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tilteLab: UILabel!
    
    @IBOutlet weak var userTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginbutton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var tomImageView: UIImageView!
    
    
    //在视图将要出现的时候改变坐标
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tilteLab.frame.origin.x -= view.frame.width
        userTF.frame.origin.x -= view.frame.width
        passwordTF.frame.origin.x -= view.frame.width
        rightImageView.frame.origin.x -= view.frame.width
        tomImageView.frame.origin.x -= view.frame.width
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.tilteLab.frame.origin.x += self.view.frame.width
            
        }
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: [], animations: {
            self.userTF.frame.origin.x += self.view.frame.width
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.6, options: [], animations: {
            self.passwordTF.frame.origin.x += self.view.frame.width
        }, completion: nil)
        
        
        
        //旋转角度，顺时针转
        /// 创建了一个旋转的结构，参数是一个CGFloat类型的角度，这里我们使用预定义好的常量比如M_PI代表3.14...，也就是旋转一周、M_PI_2代表1.57...，也就是旋转半周等
        let rotation = CGAffineTransformMakeRotation(CGFloat(M_PI))
        UIView.animateWithDuration(1, animations: {
            self.loginbutton.transform = rotation
        })
        
        
        
        
        
        
        //缩放
        /// 首先创建了一个缩放的结构，第一个参数是x轴的缩放比例，第二个参数是y轴的缩放比例。
        let scale = CGAffineTransformMakeScale(0.5, 0.5)
        UIView.animateWithDuration(0.5, animations: {
            self.imageView.transform = scale
        })
        
        
        
        
        
        
        
        //   animationWithDuration(_:delay:options:animations:completion:)方法，其中的options当时没有详细的讲述，这节会向大家说明该属性。options选项可以使你自定义让UIKit如何创建你的动画。该属性需要一个或多个UIAnimationOptions枚举类型，让我们来看看都有哪些动画选项吧。
        
        
        
        
        
        
        /**
        重复类
        
        .Repeat：该属性可以使你的动画永远重复的运行。
        .Autoreverse：该属性可以使你的动画当运行结束后按照相反的行为继续运行回去。该属性只能和.Repeat属性组合使用。
        */

        UIView.animateWithDuration(2, delay: 0.5, options: [.Repeat, .Autoreverse], animations: {
            self.rightImageView.center.x += self.view.bounds.width
            }, completion: nil)
        
        
        
        
        
        
        /**
        动画缓冲
        */
        /**
        .CurveLinear ：该属性既不会使动画加速也不会使动画减速，只是做以线性运动。
        .CurveEaseIn：该属性使动画在开始时加速运行。
        .CurveEaseOut：该属性使动画在结束时减速运行。
        .CurveEaseInOut：该属性结合了上述两种情况，使动画在开始时加速，在结束时减速。
        */
        
        UIView.animateWithDuration(2, delay: 1, options: [.Repeat, .Autoreverse, .CurveEaseOut], animations: {
            self.tomImageView.frame.origin.x += self.view.frame.width
            }, completion: nil)
 
    }
 

    /**
     usingSpringWithDamping：弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
     initialSpringVelocity：弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果。
     */
    
    
     /**
     以下为设置同样的时间，不同的阻尼系数，不同的动力的效果；并在动画中增大宽和高
     */
    
    
    
    @IBAction func doClickloginButton(sender: AnyObject) {
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 30, options: .AllowUserInteraction, animations: {
            
            self.loginbutton.center.y += 30;
            
        }, completion: nil)
    }
    
    

    
    @IBAction func doClickRegister(sender: UIButton) {
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .AllowAnimatedContent, animations: {
            
            sender.center.y += 30
            sender.bounds.size.width += 10

            
        }, completion: nil)
        
    }
    
    
    @IBAction func doClickExit(sender: UIButton) {
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: .AllowAnimatedContent, animations: {
            
            sender.center.y += 30
            sender.bounds.size.height += 10

        }, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

