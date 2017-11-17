//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport


class MyView: UIView{
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 100, height: 100)
  }
  
  override var alignmentRectInsets: UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
}



class MyViewController : UIViewController {
  
  let guide = UILayoutGuide()
  
  
  override func loadView() {
    let view = UIView()
    view.backgroundColor = .white
    
    let v1 = UIView()
    v1.backgroundColor = UIColor.gray
    view.addSubview(v1)
    v1.addLayoutGuide(guide)
    
    let v2 = UIView()
    v2.backgroundColor = UIColor.red
    v1.addSubview(v2)
    v1.translatesAutoresizingMaskIntoConstraints = false
    v2.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      guide.leadingAnchor.constraint(equalTo: v1.leadingAnchor) ,
      guide.trailingAnchor.constraint(equalTo: v1.trailingAnchor) ,
      guide.bottomAnchor.constraint(equalTo: v1.bottomAnchor) ,
      guide.heightAnchor.constraint(equalToConstant: 20) ,
      v2.bottomAnchor.constraint(equalTo: guide.topAnchor) ,
      v2.leadingAnchor.constraint(equalTo: v1.leadingAnchor) ,
      v2.trailingAnchor.constraint(equalTo: v1.trailingAnchor) ,
      v2.topAnchor.constraint(equalTo: v1.topAnchor),
      v2.heightAnchor.constraint(equalToConstant: 49),
      v1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      v1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      v1.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
    // intrinsic content size 系统自建的这些约束都是有非常低的优先级。除非我们没有其他约束和他冲突，他们才会起作用。
    self.view = view
  }
  
  
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

