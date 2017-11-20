//
//  MyView.swift
//  Animations-01
//
//  Created by duzhe on 2017/11/20.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class MyView: UIView {

  // 属性可以动画
  var swing : Bool = false {
    didSet {
      var p = self.center
      p.x = self.swing ? p.x + 100 : p.x - 100
      UIView.animate(withDuration: 0 , animations: {
        self.center = p
      })
    }
  }

}
