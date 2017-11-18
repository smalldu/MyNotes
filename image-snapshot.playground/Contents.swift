//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
/*
 整个视图 -- 从任何一个单一的按钮到你整个界面包含视图整个层次结构--可通过调用UIView的实例方法drawViewHierarchyInRect:afterScreenUpdates:可以被绘制到当前的图形上下文中. （此方法比CALayer的renderInContext：速度快很多;不过，renderInContext：确实很方便）。绘制的结果是原始视图的快照(snapshot)：它看起来像原来的视图，但它本质上只是原来视图的一个位图图像。
 
 获得视图的快照更快的方法是使用的UIView（或UIScreen）的实例方法snapshotViewAfterScreenUpdates:.结果是一个UIView，而不是一个UIImage;这很像一个只知道如何绘制一个图像--即快照--的UIImageView。这样的快照视图通常会被用作扩大其边界和拉伸其图像。如果你想拉伸快照让它表现得像一个可调整大小的图像，调用resizableSnapshotViewFromRect：afterScreenUpdates：withCapInsets：。
 
 Snapshots非常有用因为IOS界面的动态性质。例如，你可以在真正的视图上面放置一个快照从而隐藏真正的视图上正在发生的事情，或者在动画中移动快照而不是真正的视图。
 */

class MyViewController : UIViewController {
  let imageView = UIImageView()
  
  override func loadView() {
    let view = UIView()
    view.backgroundColor = .white
    
    let button = UIButton()
    button.setTitle("snap move", for: UIControlState.normal)
    button.setTitleColor(UIColor.blue, for: UIControlState.normal)
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = UIColor.gray
    view.addSubview(imageView)
    imageView.image = UIImage(named:"Oval")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: view.topAnchor),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 15) ,
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      ])
    
    button.addTarget(self, action: #selector(snapMove), for: .touchUpInside)
    self.view = view
  }
  
  // 截图后做动画
  @objc func snapMove(){
    guard let snapshot = imageView.snapshotView(afterScreenUpdates: false) else { return }
    snapshot.frame = imageView.frame
    self.view.addSubview(snapshot)
    UIView.animate(withDuration: 0.8, animations: {
      snapshot.frame.origin.y = 600
      snapshot.alpha = 0
    }) { _ in
      snapshot.isHidden = true
      snapshot.removeFromSuperview()
    }
  }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
















