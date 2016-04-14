//
//  ViewController.swift
//  FrameAnimation
//
//  Created by 51Testing on 15/12/11.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var viewbg: UIImageView!
    @IBOutlet weak var penguin: UIImageView!
    
    @IBOutlet weak var slideButton: UIButton!
    
    
    var isLookingRight: Bool = true {
        
        didSet {
        
            let xScale: CGFloat = isLookingRight ? 1 : -1
            //（x: 1, y:1） 面向右边
            //（x: -1, y:1） 面向左边
            penguin.transform = CGAffineTransformMakeScale(xScale, 1)
            //曲线的方向
            slideButton.transform = penguin.transform
        }
    
    }
    
    
    
    
    var penguinY: CGFloat!
    var walkSize: CGSize!
    var slideSize: CGSize!
    
    let animationDuration = 1.0
    
    
    
    var walkFrames = [
        UIImage(named: "walk01.png")!,
        UIImage(named: "walk02.png")!,
        UIImage(named: "walk03.png")!,
        UIImage(named: "walk04.png")!
    ]
    
    var slideFrames = [
        UIImage(named: "slide01.png")!,
        UIImage(named: "slide02.png")!,
        UIImage(named: "slide01.png")!
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        walkSize = walkFrames[0].size
        slideSize = slideFrames[0].size
        
        penguinY = penguin.frame.origin.y
    
        
        loadWalkAnimation()
    
    }

    @IBAction func leftButton(sender: AnyObject) {
        
        isLookingRight = false
        penguin.startAnimating()
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.penguin.center.x -= self.walkSize.width
            
            }, completion: nil)
    
    
    
    }
    
    
    @IBAction func rightButton(sender: AnyObject) {
        
        isLookingRight = true
        penguin.startAnimating()
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseIn, animations: {
            
            self.penguin.center.x += self.walkSize.width
            
            }, completion: nil)
        
    }
    
    @IBAction func curveButton(sender: AnyObject) {
        
        loadSlidAnimation()
        penguin.startAnimating()
        
        penguin.frame = CGRect(x: penguin.frame.origin.x, y:penguinY + (walkSize.height - slideSize.height), width: slideSize.width, height: slideSize.height)
        
        UIView.animateWithDuration(animationDuration - 0.02, delay: 0.0, options: .CurveEaseOut, animations: {
           
            self.penguin.center.x += self.isLookingRight ? self.slideSize.width : -self.slideSize.width
            
            }, completion: {_ in
            
            //保证恢复正常状态
            self.penguin.frame = CGRect(
                x: self.penguin.frame.origin.x, y: self.penguinY,
                width: self.walkSize.width, height: self.walkSize.height)
            self.loadWalkAnimation()
            
            
            })
    }
    
    
    func loadWalkAnimation() {
        //执行动画的数据源数组
        penguin.animationImages = walkFrames
        //其中一个动画持续时间
        penguin.animationDuration = animationDuration / 3
        //重复次数
        penguin.animationRepeatCount = 3
    }
    
    
    func loadSlidAnimation() {
        
        penguin.animationImages = slideFrames
        penguin.animationDuration = animationDuration
        penguin.animationRepeatCount = 1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

