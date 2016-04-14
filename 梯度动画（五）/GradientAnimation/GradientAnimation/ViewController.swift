//
//  ViewController.swift
//  GradientAnimation
//
//  Created by 51Testing on 15/12/4.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var gradientView: GradientView!
    
    @IBOutlet weak var timaLab: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        gradientView.text = "asdfadsfasdfasdf"
    
        
        let swipe = UISwipeGestureRecognizer(target: self, action: "didSlide")
        swipe.direction = .Right
        gradientView.addGestureRecognizer(swipe)
        
    }
    
    func didSlide() {
    
        UIView.animateWithDuration(0.5, animations: {
            
            self.timaLab.frame.origin.y -= 200
            
            }, completion: { _ in
        
                UIView.animateWithDuration(0.3, delay: 2, options: [], animations: {
                    
                 self.timaLab.frame.origin.y += 200

                    
                    }, completion: nil)
        })
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

