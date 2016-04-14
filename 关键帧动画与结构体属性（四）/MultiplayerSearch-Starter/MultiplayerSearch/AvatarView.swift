

import UIKit
import QuartzCore


/// 实时渲染
///可以将自定义的代码实时渲染到Interface Builder中。而它们之间的桥梁就是通过两个指令来完成，即@IBDesignable和@IBInspectable。
///通过@IBDesignable告诉Interface Builder这个类可以实时渲染到界面中，但是这个类必须是UIView或者NSView的子类。
///通过@IBInspectable可以定义动态属性，即可在attribute inspector面板中可视化修改属性值。

@IBDesignable
class AvatarView : UIView {
    
    let lineWidth: CGFloat = 6.0
    let animationDuration = 1.0
    
    var shouldTransitionToFinishedState = false
    var isSquare = false
    
    
    //UI
    let photoLayer = CALayer()
    let circleLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor()
        return label
    }()
    
    
    @IBInspectable
    var image: UIImage! {
        didSet{
            print("photoLayer")
            photoLayer.contents = image.CGImage
        }
    }
    
    @IBInspectable
    var name: NSString? {
        didSet {
             print("label")
            label.text = name as? String
        }
    }
    
    
    /**
     //当加入视图完成后调用
     (void)didAddSubview:(UIView *)subview
     
     
//当视图移动完成后调用
(void)didMoveToSuperview
     
     
     //当视图移动到新的WINDOW后调用
     (void)didMoveToWindow
     //在删除视图之后调用
     (void)willRemoveSubview:(UIView *)subview
     //当移动视图之前调用
     (void)didMoveToSuperview:(UIView *)subview
     
     
//当视图移动到WINDOW之前调用
(void)didMoveToWindow
     */
    
    
    override func didMoveToWindow() {
        
        
         print("\n  didMoveToWindow")
        layer.addSublayer(photoLayer)
        photoLayer.mask = maskLayer
        layer.addSublayer(circleLayer)
        
        
        
    }
    
    
    /**
     layoutSubviews在以下情况下会被调用：
     
     1、init初始化不会触发layoutSubviews
     
     但是是用initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发
     
     2、addSubview会触发layoutSubviews
     
     3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
     
     4、滚动一个UIScrollView会触发layoutSubviews
     
     5、旋转Screen会触发父UIView上的layoutSubviews事件
     
     6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
     
     layoutSubviews, 当我们在某个类的内部调整子视图位置时，需要调用。
     
     
     刷新子对象布局
     
     -layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写
     -setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
     -layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
     
     
     
     */
    
    
    
    override func layoutSubviews() {
        
        print("\n  layoutSubviews")

        //设置尺寸
        photoLayer.frame = CGRect(x: (bounds.size.width - image.size.width + lineWidth)/2, y: (bounds.size.height - image.size.height - lineWidth)/2, width: image.size.width, height: image.size.height)
        
        circleLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
        circleLayer.strokeColor = UIColor.redColor().CGColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clearColor().CGColor
        
        maskLayer.path = circleLayer.path
        maskLayer.position = CGPoint(x: 0.0, y: 10.0)
        
        //Size the label
        label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
        
    }
    
   
    
    
    /**
     
     - parameter bouncePoint: 指定位置
     - parameter morphSize:   指定尺寸
     
     */
    func bounceOffPoint(bouncePoint: CGPoint, morphSize: CGSize) {
        
        //视图的原始中心位置
        let originalCenter = center
        
        //到达指定位置
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
            //指定
            self.center = bouncePoint
            }, completion: {_ in
                //complete bounce to
               
                if self.shouldTransitionToFinishedState {
                    self.animateToSquare()
                }
                
                
        })
        
        
        //恢复默认状态
        UIView.animateWithDuration(animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: {
            
            self.center = originalCenter
            
            }, completion: {_ in
                //回到默认状态后，延迟0.1秒再次执行动画
                delay(seconds: 0.1) {
                    
                    if !self.isSquare {
                    self.bounceOffPoint(bouncePoint, morphSize: morphSize)
                    }
                    
            } })
        
        //视图的原始中心位置 与 目的地位置 做比较
        //三目运算
        let morphedFrame = (originalCenter.x > bouncePoint.x) ?
                
                //变形后的Frame
                    CGRect(x: 0.0, y: bounds.height - morphSize.height,
                    width: morphSize.width, height: morphSize.height)
                    
                    :
                 //默认的Frame
                    CGRect(x: bounds.width - morphSize.width,
                    y: bounds.height - morphSize.height,
                    width: morphSize.width, height: morphSize.height)
    
    
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        
        //UIBezierPath 使用CGRect 创建一个椭圆的曲线来适应原始的区域。
        morphAnimation.toValue = UIBezierPath(ovalInRect: morphedFrame).CGPath
        
        //动画的样式
         morphAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        //添加动画
        circleLayer.addAnimation(morphAnimation, forKey: nil)
        maskLayer.addAnimation(morphAnimation, forKey: nil)
        
    }
    
    
    func animateToSquare() {
        
        isSquare = true
        
        let squarePath = UIBezierPath(rect: bounds).CGPath
        let morph = CABasicAnimation(keyPath: "path")
        morph.duration = 0.25
        morph.fromValue = circleLayer.path
        morph.toValue = squarePath
        
        circleLayer.addAnimation(morph, forKey: nil)
        maskLayer.addAnimation(morph, forKey: nil)
        
        circleLayer.path = squarePath
        maskLayer.path = squarePath
    }
    
}

