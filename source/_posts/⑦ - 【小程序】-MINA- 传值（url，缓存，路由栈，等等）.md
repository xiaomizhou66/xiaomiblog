---
title: MINA 框架 传值
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - MINA 框架
updated:
tags:
comments:
---

# 一、前言

官网路由文档[地址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/route.html)

# 二、url 传值（正向传值）

- 用 navigator 标签（貌似有 bug ，还是算了吧！！）
- wx.navigator 接口 （写在 JS 错了还能去调试，也可以传递更多的数据类型）

## 2.1 传字符串(事件 + onload 周期的配合)

传递字符串是最简单的方法

> A 页面

html 中使用 data-xxx 传参

```HTML
<block wx:for="{{rowData}}" wx:key="index" wx:for-item="item">
  <view data-alpha-beta="1" data-alphaBeta="2" data-id="{{item.id}}" bindtap="bindViewTap">
    DataSet Test
  </view>
<block>
```

```JS
Page({
  data: {
    rowData:{
      [
        {
          id:'dddd'
        }
      ]
    }
  },
  bindViewTap(e) {
    e.currentTarget.dataset={
      alphaBeta:1,
      alphabeta:2,
      id:'ddd'
    }
    e.currentTarget.dataset.alphaBeta === 1 // - 会转为驼峰写法
    e.currentTarget.dataset.alphabeta === 2 // 大写会转为小写
    wx.navigateTo({
      url: 'test?id=1'// test 是  test 的路径，例如需要跳转到 "pages/products/products" 页面
      //    url:"../products/products?id=1" ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！注意路径是这样写的
      //    路径没有写正确就会找不到页面了，其实就是 A 文件相对 B 文件的路径啊！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
      //    跳转不了的，
      //    1. 看 url 写对了没有，
      //    2. 看 app.json 中定义了没有
      //    3. 看 tabbar 是不是已经定义了？ wx.navigateTo 方法用对了没有
    })
  }
})
```

> B 页面

```JS
// test.js
Page({
  data:{
    id:''
  },
  onLoad(options) {
    //console.log(options.query) 这个 query 只的是参数名，就是穿过来的  alphaBeta，alphabeta，id，
    // 直接 console.log(options.query) 肯定是 undefined 的呀！！！！！！！！！！！！！！！！！
    this.setData({
      id: options.id
    })
  }
})
```

## 2.2 传对象 ！！！！！！！！！！！！！！！！！大坑！！！！！！！！！！！！！！！！！！！

```JS
// pageA.js
  data:{
    productData: {
      createdAt: 0,
      description: '',
      habitat: '',
      id: '',
      images: [{
          fileName: '',
          id: '',
          key: '',
          url: ''
      }],
      name: '',
      price: 0,
      quantity: 0,
      shelf: true,
      sold: 0,
      spec: {
          height: 0,
          length: 0,
          weight: 0,
          width: 0
      },
      updateAt: 0
    }
  },
  buy() {
    let productStr = JSON.stringify(this.data.productData)
    wx.navigateTo({
      url: `../buy/buy?productStr=${productStr}`
    })
  }
```

```JS
// PageB.js
  data:{
    product:{}
  },
  onLoad: function (options) {
    let productObj = JSON.parse(options.productStr)
    this.setData({
      product: productObj
    })
  }
```

```BASH
# 直接按照上面的方法传值，就会发现有错误了，各种各样的错误
thirdScriptError
Unexpected end of JSON input;at "pages/buy/buy" page lifeCycleMethod onLoad function
SyntaxError: Unexpected end of JSON input


Unexpected token % in JSON at position 0;at "pages/buy/buy" page lifeCycleMethod onLoad function
SyntaxError: Unexpected token % in JSON at position 0

# 原因如下：
# 1. 看下 pages.json 文件，是不是有文件是空的？即使没有配置信息也不能让小程序的 json 文件为空
#    至少要有一堆花括号，所以就是在增加页面的时候要注意了，最直接的增加页面的方法是在 app.json 添加，
#    快速添加页面，增加速度，也避免错误。
# 2. json 文件是不是有注释了？json 文件不允许有注释
# 3. 传值的对象里面有特殊的字符，url 带参数，如果是对象，并且对象里面有特殊的字符，这些字符 JSON.parse
#    解析不了的，就会发生错误了
```

```JS
//发现上面的错误，之后，对整个对象先使用 encodeURIComponent 解析，发现也是错误的。
// A 页面
 buy() {
    let productStr = encodeURIComponent(JSON.stringify(this.data.productData))
    wx.navigateTo({
      url: `../buy/buy?productStr=${productStr}`
    })
  }

// B 页面
 onLoad: function (options) {
    let productCodeObj = JSON.parse(options.productStr)
    let productObj = decodeURIComponent(productCodeObj)
    this.setData({
      product: productObj
    })
  },
```

最终这里才是正确的！！！！！！！！！！！！！！！！！！！！！！！！！！！

```JS
// 正确的写法

// A 页面，
// 先使用  encodeURIComponent 方法对 url 进行编码 （encodeURIComponent 对 JS 字符串操作）
// 再使用 JSON.stringify 将 js 对象转化为 JSON 字符串 （JSON.stringify 对 JS 对象操作）
  buy() {
    let productData = this.data.productData
    productData.images = productData.images.map((v)=>{
      // 因为我们这里是数组，所以要遍历，处理所有的 url
      v.url = encodeURIComponent(v.url)// 编码 url
      return v
    })
    let productStr = JSON.stringify(productData)
    wx.navigateTo({
      url: `../buy/buy?productStr=${productStr}`
    })
  }

// B 页面
// 先使用  JSON.parse 将 js 对象转化为 JSON 字符串 （JSON.parse          对 JSON 字符串操作）
// 再使用  decodeURIComponent 方法对 url 进行解码 （decodeURIComponent 是对 JS 字符串操作的）
onLoad: function (options) {
    let productObj = JSON.parse(options.productStr)
    productObj.images = productObj.images.map(v => {
      v.url = decodeURIComponent(v.url)// 解码 url
      return v
    })
    this.setData({
      product: productObj
    })
  },

```

缺点：
    1. url 传值要化为 JSON 字符串才能传值，不直传递对象
    2. JSON.stringify 不转义字符，它只返回字符串表示，当你在 url 中使用它时，你需要使用它来转义它 encodeURIComponent
    3. JSON.parse 解析不了特殊的字符，例如 ？ /n  % 、 & 之类的字符，因此传递字符串的时候回遇到各种错误,dddd特殊的字符需要编码
    4. 不能对整个对象使用 encodeURIComponent ，它只能使用在 url 字符串上面。虽然说 encodeURIComponent 方法 参数是包含 url 的参数，
        但是根据上面的使用也发现了，直接对整个对象是无效的，只能对 url 去使用。

知识点学习
[JSON.parse 知识](https://blog.csdn.net/u011277123/article/details/53055479)
[encodeURIComponent 与 encodeURI 的区别](https://www.html.cn/archives/6954)
[encodeURIComponent 方法使用](http://www.w3school.com.cn/js/jsref_encodeURIComponent.asp)

## 2.3 传递数组

在 JS 中数组也是一种对象，传递的方法跟上面的对象是一样的，也需要注意看看传递的数组中的项是不是存在 url。需要编码的特殊字符串。

# 三、 app.js 全局数据

将多个页面需要使用到的数据方式在 app.js 中，globalData 对象，也就是全局数据。
page.js 中 const app = getApp()就可以使用全局数据了。

缺点：
    由于是全局数据存储，当存入值的时候，需要谨慎的去管理这些全局数据（例如：何时被销毁），不小心的话就会有错误发生。

```JS
// App.js
//app.js
App({
    onLaunch: function () {
     // app.js 的周期函数
    },
    getSession(codeValue) {
     // 全局方法
    },
    globalData: {
      // 全局数据
        userInfo: null
    },
})
```

```JS
// page.js
const app = getApp()

Page({
    data: {
      //
    },
    onLoad(option) {
        // this.setData({
        //     'productData.id': option.id
        // })
        this.getProductData(option.id)
    },

    /**
     * 生命周期函数--监听页面初次渲染完成
     */
    onReady: function () {

    },

    /**
     * 生命周期函数--监听页面显示
     */
    onShow: function () {

    },

    /**
     * 生命周期函数--监听页面隐藏
     */
    onHide: function () {

    },

    /**
     * 生命周期函数--监听页面卸载
     */
    onUnload: function () {

    },

    /**
     * 页面相关事件处理函数--监听用户下拉动作
     */
    onPullDownRefresh: function () {

    },

    /**
     * 页面上拉触底事件的处理函数
     */
    onReachBottom: function () {

    },

    /**
     * 用户点击右上角分享
     */
    onShareAppMessage: function () {
      // 页面周期
    },

    // 获取商品列表
    getProductData(id) {
      // 页面方法
        wx.request({
            url: `https://api.talcoding.com/v1/products/${id}`,
            method: 'GET',
            success: (res) => {
                this.setData({
                    productData: res.data
                })
            }
        })
    },
    tapMove(e) {
        //页面方法，在任何地方都可以去使用 app.js 的全局数据或者是方法
        app.globalData.userInfo //获取全局数据
        app.globalData.getSession(codeValue) //调用全局方法
    }
})
```

# 四、页面栈 API 传值（反向传值）

这个 API 接口不只是可以用来传递数据，还可以调用各个页面的方法。因为我们获取到的是 `实例本身`。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

调用小程序提供的 API 接口 getCurrentPages()

```JS
// B 当前的页面
 data:{
   id:'999'
 },
 toPageA(){
    var pages = getCurrentPages() // 获取当前 路由栈中 全部界面, 然后把数据写入相应界面,
    //                               getCurrentPages() 函数用于获取当前页面栈的实例，以数组形式按栈的顺序给出，第一个元素为首页，最后一个元素为当前页面。
    //var currentPage  = pages[pages.length - 1]  //当前界面
    var prePage = pages[pages.length - 2]         //上一个界面
    var that = this // 一定要用这个，不然的话 this 就错误了，当然了如果传递的是静态就不用 this 就不要用 that 了
    prePage.setData({
     id: that.data.id,
    })
    prevPage.setData({
      myData:{           //调用 前一个页面/上一个页面的 setData 将数据存在它的 myData 数据中
        a:1,b:2
      }
    })
 }

 // 在 A 界面需要接受 B 界面传过来值码如下：
 // 这里要在 onShow 方法里面重新调用你的数据请求或是，为了验证是否传值成功，你可以打印验证
 // 注：由于你从 B 界面返回 A 界面使用了 wx.navigateBack，所以当你回到 A 界面后 onLoad、onReady 方法不响应，onShow 方法响应，
 // onLoad、onReady 后期只是初次渲染的时候使用调用 onShow 是每次显示该页面的时候调用
 // 所以这里你需要特别注意--生命周期 与 路由接口 推入 【页面栈】 与否

// A 前面页面
  //生命周期函数--监听页面显示
  onShow: function () {
    //获取数据
    this.gainData()
    // 打印你的传值，这里是传递过来的值？？？？，是这样使用的么？？？后面再来看看吧，还没有使用!!!!!!!!!!!!!!!!!!!!!????????????????????????????????
    console.log("res==", this.data.res)
  },
```

优点：
    比起全局数据存值的方法，这个方法逻辑上要清晰一些，也不存在对数据销毁有额外的管理工作。
缺点：
    不可以调用下一个页面的 setData 存值么，所以这个是反向传值，只能是带数据回到原来的页面。
    对页面栈的了解
    生命周期要非常的了解，正确的选择。
适用场合：
    之前访问过的页面

知识点：
    1. 页面栈 [官方文档](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/route.html)
    2. getCurrentPages(),函数用于获取当前页面栈的实例，以数组形式按栈的顺序给出，`第一个元素为首页，最后一个元素为当前页面`。
        不要尝试修改页面栈，会导致路由以及页面状态错误。
        不要在 App.onLaunch 的时候调用 getCurrentPages()，此时 page 还没有生成。也没有必要去使用这个！！！！

```BASH
# 页面栈 ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
# 路由方式           页面栈表现

# 初始化          新页面入栈
# 打开新页面      新页面入栈
# 页面重定向      当前页面出栈，新页面入栈
# 页面返回        页面不断出栈，直到目标返回页
# Tab 切换        页面全部出栈，只留下新的 Tab 页面 （这里的 tab 切换，其实是 tabbar 切换的意思！！！！！！！！！！！！官方文档也得让人误解！！！）
# 重加载          页面全部出栈，只留下新的页面
```

```BASH
# 路由方式
# 对于路由的触发方式以及页面生命周期函数如下：
# 路由方式    触发时机                                                                                      路由前页面    路由后页面

# 初始化      小程序打开的第一个页面                                                                                        onLoad, onShow
# 打开新页面  调用 API wx.navigateTo 或使用组件 <navigator open-type="navigateTo"/>                           onHide       onLoad, onShow
# 页面重定向  调用 API wx.redirectTo 或使用组件 <navigator open-type="redirectTo"/>                           onUnload     onLoad, onShow
# 页面返回    调用 API wx.navigateBack 或使用组件<navigator open-type="navigateBack">或用户按左上角返回按钮     onUnload     onShow
# Tab 切换   调用 API wx.switchTab 或使用组件 <navigator open-type="switchTab"/> 或用户切换 Tab                   各种情况请参考下表
# 重启动     调用 API wx.reLaunch 或使用组件 <navigator open-type="reLaunch"/>                                onUnload     onLoad, onShow
```

Tips:

- navigateTo, redirectTo 只能打开非 tabBar 页面。
- switchTab 只能打开 tabBar 页面。
- reLaunch 可以打开任意页面。
- 页面底部的 tabBar 由页面决定，即只要是定义为 tabBar 的页面，底部都有 tabBar。
- 调用页面路由带的参数可以在目标页面的onLoad中获取。

# 五、缓存传值

每个微信小程序都可能用到本地缓存数据（小程序的缓存传值有自己的方法，区别于 web 页面的缓存传值）这里我们可以通过调用微信提供的方法：wx.setStorage、wx.setStorageSync、wx.getStorage、wx.getStorageSync、wx.clearStorage、wx.clearStorageSync、实现对数据本地缓存、获取、清除。

官网文档：[缓存](https://developers.weixin.qq.com/miniprogram/dev/api/wx.setStorageSync.html)，
          [最新文档](https://developers.weixin.qq.com/miniprogram/dev/framework/ability/storage.html)



优点：

缺点：
    1. 本地数据存储的大小限制为 10MB
    2. storage 以用户维度隔离，同一台设备上，A 用户无法读取到 B 用户的数据。
    3. 如果用户储存空间不足，我们会清空最近最久未使用的小程序的本地缓存。我们不建议将关键信息全部存在 storage，以防储存空间不足或用户换设备的情况。