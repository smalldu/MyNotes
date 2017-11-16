//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
  
  var constraintsWith = [NSLayoutConstraint]()
  var constraintsWithout = [NSLayoutConstraint]()
  var v1: UIView!
  var v2: UIView!
  var v3: UIView!
  override func loadView() {
    let view = UIView()
    view.backgroundColor = .white
//    let v = UIView(frame:CGRect(x: 40, y: 40, width: 100, height: 100))
//    v.backgroundColor = UIColor.red
//
//    print(v.center)
//    print(v.frame.origin)
//    print(v.bounds)
//
//
//    v.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(v)
//    view.addConstraint(
//      NSLayoutConstraint(item: v ,
//                         attribute: .top ,
//                         relatedBy: .equal ,
//                         toItem: view ,
//                         attribute: .top ,
//                         multiplier: 1,
//                         constant: 20)
//    )
//    view.addConstraint(
//      NSLayoutConstraint(item: v ,
//                         attribute: .left ,
//                         relatedBy: .equal ,
//                         toItem: view ,
//                         attribute: .left ,
//                         multiplier: 1,
//                         constant: 20)
//    )
//    v.addConstraint(
//      NSLayoutConstraint(item: v ,
//                         attribute: .width ,
//                         relatedBy: .equal ,
//                         toItem: nil ,
//                         attribute: .notAnAttribute ,
//                         multiplier: 1,
//                         constant: 100)
//    )
//    v.addConstraint(
//      NSLayoutConstraint(item: v ,
//                         attribute: .height ,
//                         relatedBy: .equal ,
//                         toItem: nil ,
//                         attribute: .notAnAttribute ,
//                         multiplier: 1,
//                         constant: 100)
//    )
//    NSLayoutConstraint.activate([
//        v.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10) ,
//        v.topAnchor.constraint(equalTo: view.topAnchor, constant: 10) ,
//        v.widthAnchor.constraint(equalToConstant: 100) ,
//        v.heightAnchor.constraint(equalToConstant: 100)
//      ])
////
//    let d = ["v0":v]
//    NSLayoutConstraint.activate([
//      NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(100)]", options: [], metrics: nil, views: d),
//      NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(100)]", options: [], metrics: nil, views: d),
//      ])
    
    let v1 = UIView()
    v1.backgroundColor = UIColor.red
    v1.translatesAutoresizingMaskIntoConstraints = false
    let v2 = UIView()
    v2.backgroundColor = UIColor.yellow
    v2.translatesAutoresizingMaskIntoConstraints = false
    let v3 = UIView()
    v3.backgroundColor = UIColor.blue
    v3.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(v1)
    view.addSubview(v2)
    view.addSubview(v3)
    self.v1 = v1
    self.v2 = v2
    self.v3 = v3
    
    // 构建约束对象
    
    let c1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[v(100)]",
                                            options: [], metrics: nil, views: ["v":v1])
    let c2 = NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v":v2])
    let c3 = NSLayoutConstraint.constraints(withVisualFormat:
      "H:|-(20)-[v(100)]", options: [], metrics: nil, views: ["v":v3])
    let c4 = NSLayoutConstraint.constraints(withVisualFormat:
      "V:|-(100)-[v(20)]", options: [], metrics: nil, views: ["v":v1])
    
    let c5with = NSLayoutConstraint.constraints(withVisualFormat:
      "V:[v1]-(20)-[v2(20)]-(20)-[v3(20)]", options: [], metrics: nil,
      views: ["v1":v1, "v2":v2, "v3":v3])
    
    let c5without = NSLayoutConstraint.constraints(withVisualFormat:
      "V:[v1]-(20)-[v3(20)]", options: [], metrics: nil,
      views: ["v1":v1, "v3":v3])
    
    
    self.constraintsWith.append(contentsOf: c1)
    self.constraintsWith.append(contentsOf: c2)
    self.constraintsWith.append(contentsOf: c3)
    self.constraintsWith.append(contentsOf: c4)
    self.constraintsWith.append(contentsOf: c5with)
    
    self.constraintsWithout.append(contentsOf: c1)
    self.constraintsWithout.append(contentsOf: c3)
    self.constraintsWithout.append(contentsOf: c4)
    self.constraintsWithout.append(contentsOf: c5without)
    
    
    NSLayoutConstraint.activate(constraintsWithout)
    
    self.view = view
    
    if self.v2.superview != nil {
      self.v2.removeFromSuperview()
      NSLayoutConstraint.deactivate(self.constraintsWith)
      NSLayoutConstraint.activate(self.constraintsWithout)
    } else {
      mainview.addSubview(v2)
      NSLayoutConstraint.deactivate(self.constraintsWithout)
      NSLayoutConstraint.activate(self.constraintsWith)
    }
    
//   v1.preservesSuperviewLayoutMargins = true
    
    
  }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

