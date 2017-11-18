
### UIImage

`UIImage` 可以从本地读取一个图片文件。将图片资源存在app Bundle，系统支持各种类型的图像。比如：TIFF, JPEG, GIF, and PNG。最好使用PNG，系统对它有做过优化。

当然也可以从其他方式获取一个图像，如downloading一个 图片的 Data , 然后转换为 `UIImage` ，反过来，我们也可以将UIImage的图片存到本地文件 。


#### Image Files 

加载本地bundle的图片资源一般使用UIImage的初始化方法init(named:)。这个方法会从两个地方寻找image 

- *Asset catalog*

在Asset目录按照name去寻找资源，name是区分大小写的 

-  顶层的 app bundle ， 也就是 main bundle

而且需要写扩展名，如果不写，默认PNG

在调用init(named:)的时候，会先从Asset catalog没有找到才会从app bundle搜索。避免相同的image命名

init(named:)在调用的时候会将image的data缓存在内存中，当你再次调用的时候可以立刻从缓存中取出来。此外，你还可以通过init(contentsOfFile:)方法获取image，这个方法并不会缓存。这个方法需要一个路径参数

你可以通过下面方式获取图片的路径:

```swift
Bundle.main.path(forResource: "name", ofType: "type")
```

由于不同手机的分辨率不同，所以图片的name在retain上对应name@2x在plus 上 name@3x 就会被自动调用。`UIScreen.main.scale`对应的值为1.0、2.0、3.0

同样的如果为 ~ipad 应用跑在ipad上的时候会自动应用。在universal app需要提供。

当然，我们可以指定显示的scale，iPhone还是iPad，横竖屏等。

### UIImageView 

一个UIImageView实际上有两个image，一个image属性一个highlightedImage属性。 `highlightedImage` 一般很少用到，因为 `UIImageView` 并不会像 `UIButton` 那样，tap的时候会有 highlight 状态的变化 。 但是 UIImageView 在 tableview 的cell 被选中时候 会有 highlight 状态。 这个亲测是对的，大家可以自己试试。把 ImageView放在cell中设置不同的 image 和 highlightedImage 点击的时候回看到不同的image 

`UIImageView` 继承自 `UIView` 所以它拥有 UIView 的所有特性 。一个图像可以有透明的区域。 UIImageView 会respect this。

`UIImageView` 怎样绘制 image取决于 `contentMode` 属性 。这个属性是继承自 `UIView` 的。`.scaleToFill ` 意味着image长宽会拉伸为view的长宽。其他属性可以自行测试。 一般会使用 .aspectFill 或者 .aspectFit 保证图片不被压缩。`.aspectFill` 一般会配合 `clipsToBounds` 把超出的部分切掉。默认的`contentMode` 是 `.scaleToFill` 。


### Resizable Images( 调整大小 )

很多情况下，我们都需要对图像进行拉伸 。比如slider的 track , 或者一个 progress view 。或者一个聊天的气泡 。还有一些其他情况 

resize一个image 一般调用 `resizableImageWithCapInsets:resizingMode: ` 方法 ， `capInsets:` 是一个 `UIEdgeInsets` 表示图象向内部的距离。resize image分两种模式 

- .tile
    平铺: 变化的区域的内部图片是平铺（重复）;每一条边是由非变化区域的相应边缘矩形组成的。相对于变化区域的四个角落的绘制不变。
- .stretch 
    拉伸: 变化区域的内部被拉伸一次以填充;每一条边是由非变化区域的相应边缘矩形组成的。相对于变化区域的四个角落的绘制不变。
    
    [programming iOS - view drawing (一)](http://www.jianshu.com/p/e4e179cea022)
    [programming ios - view drawing(二)](http://www.jianshu.com/p/fe0b03063ac2)
    http://www.jianshu.com/p/a577023677c1


一个常见的延伸策略是让几乎一半的原始图像作为capinset，只留下中心的一两个像素来填充空白区域：


```swift
let marsTiled = mars.resizableImageWithCapInsets(
    UIEdgeInsetsMake(
        mars.size.height / 2.0 - 1, 
        mars.size.width / 2.0 - 1, 
        mars.size.height / 2.0 -1, 
        mars.size.width / 2.0 - 1
    ), resizingMode: .Stretch)
```



































