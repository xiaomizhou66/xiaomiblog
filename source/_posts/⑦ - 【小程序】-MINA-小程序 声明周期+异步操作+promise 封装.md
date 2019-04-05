## 生命周期 + 异步操作 + promise 封装

### 生命周期

打开小程序 :
app.onLaunch -> app.onShow -> Page.onLoad -> Page.onShow -> Page.onReady
进入下一个页面:
Page.onHide -> Next.onLoad -> Next.onShow -> Next.onReady
返回上一个页面:
Next.onUnload -> Page.onShow
离开小程序:
app.onHide
再次进入:
app 未销毁 -> app.onShow 否则从头开始（销毁判断看上文运行机制）

注意：Tabbar 页面初始化之后不会被销毁，也就是只会执行一次 onLoad 函数

只触发一次的，一般都是用来初始化操作

- onLaunch：`初始化全局数据，注意异步问题`
- onLoad：`初始化页面数据`
- onReady：代表页面已经准备妥当，界面内容的修改，最好放在这里，如 wx.setNavigationBarTitle
- onUnload：清除定时器，因为所有页面的脚本逻辑都跑在同一个 JsCore 线程

触发多次的，一般用来改变状态

onShow：刷新
onHide：重置

### 线程

Page 实例由两大线程组成

负责界面的线程（view thread）和服务线程（appservice thread），各司其职又互相配合

界面线程有四大状态：

初始化状态：
初始化界面线程所需要的工作，包括工作机制，基本和我们开发者没有关系，等初始化完毕就向 “服务线程”发送初始化完毕信号，然后进入等待传回初始化数据状态
首次渲染状态：
收到“服务线程”发来的初始化数据后（就是 json 和 js 中的 data 数据），就开始渲染小程序界面，渲染完毕后，发送“首次渲染完毕信号”给服务线程，并将页面展示给用户
持续渲染状态：
此时界面线程继续一直等待“服务线程”通过 this.setdata（）函数发送来的界面数据，只要收到就重新局部渲染，也因此只要更新数据并发送信号，界面就自动更新
结束状态：

服务线程五大状态：

初始化状态：
无需和其他模块交流，跟小程序开发也没多大关联，此阶段就是启动服务线程所需的基本功能，比如信号发送模块。系统的初始化工作完毕，就调用自定义的 onload 和 onshow，然后等待界面线程的“界面线程初始化完成”信号。onload 是只会首次渲染的时候执行一次，onshow 是每次界面切换都会执行，简单理解，这就是唯一差别
等待激活状态：
接收到“界面线程初始化完成”信号后，将初始化数据发送给“界面线程”，等待界面线程完成初次渲染
激活状态：
收到界面线程发送来的“首次渲染完成”信号后，就进入激活状态既程序的正常运行状态，并调用自定义的 onReady()函数。此状态下就可以通过 this.setData 函数发送界面数据给界面线程进行局部渲染，更新页面
后台运行状态：
如果界面进入后台，服务线程就进入后台运行状态，从目前的官方解读来说，这个状态挺奇怪的，和激活状态是相同的，也可以通过 setdata 函数更新界面的

## 网路请求 的 异步操作问题

API 接口，一定是在 success 回调里面去操作，在外面操作不会得到执行的，一定要注意！！！！！！
在同一个页面之间的调用，微信的 API 我们可以保证在 success 回调去执行，但是不在同一个页面，我们就不能保证了，这就会出现问题。

小程序的生命周期执行的是 顺序应该是 app.js 的周期，然后是 pages.js 的周期。但是有的时候我们会发现写在 app.js 的代码段却在 page.js 的周期之后才会执行。

因为小程序执行的 `小程序生命周期函数并没有错乱，只是加了 网络请求，异步操作结束的时间我们只不知道的`
有可能 App.js 的 onLaunch 周期开始执行了，已经到了 pages.js 的 onLoad 周期了，并且 onload 周期执行完毕了，但是 App.js 的 onLaunch 周期 还没有结束。 如果 pages.js 的 onLoad 使用到 App.js 的 onLaunch 周期 的结果值，那么就会发生错误。

小程序初始化时触发 App 里的 onLaunch，后面再执行页面 Page 里的 onLoad，但是在 onLaunch 里请求获取是否有权限，等待返回值的时候 Page 里的 onLoad 事件就已经执行了。

## 错误实例

```JS
//APP.JS
App({
  onLaunch: function () {
    // 展示本地存储能力
    var logs = wx.getStorageSync('logs') || []
    logs.unshift(Date.now())
    wx.setStorageSync('logs', logs)
    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
        wx.request({
          url: 'xxxxxx',
          method: 'POST',
          data: {
            code: res.code,
          },
          success: (res) => {
            wx.setStorage({
              key: 'session',
              data: res.data,
            })
          }
        })
      }
    })
    this.getUserInfo()
  },
  getUserInfo() {
    var that = this
    wx.getStorage({
      key: "session",
      success: (res) => {
        let token = res.data.token
        wx.request({
          url: `xxxxxx`,
          method: 'GET',
          header: {
            Authorization: `Code ${token}`
          },
          success: (res) => {
            that.globalData.isSync = res.data.isSync
            let userInfo = {
              nickName: res.data.nickName,
              avatarUrl: res.data.avatarUrl
            }
            that.globalData.userInfo = userInfo
            console.log(that.globalData.isSync,'that.globalData.isSync--app--onLaunch')
          }
        })
      }
    })
  },
  // 用户授权
  authorize(data) {
    wx.getStorage({
      key: "session",
      success: (res) => {
        let token = res.data.token
        wx.request({
          url: `xxxxxx`,
          method: 'PUT',
          header: {
            Authorization: `Code ${token}`
          },
          data: data,
          success: (res) => {
            let userInfo = {
              nickName: res.data.nickName,
              avatarUrl: res.data.avatarUrl
            }
            this.globalData.isSync = res.data.isSync
            this.globalData.userInfo = userInfo
            console.log(that.globalData.isSync,'that.globalData.isSync--app--全局函数')
          }
        })
      }
    })
  },
  globalData: {
    isSync: false,
    userInfo: {}
  }
})
```

```JS
//index.js
import utils from '../../utils/utils.js'
const app = getApp()

Page({
  data: {
    isAuthorizeModal: false,
    isNotAuthorizeModal: false
  },
  onLoad: function () {
    this.loadData();
    console.log(app.globalData.isSync,'app.globalData.isSync----index--onload')
    if (app.globalData.isSync == false) {
      wx.hideTabBar({})
      this.setData({
        isAuthorizeModal: true
      })
    }
  },
  // 用户授权：弹出获取用户授权信息 弹窗
  onGotUserInfo(e) {
    // 先判断点击的是 授权 还是 拒绝授权，
    if (e.detail.userInfo) {
      let data = {
        encryptedData: e.detail.encryptedData,
        iv: e.detail.iv
      }
      app.authorize(data) //调用 app 的授权方法
      this.setData({
        isAuthorizeModal: false
      })
    }
    wx.showTabBar({})
  },
  // 暂不授权
  notAuthorize() {
    wx.showTabBar({})
    this.setData({
      'isAuthorizeModal': false
    })
  },
  // 获取商品列表
  loadData() {
    let page = this.data.productData.page;
    let size = this.data.productData.size;
    wx.request({
      url: `xxxxxxxxxxxxxxxxxxxxx`,
      method: 'GET',
      success: (res) => {
        let productData = res.data
        productData.products = productData.products.map(v => {
          v.price = utils.formatPrice(v.price)
          return v
        })
        this.setData({
          productData: productData
        })
      }
    })
  }
})
```

```JS
//执行结果如下
console.log(app.globalData.isSync,'app.globalData.isSync----index--onload')// false
console.log(that.globalData.isSync,'that.globalData.isSync--app--onLaunch')//true
```

上面的代码中我们希望在 index.js 中的 onload 周期使用全局数据 app.globalData.isSync 。但是 onload 却不能正确的获取 app.globalData.isSync 的值。这个就是异步请求操作导致 onload 周期中的代码先执行完了 onLaunch 才执行完。

## 解决办法：回调函数

回调函数：这个是最好理解的，但是操作比较麻烦，
promise：新把的小程序已经支持 ES6 的语法。

### 回调函数

https://blog.csdn.net/rolan1993/article/details/80362029

```JS
//APP.JS
App({
  onLaunch: function () {
    // 展示本地存储能力
    var logs = wx.getStorageSync('logs') || []
    logs.unshift(Date.now())
    wx.setStorageSync('logs', logs)
    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
        wx.request({
          url: 'xxxxxx',
          method: 'POST',
          data: {
            code: res.code,
          },
          success: (res) => {
            wx.setStorage({
              key: 'session',
              data: res.data,
              success:()=>{
                this.getUserInfo()
              }
            })
          }
        })
      }
    })
  },
  getUserInfo() {
    var that = this
    wx.getStorage({
      key: "session",
      success: (res) => {
        let token = res.data.token
        wx.request({
          url: `xxxxxx`,
          method: 'GET',
          header: {
            Authorization: `Code ${token}`
          },
          success: (res) => {
            that.globalData.isSync = res.data.isSync
            let userInfo = {
              nickName: res.data.nickName,
              avatarUrl: res.data.avatarUrl
            }
            that.globalData.userInfo = userInfo
            console.log(that.globalData.isSync,'that.globalData.isSync--app--onLaunch')
            //---------------------------------------------------------------------------
            //在这里调用使用回调函数，确保有值给到 pages.js
            if(this.getUserInfoReadyCallBack){
              this.getUserInfoReadyCallBack(res)
            }
            //---------------------------------------------------------------------------
          }
        })
      }
    })
  },
  // 用户授权
  authorize(data) {
    wx.getStorage({
      key: "session",
      success: (res) => {
        let token = res.data.token
        wx.request({
          url: `xxxxxx`,
          method: 'PUT',
          header: {
            Authorization: `Code ${token}`
          },
          data: data,
          success: (res) => {
            let userInfo = {
              nickName: res.data.nickName,
              avatarUrl: res.data.avatarUrl
            }
            this.globalData.isSync = res.data.isSync
            this.globalData.userInfo = userInfo
            console.log(that.globalData.isSync,'that.globalData.isSync--app--全局函数')
          }
        })
      }
    })
  },
  globalData: {
    isSync: false,
    userInfo: {}
  }
})
```

```JS
//index.js
import utils from '../../utils/utils.js'
const app = getApp()

Page({
  data: {
    isAuthorizeModal: false,
    isNotAuthorizeModal: false
  },
  onLoad: function () {
    this.loadData();
    //------------------------------------------------------------------------------------
    // 由于 app.js 的 getUserInfo() 是网络请求，可能会 比 app.js 的 onLaunch 先执行
    // 这里使用回调避免这个问题(等在 onLaunch 的网络请求结束有 res 结果之后)
    app.userInfoReadyCallback = res => {
      console.log(app.globalData.isSync, 'app.globalData.isSync----index--onload')
      // 这里的 isSync 都可以使用 res 的数据了，app.globalData.isSync 也可以。
      if (res.isSync == false) {
        wx.hideTabBar({})
        this.setData({
          isAuthorizeModal: true // 第一次加载的时候
        })
      }
    }
    //------------------------------------------------------------------------------------
  },
  // 用户授权：弹出获取用户授权信息 弹窗
  onGotUserInfo(e) {
    // 先判断点击的是 授权 还是 拒绝授权，
    if (e.detail.userInfo) {
      let data = {
        encryptedData: e.detail.encryptedData,
        iv: e.detail.iv
      }
      app.authorize(data) //调用 app 的授权方法，
      //-----------------------------------------------------------------
      this.setData({
        isAuthorizeModal: false
      })
      //--------------------------------------------------------------------
    }
    wx.showTabBar({})
  },
  // 暂不授权
  notAuthorize() {
    wx.showTabBar({})
    this.setData({
      'isAuthorizeModal': false
    })
  },
  // 获取商品列表
  loadData() {
    let page = this.data.productData.page;
    let size = this.data.productData.size;
    wx.request({
      url: `xxxxxxxxxxxxxxxxxxxxx`,
      method: 'GET',
      success: (res) => {
        let productData = res.data
        productData.products = productData.products.map(v => {
          v.price = utils.formatPrice(v.price)
          return v
        })
        this.setData({
          productData: productData
        })
      }
    })
  }
})
```

```JS
//my.js
  // 获取用户授权
  onGotUserInfo(e) {
    if (e.detail.userInfo) {
      let data = {
        encryptedData: e.detail.encryptedData,
        iv: e.detail.iv
      }
      app.authorize(data)//调用 app 全局方法
      //------------------使用回调，才能获取到一个正确的 全局值
      app.authorizeReadyCallback = () => {
        this.setData({
          isAuthorized: app.globalData.isSync,
          userInfo: app.globalData.userInfo
        })
      }
    }
  },
```

解析：

```JS
//APP.JS
// 网络请求
success:(res)=>{
  //这里是去调用 index.js 中 onload 周期的回调函数
  if (this.userInfoReadyCallback) {
    this.userInfoReadyCallback(res)
  }
}

//index.js
onLoad: function () {
    this.loadData();
    // 由于 app.js 的 getUserInfo() 是网络请求，可能会 比 app.js 的 onLaunch 先执行
    // 这里使用回调避免这个问题(等在 onLaunch 的网络请求结束有 res 结果之后)

    //--------在这里定义了回调函数
    app.userInfoReadyCallback = () => {
      console.log(app.globalData.isSync, 'app.globalData.isSync----index--onload')
      // 这里的 isSync 都可以使用 res.data.isSync 的数据，app.globalData.isSync 也可以。
      if (app.globalData.isSync == false) {
        console.log('666666666666666')
        wx.hideTabBar({})
        this.setData({
          isAuthorizeModal: true // 第一次加载的时候
        })
      }
    }
    // 第一次加载的时候执行这个周期，后面就不会执行这个周期了（一个页面只会调用一次）
  },
```

```JS
//在每个请求接口中，不只是我们自己的服务端的网络请求，微信的 API 接口都是写了 success 或者是 fail 还有 complete 回调函数的，
//后续的操作都是需要卸载回调函数里面的。不在回调函数里面操作，就不会得到正确的执行。

// 上面在 page.js 页面调用 app.js 的全局数据，或者方法就知道了，我们获取全局的数据，需要在全局方法修改全局数据 完成之后获取才是对的
// 这就要求我们使用回调，以达到这个效果。

    wx.login({
      success: res => {
        // 这里是在  wx.login 的 success 回调函数里面执行
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
        wx.request({
          url: 'xxxxxx',
          method: 'POST',
          data: {
            code: res.code,
          },
          success: (res) => {
            // 这里是在  wx.request 的 success 回调函数里面执行
            wx.setStorage({
              key: 'session',
              data: res.data,
              success:()=>{
                // 这里是在  wx.setStorage 的 success 回调函数里面执行
                this.getUserInfo()
              }
            })
          }
        })
      }
    })
```

## promise 封装 API 接口

回调函数用起来感觉挺方便的，但是后期的维护是需要成本的，一堆的回调函数是很让人扼头疼的。 ES6 的 promise 就给我们用各种办法解决了，其中 promise 就是一个解决办法。

### 小程序快速搭建的示例

```JS
// utils.js 工具集

const Promise = require('./Promise')

//ES5 function formatPrice(price){}
//ES6
let formatPrice = (price) => {
  price = (price / 100).toFixed(2)
  return price
}

module.exports = {
  formatPrice: formatPrice
}

// pages.js 调用 utils 方法
// import utils from  '../../utils/utils.js'
// utis.formatPrice(price)
```

```JS
//APP.js
// 这厘是 mina 框架快速创建的原例子（使用 promise 修改）
App({
  onLaunch: function () {
    // 展示本地存储能力
    var logs = wx.getStorageSync('logs') || []
    logs.unshift(Date.now())
    wx.setStorageSync('logs', logs)

    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
        //  ??????   openId 不是在这里获取的把？？？？
        // 应该是 wx.getUserInfo 里面有  openId sessionKey unionId
      }
    })
    // 获取用户信息
    wx.getSetting({
      success: res => {
        if (res.authSetting['scope.userInfo']) {

          // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
          wx.getUserInfo({
            success: res => {
              // 可以将 res 发送给后台解码出 unionId
              this.globalData.userInfo = res.userInfo

              // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回（官网提供的使用全局）
              // 所以此处加入 callback 以防止这种情况
              if (this.userInfoReadyCallback) {
                this.userInfoReadyCallback(res)
              }
            }
          })
        }
      }
    })
  },
  //获取系统信息
  getSystemInfo() {
      return new utils.Promise((resolve, reject) => {
        var that = this
        if (that.globalData.systemInfo) {
          resolve(that.globalData.systemInfo)
        } else {
          wx.getSystemInfo({
              success: function(res) {
                  resolve(that.globalData.systemInfo = res);
              }
          })
        }
      })
  },
  globalData: {
    userInfo: {},
    systemInfo: {}
  }
})
```

```JS
//index.js
import utils from '../../utils/utils.js'
const app = getApp()//获取应用实例

Page({
  data: {
    motto: 'Hello World',
    userInfo: {},
    hasUserInfo: false,
    canIUse: wx.canIUse('button.open-type.getUserInfo')
  },
  //事件处理函数
  bindViewTap: function() {
    wx.navigateTo({
      url: '../logs/logs'
    })
  },
  onLoad: function () {
    if (app.globalData.userInfo) {
      this.setData({
        userInfo: app.globalData.userInfo,
        hasUserInfo: true
      })
    } else if (this.data.canIUse){

      // 官方是用的回调函数，解决全局数据的调用问题
      // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
      // 所以此处加入 callback 以防止这种情况
      app.userInfoReadyCallback = res => {
        this.setData({
          userInfo: res.userInfo,
          hasUserInfo: true
        })
      }
    } else {
      // 在没有 open-type=getUserInfo 版本的兼容处理
      wx.getUserInfo({
        success: res => {
          app.globalData.userInfo = res.userInfo
          this.setData({
            userInfo: res.userInfo,
            hasUserInfo: true
          })
        }
      })
    }
  },
  getUserInfo: function(e) {
    console.log(e)
    app.globalData.userInfo = e.detail.userInfo
    this.setData({
      userInfo: e.detail.userInfo,
      hasUserInfo: true
    })
  }
})
```

```JS
function login(params,cbfunc){
  // network request
  console.log("to login")
  var res="66666"
  cbfunc(res)
}


login({username:'zihua',password:'12345'},(res)=>{
  // 执行函数
})
```

### 在小程序中使用 promise

[Promise 化](https://juejin.im/post/5c46e8556fb9a049e7026ff8)

mina 框架怎么使用 yarn ，npm 安装？？？

但是感觉好像没有必要使用吧？？？微信的 API 也是封装了回调的，没有那个必要把？？？？
上面之所以需要自己去写回调，是因为自己