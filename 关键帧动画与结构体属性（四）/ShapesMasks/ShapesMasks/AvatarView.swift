

import UIKit
import QuartzCore

@IBDesignable
class AvatarView: UIView {
  
  //constants
  let lineWidth: CGFloat = 6.0
  let animationDuration = 1.0
  
  //ui
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
  
  //variables
  @IBInspectable
  var image: UIImage! {
    didSet {
        
      photoLayer.contents = image.CGImage
        
        
    }
  }
  
  @IBInspectable
  var name: NSString? {
    didSet {
      label.text = name as? String
    }
  }
  
  var shouldTransitionToFinishedState = false
  
  override func didMoveToWindow() {
    

    layer.addSublayer(photoLayer)
    photoLayer.mask = maskLayer
    layer.addSublayer(circleLayer)
    
  }
  
  override func layoutSubviews() {
    
    //Size the avatar image to fit
    photoLayer.frame = CGRect(
      x: (bounds.size.width - image.size.width + lineWidth)/2,
      y: (bounds.size.height - image.size.height - lineWidth)/2,
      width: image.size.width,
      height: image.size.height)
    
    //Draw the circle
    circleLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
    circleLayer.strokeColor = UIColor.whiteColor().CGColor
    circleLayer.lineWidth = lineWidth
    circleLayer.fillColor = UIColor.clearColor().CGColor
    
    //Size the layer
    maskLayer.path = circleLayer.path
    maskLayer.position = CGPoint(x: 0.0, y: 10.0)
    
    //Size the label
    label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
  }
  
}
