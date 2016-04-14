//
//  GradientView.swift
//  GradientAnimation
//
//  Created by 51Testing on 15/12/4.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit
import QuartzCore


@IBDesignable
class GradientView: UIView {

    let gradientLayer: CAGradientLayer = {
        
        let gradiendLayer = CAGradientLayer()
        
        gradiendLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradiendLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [
            UIColor.yellowColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.orangeColor().CGColor,
            UIColor.cyanColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.yellowColor().CGColor
        ]
        gradiendLayer.colors = colors
        
        
        let locations = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25];
        gradiendLayer.locations = locations
        
        
        return gradiendLayer
    }()
    
    
    
    let textAttributes: NSDictionary = {
       
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        return [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 30.0)!, NSParagraphStyleAttributeName:style]
    
    }()
    
    @IBInspectable
    var text : String! {
    
        didSet{
            
            setNeedsDisplay()
            
          //  创建一个临时的图像上下文（graphic context）将text渲染为image
            
        /*
            //第一步：获得一个图形上下文是我们完成绘图任务。可以当做时画布，然后才可以画画
            
            第一种方法就是创建一个图片类型的上下文。调用UIGraphicsBeginImageContextWithOptions函数就可获得用来处理图片的图形上下文。利用该上下文，你就可以在其上进行绘图，并生成图片。调用UIGraphicsGetImageFromCurrentImageContext函数可从当前上下文中获取一个UIImage对象。记住在你所有的绘图操作后别忘了调用UIGraphicsEndImageContext函数关闭图形上下文。
            
            第二种方法是利用cocoa为你生成的图形上下文。当你子类化了一个UIView并实现了自己的drawRect：方法后，一旦drawRect：方法被调用，Cocoa就会为你创建一个图形上下文，此时你对图形上下文的所有绘图操作都会显示在UIView上。
            
            Quartz2D提供了以下几种类型的Graphics Context：
            Bitmap Graphics Context
            PDF Graphics Context
            Window Graphics Context
            Layer Graphics Context
            Printer Graphics Context
            
            */
         




        /*
            void UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
            
            
            size——同UIGraphicsBeginImageContext
            opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
            scale—–缩放因子
        */
            
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            
            let context = UIGraphicsGetCurrentContext()
            
            text.drawInRect(bounds, withAttributes: textAttributes as? [String : AnyObject])
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clearColor().CGColor
            maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
            maskLayer.contents = image.CGImage
            
            
            gradientLayer.mask = maskLayer
            
            
        }
    }
    
//    override func drawRect(rect: CGRect) {
//        layer.borderColor = UIColor.whiteColor().CGColor
//        layer.borderWidth = 1.0
//        layer.backgroundColor = UIColor(white: 1.0, alpha: 0.1).CGColor
//        
//        let style = NSMutableParagraphStyle()
//        style.alignment = .Center
//        
//        let font = UIFont(name: "HelveticaNeue-Thin", size: bounds.size.height/2)
//        
//        let attrs = NSMutableDictionary()
//        attrs[NSFontAttributeName] = font
//        attrs[NSParagraphStyleAttributeName] = style
//        attrs[NSForegroundColorAttributeName] = UIColor.whiteColor()
//        
//        NSString(string: text).drawInRect(bounds, withAttributes: attrs)
//    }
//    
    
    
    override func layoutSubviews() {
        
        //设置Layer层的宽度大一点，防止动画结束时动画不均匀
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: bounds.origin.y, width: 3 * bounds.size.width, height: bounds.size.height)
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0.0,  0.0, 0.0, 0.0, 0.0, 0.25]
        
        gradientAnimation.toValue = [
            0.65, 0.8, 0.85, 0.9, 0.95, 1.0
        ]
        
        gradientAnimation.duration = 3.0
        
        //设置重复次数为无限大
        gradientAnimation.repeatCount = Float.infinity
        
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)
        
        
        
    }
    

    
    
}
