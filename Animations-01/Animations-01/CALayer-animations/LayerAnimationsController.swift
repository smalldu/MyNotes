//
//  LayerAnimationsController.swift
//  Animations-01
//
//  Created by duzhe on 2017/11/20.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class LayerAnimationsController: UIViewController {
  
  @IBOutlet weak var view1: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()
////    CATransaction
//    CATransaction.setDisableActions(true) // 关闭默认隐式动画
    view1.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
  }
  
  @IBAction func doRotate(_ sender: Any) {
    let layer = view1.layer
    
    CATransaction.setDisableActions(true)
    let baseAnimate = CABasicAnimation()
    let startValue = layer.transform
    let endValue = CATransform3DRotate(startValue, CGFloat(Double.pi/4), 0, 0, 1)
    layer.transform = endValue
    
    baseAnimate.keyPath = "transform"
    
    baseAnimate.duration = 0.8
    let clunk = CAMediaTimingFunction(controlPoints:0.9, 0.1, 0.7, 0.9)
    baseAnimate.timingFunction = clunk
    
    baseAnimate.fromValue = NSValue(caTransform3D: startValue)
    baseAnimate.toValue = NSValue(caTransform3D: endValue)
    
    layer.add(baseAnimate, forKey: nil)
  }
}

