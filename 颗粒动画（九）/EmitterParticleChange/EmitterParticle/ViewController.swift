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
        let rect = CGRect(x: 0.0, y: -70.0, width: view.bounds.width, height: 50.0)
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
        emitterCell.birthRate = 200
        emitterCell.lifetime = 3
        //加速度
        emitterCell.yAcceleration = 100
        emitterCell.xAcceleration = 10

        //设置速度与发射的经度
        emitterCell.velocity = 20
        
        emitterCell.emissionLongitude = CGFloat(-M_PI)
        
        //随机速度 -180 - 220
        emitterCell.velocityRange = 200.0
        //随机发射角度 180 - 0
        emitterCell.emissionRange = CGFloat(M_PI_2)
        
        //随机色前提要设置初始值
        emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).CGColor
        emitterCell.redRange = 0.1
        emitterCell.greenRange = 0.1
        emitterCell.blueRange = 0.1
        
        //随机出现的大小
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
        emitterCell.scaleSpeed = -0.15
        
        //更改雪花的透明度
        emitterCell.alphaRange = 0.75
        emitterCell.alphaSpeed = -0.15
        
        
        
        //添加到发射层
        emitter.emitterCells = [emitterCell]
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

