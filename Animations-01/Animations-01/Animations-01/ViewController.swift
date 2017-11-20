//
//  ViewController.swift
//  Animations-01
//
//  Created by duzhe on 2017/11/20.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var flipView1: UIImageView!
  var isView1Animating =  false
  var view1OriginX: CGFloat = 0
  override func viewDidLoad() {
    super.viewDidLoad()
    flipView1.image = #imageLiteral(resourceName: "cat").withRenderingMode(.alwaysTemplate)
    flipView1.tintColor = UIColor.purple
  }

  /// 往返动画 并指定次数
  @IBAction func doAutoReverse(_ sender: Any) {
    if self.isView1Animating {
      return
    }
//    let repeatCount: Float = 5.0
    view1OriginX = self.view1.center.x
    let options: UIViewAnimationOptions = [ .autoreverse , .repeat ]
    UIView.animate(withDuration: 0.5, delay: 0, options: options , animations: {
//      UIView.setAnimationRepeatCount(repeatCount) // 设置动画重复次数
      self.isView1Animating = true
      self.view1.center.x -= 100
    }) { _ in
      self.isView1Animating = false
      self.view1.center.x = self.view1OriginX
    }
  }
  
  
  // 两种方式都可以取消上面的动画
  @IBAction func stopView1(_ sender: Any) {
//    self.view1.layer.position = self.view1.layer.presentation()!.position
//    UIView.animate(withDuration: 0.1) {
//      self.view1.center.x = self.view1OriginX
//    }
    UIView.animate(withDuration: 0.1, delay: 0, options: .beginFromCurrentState, animations: {
      self.view1.center.x = self.view1OriginX
    }) { _ in
      
    }
  }
  
  // 翻转
  @IBAction func doFlips(_ sender: Any) {
    
    // 如果要对这写动画集体repeat 最好是用layer的 animationGroup
    UIView.transition(with: self.flipView1 , duration: 0.8 , options: .transitionFlipFromLeft , animations: {
      self.flipView1.tintColor = UIColor.red
    }) { _ in
      UIView.transition(with: self.flipView1 , duration: 0.8 , options: .transitionFlipFromTop, animations: {
        self.flipView1.tintColor = UIColor.blue
      }) { _ in
        UIView.transition(with: self.flipView1 , duration: 0.8 , options: .transitionFlipFromRight , animations: {
          self.flipView1.tintColor = UIColor.green
        }) { _ in
          UIView.transition(with: self.flipView1 , duration: 0.8 , options: .transitionFlipFromBottom  , animations: {
            self.flipView1.tintColor = UIColor.purple
          }) { _ in
            
          }
        }
      }
    }
  }
  
  
  
  
  
}
























