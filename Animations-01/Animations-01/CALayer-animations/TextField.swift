//
//  TextField.swift
//  Animations-01
//
//  Created by duzhe on 2017/11/21.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

class TextField: UITextField {
  
  var lineColor = UIColor.gray
  var animateLineColor = UIColor.red
  
  lazy var placeholderLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  
  lazy var animateLineView: UIView = {
    let view = UIView()
    return view
  }()
  
  lazy var lineView: UIView = {
    let view = UIView()
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    #if !TARGET_INTERFACE_BUILDER  // 非interfabuilder环境下
      // 如果是从代码层面开始使用Autolayout,需要对使用的View的translatesAutoresizingMaskIntoConstraints的属性设置为false
      translatesAutoresizingMaskIntoConstraints = false
    #endif
    prepareView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    prepareView()
  }
  
  func prepareView() {
//    placeholder = ""
    self.text = "swel"
    borderStyle = .none
    backgroundColor = UIColor.clear
    addSubview(lineView)
    lineView.translatesAutoresizingMaskIntoConstraints = false
    lineView.backgroundColor = lineColor
    
    
    NSLayoutConstraint.activate([
        lineView.leftAnchor.constraint(equalTo: self.leftAnchor),
        lineView.rightAnchor.constraint(equalTo: self.rightAnchor),
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        lineView.heightAnchor.constraint(equalToConstant: 1)
      ])
  }
  /// 编辑区域  光标区域
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x, y: bounds.height - 45  , width: bounds.width, height: 45)
  }
  
  // 设置文本显示区域
//  override func textRect(forBounds bounds: CGRect) -> CGRect {
//    return CGRect(x: bounds.origin.x, y: bounds.height - 45  , width: bounds.width, height: 45)
//  }
  
  // 设置默认文字显示区域
//  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//    return CGRect(x: bounds.origin.x, y: bounds.height - 45  , width: bounds.width, height: 45)
//  }
}



































