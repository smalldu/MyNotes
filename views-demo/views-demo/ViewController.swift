//
//  ViewController.swift
//  views-demo
//
//  Created by duzhe on 2017/11/15.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let view1 = UIView()
  override func viewDidLoad() {
    super.viewDidLoad()
//    view.isHidden
//    view.isOpaque
//    let btn = UIButton()
//    btn.isOpaque
    
    view1.frame = CGRect(x: 20, y: 40, width: 100, height: 100)
    view1.backgroundColor = UIColor.blue
    view1.isOpaque = false
    view1.alpha = 0.3
    view.addSubview(view1)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print(view1.isOpaque)
  }
}

