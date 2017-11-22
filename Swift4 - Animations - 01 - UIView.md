### Spring 弹性动画

弹性动画一般有一个很快的初速度，在结束的时候也会有一个摆动。类似弹簧的效果。

```swift
UIView.animate(withDuration: 0.5 , delay: 0 , usingSpringWithDamping: 0.7 , initialSpringVelocity: 20 , options: [] , animations: {
  self.view2.center.x -= 100
}, completion: nil)
```






