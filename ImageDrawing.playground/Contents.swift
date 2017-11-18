//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport


class MyViewController : UIViewController {
  
  let imageView = UIImageView()
  let imageView1 = UIImageView()
  let imageView2 = UIImageView()
  let imageView3 = UIImageView()
  let imageView4 = UIImageView()
  
  override func loadView() {
    let view = UIView()
    view.backgroundColor = .white
    
//    let image = UIImage(named:"oval")
    imageView.backgroundColor = UIColor.lightGray
    imageView1.backgroundColor = UIColor.lightGray
    imageView2.backgroundColor = UIColor.lightGray
    imageView3.backgroundColor = UIColor.lightGray
    imageView4.backgroundColor = UIColor.lightGray
    
    imageView.image = self.generalTwoCircles()
    view.addSubview(imageView)
    imageView1.image = self.mutiplyImage()
    view.addSubview(imageView1)
    imageView2.image = self.rightHalf()
    view.addSubview(imageView2)
    imageView3.image = self.twoHalf()
    view.addSubview(imageView3)
    imageView4.image = self.prefectTwoHalfs()
    view.addSubview(imageView4)
    
    imageView1.translatesAutoresizingMaskIntoConstraints = false
    imageView2.translatesAutoresizingMaskIntoConstraints = false
    imageView3.translatesAutoresizingMaskIntoConstraints = false
    imageView4.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.topAnchor.constraint(equalTo: view.topAnchor),
      imageView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
      imageView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView2.topAnchor.constraint(equalTo: imageView1.bottomAnchor, constant: 10),
      imageView3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView3.topAnchor.constraint(equalTo: imageView2.bottomAnchor, constant: 10),
      imageView4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView4.topAnchor.constraint(equalTo: imageView3.bottomAnchor, constant: 10)
      
      ])
    self.view = view
  }
  
  // 绘制两个 圆
  func generalTwoCircles()-> UIImage?{
    let image = UIImage(named:"oval")!
    let size = image.size
    UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width*2, height: size.height), false, 0)
    
    image.draw(at: CGPoint.zero)
    image.draw(at: CGPoint(x: size.width, y: 0))
    
    let im = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return im
  }
  
  // 同心圆
  func mutiplyImage() -> UIImage?{
    let image = UIImage(named:"oval")!
    let size = image.size
    UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width*2, height: size.height*2), false, 0)
    
    image.draw(in: CGRect(x: 0, y: 0, width: size.width*2, height: size.height*2))
    image.draw(in: CGRect(x: size.width/2, y: size.height/2, width: size.width, height: size.height))
    let im = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return im
  }
  
  // 图片的右半边
  func rightHalf()-> UIImage?{
    let image = UIImage(named:"oval")!
    let size = image.size
    UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width/2, height: size.height), false, 0)
    
    image.draw(at: CGPoint(x: -size.width/2, y: 0))
    
    let im = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return im
  }
  
  // cgImage 两个 一半 会出现垂直翻转  这个未处理 scale问题
  func twoHalf() -> UIImage?{
    let image = UIImage(named:"oval")!
    let cgImage = image.cgImage
    let size = image.size
    
    let imageLeft = cgImage?.cropping(to: CGRect(x: 0, y: 0, width: size.width/2, height: size.height))
    
    let imageRight = cgImage?.cropping(to: CGRect(x: size.width/2, y: 0, width: size.width/2, height: size.height))
    UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width * 1.5, height: size.height), false, 0)
    
    let context = UIGraphicsGetCurrentContext()
    context?.draw(flip(im: imageLeft!) , in: CGRect(x: 0, y: 0, width: size.width/2, height: size.height))
    context?.draw(flip(im: imageRight!) , in: CGRect(x: size.width , y: 0, width: size.width/2, height: size.height))
    
    let im = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return im
  }
  
  // 将cgimage 垂直翻转
//  绘制CGImage到一个中间的UIImage然后从中间UIImage中提取出另一个CGImage
  func flip(im: CGImage) -> CGImage {
    let size = CGSize(width: im.width, height: im.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let context = UIGraphicsGetCurrentContext()
    context?.draw(im, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let result = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
    UIGraphicsEndImageContext()
    return result!
  }
  
  // 因为cgimage 没有scale属性,所以 处理CGImage最好的解决办法是，把它封装为一个UIImage并绘制这个UIImage而不是直接绘制CGImage从CGImage生成UIImage时可以调用init(CGImage:scale:orientation:)来避免图片的缩放。而且直接绘制UIImage而不是CGImage也避免翻转问题！
  func prefectTwoHalfs()->UIImage?{
    let image = UIImage(named:"oval")!
    let cgImage = image.cgImage!
    let size = image.size
    
    let sizeCG = CGSize(width: cgImage.width, height: cgImage.height)
    let imageLeft = cgImage.cropping(to: CGRect(x: 0, y: 0, width: sizeCG.width/2, height: sizeCG.height))
    let imageRight = cgImage.cropping(to:  CGRect(x: sizeCG.width/2 , y: 0, width: sizeCG.width/2, height: sizeCG.height))
    UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width * 1.5, height: size.height), false, 0)
    
    UIImage(cgImage: imageLeft! , scale: image.scale, orientation: image.imageOrientation)
      .draw(at: CGPoint.zero)
    UIImage(cgImage: imageRight! , scale: image.scale, orientation: image.imageOrientation)
      .draw(at: CGPoint(x: size.width, y: 0))
    let im = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return im
  }
//  drawViewHierarchyInRect:afterScreenUpdates: 此方法比CALayer的renderInContext：速度快很多;不过，renderInContext：确实很方便，绘制的结果是原始视图的快照(snapshot)：它看起来像原来的视图，但它本质上只是原来视图的一个位图图像
}


PlaygroundPage.current.liveView = MyViewController()

