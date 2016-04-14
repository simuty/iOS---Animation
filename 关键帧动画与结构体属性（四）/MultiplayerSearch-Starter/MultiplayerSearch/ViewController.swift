

import UIKit

//
// Util delay function
//
func delay(seconds seconds: Double, completion:()->()) {
  let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
  
  dispatch_after(popTime, dispatch_get_main_queue()) {
    completion()
  }
}

class ViewController: UIViewController {
  
  @IBOutlet var myAvatar: AvatarView!
  @IBOutlet var opponentAvatar: AvatarView!
  
  @IBOutlet var status: UILabel!
  @IBOutlet var vs: UILabel!
  @IBOutlet var searchAgain: UIButton!
  
    let animationDuration = 0.4
    
    
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    
    searchForOpponent()
  }
    
    
    func searchForOpponent() {
        
        let avatarSize = myAvatar.frame.size
        let bounceXOffset: CGFloat = avatarSize.width/1.9
        let morphSize = CGSize(
        width: avatarSize.width * 0.85,
        height: avatarSize.height * 1.1)
        
        
        let rightBouncePoint = CGPoint(
            x: view.frame.size.width/2.0 + bounceXOffset, y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(
            x: view.frame.size.width/2.0 - bounceXOffset,
            y: myAvatar.center.y)
        
        myAvatar.bounceOffPoint(rightBouncePoint, morphSize: morphSize)
        opponentAvatar.bounceOffPoint(leftBouncePoint, morphSize: morphSize)
        
        //停4秒后加载图片
        delay(seconds: 4.0, completion: foundOpponent)
        
        
    }
    
//寻找对手
    func foundOpponent() {
        
        status.text = "Connecting...."
        opponentAvatar.image = UIImage(named: "avatar-2")
        opponentAvatar.name = "Name"
        
        delay(seconds: 4, completion:connectedToOpponent)
        
    }
    
    func connectedToOpponent() {
            myAvatar.shouldTransitionToFinishedState = true
            opponentAvatar.shouldTransitionToFinishedState = true
            
            delay(seconds: 1.0, completion: completed)
    }

    
    func completed() {
            
            status.text = "Ready to play"
            
            UIView.animateWithDuration(0.2) {
                self.vs.alpha = 1.0
                self.searchAgain.alpha = 1.0
            }
            
            
    }
    
       
  
  @IBAction func actionSearchAgain() {
    UIApplication.sharedApplication().keyWindow!.rootViewController = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as? UIViewController
  }
}

