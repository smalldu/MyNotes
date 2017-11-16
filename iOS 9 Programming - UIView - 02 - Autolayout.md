# UIView - 02 - Autolayout

也许以前，`Autolayout` 是一个可选的技术，你可以使用它或者不使用它转而去使用`frame`布局。但是`Autolayout`必然是以后的趋势，随着苹果发布的手机越来越多，越来越多的尺寸需要去适配，使用`frame` 布局，对以后代码的维护简直是灾难。尤其现在又出了 iPhone X ，有了安全区域的概念， `frame` 布局更加困难，要写很多的代码考虑兼容版本。 虽然 Autolayout 在性能上相比 frame布局是差了点，但是随着设备硬件环境的提高，这些性能上的差异几乎可以无视，除非是对性能非常敏感的App 。大多数情况我们还是需要迅速的完成任务，才能有更多的时间来做其他的事情。那么 Autolayout 就会是我们必须要掌握的技术了。

扯了一堆废话，就像说明它在我心中的重要性。

一般通过AutoLayout：

- 在代码中为 view 添加约束代码
- 在xib或者storyboard中建立约束

### 约束（Constraints）

一个AutoLayout的约束是一个 `NSLayoutConstraint` 的实例 ,用来描述view自身的宽高或者与别的view的属性的关系。这两个view要拥有同一个superview（不一定是直接父视图）,也即是他们拥有同一个祖先。

看下 `NSLayoutConstraint` 的主要属性

- `firstItem`, `firstAttribute`, `secondItem`, `secondAttribute` 

    - 一个约束用来描述两个view的属性的关系，如果约束是描述一个view自己的height或者width，那么second view的值就是nil，它的attribute就是`.notAnAttribute` 。 另外 `NSLayoutAttribute` 有以下值：
        + `.left` , `.right` , `.leading`,`.trailing`
        + `.top` , `.top`
        + `.width`,`.height`
        + `.centerX`,`.centerY`
        + `.firstBaseline` , `.lastBaseline`
        + `.notAnAttribute`

>.leading, .trailing 等价于 .left , .right
.firstBaseline主要用于多个labels，指从上到下有一定距离。.lastBaseline是指从下到上。

- `multiplier`, `constant` 
  
   用来描述属性的关系，multiplier做乘法，constant做加法

- `relation`
    是一个`NSLayoutRelation`类型的值，表示两个属性之间的关系，有三种关系，分别是：`lessThanOrEqual``equal`、`greaterThanOrEqual` 

- `priority` 
    `priority` 的值从1000-1，每个约束可以有不同的优先级，决定他们使用的顺序。是一个 `UILayoutPriority` 对象


约束需要作用的view上，一个view可以有多个约束，so view有一个 `constraints` 属性。还有一些实例方法：

- `addConstraint:`, `addConstraints:`
- `removeConstraint:` , `removeConstraints:`

一般需要把约束添加在superview上, 除了自己的宽高约束等。

`NSLayoutConstraint` 属性除过 `priority` 和 `constant` 其他都是只读的，所以如果你想改变已经存在的约束的其他属性，你必须先remove掉这个约束，然后再添加一个新的。

### 使用代码创建约束 

记得设置 `translatesAutoresizingMaskIntoConstraints` 为 false . 我们并不需要将AutoresizingMask自动转换为约束。这个值默认是 true，需要手动设置为 false 

```swift
v.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(v)
view.addConstraint(
  NSLayoutConstraint(item: v ,
                     attribute: .top ,
                     relatedBy: .equal ,
                     toItem: view ,
                     attribute: .top ,
                     multiplier: 1,
                     constant: 20)
)
view.addConstraint(
  NSLayoutConstraint(item: v ,
                     attribute: .left ,
                     relatedBy: .equal ,
                     toItem: view ,
                     attribute: .left ,
                     multiplier: 1,
                     constant: 20)
)
v.addConstraint(
  NSLayoutConstraint(item: v ,
                     attribute: .width ,
                     relatedBy: .equal ,
                     toItem: nil ,
                     attribute: .notAnAttribute ,
                     multiplier: 1,
                     constant: 100)
)
v.addConstraint(
  NSLayoutConstraint(item: v ,
                     attribute: .height ,
                     relatedBy: .equal ,
                     toItem: nil ,
                     attribute: .notAnAttribute ,
                     multiplier: 1,
                     constant: 100)
)
```

这里其实只是想设置 

```swift
v.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
```

但是用代码写约束居然写了那么多代码...

这只是其中的一种方式，当然还有更多其他的方式。 

### Anchor 符号

iOS9开始我们可以使用一些简短紧凑的语法来描述 `AutoLayout`  , 我们把关注点从约束转移到了描述约束关系的属性。

以下列出view的一些属性：

- `topAnchor`, `bottomAnchor`
- `leftAnchor`, `rightAnchor`, `leadingAnchor`, `trailingAnchor`
- `centerXAnchor`, `centerYAnchor`
- `firstBaselineAnchor`, `lastBaselineAnchor`

这些属性都是 `NSLayoutAnchor` 的对象（或者它的子类）.

处理relation的一些方法：

- `constraintEqualToConstant:`
- `constraintGreaterThanOrEqualToConstant:`
- `constraintLessThanOrEqualToConstant:`
- `constraintEqualToAnchor:`
- `constraintGreaterThanOrEqualToAnchor:`
- `constraintLessThanOrEqualToAnchor:`
- `constraintEqualToAnchor:constant:`
- `constraintGreaterThanOrEqualToAnchor:constant:`
- `constraintLessThanOrEqualToAnchor:constant:`
- `constraintEqualToAnchor:multiplier:`
- `constraintGreaterThanOrEqualToAnchor:multiplier:`
- `constraintLessThanOrEqualToAnchor:multiplier:`
- `constraintEqualToAnchor:multiplier:constant:`
- `constraintGreaterThanOrEqualToAnchor:multiplier:constant:`
- `constraintLessThanOrEqualToAnchor:multiplier:constant:`

有了这些，约束变得简短起来。 

```swift
NSLayoutConstraint.activate([
        v.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10) ,
        v.topAnchor.constraint(equalTo: view.topAnchor, constant: 10) ,
        v.widthAnchor.constraint(equalToConstant: 100) ,
        v.heightAnchor.constraint(equalToConstant: 100)
      ])
```

有点类似 `SnapKit` 了，但是还是没有 `SnapKit` 简洁并且可以多个属性链式设置

为了让语法更简洁，于是有了 Visual format 

###  Visual format

来看一个表达式： 

```swift
"V:|[v2(10)]"
```

- V: vertical(垂直)方向的尺寸。H:水平方向
- | 在这里表示它的superview ， 这里表示v2的顶部贴着它superview的顶部。小括号中的10表示v2的高度是10.

我们需要提前指定那个字符串代表那个view

所以我们约束表达式也可以这么写：

```swift
let d = ["v0":v]
NSLayoutConstraint.activate([
  NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(100)]", options: [], metrics: nil, views: d),
  NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0(100)]", options: [], metrics: nil, views: d),
  ])
```

下面看下更多关于这个语法的东西：
- `metrics` 参数是一个放numeric值的字典，允许你用name解释一个numeric数值
- `options:` 是一个NSLayoutFormatOptions类型的值，主要做alignments。
- 指定两个view之间的距离可以用这种语法"[v1]-20-[v2]"
- 括号中的值也可以指定符号"[v1(>=20@400,<=30)]"

等多语法的只是可以在Apple’s Auto Layout Guide 的 “Visual Format Syntax” 章节学习

### Constraints as objects

有时候界面需要变换，比如一个view移动到另一个地方，一个view移除，或者新增一个view，这时候我们需要事先把布局保存起来。

首先创建两个数组保存约束,并声明三个全局变量

```swift
var constraintsWith = [NSLayoutConstraint]()
var constraintsWithout = [NSLayoutConstraint]()
var v1: UIView!
var v2: UIView!
var v3: UIView!
```

我们首先展示的是v1\v2\v3三个view纵向排列。然后移除v2将v3的位置移动到v2。 也可以还原。

```swift
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

```
这段代码很明显，先设置了c1、c2、c3、c4 设置了他们的水平宽度和距离superview左边的20 。

c5with 是有v2的情况
c5without是没有v2的情况

然后搞一个按钮在点击的时候进行切换：

```swift
if self.v2.superview != nil {
  self.v2.removeFromSuperview()
  NSLayoutConstraint.deactivate(self.constraintsWith)
  NSLayoutConstraint.activate(self.constraintsWithout)
} else {
  mainview.addSubview(v2)
  NSLayoutConstraint.deactivate(self.constraintsWithout)
  NSLayoutConstraint.activate(self.constraintsWith)
}
```

### Guides and margins 引导边距

设想一下，一个viewController的view紧挨着top和bottom，而界面的top和bottom经常会被一些bar挡住（status bar \ navigation bar \ tab bar \ toolbar）. 我们如果依赖mainview布局，这些subviews将很有可能被这些bar挡住。iOS 7以后 main view 可以延伸到window的边界。此外，这些bar可以动态的显示和隐藏。而且有可能改变高度。iOS 8上 app在横屏下statusbar默认是隐藏的。


为了解决这个问题，UIViewController提供了两个不可见的view在AutoLayout中使用起来很方便，`topLayoutGuide`和 `bottomLayoutGuide` , `topLayoutGuide` 匹配最顶部的bar，`bottomLayoutGuide`匹配最底部的bar。这两个view会随环境的改变而改变。

但是这两个guide在 iOS 11中被废弃了，使用 safeArea 替换，因为多了iPhone X 需要有上下左右间距，所有有了安全区域的概念（暂时不在本节讨论范围）

我们在visual format语法中也能用

```swift
let arr = NSLayoutConstraint.constraints(withVisualFormat:
      "V:[tlg]-0-[v]", options: [], metrics: nil,
      views: ["tlg":self.topLayoutGuide, "v":v])
```
在iOS 9中也可以这样:

```
let tlg = self.topLayoutGuide
let c = v.topAnchor.constraint(equalTo: tlg.bottomAnchor)
```

一个view的margin可以用以下方式表示：

- .topMargin, .bottomMargin
- .leftMargin, .rightMargin, .leadingMargin, .trailingMargin
- .centerXWithinMargins, .centerYWithinMargins

因此，我们还可以这样创建一个约束

```swift
let c = NSLayoutConstraint(item: v,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .leftMargin,
                               multiplier: 1,
                               constant: 0)
```

或者 这样

```swift
let c = v1.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor)
```







































