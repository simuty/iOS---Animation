

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
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
  
  var statusPosition = CGPoint.zero
    
   let info = UILabel()
  // MARK: view controller methods
  
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
    
    
    
    
    info.frame = CGRect(x: 0.0, y: loginButton.center.y + 60.0,
        width: view.frame.size.width, height: 30)
    info.backgroundColor = UIColor.clearColor()
    info.font = UIFont(name: "HelveticaNeue", size: 12.0)
    info.textAlignment = .Center
    info.textColor = UIColor.whiteColor()
    info.text = "Tap on a field and enter username and password"
    view.insertSubview(info, belowSubview: loginButton)

    
    
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    heading.center.x  -= view.bounds.width
    
    /****************综合****************/
    
    
//    username.center.x -= view.bounds.width
//    password.center.x -= view.bounds.width
//    
    
    
    /****************综合****************/
    
    
    loginButton.center.y += 30.0
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    UIView.animateWithDuration(0.5, animations: {
      self.heading.center.x += self.view.bounds.width
    })

    UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
      self.username.center.x += self.view.bounds.width
    }, completion: nil)

    UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: [], animations: {
      self.password.center.x += self.view.bounds.width
    }, completion: nil)

    
    
    //初始化一个动画群组
    let groupAnimation = CAAnimationGroup()
    groupAnimation.delegate = self
    groupAnimation.duration = 0.5
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5
    groupAnimation.fillMode = kCAFillModeBackwards
    //缩放
    let scaleDowm = CABasicAnimation(keyPath: "transform.scale")
    scaleDowm.fromValue = 3.5
    scaleDowm.toValue = 1.0
    //旋转
    let rotate = CABasicAnimation(keyPath: "transform.rotation")
    rotate.fromValue = CGFloat(M_PI_4)
    rotate.toValue = 0.0
    //淡入淡出的效果
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 0.0
    fade.toValue = 1.0
    
    groupAnimation.animations = [scaleDowm, rotate, fade]
    loginButton.layer.addAnimation(groupAnimation, forKey: nil)
    
    
    
        let flyLeft = CABasicAnimation(keyPath: "position.x")
        flyLeft.fromValue = info.layer.position.x +
          view.frame.size.width
        flyLeft.toValue = info.layer.position.x
        flyLeft.duration = 5.0
//重复次数
        flyLeft.repeatCount = 2.5
    //重复的时间代替重复的次数
       //flyLeft.repeatDuration = 4
    //流动的来回运动，如果将重复次数改为整数，当运动结束后，视图将直接跳转到最后指定的位置，
       flyLeft.autoreverses = true
    //设置运动本身的速度
       flyLeft.speed = 2.0
    
    
    info.layer.addAnimation(flyLeft, forKey: "infoappear")
    //设置Layer层动画的速度
    info.layer.speed = 2.0
    
 //   view整个layer层的动画速度
   // view.layer.speed = 2.0
 
  }
  
  // MARK: further methods
  
  @IBAction func login() {

    UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.bounds.size.width += 80.0
    }, completion: nil)

    UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
      self.loginButton.center.y += 60.0
      self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
      
      self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height/2)
      self.spinner.alpha = 1.0

    }, completion: {_ in
      self.showMessage(index: 0)
    })
    
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
            //reset form
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

    
 }

