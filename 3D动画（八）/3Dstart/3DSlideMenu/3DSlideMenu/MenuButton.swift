////
////  MenuButton.swift
////  3DSlideMenu
////
////  Created by 51Testing on 15/12/9.
////  Copyright © 2015年 HHW. All rights reserved.
////
////
//import UIKit
//
//
////自定义按钮
//class MenuButton: UIView {
//    
//    var imageView: UIImageView!
//    var tapHandler: (()->())?
//    
//    //当视图移动完成后调用
//    override func didMoveToSuperview() {
//        frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
//        imageView = UIImageView(image: UIImage(named: "menu.png"))
//        imageView.userInteractionEnabled = true
//        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTap")))
//        addSubview(imageView)
//    }
//    
//    func didTap() {
//        tapHandler?()
//    }
//
//}


import UIKit

class MenuButton: UIView {
    
    var imageView: UIImageView!
    var tapHandler: (()->())?
    
    override func didMoveToSuperview() {
        frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        
        imageView = UIImageView(image:UIImage(named:"menu.png"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTap")))
        addSubview(imageView)
    }
    
    func didTap() {
        tapHandler?()
    }
}