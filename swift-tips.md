### throw 和 rethrow 

throw 表示这个函数本身可能会抛出异常，无论作为参数的闭包是否抛出异常
rethrow 我们有可能给一个函数传入一个会爆出异常的函数闭包。这表示这个函数本身不会抛出异常，但如果作为参数的闭包抛出了异常，那么它会把异常继续抛上去。

例子： 

```swift
func Init<T>( _ object: T, block: (T) throws -> ()) rethrows -> T{
    try block(object)
    return object
}
```


