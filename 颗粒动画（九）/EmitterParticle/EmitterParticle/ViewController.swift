//
//  ViewController.swift
//  EmitterParticle
//
//  Created by 51Testing on 15/12/11.
//  Copyright © 2015年 HHW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 创建一个CAEmitterLayer,
        let rect = CGRect(x: 0.0, y: 100.0, width: view.bounds.width, height: 50.0)
        let emitter = CAEmitterLayer()
         emitter.frame = rect
        view.layer.addSublayer(emitter)
        
        //指定目的地为矩形区域、位置、尺寸
        emitter.emitterShape = kCAEmitterLayerRectangle
        emitter.emitterPosition = CGPoint(x: rect.width / 2, y: rect.height / 2)
        emitter.emitterSize = rect.size
        
        //发射单元
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "flake.png")?.CGImage
        emitterCell.birthRate = 20
        emitterCell.lifetime = 3
        
        
        emitter.emitterCells = [emitterCell]
        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

