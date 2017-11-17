//
//  ResizableImagesController.swift
//  views-demo
//
//  Created by Zoey Shi on 2017/11/17.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class ResizableImagesController: UIViewController {
  
  
  @IBOutlet weak var bubbleView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let bubble = #imageLiteral(resourceName: "bubble")
//    bubble.renderingMode
//    bubble.withRenderingMode(.alwaysTemplate) 改变render mode 就可以去除图片的像素只留下 透明值和一个纯色的 tint color 混合而成的图片
    view.tintColor = UIColor.red
    
//    tintColor 的属性是一层一层继承下来的 改变了父view的tintColor 如果子view没有设置 则默认使用父view  整个系统的tintColor 默认继承 key window的tintColor
    let bubbleTiled = bubble.resizableImage(withCapInsets: UIEdgeInsets(top: 50, left: 100, bottom: 50, right: 50) , resizingMode: .tile)
    bubbleView.image = bubbleTiled.withRenderingMode(.alwaysTemplate)
//    bubbleView.image = createImage()
//    bubbleTiled.imageFlippedForRightToLeftLayoutDirection()
  }
  
//  Graphics Contexts 绘制图片
  
  
  func createImage() -> UIImage?{
    // 第一个参数为size 第二个参数为是否需要透明 如果为true 会有个黑色的背景 第三个参数为缩放系数 传0告诉系统根据主屏幕来设置图片的缩放系数
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 100) , false, 0)
    // 也可以用context的方式
//    let context = UIGraphicsGetCurrentContext()!
    let p = UIBezierPath(ovalIn:  CGRect(x: 0, y: 0, width: 100, height: 100))
    UIColor.blue.setFill()
    p.fill()
    let im = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return im
  }
  
  
  
}

