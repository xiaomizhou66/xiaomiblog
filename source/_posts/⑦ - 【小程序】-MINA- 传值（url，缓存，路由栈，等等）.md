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

# 二、url 传值

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
  onLoad(option) {
    //console.log(option.query) 这个 query 只的是参数名，就是穿过来的  alphaBeta，alphabeta，id，
    // 直接 console.log(option.query) 肯定是 undefined 的呀！！！！！！！！！！！！！！！！！
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
    3. JSON.parse 解析不了特殊的字符，例如 ？ /n  % 、 & 之类的字符，因此传递字符串的时候回遇到各种错误
        特殊的字符需要编码
        模拟机上，编码之后解析没有问题了，
        但是在真机上，编码后的字符还是无法解析的
    4. 不能对整个对象使用 encodeURIComponent ，它只能使用在 url 字符串上面。虽然说 encodeURIComponent 方法 参数是包含 url 的参数，
        但是根据上面的使用也发现了，直接对整个对象是无效的，只能对 url 去使用。

## 2.3 传递数组

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

# 四、路由栈 API 获取其他页面的方法

调用小程序提供的 API 接口 getCurrentPages()

```JS
var pages = getCurrentPages() // 获取当前页面路由栈的信息
var currentPage = pages[pages.length - 1] // 当前页面
var prevPage = pages[pages.length - 2] // 上一个页面

// 调用 前一个页面/上一个页面的 setData 将数据存在它的 myData 数据中
// 根据自己需求
prevPage.setData({
  myData:{
    a:1,b:2
  }
})
```

优点：
    比起全局数据存值的方法，这个方法逻辑上要清晰一些，也不存在对数据销毁有额外的管理工作。
缺点：
    ？？？？？可以调用下一个页面的 setData 存值么？不可以的话那就是说这个传值方法只能在返回页面的时候可以使用咯？？？
    对路由栈的了解，有的方法的路由并不会推入到路由栈中。！！！！！！！！！！！！！
适用场合：
    之前访问过的页面

# 五、缓存传值（区别于 web 页面的缓存传值）

小程序的缓存传值有自己的方法。