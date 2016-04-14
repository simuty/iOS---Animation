

import UIKit

// A delay function
func delay(seconds seconds: Double, completion:()->()) {
  let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
  
  dispatch_after(popTime, dispatch_get_main_queue()) {
    completion()
  }
}

class ViewController: UIViewController {
  
  // MARK: IB outlets
  
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!
  
  // MARK: further UI
  
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
  var statusPosition = CGPoint.zero
  let label = UILabel()
  
    //Add Label 从右至左
    let infoLab = UILabel()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true
    
    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)
    status.hidden = true
    status.center = loginButton.center
    view.addSubview(status)
    
    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .Center
    status.addSubview(label)
    
    statusPosition = status.center
    
    /*------------------本次操作----------*/
    
    infoLab.frame = CGRectMake(0.0, loginButton.center.y + 60.0, view.frame.size.width, 30)
    infoLab.backgroundColor = UIColor.clearColor()
    infoLab.font = UIFont(name: "HelveticaNeue", size: 12.0)
    infoLab.textAlignment = .Center
    infoLab.textColor = UIColor.whiteColor()
    infoLab.text = "Tap on a field and enter username and password"
    view.insertSubview(infoLab, aboveSubview: loginButton)
    
    
    username.delegate = self
    password.delegate = self
    
    /*------------------本次操作----------*/
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
  //  heading.center.x  -= view.bounds.width
    username.center.x -= view.bounds.width
    password.center.x -= view.bounds.width
    
    loginButton.center.y += 30.0
    loginButton.alpha = 0.0
    
    let fadeIn = CABasicAnimation(keyPath: "opacity")
    fadeIn.fromValue = 0.0
    fadeIn.toValue = 1.0
    fadeIn.duration = 0.5
    fadeIn.fillMode = kCAFillModeBackwards
    fadeIn.beginTime = CACurrentMediaTime() + 0.5
    cloud1.layer.addAnimation(fadeIn, forKey: nil)
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.7
    cloud2.layer.addAnimation(fadeIn, forKey: nil)
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.9
    cloud3.layer.addAnimation(fadeIn, forKey: nil)
    
    fadeIn.beginTime = CACurrentMediaTime() + 1.1
    cloud4.layer.addAnimation(fadeIn, forKey: nil)
    
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    
    
    
    
 /// CABasicAnimation 设置规则   layer负责展示  addAnimation 开始
    
    
    let flyRight = CABasicAnimation(keyPath: "position.x")
    //CABasicAnimation 本类中只有三个属性
    flyRight.fromValue = -view.bounds.size.width / 2
    flyRight.toValue = view.bounds.size.height / 2
    flyRight.duration = 0.5

    //获得当前时间，加上延迟的秒数
    flyRight.beginTime = CACurrentMediaTime() + 0.3
    
    //动画完成之后保持那种状态
    flyRight.fillMode = kCAFillModeBoth
    //动画完成之后时候显示在屏幕上
    //flyRight.removedOnCompletion = false
    
    
    
/*------------------本次操作----------*/
    
    //设置代理
    /**
    *   func animationDidStart(anim: CAAnimation!)
        func animationDidStop(anim: CAAnimation!, finished flag: Bool)
    *
    */

    flyRight.delegate = self
    //CAAnimation 遵循键值编码协议
    
    flyRight.setValue("form", forKey: "name")
    flyRight.setValue(heading.layer, forKey: "layer")
    
    flyRight.setValue(username.layer, forKey: "layer")
    flyRight.setValue(password.layer, forKey: "layer")
    
    
    heading.layer.addAnimation(flyRight, forKey: nil)

    
    //从右至左的动画
    let  flyLeft = CABasicAnimation(keyPath: "position.x")
    flyLeft.fromValue = infoLab.layer.position.x + view.frame.size.width
    flyLeft.toValue = infoLab.layer.position.x
    flyLeft.duration = 0.3
    infoLab.layer.addAnimation(flyLeft, forKey: "infoapper")
    
    //透明度有0.2至1.0
    let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
    fadeLabelIn.fromValue = 0.2
    fadeLabelIn.toValue = 1.0
    fadeLabelIn.duration = 4.5
    infoLab.layer.addAnimation(fadeLabelIn, forKey: "fadein")
    
    
/*------------------本次操作----------*/
    
    
    
    username.layer.position.x = view.bounds.size.width/2
    password.layer.position.x = view.bounds.size.width/2
    
    flyRight.beginTime = CACurrentMediaTime() + 0.3
    flyRight.fillMode = kCAFillModeBoth
    flyRight.setValue(username.layer, forKey: "layer")
    username.layer.addAnimation(flyRight, forKey: nil)
    
    flyRight.beginTime = CACurrentMediaTime() + 0.6
    flyRight.setValue(password.layer, forKey: "layer")
    password.layer.addAnimation(flyRight, forKey: nil)
    
    delay(seconds: 5.0, completion: {
        print("where are the fields?")
        })

    
    animateCloud(cloud1)
//    animateCloud(cloud2)
//    animateCloud(cloud3)
//    animateCloud(cloud4)
//    
    
    
    
    UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
        self.loginButton.center.y -= 30.0
        self.loginButton.alpha = 1.0
    }, completion: nil)

  }
  
  // MARK: further methods
  
  @IBAction func login() {

    UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.bounds.size.width += 80.0
    }, completion: nil)

    UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.center.y += 60.0
     // self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
      
      self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height/2)
      self.spinner.alpha = 1.0

    }, completion: {_ in
      self.showMessage(index: 0)
    })
    
    
    let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)

    tintBackgroundColor(layer: loginButton.layer, toColor: tintColor)
    
    roundCorners(layer: loginButton.layer, toRadius: 25.0)
    

    
    
    
  }

  func showMessage(index index: Int) {
    label.text = messages[index]
    
    UIView.transitionWithView(status, duration: 0.33, options:
      [.CurveEaseOut, .TransitionCurlDown], animations: {
        self.status.hidden = false
      }, completion: {_ in
        //transition completion
        delay(seconds: 2.0) {
          if index < self.messages.count-1 {
            self.removeMessage(index: index)
          } else {
            self.resetForm()
          }
        }
    })
  }

  func removeMessage(index index: Int) {
    
    UIView.animateWithDuration(0.33, delay: 0.0, options: [], animations: {
        
      self.status.center.x += self.view.frame.size.width
        
    }, completion: {_ in
      self.status.hidden = true
      self.status.center = self.statusPosition
      
      self.showMessage(index: index+1)
    })
  }
    
    
    func resetForm() {
        
        UIView.transitionWithView(status, duration: 0.2, options: .TransitionFlipFromTop, animations: {
            self.status.hidden = true
            self.status.center = self.statusPosition
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
            
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
            
            }, completion: {_ in
                let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
                tintBackgroundColor(layer: self.loginButton.layer, toColor: tintColor)
                roundCorners(layer: self.loginButton.layer, toRadius: 10.0)
        })
    }

    
    
   /*------------------本次操作----------*/
    
    func animateCloud(cloud: UIImageView) {
        //速度
        let cloudSpeed = 10 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
    
         print("\n11111111    \(cloudSpeed)")
         print("\n2222222    \(duration)")
    
        let test = NSTimeInterval(duration)
    
    
        print("\n----------   \(duration)")
    
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: .CurveLinear, animations: {
            
            //移动至最右侧
            cloud.frame.origin.x = self.view.frame.size.width
             print("\n333333     \(cloud.frame.origin.x)")
            
            }, completion: {_ in
                //置为最屏幕左侧，伪装为循环
                cloud.frame.origin.x = -cloud.frame.size.width
                
                print("\n44444444    \(cloud.frame.origin.x)")
                self.animateCloud(cloud)
                
        })
    }
    

    
    /**
            MARK delegate
    */
    
    
    override func animationDidStart(anim: CAAnimation) {
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("animation did finish")
        
            if  let name = anim.valueForKey("name") as? String {
                
                let layer = anim.valueForKey("layer") as? CALayer
                anim.setValue(nil, forKey: "layer")
                
                let pulse = CABasicAnimation(keyPath: "transform.scale")
                pulse.fromValue = 1.25
                pulse.toValue = 1.0
                pulse.duration = 0.25
                layer?.addAnimation(pulse, forKey: nil)
        
            }
        
        
    }
    
    
   
    

 
}



extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print(infoLab.layer.animationKeys())
    }
        
}



/*------------------本次操作----------*/


//设置背景色与圆角的动画一样，1、初始化动画 2、设置三个属性 3、添加动画 4、layer层添加相应的内容
func tintBackgroundColor(layer layer: CALayer, toColor: UIColor) {
    
    let tint = CABasicAnimation(keyPath: "backgroundColor")
    tint.fromValue = layer.backgroundColor
    tint.toValue = toColor.CGColor
    tint.duration = 1.0
    layer.addAnimation(tint, forKey: nil)
    layer.backgroundColor = toColor.CGColor
}


func roundCorners(layer layer: CALayer, toRadius: CGFloat) {
    
    let round = CABasicAnimation(keyPath: "cornerRadius")
    round.fromValue = layer.cornerRadius
    round.toValue = toRadius
    round.duration = 0.33
    layer.addAnimation(round, forKey: nil)
    layer.cornerRadius = toRadius
}







