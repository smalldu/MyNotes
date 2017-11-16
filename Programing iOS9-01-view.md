# UIView - 01

view 指 `UIView` 以及他的子类，他可以将自己绘制在一个矩形内，我们可以很轻松的操作它的大小、变换、隐藏显示等。
view 也是一个响应者（因为它继承自`UIResponder`），所以view 为我们提供了很多用户交互方式，如点击、滑动、双击、长按等。还有一些touches方法。
view 的层级使我们组织一个界面最重要的因素，一个view可以有多个subviews，只有一个直接superView。这样就形成一个层级树。这个层级允许视图一起出现、消失或者移动。
你可以通过xib或者code创建view，这个完全取决于你的需求或者喜好，个人偏爱xib。

### UIWindow

window 一般是view层级最底层的视图，一般是一个`UIWindow`（`UIViw`的子类）对象，当然你也可以自定义它的子类。它在运行时被创建然后一直不会被销毁或者替换。是其他所有view的superview。

> 如果你的 App 可以在额外的饿屏幕上展示view，你也可以创建另一个 `UIWindow` 来包含这些views.暂时不在讨论范围内。 

创建`UIWindow`
iOS 9 以前,必须指定frame

```swift
let w = UIWindow(frame: UIScreen.main.bounds)
```

iOS 9以后

```swift
let w = UIWindow()
```
系统将会自动将 `UIScreen.main.bounds` 赋值给它的 `frame` 

为了保证window在app的整个生命周期一直被持有，`AppDelegate` 持有一个`window`属性的强引用。

我们一般并不会将view直接放在window上操作，而是使用 viewControler 赋值给window的 `rootViewController` 属性，一旦一个 viewController 称为 window 的rootViewController , 它的 `view` 将成为 window 的 rootView 。其他views 都将是这个 root view的subviews。

调用window的 `makeKeyAndVisible` 使界面显示出来。

来总结下 main window创建的两种方式。

- *使用 main storyboard*

如果我们的app创建时通过 `Single View App` 默认是通过这种方式，会在Info.plist 中指定Main storyboard的name。在调用 `application:didFinishLaunchingWithOptions: ` 之前，系统会自动给 appDelegate 的 `window`属性赋值，为一个`UIWindow`对象 frame自动设置为 main bounds. 然后调用上述方法，然后自动调用 `makeKeyAndVisible`，自动将window的rootViewController 设置为 main storyboard 中的initail view controller.

如果你想使用自定义的`window` 
修改AppDelegate中的window 
```swift
lazy var window : UIWindow? = {
    return MyWindow()
}()
```

系统从这个属性取，如果没有取到才会赋值 `UIWindow` 

- code创建

首先删除 Main.storyboard 和 ViewController等，选中target 删除main interface下的`Main` ,然后删除AppDelegate里无用内容。只留下`application:didFinishLaunchingWithOptions: `和`window`属性。

```swift
import UIKit
@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)
        -> Bool {
            self.window = UIWindow()
            self.window!.rootViewController = UIViewController()
            self.window!.backgroundColor = UIColor.whiteColor()
            self.window!.makeKeyAndVisible()
            return true
} }

```
以上就是最少work代码。这里你也可以指定为自定义的 window

一个app运行以后，获取window的方式：

- `view.window` 可能为空，如果一个view还没有被添加到window上的时候这个值是空的。可以用他来判断view是否被加到window上
- `let w = UIApplication.shared.delegate!.window!!` 缺点，需要多层解包，如果不想多层解包，也可以这样`let w = (UIApplication.shared.delegate as! AppDelegate).window!` 
- 还有一种方式 `let w = UIApplication.shared.keyWindow!` 但是这个不太稳定，因为系统可能会创建临时然后把他们赋值给`keywindow` 

所以第二种最可靠！

### subView 和 superView

在iOS中，一个view的subView是可以绘制在view的外面（outside）。view也可以和其他view交叠。

同一层级拥有相同superView的view有确定的顺序。如果两个view有重叠的部分，哪个后draw重叠部分就显示哪个视图（不透明度为1的情况）。如果使用xib布局，我们可以调整这些顺序。选中xib然后 Editor-> Arrange -> Send to Front\Send to Back\Send Forward\Send Backward 。也可以直接拖动。

code方式。

- 如果一个 removed 或者 在superview内移动，这些都将同时发生在它的subviews上
- 一个view的不透明度也会被它的subviews继承
- view可以限制他的subviews是否可以在视图之外渲染，如果调用`clipsToBounds`超出部分将会被裁剪
- 一个superview有用他的subviews
- 如果一个 view 的尺寸变化了，它的 subview 也会自动被重新设置尺寸

一个UIView有一个`superview`属性和一个`subviews`（数组）属性（都是可空类型）。可以据此来判断视图层级。另外也有一个 `isDescendant(of:)` 方法来检查一个 view 是不是另一个 view 的 subview (可以不是直接子视图)。View 还有一个 `tag` 属性，可以通过 `viewWithTag:` 来进行引用。我们最好给所有`subviews`设置不同的`tag`

使用代码操作视图层级：（可以直接操作，也可以配合动画）

- `addSubview:` 方法添加一个 subview
- `removeFromSuperview` 移除一个 subview
- `insertSubview:atIndex:` 指定index层级
- `insertSubview:belowSubview:` 在某个view下面添加一个subview
- `insertSubview:aboveSubview:` 在某个view上面添加一个subview
- `exchangeSubviewAtIndex:withSubviewAtIndex:` 交换两个subview的位置
- `bringSubviewToFront:` 将某个subview移动到最前面
- `sendSubviewToBack:` 将某个subview放到最后面

没有一个方法可以直接移除一个 view 的所有 subview。然而，因为一个 view 的 subview 数组是一个不可变的数组，所以可以用如下方法一次移除全部：

```swift
myView.subviews.forEach {$0.removeFromSuperview}
```

重写下列方法就可以根据需要在不同的情况下进行不同的操作：

- `didAddSubview:`, `willRemoveSubview:`
- `didMoveToSuperview`, `willMoveToSuperview:`
- `didMoveToWindow`, `willMoveToWindow:`

### Visibility and Opacity（可见性和透明度）

视图的可见性可以通过设置 `isHidden` 属性来更改。一个隐藏的 view 无法接收触摸事件，所以对于用户来说相当于不存在，但实际上是存在的，所以仍然可以在代码中对其操作

View 的背景颜色可以通过其 `backgroundColor` 属性来设置，颜色属于 `UIColor` 类。如果 `backgroundColor` 为 `nil`(默认值) 那么背景就是透明的

可以通过设置 view 的 `alpha` 属性来修改透明程度，1.0 是完全不透明，0.0 是透明。假设一个 view 的 `alpha` 是 0.5，那么它的 `subview` 的 alpha 都是以 0.5 为基准的，不可能高于 0.5。而 `UIColor` 也有 `alpha` 这个属性，所以即使一个 view 的 `alpha` 是 1.0，它仍旧可能是透明的，因为其 `backgroundColor` 可以是透明的。一个 `alpha` 为 0.0 的 view 是完全透明的所以是不可见的，通常来说也不可能被点击。


View 的 `alpha` 属性不仅影响背景颜色，也会影响其内容的透明度。（比如一个背景色将会渗透图片）


view的 `isOpaque`（不透明度）,并不会影响view的样子，更多的是对于系统绘制时的提示。如果一个 view 的 `isOpaque` 设为 true，因为不用考虑透明的绘制，所以效率会高一点，并且再设置透明的背景颜色或者 `alpha` 属性都无效(自己试验设置`alpha`是有效的...)。可能会让人吃惊，它的默认值是 true

官方文档是这么说的: 

>An opaque view is expected to fill its bounds with entirely opaque content—that is, the content should have an alpha value of 1.0
. If the view is opaque and either does not fill its bounds or contains wholly or partially transparent content,the results are unpredictable. You should always set the value of this property to NO
if the view is fully or partially transparent.


如果opaque被设置成YES，而对应UIView的alpha属性不为1.0的时候，就会有不可预料的情况发生

### Frame

View 的 frame属性(CGRect类) 是它本身的长方形在 superview 中的位置，注意是在 superview 的坐标系中的位置。默认来说，superview 的坐标系原点在左上，向右 x 增加，向下 y 增加

看一个frame使用的简单的例子：

```swift
let mainview = self.view
let v1 = UIView(frame:CGRectMake(113, 111, 132, 194))
v1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
let v2 = UIView(frame:CGRectMake(41, 56, 132, 194))
v2.backgroundColor = UIColor(red: 0.5, green: 1, blue: 0, alpha: 1)
let v3 = UIView(frame:CGRectMake(43, 197, 160, 230))
v3.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
mainview.addSubview(v1)
v1.addSubview(v2)
mainview.addSubview(v3)
```
***

### Bounds and Center

`frame` 是一个view在它superview的坐标系的位置， `bounds`对应的是view在自己的坐标系下的位置和尺寸

`bounds` 的 `size` 会影响其 `frame` 的 `size` ，改变 `frame` 的 `size` 会影响其 bounds 的 `size` 。只有 view 的 `center` 不会影响 `bounds` 的 `size` 。 这个属性代表了 subview 在 superview 中的 `position` 。

获取 view center的方法 

```swift
let c = CGPointMake(view1.bounds.midX + view1.frame.origin.x ,view1.bounds.midY + view1.frame.origin.y)
```

view的bounds和center互不影响，相互独立的。frame是center和bounds便捷的表达。大多数情况我们只需要使用frame就可以了。一般会通过init(frame:) 来创建一个view。注意有些情况下 frame 会没有什么意义，但是 bounds 和 center 总是有效的，所以建议多用 bounds 和 center 的组合，也比较容易理解。

- bounds: 一个 view 自己的坐标系统
- center: 一个 view 的坐标系统和其 superview 的坐标系统的关系

![center](http://oyl1dq3ij.bkt.clouddn.com/center.png)

可以用如下方法来进行不同 view 之间的坐标转换:

- `convertPoint:fromView:`, `convertPoint:toView:`
- `convertRect:fromView:`, `convertRect:toView:`

如果第二个参数是nil，系统自动填补为 `window`

>注意，通过改变 center 来设置 view 的位置时，如果高或宽不是偶数，那么可能会导致 misaligned(错位)。可以通过打开模拟器的 Debug -> Color Misaligned Images 来进行检测。


### Window Coordinates and Screen Coordinates(窗口坐标和屏幕坐标)

设备屏幕是没有 frame 的，但是有 `bounds` 也就是 `UIScreen.main.bounds` 。 Main window 也没有 superview，不过其 `frame` 被设置为屏幕的 `bounds`. 前面将window的时候有说过。

大多数情况下，window是充满整个屏幕的，所以大多数情况下window的坐标和screen的坐标是一样的。

现在的 iOS 中坐标系和手机是否选择是有关的，有如下两个属性：（在实际开发中基本不会碰到）

- UIScreen 的 `coordinateSpace` 属性
    + 这个坐标空间会旋转，就是高和宽在设备旋转时会呼唤，(0.0, 0.0) 是这个 app 本身的左上方

- UIScreen 的 `fixedCoordinateSpace` 属性
    + 这个坐标空间不会变化，就是物理上的左上角，从用户来看，这里的 (0.0, 0.0) 可能是 app 本身的任何一个角

可以用下面的方法来对不同坐标空间进行转换：

- `convertPoint:fromCoordinateSpace:`, `convertPoint:toCoordinateSpace:`
- `convertRect:fromCoordinateSpace:`, `convertRect:toCoordinateSpace:`

假设界面中有一个 UIView v，我们想知道它的实际设备坐标，可以用下面的代码：

```swift
let r = v.superview?.convert(v.frame, to: UIScreen.main.fixedCoordinateSpace)
```

但实际上你需要这种信息的机会非常少(反正我是没遇到过需要使用的)，或者其实几乎都不用担心 window 坐标，因为所有的可见操作都会在 root view contoller 的 main view 中进行，它的 bounds 是会自动调整的。

### Transform ( 变换 )

一个 view 的 transform 属性改变这个 view 是如何被绘制的，实际上就是一个 CGAffineTransform类的 3x3 矩阵（线性代数中的概念）。所有的变换都是以这个 view 的 center 做基准的。

以下为view的平移旋转缩放

```swift
v.transform = CGAffineTransform
      .identity
      .rotated(by: 10 * CGFloat(Double.pi/180))
      .translatedBy(x: 10, y: 0)
      .scaledBy(x: 1.1, y: 1.1)
```

### Trait Collections and Size Classes

界面上的每个 view(或者ViewController) 都有一个 `traitCollection` 属性 , 值是一个 UITraitCollection，包含下面四个属性：

- `displayScale` 由当前屏幕决定的缩放尺寸，1 4以前的机型 基本没有了应该 2 、（4，5，6 3） 3、 (iPhone 6 plus/6s Plus) 。（和UIScreen的scale值是一样的）
- `userInterfaceIdiom` 一个 `UserIterfaceIdiom` 值 ，可能是 `.phone` 或 `.pad` ，来标志不同的设备，默认来说和 UIDevice 的 `userInterfaceIdiom` 属性一致
- `horizontalSizeClass`, `verticalSizeClass`，是 `UIUserInterfaceSizeClass` 值，可能是 `.regular` 或 `.compact`
    - 水平和竖直都是 .regular -> iPad
    - 水平是 .compact 竖直是 .regular -> iPhone 在垂直方向，或者 iPad 的分屏应用
    - 水平和竖直都是 .compact -> iPhone 在水平方向(iPhone 6/6s plus除外)
    - 水平是 .regular 竖直是 .compact -> iPhone 6/6s Plus 在水平方向


### Layout

superview 移动的时候 subview 就会移动。subview 大小和位置 会随着 superview改变，这就是layout。

一些superview动态改变的例子： 

- 屏幕旋转的时候，左上角会发生变化，长宽也要对调
- 我们的app需要等比例匹配不同的设备尺寸
- universal app需要运行在iPad和iPhone上，所以自己需要知道自己运行的环境来适应不同的屏幕
- 从xib初始化的view，需要resize去适应所在的view
- view需要适应别的view的变化对自己的影响，比如navagationBar隐藏和显示

在以上的任何情况下其他view可能需要Layout，还有一些其他情况

Layout 有三种主要的执行方式

- 手动 `layout:superview` 在被更改尺寸会发送 `layoutSubviews` 消息，如果你新建自己的子类并且重写 `layoutSubviews` 就可以手动进行更改，这很麻烦，但是可以做任何你想做的事情
- Autoresizing： iOS 6 之前的方式，主要是通过自己的 `autoresizingMask` 属性来变化
- Autolayout：根据 view 的 constraints(NSLayoutConstraint)来进行变化，是很强大的功能，不用写代码就可以进行复杂的定制

### Autoresizing

Autoresizing 是一种自动拉伸和固定大小的一种概念，view有一个 `autoresizingMask` 属性 ，这个属性是一个 `UIViewAutoresizing` 的值 。默认是 `.none` 。下面举例来看看它的用法：


```swift
let mainview = self.view
let v1 = UIView(frame:CGRectMake(100, 111, 132, 194))
v1.backgroundColor = UIColor(red: 1, green: 0.4, blue: 1, alpha: 1)
let v2 = UIView(frame:CGRectMake(0, 0, 132, 10))
v2.backgroundColor = UIColor(red: 0.5, green: 1, blue: 0, alpha: 1)
let v3 = UIView(frame:CGRectMake(v1.bounds.width-20, v1.bounds.height-20, 20, 20))
v3.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
mainview.addSubview(v1)
v1.addSubview(v2)
v1.addSubview(v3)
```


如果我加上一句代码，改变了v1的宽度呢？

```swift
v1.bounds.size.width += 40
```

这时候就可以利用autoresizingMask属性来指定v2的宽度可伸缩。

```
v2.autoresizingMask = .flexibleWidth
```

感兴趣的同学可以研究下，其实这些已经不是那么常用了，我们有更强大的 `AutoLayout` 了，基本不需要它了。











