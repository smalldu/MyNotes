//
//  MyDrawView.swift
//  views-demo
//
//  Created by Zoey Shi on 2017/11/17.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class MyDrawView: UIView {

  override func draw(_ rect: CGRect) {
    draw1()
    draw2()
  }
  
  
  override func draw(_ layer: CALayer, in ctx: CGContext) {
//    它并不是当前的图形上下文，所以为了使用UIKit，我得先让它成为当前得图形上下文：
    UIGraphicsPushContext(ctx)
    let p = UIBezierPath(ovalIn:CGRect(x: 10, y: 10, width: 80, height: 80))
    UIColor.green.setFill()
    p.fill()
    UIGraphicsPopContext()
  }
  
  func draw1(){
    let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 100))
    UIColor.red.setFill()
    path.fill()
  }
  
  
  func draw2(){
    let context = UIGraphicsGetCurrentContext()
    context?.addEllipse(in: CGRect(x: 5, y: 5, width: 90, height: 90))
    context?.setFillColor(UIColor.blue.cgColor)
    context?.fillPath()
  }
  
  
  

}
