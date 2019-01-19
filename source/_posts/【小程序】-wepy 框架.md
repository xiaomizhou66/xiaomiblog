---
title: wepy-cli 框架 入门学习
date: '2018/8/18 21:57:28'
categories:
  - 七、小程序
  - wepy 框架
abbrlink: '55118849'
updated:
tags:
comments:
---

## 一、wepy-cli 类 vue-cli 脚手架：组件化开发框架 wepy

WePY 是一款让小程序支持组件化开发的框架，通过预编译的手段让开发者可以选择自己喜欢的开发风格去开发小程序。框架的细节优化，Promise，Async Functions 的引入都是为了能让开发小程序项目变得更加简单，高效。
特性：

类 Vue 开发风格
支持自定义组件开发
支持引入 NPM 包
支持 Promise
支持 ES2015+ 特性，如 Async Functions
支持多种编译器，Less/Sass/Styus、Babel/Typescript、Pug
支持多种插件处理，文件压缩，图片压缩，内容替换等
支持 Sourcemap，ESLint 等
小程序细节优化，如请求列队，事件优化等

[Github地址:](https://github.com/Tencent/wepy)
[官网首页](https://tencent.github.io/wepy/)
[官网使用文档](https://tencent.github.io/wepy/document.html#/)

## 二、wepy 与 vue 的异同

wepy 和 vue 主要区别
1.二者均支持 props、data、computed、components、methods、watch（wepy 中是 watcher）， 但 wepy 中的 methods 仅可用于页面事件绑定，其他自定义方法都要放在外层，而 vue 中所有方法均放在 methods 下

2.wepy 中 props 传递需要加上 .sync 修饰符（类似VUE1.x）才能实现 props 动态更新，并且父组件再 变更传递给子组件 props 后要执行this.$apply() 方法才能更新

3.wepy支持数据双向绑定，子组件在定义props时加上twoway:true属性值即可实现子组件修改父组 件数据

4.VUE2.x推荐使用eventBus方式进行组件通信，而在wepy中是通过broadcast，broadcast，emit，$invoke 三种方法实现通信

## 二、wepy-cli 的安装 与使用

### 2.1 全局安装 wepy-cli

```bash
npm install wepy-cli -g
```

### 2.2 使用 wepy-cli 初始化项目，类似 vue-cli

```BASH
wepy init standard myproject (1.7.0之后的版本)初始化项目   ，还可以使用 wepy list 查看项目模板
cd myproject                  #切换至项目目录
npm  install                  #安装依赖
wepy build --watch  #开启实时编译，微信开发者工具 打开 dist 文件夹，注意把 设置改为 false，如下图
# 两种办法， npm run dev 是简写，是 package.json 中设置的(好像没有设置好，用 npm run dev 没有出来哦)

# 问题：如果是 yarn 怎么做？
```

```BASH
#完成项目之后打包
npm run build #打包项目
```

project.config.json 项目配置文件，与MINA框架的项目配置文件一样的，只是几个值一定要设置为 false，其实在开发者工具中右边就是项目配置项，一个是可视化的，一个是文件的xnia形式，可视化的是这台电脑的开发者工具的设置。文件是这个项目的设置，走到哪里，这个小程序项目的设置都是不会变的。
![t](http://liuxmoo.foryung.com/20180325141533103.png)

### 2.2.1 注意事项

使用微信开发者工具新建项目，本地开发选择dist目录。

- 微信开发者工具-->项目-->关闭ES6转ES5。重要：漏掉此项会运行报错。
- 微信开发者工具-->项目-->关闭上传代码时样式自动补全 重要：某些情况下漏掉此项会也会运行报错。
- 微信开发者工具-->项目-->关闭代码压缩上传 重要：若开启，会导致真机computed, props.sync 等等属性失效。
- 本地项目根目录运行wepy build --watch，开启实时编译。

### 2.3 安装过程中的问题

#### 2.3.1 安装过程中版本支持问题解决

```BASH
λ cnpm install
√ Installed 23 packages
√ Linked 286 latest versions
√ Run 0 scripts
`deprecate eslint@3.19.0 › file-entry-cache@2.0.0 › flat-cache@1.3.4 › circular-json@^0.3.1 CircularJSON is in maintenance only, flatted is its successor.` #deprecate 弃用 flatted 分层
`deprecate wepy-compiler-less@1.3.12 › less@2.7.3 › request@2.81.0 › hawk@3.1.3 › cryptiles@2.x.x This version is no longer maintained. Please upgrade to the latest version.` # 此版本不再维护，请更新最近的版本。
`deprecate wepy-compiler-less@1.3.12 › less@2.7.3 › request@2.81.0 › hawk@3.1.3 › boom@2.x.x This version is no longer maintained. Please upgrade to the latest version.`
`deprecate wepy-compiler-less@1.3.12 › less@2.7.3 › request@2.81.0 › hawk@3.1.3 › hoek@2.x.x This version is no longer maintained. Please upgrade to the latest version.`
Recently updated (since 2018-11-08): 2 packages (detail see file F:\qianduan_dir\00program\wechat-wepy\suduku\node_modules\.recently_updates.t
t)
  Today:
    → eslint@3.19.0 › file-entry-cache@2.0.0 › flat-cache@^1.2.1(1.3.4) (04:42:27)
√ All packages installed (322 packages installed from npm registry, used 17s(network 16s), speed 201.4kB/s, json 309(3.15MB), tarball 85.51kB)
```

解决：npm install wepy-compiler-less@2.0.0 --save

#### 2.3.2 微信开发者工具打开 dist 文件夹是 后台报错

```BASH
VM6906:1 thirdScriptError
 sdk uncaught third Error
 `Cannot read property 'Promise' of undefined`
 `TypeError: Cannot read property 'Promise' of undefined` #Promise   没有定义
    at http://127.0.0.1:61988/appservice/npm/wepy-async-function/index.js:14:7
    at require (http://127.0.0.1:61988/appservice/__dev__/WAService.js:23:12444)
    at http://127.0.0.1:61988/appservice/__dev__/WAService.js:23:12051
    at http://127.0.0.1:61988/appservice/app.js:23:1
    at require (http://127.0.0.1:61988/appservice/__dev__/WAService.js:23:12444)
    at <anonymous>:1:1
    at HTMLScriptElement.scriptLoaded (http://127.0.0.1:61988/appservice/appservice?t=15374
```

这是因为，project.config.json  项目配置文件，与 MINA 框架的项目配置文件一样的，只是几个值一定要设置为 false 。如下是 这个文件的内容

```JSON
// project.config.json 文件 内容
//wepy 框架以为版本不同，生成的文件目录可能不同，
//1.7.0 版本之后的版本会生成的这个文件，
{
  "description": "project description",
  "setting": {
    "urlCheck": true,
    "es6": false,
    "postcss": false,
    "minified": false
  },
  "compileType": "miniprogram",
  "appid": "touristappid",
  "projectname": "Project name",
  "miniprogramRoot": "./dist"
}
```

project.config.json 文件中我们已经用了 false 为什么还会报错呢，是因为在开发者工具中农我们没有设置为 false 。
build 之后，用开发者工具打开 dist 文件内容，build 生成的 project.config.json 可能不正确，里面设置的值为 true 了需要注意修正，否则会报错，错误如下。除了在文件修正之外，在开发者工具可视化项目设置中也可以直接把 ES6 转 ES5。
![1](http://p1teq0wgy.bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180921102512.png)

## 三、WePY demo 项目的目录结构（含自定义）

```bash
├── dist/             # （生成）小程序运行代码目录（该目录由 WePY 的 build 指令自动编译生成，请不要直接修改该目录下的文件）
├── node_modules/     # （生成） 安装的依赖包
├── src/             #  （生成）代码编写的目录（该目录为使用 WePY 后的开发目录）
|   ├── assets/       # （创建） 自定义文件夹
|   |   ├── images   #   （创建）自定义存放图片文件夹
|   |   ├── svgs     #   （创建）自定义存放图片文件夹
|   |   ├──
|   |   └── styles   #  （创建/引用文件）引用的 css 或者 less 等文件
|   |
|   ├── components    # （生成） WePY 组件目录（组件不属于完整页面，仅供完整页面或其他组件引用）
|   |   ├── com_a.wpy #  可复用的 WePY 组件 a
|   |   └── com_b.wpy # 可复用的 WePY 组件 b
|   |
|   ├── mixins        # （生成） Mixin 基类，用于复用不同组件中的相同功能。
|   |   └── test.js
|   |
|   ├──interceptor    # （创建）拦截器:可以使用 WePY 提供的全局拦截器对原生 API 的请求进行拦截。
|   |   └── index.js
|   |
|   ├── pages         # （生成）WePY 页面目录（属于完整页面）
|   |   ├── index.wpy # index 页面（build 后，在 dist 目录下的 pages 目录
|   |   |              #生成 index.js、index.json、index.wxml、index.wxss 文件）
|   |   └── other.wpy # other 页面（build 后，在 dist 目录下的 pages 目录）
|   |                  # 生成 other.js、other.json、other.wxml和other.wxss文件
|   |
|   ├── store      # （生成） Redux 状态管理器，类似 vue 的 vuex。对于构建大型应用，对里面共享数据、状态的管理非常方便
|   |   ├── actions        #（生成）
|   |   |    └──counter.js #（生成）
|   |   |    └──index.js   #（生成）
|   |   |
|   |   ├── reducers       # （生成）reducers 文件件存放我们的纯函数，用来更改我们的状态
|   |   |    └──counter.js # （生成）定义函数
|   |   |    └──index.js   # （生成）暴露函数
|   |   |
|   |   ├── types           # （生成）常量定义：用于定义我们要触发的 action 的名称
|   |   |    └──counter.js  # （生成）定义常量
|   |   |    └──index.js    # （生成）暴露常量
|   |   |
|   |   └──index.js   # （生成）入口文件，主要是 初始化 Redux，其中 promiseMiddleware 是一个中间件，方便后面 action 做异步处理
|   |
|   ├──utils          # （创建）自定义文件夹（工具文件夹）
|   |   ├──util.js
|   |   └──xxxx.js
|   ├──app.wpy              # （生成）小程序配置项（全局数据、样式、声明钩子等；build 后。
|   |                        # 在 dist 目录下生成 app.js、app.json 和 app.wxss 文件）
|   └── index.template.html # 为模块配置文件：其中通过 wepy.app 创建入口文件， wepy.page 创建页面文件
|                            # wepy.component 创建组件文件 （.wpy 就是模块文件）
├──.editorconfig  #  编辑器配置文件
├──.eslintignore  # 格式化 ESLint 忽略的文件
├──.eslintrc.js   # 格式化 ESLint 的格式样式
├──.gitignore     # 上传 github 忽略的文件
├──.prettierrc    # js 代码格式要求
├──.wepycache     # wepy 缓存
├──.wepyignore    # 是指有些文件不希望通过 wepy 编译，因此这个文件属于项目的一部分，不能在 git 中排除
├── package.json         # 项目的 package 配置,项目名称，版本，依赖包，类似 vue-cli 的 package.json
├── project.config.json  # 项目配置文件，与 MINA 框架的项目配置文件一样的，只是几个值一定要设置为 false
└── wepy.config.js       # 配置文件
-----.npmignore
-----LICENSE
-----package-lock.json
-----README.md
-----yarn.lock
```

**简单来说就是**

- assets 存放一些引入的 CSS JS 文件，以及一些图片（如果有需要的话创建这个文件夹）
- ①index.template.html: 页面的入口文件
- ②wepy.config.js: webpack配置文件
- ③project.config.json: 小程序项目配置文件
- ④app.wpy: 小程序入口文件
- ⑤pages: 存放页面（组件）
- ⑥components: 存放公共（组件）
- ⑦sotre: redux(如果你创建项目时使用了redux的话)
- ⑧mixins: 混合组件
- ⑨interceptor：拦截器
- ⑩utils：工具包

### 3.1 index.template.html: 页面的入口文件

### 3.2 wepy.config.js: webpack配置文件

### 3.3 project.config.json: 小程序项目配置文件

### 3.4 app.wpy: 小程序入口文件：小程序入口 app.wpy  对应原生 MINA 框架的 app.json，app.js ，app.wxml，app.wxss

```HTML
<style lang="less">
.container {
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  box-sizing: border-box;
}
</style>

<script>
import wepy from 'wepy'
import 'wepy-async-function'

import { setStore } from 'wepy-redux'
import configStore from './store'

const store = configStore()
setStore(store)

//入口文件 app.wpy 中所声明的小程序实例继承自wepy.app类，
export default class extends wepy.app {
  //config 属性对应原生的 app.json 文件
  // build 编译时会根据 config 属性自动生成 app.json 文件，如果需要修改 config 中的内容，请使用微信提供的相关 API。
  config = {
    //① 页面路径列表
    pages: [
      'pages/index'
    ],
    //② 全局的默认窗口表现
    window: {
      navigationBarBackgroundColor: '#fff',//导航栏背景颜色，如 #000000
      navigationBarTextStyle: 'black'//导航栏标题颜色，仅支持 black / white
      navigationBarTitleText: 'WeChat',//导航栏标题文字内容
      navigationStyle:'default',//导航栏样式，仅支持以下值：default 默认样式 ,custom 自定义导航栏，只保留右上角胶囊按钮
      backgroundColor:'#ffffff'//窗口的背景色
    },
    // ③ 页面底部栏配置
    tabBar: {
      color: '#AEADAD',//tab 上的文字默认颜色
      selectedColor: '#049BFF',//tab 上的文字选中时的颜色
      backgroundColor: '#fff',//tab 的背景色
      borderStyle: 'black',//tabbar上边框的颜色， 仅支持 black / white
      position:'bottom',//tabBar的位置，仅支持 bottom / top
      list: [//最少2个、最多5个 tab
        {
          pagePath: 'pages/index',
          text: '游戏',
          iconPath: '',
          selectedIconPath: ''
        },
        {
          pagePath: 'pages/ranking',
          text: '排名',
          iconPath: '',
          selectedIconPath: ''
        }
      ]
    }
  }

  globalData = {
    userInfo: null
  }

  constructor () {
    super()
    this.use('requestfix')
  }

  onLaunch() {
    this.testAsync()
  }

  sleep (s) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve('promise resolved')
      }, s * 1000)
    })
  }

  async testAsync () {
    const data = await this.sleep(3)
    console.log(data)
  }

  getUserInfo(cb) {
    const that = this
    if (this.globalData.userInfo) {
      return this.globalData.userInfo
    }
    wepy.getUserInfo({
      success (res) {
        that.globalData.userInfo = res.userInfo
        cb && cb(res.userInfo)
      }
    })
  }
}
</script>

</script>
```

### 3.5 pages: 存放页面（组件） 小程序入口 pages.wpy  对应原生 MINA 框架的 pages.json，pages.js ，pages.wxml，pages.wxss

```HTML
<style lang="less">
  /* less */
</style>
<template>
  <view class="container">
    <!-- html -->
  </view>
</template>

<script>
  import wepy from 'wepy'
  import { connect } from 'wepy-redux'
  import Panel from '@/components/panel' // alias example
  import Counter from 'counter' // alias example
  import List from '../components/list' // aliasFields example
  import moduleA from 'module-a' // aliasFields ignore module example
  import Group from '../components/group'
  import Toast from 'wepy-com-toast'
  import testMixin from '../mixins/test'

  console.log('moduleA ignored: ', moduleA) // => moduleA ignored: {}

  @connect({
    num (state) {
      return state.counter.num
    },
    asyncNum (state) {
      return state.counter.asyncNum
    },
    sumNum (state) {
      return state.counter.num + state.counter.asyncNum
    }
  })

  export default class Index extends wepy.page {
    //页面配置对象，对应于原生的 page.json 文件，类似于 app.wpy 中的 config, 页面设置支持支 window 设置
    config = {
      navigationBarBackgroundColor: '#fff', //导航栏背景颜色，如 #000000
      navigationBarTitleText: 'WeChat',//导航栏标题文字内容
      navigationBarTextStyle: 'black',//导航栏标题颜色，仅支持 black / white
      backgroundColor:'#ffffff',//窗口的背景色
      backgroundTextStyle: 'light',//下拉 loading 的样式，仅支持 dark / light
      enablePullDownRefresh:false,//是否全局开启下拉刷新。详见 Page.onPullDownRefresh
      onReachBottomDistance:50,//页面上拉触底事件触发时距页面底部距离，单位为px。详见 Page.onReachBottom
      disableScroll:false//设置为 true 则页面整体不能上下滚动；
      //disableScroll 这项 只在页面配置中有效，无法在 app.json 中设置该项!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    }
    // 页面组件列表对象，声明页面所引入的组件列表
    components = {
      panel: Panel,
      counter1: Counter,
      counter2: Counter,//这个与上面引入的是一样的组件，但是用到不一样的地方显示？问题是一个变了另外一个会不会变啊？
      list: List,
      group: Group,
      toast: Toast
    }

    mixins = [testMixin]

    // 页面渲染数据对象，存放可用于页面模板绑定的渲染数据
    data = {
      mynum: 20,
      userInfo: {
        nickName: '加载中...'
      },
      normalTitle: '原始标题',
      setTimeoutTitle: '标题三秒后会被修改',
      count: 0,
      netrst: '',
      groupList: [...`已略`...]
    }

    computed = {
      now () {
        return +new Date()
      }
    }

    //wxml 事件处理函数对象，存放响应 wxml 中所捕获到的事件的函数，如 bindtap 、 bindchange
    methods = {
      plus () {
        this.mynum++
      },
      toast () {
        let promise = this.$invoke('toast', 'show', {
          title: '自定义标题',
          img: 'https://raw.githubusercontent.com/kiinlam/wetoast/master/images/star.png'
        })

        promise.then((d) => {
          console.log('toast done')
        })
      },
      tap () {
        console.log('do noting from ' + this.$name)
      },
      communicate () {
        console.log(this.$name + ' tap')

        this.$invoke('counter2', 'minus', 45, 6)
        this.$invoke('counter1', 'plus', 45, 6)

        this.$broadcast('index-broadcast', 1, 3, 4)
      },
      request () {
        let self = this
        let i = 10
        let map = ['MA==', 'MQo=', 'Mg==', 'Mw==', 'NA==', 'NQ==', 'Ng==', 'Nw==', 'OA==', 'OQ==']
        while (i--) {
          wepy.request({
            url: 'https://www.madcoder.cn/tests/sleep.php?time=1&t=css&c=' + map[i] + '&i=' + i,
            success: function (d) {
              self.netrst += d.data + '.'
              self.$apply()
                // wepy 中 props 传递需要加上 .sync 修饰符（类似VUE1.x）才能实现 props 动态更新，
              // 并且父组件再 变更传递给子组件 props 后要执行this.$apply() 方法才能更新
            }
          })
        }
      },
      counterEmit (...args) {
        let $event = args[args.length - 1]
        console.log(`${this.$name} receive ${$event.name} from ${$event.source.$name}`)
      }
    }

    // WePY 组件事件处理函数对象，存放响应组件之间通过 $broadcast、$emit、$invoke 所传递的事件的函数
    events = {
      'index-emit': (...args) => {
        let $event = args[args.length - 1]
        console.log(`${this.$name} receive ${$event.name} from ${$event.source.$name}`)
      }
    }

    onLoad() {
      let self = this
      this.$parent.getUserInfo(function (userInfo) {
        if (userInfo) {
          self.userInfo = userInfo
        }
        self.normalTitle = '标题已被修改'

        self.setTimeoutTitle = '标题三秒后会被修改'
        setTimeout(() => {
          self.setTimeoutTitle = '到三秒了'
          self.$apply()
        }, 3000)

        self.$apply()
      })
    }
  }
</script>
```

### 3.6 components: 存放公共（组件） 小程序入口 common.wpy  对应原生 MINA 框架的 pages.js ，pages.wxml，pages.wxss

```bash
├── components    # （生成） WePY 组件目录（组件不属于完整页面，仅供完整页面或其他组件引用）
|   |   ├── com_a.wpy #  可复用的 WePY 组件 a
|   |   └── com_b.wpy # 可复用的 WePY 组件 b
```



```HTML
<style lang="less">
  .counter {
    text-align: left;
    font-size: 12px;
  }
  .count {
    font-size: 18px;
    font-weight: bold;
    &.red {
      color: red;
    }
    &.green {
      color: green;
    }
  }
</style>
<template>
  <view class="counter {{style}}">
    <button @tap="plus" size="mini">  +  </button>
    <button @tap="minus" size="mini">  -  </button>
    <button @tap="incNum" size="mini">  INCREMENT  </button>
    <button @tap="decNum" size="mini">  DECREMENT  </button>
    <button @tap="asyncInc" size="mini">  ASYNC INCREMENT  </button>
    <text class="count"> {{num}} </text>
    <text class="count"> {{stateNum}} </text>
    <text class="count"> {{asyncNum}} </text>
  </view>
</template>
<script>
// 组件文件 com.wpy 中所声明的组件实例继承自 wepy.component 类
// 不需要 config 配置以及页面特有的一些生命周期函数
// 属性与页面属性大致相同。
  import wepy from 'wepy'
  import { connect } from 'wepy-redux'
  import { INCREMENT, DECREMENT } from '../store/types/counter'
  import { asyncInc } from '../store/actions'

  @connect({
    stateNum (state) {
      return state.counter.num
    },
    asyncNum (state) {
      return state.counter.asyncNum
    }
  }, {
    incNum: INCREMENT,
    decNum: DECREMENT,
    asyncInc
  })

  export default class Counter extends wepy.component {
    props = {
      num: {
        type: [Number, String],
        coerce: function (v) {
          return +v
        },
        default: 50
      }
    }

    data = {
    }
    events = {
      'index-broadcast': (...args) => {
        let $event = args[args.length - 1]
        console.log(`${this.$name} receive ${$event.name} from ${$event.source.$name}`)
      }
    }

    watch = {
      num (curVal, oldVal) {
        console.log(`旧值：${oldVal}，新值：${curVal}`)
      }
    }

    methods = {
      plus () {
        this.num = this.num + 1
        console.log(this.$name + ' plus tap')

        this.$emit('index-emit', 1, 2, 3)
      },
      minus () {
        this.num = this.num - 1
        console.log(this.$name + ' minus tap')
      }
    }
  }
</script>
```

### 3.7 sotre: redux(如果你创建项目时使用了redux的话) Redux 状态管理器 使用，类似 vue 的 vuex

[学习网址](https://juejin.im/post/5b067f6ff265da0de02f3887)
[学习网址](https://www.jianshu.com/p/94d8f8a36ab0)

#### 3.7.1 src/store/index.js 文件 :store 的入口文件

```JS
//src/store/index.js
import { createStore , applyMiddleware } from 'redux'
import promiseMiddleware from 'redux-promise'
import reducer from './reducers'
const Store = createStore(
  reducer ,
  applyMiddleware(promiseMiddleware)
)
export default configStore => Store
```

入口文件 index.js ，里面主要是 初始化 Redux ， 其中 promiseMiddleware 是一个中间件，方便后面 action 做异步处理~ reducers 是一个纯函数，用于接受 Action 和当前 State 作为参数，返回一个新的 State。

#### 3.7.2 src/store/types 文件夹 常量定义

用于定义我们要触发的 action 的名称，这里我定义了 counter 和 list 两个 types ，内容分别如下：

```JS
//src/store/types/index.js 这里是 types 文件夹的入口文件 index.js，用于暴露 counter 和 list 两个 types
export * from './counter'
export * from './list'
```

```JS
//src/store/types/counter.js 这里是 wepy-cli 框架自带的。
export const INCREMENT = 'INCREMENT' //递增
export const DECREMENT = 'DECREMENT' //递减
export const ASYNC_INCREMENT = 'ASYNC_INCREMENT' //异步递增
```

```JS
//src/store/types/list.js 这个里是自己定义的
export const ADD = 'ADD' //加
export const REMOVE = 'REMOVE'//移除
```

#### 3.7.3  src/store/reducers文件夹 函数定义

```JS
//src/store/reducers/index.js    reducersd 入口文件
import { combineReducers } from 'redux'
import counter from './counter'
import list from './list'
export default combineReducers({
  counter ,//wepy框架预定义的
  list     //自定义的
})
//首先将 counter 和 list 的分别引入进来，通过 redux 定义的 combineReducers 函数，
//将所有的 reducers 合并成一个整体，方便我们后面对其进行管理
```

```JS
//src/store/reducers/counter.js
/* 首先引入了 handleActions 方法用来创建 actions ， 它将多个相关的 reducer 写在一起也是 ，
方面后期维护，也方便后期通过 dispatch 来调用他们更改 state 里面的状态，
它主要接收两个参数，第一个参数时候个大对象，里面存放多个 reducer ，
第二个参数是初始化的时候 state 的状态值，因此，我们一开始就定义了 defaultState ; */
import { handleActions } from 'redux-actions'
import { INCREMENT , DECREMENT , ASYNC_INCREMENT } from '../types/counter'
const defaultState  = {
  num: 0 ,
  asyncNum: 0
}
export default handleActions({
//分别定义了 INCREMENT、 DECREMENT 和 ASYNC_INCREMENT 三个 reducer ，
//前两个比较简单，分别是对 state 里面的 num 值进行 加减操作 ，
// 最后一个是通过 action.payload 的值来对 asyncNum 的值进行异步操作
  [INCREMENT](state){
    return{
      ...state,
      num : state.num + 1
    }
  },
  [DECREMENT](state){
    return{
      ...state,
      num : state.num - 1
    }
  },
  [ASYNC_INCREMENT](state, action){
    return {
      ...state ,
      asyncNum : state.asyncNum + action.payload
    }
  }
},defaultState)
```

```JS
//src/store/reducers/list.js  这里是自定义的，类似 count.js 来编辑
import { handleActions } from 'redux-actions'
import { ADD , REMOVE } from '../types/list'
const defaultState = [
  {
    title : '吃饭' ,
    text : '今天我要吃火锅'
  },
  {
    title : '工作' ,
    text : '今天我要学习 Redux'
  }
]
export default handleActions({
  [ADD]( state , action ){
    state.push(action.payload)
    return [...state]
  },
  [REMOVE]( state , action ){
    state.splice( action.payload , 1 );
    return [ ...state ]
  }
},defaultState)
```

#### 3.7.4 src/store/actions 文件夹

```JS
//src/store/actions/index.js 入口文件 index.js 将所需的 action 导出
export * from './counter'
```

```JS
//src/store/actions/counter.js
import { ASYNC_INCREMENT } from '../types/counter'
import { createAction } from 'redux-actions'
export const asyncInc = createAction(ASYNC_INCREMENT,()=>{
  return new Promise(resolve=>{
    setTimeout(()=>{
      resolve(1)
    },1000)
  })
})
//这里跟 reducer 里面的要区分，这里是可以对数据进行一系列处理的，我们通过 createAction 创建一个 action ,
//该方法主要有两个参数，第一个参数 type 表示 action 的类型，
//第二个参数 payloadCreator 是一个 function，处理并返回需要的 payload ；
//如果空缺，会使用默认方法。这里我们是延迟 1s 后返回一个 1；
```

#### 3.7.5 在 pages.wepy 中使用 store

例如我们创建一个 index.wpy 的文件。

```HTML
<template lang="wxml">
     <view class="container">
       <text>同步{{ num }}</text>
       <text>异步{{ asyncNum }}</text>
       <button @tap="increment" type="primary">加一</button>
       <button @tap="decrement" type="primary">减一</button>
       <button @tap="asyncIncrement" type="primary">异步加一</button>
       <button @tap="addList">添加</button>
       <view class="box">
           <view class="item" wx:for-items="{{ todoList }}" wx:key="index">
               <view class="title">{{ item.title }}</view>
               <view class="content">{{ item.text }}</view>
               <button type="primary" class="delete" @tap="delete({{index}})">删除</button>
           </view>
       </view>
     </view>
   </template>
<script>
  import wepy from 'wepy'
  import { connect } from 'wepy-redux'
  //从 wepy-redux 中 引入的 connect ，这个 connect 很关键，它是连接 组件 和 状态 的桥梁，
  //主要用法是 @connect(states, actions)
  //states: 访问 state 上的值，可以是数组或者对象，如果是对象的话，则包含的是 K-V 对，V 可以是函数还可以是字符串，
  //如果是字符串的话则默认获取 state[V]， 否则的话则是使用返回值；
  //而对于如果是数组的话（数组中的项只能为字符串），则认为是相同的 K-V 对象结构。
  //states 最终会附加到组件的 computed 属性值上。
  //actions: 只能传入对象，对象的 K-V 结构，如果 V 是字符串的话，则直接会 distatch,如下结构
  // args 就是调用传入参数
 /* {
      type: val,// 修正一般情况下的参数 一般支持只传一个参数
      payload: args.length > 1 ? args : args[0] // 如果真的是多个参数的话 那么 payload 就是参数组成的数组
    } */
 //如果是一个函数 fn，则会 dispatch(val.apply(store, args))，否则的话则直接 dispatch(V)
  import { INCREMENT , DECREMENT } from '../store/types/counter' //从 types/counter 导出所需的 action
  import { asyncInc } from '../store/actions'//从actions 导出所需的 action
  @connect({
    num(state){
      return state.counter.num;
    },
    asyncNum(state){
      return state.counter.asyncNum;
    }
  },{
    increment : INCREMENT ,
    decrement : DECREMENT ,
    asyncIncrement : asyncInc
  })
  export default class Index extends wepy.page {
  components = {}
  computed = {
    todoList(){
      return wepy.$store.getState().list;
    }
  }
    methods = {
    delete(index){
      wepy.$store.dispatch({ type : 'REMOVE' , payload : index })
            },
    addList(){
      wepy.$store.dispatch({ type : 'ADD' , payload : {
        title : '学习' ,
                text : '好好学习'
            }})
        }
    }
  onLoad () {
    console.log(wepy.$store.getState())
  }
}
</script>
<style lang="less">
    text{
        display: block;
        text-align: center;
        margin: 10px auto;
    }
    button{
        width: 90%;
        display: block;
        margin: 10px auto;
    }
    .item{
        display: flex;
        align-items: center;
        text-align: center;
        padding: 0 15px;
        .title{
            font-size: 14px;
            line-height: 20px;
            margin: 10px auto;
        }
        .content{
            font-size: 15px;
            flex: 1;
        }
        .delete{
            width: 70px;
            height: 40px;
            line-height: 40px;
        }
    }
</style>
```

- WePY 借鉴了 Vue.js（后文简称 Vue ）的语法风格和功能特性，如果你之前从未接触过 Vue，建议先阅读 Vue 的官方文档，以熟悉相关概念，否则在阅读 WePY 文档以及使用 WePY 进行开发的过程中，将会遇到比较多的障碍。
- 开发建议 **使用第三方成熟IDE或编辑器**(具体请参看后文的代码高亮部分)，**微信开发者工具仅用于实时预览和调试**。使用微信开发者工具-->添加项目，项目目录请选择项目根目录即可根据配置完成项目信息自动配置。
- 如果 project.config.json 不存在，建议手动创建该文件后再添加项目。 project.config.json 文件内容如下：
    {
      "description": "project description",
      "setting": {
        "urlCheck": true,    对应不检查安全域名选项，开启。 如果已配置好安全域名则建议关闭。
        "es6": false,        对应关闭 ES6 转 ES5 选项，**关闭。 重要：未关闭会运行报错。**
        "postcss": false,    对应关闭上传代码时样式自动补全选项，**关闭。 重要：某些情况下漏掉此项也会运行报**错。
        "minified": false    对应关闭代码压缩上传选项，**关闭。重要：开启后，会导致真机computed, props.sync 等等属性失效。**
      },
      "compileType": "miniprogram",
      "appid": "touristappid",
      "projectname": "Project name",
      "miniprogramRoot": "./dist"
    }

注：压缩功能可使用 WePY 提供的 build 指令代替，详见后文相关介绍以及 Demo 项目根目录中的 wepy.config.js 和 package.json 文件。

### 3.8 mixins: 混合组件 方法 js 文件

mixins 是放混合组件的方法的地方，比如很多 page 中都要用到 wx.showToast 方法。那么我们可以在 mixins 文件夹里面创建一个 toast.js

```JS
//toast.js
// mixins 是 js 文件不是 wpy 文件（当然我们需要看得懂 wepy 源码，拷源码过来自己会加功能是极好的）
import wepy from 'wepy'

export default class testMixin extends wepy.mixin {
  onLoad () {  // onLoad生命周期钩子函数
    this.showToast()
  }
  noMore () {  // 普通方法直接定义到 class 的静态方法
    wepy.showToast({        // wepy.showToast 等同于 wx.showToast
      title: '没有更多了...',
      icon: 'none',
      duration: 1500
    })
  }
  showToast () {
    wepy.showToast({
      title: '拼命加载中...',
      icon: 'loading',
      duration: 3000
    })
  }
  hideToast () {
    wepy.hideToast()
  }
}
//其中 wepy 继承了 wx 对象的方法，建议在 wepy 框架开发中不要用到 wx 对象的方法，
//虽然运行时效果是一样，但是打包时会 cli 报错（wepy 中没有 wx 对象）。
```

mixins 的方法定义好后，就可以在组件中使用 mixin 了。

```HTML
<!-- index.wpy  page.wpy-->
<script>
  import wepy from 'wepy'
  import toast from 'mixins/toast' // 导入 mixins 组件

  export default class Index extends wepy.page {
    onLoad () {
      this.showToast() // 导入和注册后，就可直接使用
      this.getMovies()
    }
    mixins = [  // 注册混合组件，注意 mixins 是一个数组
      toast
    ]
    ......
  }
</script>
```

首先在引入和注册后，然后就可以直接调用 this.showToast() 注意在 wepy 中组件中使用的是 class ,而不是 vue 中使用的 Object。

### 3.9 interceptor：拦截器

拦截器,可以使用全域拦截器配置API的config、fail、success、complete方法，参考示例：

```JS
import wepy from 'wepy';

export default class extends wepy.app {

    constructor () {
        this.intercept('request', {
            config (p) {
                p.timestamp = +new Date();
                return p;
            },
            success (p) {
                console.log('request success');
                return p;
            },
            fail (p) {
                console.log('request error');
                return p;
            }
        });
    }
}
```

### 3.10 utils：工具包

```JS
const formatTime = (time) => {
  let h = Math.floor(time / 3600)
  h = (h < 10) ? '0' + h : h
  let m = Math.floor(time % 3600 / 60)
  m = (m < 10) ? '0' + m : m
  let s = time % 3600 % 60
  s = (s < 10) ? '0' + s : s
  return `${h}:${m}:${s}`
}

/* 可以将一些公共的代码抽离成为一个单独的 js (utils.js)文件，作为一个模块;模块只有通过 module.exports 或者 exports 才能对外暴露接口。所以当你在util.js里封装的方法想要在外部使用的话,必须通过 module.exports 或者 exports 对外暴露
需要注意的是，这个文件名是指定的，只能是 utils 文件夹下的 util.js 文件，改变了就会出错的。


问题是这个文件夹是只能有一个工具文件么？？？*/

module.exports = {
  formatTime: formatTime//'对外方法名':'本地方法名'
}
```

```JS
// 调用 util.js 中的函数
import util from '../utils/util';// ES6 写法
//var util= require('../utils/util.js') // ES5 写法
util.formatTime(params))
```

问题：

```BASH
Missing files: ../utils/utils.js in F:\pages.wpy #出现这个问题就是不正确的命名了，不要去修改工具包的名字
# 只能是 ../utils/util.js
```

### 数据绑定

wepy 使用脏数据检查对 setData 进行封装，在函数运行周期结束时执行脏数据检查，一来可以不用关心页面多次 setData 是否会有性能上的问题，二来可以更加简洁去修改数据实现绑定，不用重复去写 setData 方法。代码如下：

```JS
this.title = 'this is title';// 可以直接赋值
```

在异步函数中更新数据的时候，必须手动调用 $apply 方法，才会触发脏数据检查流程的运行。如：
之前说的作为回调呢？
子组件的 onload 里面也需要 this.$apply() 吧，还有其他的情况么？？
网址：[wepy props传值有说道](https://tencent.github.io/wepy/document.html#/?id=props-%E4%BC%A0%E5%80%BC)
网址：[gitHub issue 也有说道](https://github.com/Tencent/wepy/issues/1556)

但需注意，在函数运行周期之外的函数里去修改数据需要手动调用 $apply
方法。如：

```JS
setTimeout(() => {
    this.title = 'this is title';
    this.$apply();
}, 3000);
```

## 四、wepy 完整的属性/方法/配置 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!]

### 4.1 app.wpy 的 config 选项/属性() ,data，生命周期，配置，等等

App 小程序实例中主要包含小程序生命周期函数、 config 配置对象、 globalData 全局数据对象，以及其他自定义方法与属性。

```JS
import wepy from 'wepy';

export default class MyAPP extends wepy.app {
  //config 属性对应原生的 app.json 文件
  // build 编译时会根据 config 属性自动生成 app.json 文件，如果需要修改 config 中的内容，请使用微信提供的相关 API。
  config = {
    //① 页面路径列表
    pages: [
      'pages/index'
    ],
    //② 全局的默认窗口表现
    window: {
      navigationBarBackgroundColor: '#fff',//导航栏背景颜色，如 #000000
      navigationBarTextStyle: 'black'//导航栏标题颜色，仅支持 black / white
      navigationBarTitleText: 'WeChat',//导航栏标题文字内容
      navigationStyle:'default',//导航栏样式，仅支持以下值：default 默认样式 ,custom 自定义导航栏，只保留右上角胶囊按钮
      backgroundColor:'#ffffff'//窗口的背景色
      backgroundTextStyle: 'light',//下拉 loading 的样式，仅支持 dark / light
      backgroundColorTop:'#ffffff'//顶部窗口的背景色，仅 iOS 支持
      backgroundColorBottom:'#ffffff'//底部窗口的背景色，仅 iOS 支持
      enablePullDownRefresh:false,//是否开启当前页面的下拉刷新。详见 Page.onPullDownRefresh
      onReachBottomDistance:50,//页面上拉触底事件触发时距页面底部距离，单位为px。详见 Page.onReachBottom
      pageOrientation:'portrait'//屏幕旋转设置，仅支持 auto / portrait 详见 响应显示区域变化
    },
    // ③ 页面底部栏配置
    tabBar: {
      color: '#AEADAD',//tab 上的文字默认颜色
      selectedColor: '#049BFF',//tab 上的文字选中时的颜色
      backgroundColor: '#fff',//tab 的背景色
      borderStyle: 'black',//tabbar上边框的颜色， 仅支持 black / white
      position:'bottom',//tabBar的位置，仅支持 bottom / top
      list: [//最少2个、最多5个 tab
        {
          pagePath: 'pages/index',
          text: '游戏',
          iconPath: '',
          selectedIconPath: ''
        },
        {
          pagePath: 'pages/ranking',
          text: '排名',
          iconPath: '',
          selectedIconPath: ''
        }
      ]
    },
    //④ 网络超时时间 默认都是 60000 ms
    networkTimeout: {
      request: 10000,//wx.request 的超时时间，单位：毫秒。
      downloadFile: 10000,//wx.downloadFile 的超时时间，单位：毫秒。
      connectSocket:10000,
      uploadFile:10000
    },
    debug: true, //⑥ 是否开启 debug 模式，默认关闭, 这个配置，项目上线要删除
    functionalPages:true,//⑦ 启用插件功能页时
    subpackages:,//⑧ subPackages 也行???? 启用分包加载时，声明项目分包结构。
    workers:,//⑨ 使用 Worker 处理多线程任务时，设置 Worker 代码放置的目录
    requiredBackgroundModes: ['audio'],//⑩ 申明需要后台运行的能力，类型为数组。 目前也只是支持 audio
    plugins:,//⑪ 声明小程序需要使用的插件。
    preloadRule:,//⑫ 声明分包预下载的规则。
    resizable:,//⑬在 iPad 上运行的小程序可以设置支持屏幕旋转。
    //当小程序需要使用 wx.navigateToMiniProgram 接口跳转到其他小程序时，
    navigateToMiniProgramAppIdList:,//⑭需要先在配置文件中声明需要跳转的小程序 appId 列表，最多允许填写 10 个。
    usingComponents://⑮ 开发者工具 1.02.1810190 及以上版本支持 usingComponents 字段，
    //在此处声明的自定义组件视为全局自定义组件，在小程序内的页面或自定义组件中可以直接使用而无需再声明。
  }

    //小程序的生命周期，周期函数
    onLaunch () {} //小程序初始化完成时（全局只触发一次）
    onShow () {}  // 小程序启动，或从后台进入前台显示时
    onHide () {}  // 小程序从前台进入后台时
    onError() {} //小程序发生脚本错误，或者 api 调用失败时触发，会带上错误信息
    onPageNotFound() {} //小程序要打开的页面不存在时触发，会带上页面信息回调该函数
   //前台、后台定义： 当用户点击左上角关闭，或者按了设备 Home 键离开微信，小程序并没有直接销毁，而是进入了后台；
   //当再次进入微信或再次打开小程序，又会从后台进入前台。
   //需要注意的是：只有当小程序进入后台一定时间，或者系统资源占用过高，才会被真正的销毁。

    globalData = {} //全局属性
    // 全局方法

    customData = {}; // 自定义数据 ？？？没有看到过这个啊？？
    customFunction ()　{ } //自定义函数
}
```

### 4.2 page.wpy 与 components.wpy 的 选项/属性：data，生命周期，配置，等等

由于 Page 页面实际上继承自 Component 组件，即 Page 也是组件。除扩展了页面所特有的 config 配置以及特有的页面生命周期函数之外，其它属性和方法与 Component 一致，因此这里以 Page 页面为例进行介绍。

```JS
import wepy from 'wepy';

export default class MyPage extends wepy.page {
// export default class MyComponent extends wepy.component {
    // 只在Page实例中存在的配置数据，对应于原生的page.json文件  只是 pages.wpy 中的有，components.wpy 中没有
    config = {
      navigationBarBackgroundColor: '#fff', //导航栏背景颜色，如 #000000
      navigationBarTitleText: 'WeChat',//导航栏标题文字内容
      navigationBarTextStyle: 'black',//导航栏标题颜色，仅支持 black / white
      backgroundColor:'#ffffff',//窗口的背景色
      backgroundTextStyle: 'light',//下拉 loading 的样式，仅支持 dark / light
      enablePullDownRefresh:false,//是否全局开启下拉刷新。详见 Page.onPullDownRefresh
      onReachBottomDistance:50,//页面上拉触底事件触发时距页面底部距离，单位为px。详见 Page.onReachBottom
      disableScroll:false//设置为 true 则页面整体不能上下滚动；
      //disableScroll 这项 只在页面配置中有效，无法在 app.json 中设置该项!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    }

    data = {};  // 页面所需数据均需在这里声明，可用于模板数据绑定

    components = {};  // 声明页面中所引用的组件，或声明组件中所引用的子组件

    mixins = [];  // 声明页面所引用的Mixin实例

    computed = {};  // 声明计算属性（详见后文介绍）
    watch = {};  // 声明数据 watcher（详见后文介绍）

   // 组件事件处理函数：页面中的某个元素触发的函数
    methods = {};  // 声明页面 wxml 中标签的事件处理函数。用于 本组件 触发的事件处理
    events = {};  // 声明组件之间的事件处理函数           用于 其他组件 触发的事件处理

    customData = {}  // 自定义数据
    customFunction ()　{}  //自定义方法，这里与 methods  平级，这些方法不能卸载  methods 里面

    // 生命周期函数
    onLoad () {}  // 页面加载（执行 ？？ 次）：在 Page 和 Component 共用的生命周期函数
    onShow () {}  // 页面显示（执行很多次）：只在 Page 中存在的页面生命周期函数
    onReady() {}  // 页面初次渲染完成（执行 1 次）：只在？？？
    onHide () {}  // 页面隐藏（执行很多次）：只在 Page 中存在的页面生命周期函数
    onUnload(){}  //页面卸载（执行 ？？ 次）：在 Page 和 Component 共用的生命周期函数

    // 页面事件处理函数：整个页面触发的函数
    onPullDownRefresh(){}  //监听用户下拉动作
    onReachBottom(){}  //页面上拉触底事件的处理函数
    onShareAppMessage(){}  //用户点击右上角转发
    onPageScroll(){}  //页面滚动触发事件的处理函数
    onResize(){}  //页面尺寸改变时触发
    onTabItemTap(){}  //当前是 tab 页时，点击 tab 时触发
}
```

### 4.2 components.wpy 的 选项/属性：data，生命周期，配置，等等

除了 config 之外，拥有 page 页面的所有属性与方法
/.,   Zxcvbvc选项

在 pages 页面中我们有几种函数

- 2、页面事件处理函数：eg：onPullDownRefresh()
- 3、组件事件处理函数 methods 内：自定义
- 4、props 传值处理函数 events 内：自定义
- 5、普通函数 为其他的函数做准备的函数：自定义

```JS
//在 vue 中，所有方法都定义在 methods 里面。
//而在 wepy 中，
// ① 普通方法是直接定义在 class 静态方法里面。（就是与  methods  events 平级的地方）
// ② events 只定义组件间交互的方法。（它的父子组件，传递过来方法）
// ③ methods只定义事件方法。（本组件事件触发的方法）

/* index.wpy */
getSliderImg (data) { // ① 普通方法
  this.sliderImg = data.slice(0, 10)
  this.$apply()
}
onPullDownRefresh () {  // 页面事件处理函数：顶部下拉刷新（这是对整个页面而言触发的事件）
  this.showToast()
  this.sliderImg = null
  this.active = true
  this.$apply()
  this.getMovies()
}
events = {  // ② 与子组件的交互，都要写到 events 里面
  'showMovieDetail': (id) => {
    wepy.navigateTo({
      url: `./movie-detail?locationId=${290}&movieId=${id}`
    })
  }
}
methods = {
  toggleType (flag) { // ③ 组件事件处理函数：点击事件方法（这是对 页面中的某个元素操作 触发的事件）
    this.active = flag
    this.showToast()
    this.getMovies()
  }
}
```

### 4.4 computed 属性/选项

wepy 中也有 computed,props，data,watch 等 vue 中有的一些属性（没有filter, directive）。
props,data,watch 和 vue 基本无异。 wpy 中是 watcher

wepy 中 computed 计算属性是无法传参的（本人没能找到传参的方法，且官方文档没有提到），在处理一些动态数据的时候，只能通过其他方法来操作。
比如，服务端获取到的的 JSON 对象内有条时间戳数据需要转换成字符串，我的做法是将时间戳另外传值给子组件，然后在子组件中使用 computed 对props 进行记算。

### 4.10 this.$parent.全局方法 this.$parent.全局属性

在 Page 页面实例中，可以通过 this.$parent 来访问 App 实例 的方法与属性

## 五、wepy 继承 wx 对象的所有 API

[小程序官网 API](https://developers.weixin.qq.com/miniprogram/dev/api/)

## 六、wepy 中的 API 类

### 6.1 app ：wepy.app Class

App 基类，小程序入口。

```JS
export class App extends wepy.app {

  // ① 属性
   this.$wxapp // getApp()

  // ② 属性
   this.$pages = {
   './pages/index': IndexPage
   }

  // ④ use() 使用中间件
  constructor() {
    super()
    this.use('requestfix'); //修复小程序请求并发问题。
    this.use('promisify');//使用 wepy.xxx 的方式请求小程序原生 API 都将 Promise 化。
    //③  $interceptors 拦截器属性
    this.$interceptors = {
    'request': {
        config (p) {
            return p;
        },
        success (rst) {

        }
    }
    /*⑤ intercept 拦截器  方法
    //使用拦截器对原生 API 请求进行拦截。
    this.intercept('request', {
      config (p) {
        p.timestamp = +new Date()
        return p
      },
      success (obj) {
        console.log('request success')
      }
    }) */
  }
}
```

### 6.2 component && page ：wepy.component Class && wepy.page Class

组件基类

```JS
export default class Counter extends wepy.component {

  $name       //① String: 组件名称。
  $isComponent//② Boolean：是否是组件，如果是页面，此值为false。
  $wxpage     //③ :Object: 小程序原生page。
  $parent     //④ :Page|App：组件的父组件，如果当前是组件是Page对象，那么$parent的值为App对象。
  $root       //⑤ :Page: 组件所在的Page对象，如果当前组件是Page对象，那么$root的值就是自己本身。
  $coms       //⑥ :List<Component>：组件的子组件列表。
  $mixins     //⑦ :Array[Mixin]：组件所注入的Mixin对象。
  data        //⑧ :Object: 组件需要绑定的数据。
  methods     //⑨ :List<Function>：组件需要响应的事件列表。
  props       //⑩ :List<Props>：组件允许传递的props列表。
  events      //⑪:List<Function>：组件通信时所需要的事件表现。

  this.setData('list', ['apple', 'pen']);//⑫ 对原有小程序的setData的封装。
  this.setData({
    list: ['apple', 'pen']//因为 WePY 的脏检查流程会自动执行 setData 操作，所以通常情况下不需要使用此方法。
  });
  this.getCurrentPages()//                ⑬ 相当于全局方法 getCurrentPages()
  this.$getComponent('./coma/comb'); //   ⑭ 通过组件名称路径查找组件对象。
  this.$getComponent('../comc');//通过组件名称路径查找组件对象。
  //                                      ⑮ $invoke(com:String|Component)：
  //调用另一组件的方法。优先调用 methods 中方法，如果方法不存在，则调用组件的自定义方法，调用自定义方法时，不会传递事件 $event。
  
  // comb.js
  /* export class ComB extends wepy.component {
      methods = {
          func1 (p1, p2, evt) {}
      },
      func2 (p1, p2) {}
  } */
  // coma.js ，假设这里是 coma.js
  this.$invoke('./ComB', 'func1', 'p1', 'p2');
  this.$invoke('./ComB', 'func2', 'p1', 'p2');

  //⑯ $broadcast(eventName:String, [args])：组件发起一个广播事件。  父 传 子
  // coma.js 假设这里是 coma.js
  components = { ComA };
  this.$broadcast('broadcast-event', 'p1', 'p2');

  /* coma.js 的所有子组件，有需要的话
  events = {
      'broadcast-event': (p1, p2, event) {}
  } */

  //⑰ $emit(eventName:String, [args])：组件发起一个冒泡事件。 子 传 父
  // coma.js 假设这里是 coma.js
  this.$emit('emit-event', 'p1', 'p2');

  /* coma.js 的所有 父 组件，有需要的话
  components = { ComA };
  events = {
      'emit-event': (p1, p2, event) => {}
  } */

  //⑱ $apply([func:Function])：组件发起脏检查
  //正常流程下，改变数据后，组件会在流程结束时自动触发脏检查。 在异步或者回调流程中改变数据时，需要手动调用 $apply 方法。
  this.userName = 'Gcaufy';
  this.$apply();

  this.$apply(() => {
      this.userName = 'Gcaufy';
  });

  //⑲ $nextTick([func:Function])：组件数据绑定完成后的回调事件，v1.6.1 以上可用。
  // 数据绑定后的回调事件，在不传入function时，返回一个promise对象
  this.userName = 'Gcaufy';
  this.$nextTick(function () {
    console.log('UI updated');
  });
  // 或者
  this.userName = 'Gcaufy';
  this.$nextTick().then(function () {
    console.log('UI updated');
  });


  // 下面的 page 页面专有的属性与方法， common 组件是没有的。
  //⑳$preload(key:String|Object, [value:Object])，
  // 加载 preload 数据后，跳转至另一个页面时，在 onLoad 方法中可以获取到上个页面的 preload 数据。
  this.$preload('userName', 'Gcaufy');
  this.$redirect('./page2');
  // page2.js
  /* onLoad (params, data) {
      console.log(data.preload.userName);
  } */

  //㉑ $redirect(url:String|Object, [params:Object])：wx.redirectTo的封装方法。
  this.$redirect('./page2', {a: 1, b: 2});
  this.$redirect({
      url: './pages?a=1&b=2'
  });
  // page2.js
  /* onLoad (params, data) {
      console.log(data.preload.userName);
  } */

  // ㉒ $navigate(url:String|Object, [params:Object])：wx.navigateTo的封装方法
  
  //㉓ $switch(url:String|Object)：wx.switchTab的封装方法
}
```

#### 预加载 ？？？、这个官网上面没有啊

预加载
请求数据是在 onLoad 中进行，但是小程序的 page 1跳转到 page 2，再到 page 2 的 onLoad 是存在一个 300ms ~ 400ms 的延时.
wepy 扩展了生命周期，添加了onPrefetch 事件，会在 redirect 之时被主动调用。同时给 onLoad 事件添加了一个参数，用于接收预加载或者是预查询的数据：

```JS
// params
// data.from: 来源页面，page1
// data.prefetch: 预查询数据
// data.preload: 预加载数据
onLoad (params, data) {}
//预加载数据示例：
// page1.wpy 预先加载 page2 需要的数据。

methods: {
  tap () {
    this.$redirect('./page2');
  }
},
onLoad () {
  setTimeout(() => {
    this.$preload('list', api.getBigList())
  }, 3000)
}

// page2.wpy 直接从参数中拿到 page1 中预先加载的数据
onLoad (params, data) {
  data.preload.list.then((list) => render(list));
}
//预查询数据示例：
// page1.wpy 使用封装的 redirect 方法跳转时，会调用 page2 的 onPrefetch 方法
methods: {
  tap () {
    this.$redirect('./page2');
  }
}

// page2.wpy 直接从参数中拿到 onPrefetch 中返回的数据
onPrefetch () {
  return api.getBigList();
}
onLoad (params, data) {
  data.prefetch.then((list) => render(list));
}
```

### 6.3 event ： wepy.event Class  小程序事件封装类

## 七、组件之间通信与交互，事件通信交互-页面传参

### 7.1 父子组件传值：props 传值：父组件 <=> 子组件

也就是在父组件中 子组件处 ：写上传递的属性 与其对应的值。

props 传值在 WePY 中属于父子组件之间传值的一种机制，包括静态传值与动态传值。

静态传值：传值即使静态传值，静态传值为父组件向子组件传递常量数据，因此只能传递 String 字符串类型。
        静态传值，使用静态传值时，子组件会接收到字符串的值。
动态传值：动态传值是指父组件向子组件传递动态数据内容，父子组件数据完全独立互不干扰。!!!!!!!!!!!!!!!!!

#### 7.1.1 静态传值：传递字符串 父组件 => 子组件

只能是父组件传给子组件

```html
<!-- 父组件 -->
<template>
  <child title="mytitle"></child>
</template>
```

```html
<!-- 子组件 -->
<script>
  export default class Index extends wepy.page {
    props = {
      title: String // 在子组件接收 父组件传递过来的值，这里是静态传值，数据类型值 字符串
    };
    onLoad () {
      console.log(this.title); // mytitle
    }
  }
</script>
```

#### 7.1.2 动态态传值：父子组件的值互相不影响 父组件 <=> 子组件

由于上面的静态传值，只能是父组件传值给子组件，在子组件是不能去修改父组件的属性值的，而有时候我们需要做到 父子组件的数据双向绑定，简单点的，目的也就是子组件可以修改值传递给父组件。

①sync修饰符：其实就是做到子组件中修改属性并传递给父组件 父组件 <= 子组件，`:name.sync` 就是 `:name="name" @update:name="name = $event"` 的缩写。
  注意带有 .sync 修饰符的 v-bind 不能和表达式一起使用 (例如 `v-bind:title.sync=”doc.title + ‘!’”` 是无效的)。取而代之的是，你只能提供你想要绑定的属性名
②twoWay:是否可以子组件向父组件传值，默认值为 false，也就是不允许子组件向父组件传值。
    `:name.sync` 等价于 父组件向子组件传值 ，但是子组件不能传值给父组件，也就是静态传值的效果
    `:name.sync` props 中 `twoWay: true` 等价于 双向传值

```html
<!-- 父组件 -->
<template>
  <child :title="parentTitle" :syncTitle.sync="parentTitle" :twoWayTitle="parentTitle"></child>
</template>
```

```html
<!-- 子组件 -->
<script>
  export default class Index extends wepy.page {
    props = {
    title: String, // 静态传值 （父组件中 title 属性没有 .sync 修饰，并且这里默认 twoWay: false）

    syncTitle: {   // 父向子单向动态传值
        type: String, //（父组件中 syncTitle 属性有 .sync 修饰，但是这里默认 twoWay: false）
        default: 'null' // 因此只能是父组件传值给子组件
    },

    twoWayTitle: { // 双向传值
        type: String, //（父组件中 syncTitle 属性有 .sync 修饰，这里 twoWay: true）
        default: 'nothing', //问题？这里默认值是什么？？？？
        twoWay: true
    }
};
onLoad () {
    console.log(this.title); // p-Title
    console.log(this.syncTitle); // p-Title
    console.log(this.twoWayTitle); // p-Title

    this.title = 'c-title';// 修改子组件的属性值，因为 title 没有 sync 只能是 父 影响 子，子无法改变 父组件的
    console.log(this.$parent.parentTitle); // p-Title
    this.twoWayTitle = 'two-way-title';
    this.$apply(); //https://juejin.im/post/59bfe84351882531b730bac2 ，
    // wepy 中 props 传递需要加上 .sync 修饰符（类似VUE1.x）才能实现 props 动态更新，
    // 并且父组件再 变更传递给子组件 props 后要执行this.$apply() 方法才能更新
    console.log(this.$parent.parentTitle); // two-way-title.  --- twoWay为true时，子组件props中的属性值改变时，会同时改变父组件对应的值
    this.$parent.parentTitle = 'p-title-changed';
    this.$parent.$apply();
    console.log(this.title); // 'c-title';
    console.log(this.syncTitle); // 'p-title-changed' --- 有.sync修饰符的props属性值，当在父组件中改变时，会同时改变子组件对应的值。
}
</script>
```

问题： apply（） ，call 函数，等等，好难。
上面的这个例子举例真是不让人理解、

apply() 方法调用一个函数, 其具有一个指定的this值，以及作为一个数组（或类似数组的对象）提供的参数

```BASH
VM139764:1 CLI报错：
F:\qianduan_dir\00program\wechat-wepy\suduku\src\pages\grid.wpy
  240:10  error  Missing space before value for key 'grid'  key-spacing
  269:10  error  Missing space before value for key 'name'  key-spacing

✖ 2 problems (2 errors, 0 warnings)
```

解答：这个是因为 eslint 的要求，要求 对象中，key 与 value 之间是需要空格间隔的，否则就会报错，找到了原因，是因为在父组件中，data 部分写成了这样

```JS
  data = {
    name:'xiaomi'// 这里 key 与 value 之间没有空格，eslint 是会当成错误报出来的。
  }

  //解决办法就是 ctrl + s 多按几遍，就会自动的格式化了，这里 eslint 很烦人的一个地方，文件它也不报错，只是在控制台一直报错，
  // 明白了错误的意思之后，随手  ctrl + s  发现 data 中格式给改变了，
  data = {
    name: 'xiaomi'// 格式化成这样就正确了。
  }
```

然后又出来了一个问题

```BASH
204:24  error  Extra semicolon  semi # 多余的 分号
205:37  error  Extra semicolon  semi
206:39  error  Extra semicolon  semi
207:30  error  Extra semicolon  semi
```

这还是 eslint 的问题，要修改 .eslintrc.js 文件

```JS
module.exports = {
  root: true,
  globals: { wx: true },
  parser: 'babel-eslint',
  parserOptions: {
    sourceType: 'module'
  },
  env: {
    browser: true
  },
  // https://github.com/feross/standard/blob/master/RULES.md#javascript-standard-style
  extends: [
  'standard',
  "eslint:recommended" //增加这一句，并且看到这里就变成一个数组了
],
  // required to lint *.wpy files
  plugins: [
    'html'
  ],
  settings: {
    'html/html-extensions': ['.html', '.wpy']
  },
  // add your custom rules here
  'rules': {
    // allow paren-less arrow functions
    'arrow-parens': 0,
    // allow async-await
    'generator-star-spacing': 0,
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0,
    'space-before-function-paren': 0,
    "no-console":0 // 增加这一句
  }
}
```

问题： 这个 .sync 与 twoWay 到底是怎么限制传值的？？？？？

```HTML
<!-- 父组件 -->
<view class='grid'>
  <childrengrid :syncname.sync="name" :syncTwoname.sync="name" :twoName="name"></childrengrid>
</view>
<script>
data={
  name: 'xiaomi'
}
</script>
```

```HTML
<!-- 子组件 -->
<style lang="less">
    .common-grid{
      width: 100%;
      height: 10%;
      background: red;
    }
</style>
<template>
  <view class="common-grid">
  </view>
</template>
<script>
  import wepy from 'wepy'

  export default class CommonGrid extends wepy.component {
    data = {
    }
    // :name='name' :syncname.sync='name' :syncTwoname.sync='name' :twoname='name'
    props={
      gridData: {
        type: Array
      },
      syncname: {
        type: String,
        twoWay: false
      },
      syncTwoname: {
        type: String,
        twoWay: true
      },
      twoName: {
        type: String,
        twoWay: true
      }
    }
    onLoad () {
      console.log('this.syncname:' + this.syncname)//this.syncname:xiaomi
      console.log('this.syncTwoname:' + this.syncTwoname)//this.syncTwoname:xiaomi
      console.log('this.twoname:' + this.twoName)//this.twoName:xiaomi

      this.syncname = 'mei'
      this.$apply()
      console.log('this.$parent.name:' + this.$parent.name) //this.$parent.name:xiaomi
      // 说明 .sync 子组件 是无法改变 父组件

      this.syncTwoname = 'mei1'
      this.$apply()
      console.log('this.$parent.name:' + this.$parent.name)//this.$parent.name:mei1
      // .sync twoWay=true 子组件 可以修改 父组件

      this.twoName = 'mei2'
      this.$apply()
      console.log('this.$parent.name:' + this.$parent.name)//this.$parent.name:mei2
      // twoWay=true  子组件 可以修改 父组件

      this.$parent.name = 'mei3'
      this.$parent.$apply()
      console.log('this.syncname:' + this.syncname)//this.syncname:mei
      //  .sync  父组件也无法修改子组件啊 ？？？？？？？？
      console.log('this.syncTwoname:' + this.syncTwoname)//this.syncTwoname:mei3
      // .sync twoWay=true  父组件 可以修改 子组件
      console.log('this.twoName:' + this.twoName)//this.twoName:xiaomi
      // twoWay=true  父组件 无法修改 子组件
    }
  }
</script>
```

没有 .sync 与 twoWay 与静态传值是一样的，父子组件互补影响
只有 .sync 貌似 父组件无法修改子组件啊！！！！！
只有 twoWay=ture 子组件可以修改父zujian
有 .sync 与 twoWay 父子组件可以互相修改

### 7.2  $emit 子组件 => 所有父组件

$emit 与 $broadcast 正好相反，事件发起组件的所有祖先组件会依次接收到$emit事件。如果组件ComE发起一个$emit事件，那么接收到事件的先后顺序为：组件ComA、页面Page_Index。如下图：

![t](https://cloud.githubusercontent.com/assets/2182004/20554704/9997932c-b198-11e6-9840-3edae2194f47.png)

```HTML
<!-- 子组件：触发方法 -->
<template>
  <view @tap='tap'>
    这里绑定事件
  </view>
</template>
<script>
   export default class Com extends wepy.component {
      components = {};
      data = {};
      methods = {
        tap(){
          this.$emit('some-event', 1, 2, 3, 4);
          // 事件方法, 使用 $emit 发起一个名为 some-event 的监听属性 传值为 1, 2, 3, 4
        }
      };
   }
</script>
```

```html
<!-- 父组件：接受事件 -->
<script>
  import wepy from 'wepy'
  export default class Com extends wepy.component {
      components = {};

      data = {};

      methods = {};

      // events对象中所声明的函数为用于监听组件之间的通信与交互事件的事件处理函数
      events = {
          'some-event': (p1, p2, p3, $event) => {
                console.log(`${this.$name} receive ${$event.name} from ${$event.source.$name}`);
          }
          // 监听 从 A 产来的 some-event 属性
      };
      // Other properties
  }
</script>
```

### 7.3  $broadcast 父组件 => 所有子组件

$broadcast 事件是由父组件发起，所有子组件都会收到此广播事件，除非事件被手动取消。事件广播的顺序为广度优先搜索顺序，如上图，如果页面Page_Index 发起一个 $broadcast 事件，那么按先后顺序依次接收到该事件的组件为：ComA、ComB、ComC、ComD、ComE、ComF、ComG、ComH。如下图：

![tu](https://cloud.githubusercontent.com/assets/2182004/20554688/800089e6-b198-11e6-84c5-352d2d0e2f7e.png)
、$invoke

```HTML
<!-- 父组件：触发方法 -->
<template>
  <view @tap='tap'>
    这里绑定事件
  </view>
</template>
<script>
   export default class Com extends wepy.component {
      components = {};
      data = {};
      methods = {
        tap(){
          this.$emit('some-event', 1, 2, 3, 4);
          // 事件方法, 使用 $emit 发起一个名为 some-event 的监听属性 传值为 1, 2, 3, 4
        }
      };
   }
</script>
```

```html
<!-- 子组件：接受事件 -->
<script>
  import wepy from 'wepy'
  export default class Com extends wepy.component {
      components = {};

      data = {};

      methods = {};

      // events对象中所声明的函数为用于监听组件之间的通信与交互事件的事件处理函数
      events = {
          'some-event': (p1, p2, p3, $event) => {
                console.log(`${this.$name} receive ${$event.name} from ${$event.source.$name}`);
          }
          // 监听 从 A 产来的 some-event 属性
      };
      // Other properties
  }
</script>
```

### 7.4  $invoke A B 组件之间调用方法(父子组件，非父子组件中调用 其他组件的方法都是这样做)

$invoke 是一个页面或组件对另一个组件中的方法的直接调用，通过传入组件路径找到相应的组件，然后再调用其方法。

```html
<!-- 子组件：接受事件 -->
<script>
  import wepy from 'wepy'
  export default class Com extends wepy.component {
      this.$invoke('B', 'someMethod', 'someArgs') // 调用 B 页面 的方法
      this.$invoke('./../compsonent/C', 'someMethod', 'someArgs'); // 调用 C 组件 的方法
    };
  }
</script>
```

### 7.5 url 传值

#### 7.6.1 导航链标签 + url

```HTML
<navigator class="message" url="./pages/grid?level={{level}}">
  <!-- 这里的的 路径不要搞错-->
  <i class="iconfont icon-message cfff"></i>
  <view class="doc cfff">消息</view>
</navigator>
```

```HTML
 <!-- <view class='levels'>
    这里怎么就不对呢？？？
  <block for="{{levels}}" key="index" index="index" item="level" open-type="navigate">
    <navigator clas='level' url='./grid?level={{level}}'>
      <text>{{level}}</text>
    </navigator>
  </block>
</view> -->
```

##### 7.6.2 事件 + 基本参数 + 花括号 传值（优化之后使用的方法）

```html
<!-- wepy中的事件可传递一些基本类型的参数，但是需使用双括号。否则获取到的参数是字符串类型。 -->
 <view @tap="toggleType({{true}})">
```

```HTML
<view class="grid-row {{rowIndex % 3 == 0 ? 'grid-row-index' : ''}}" wx:for-items="{{grids}}" wx:for-index="rowIndex" wx:for-item="items" wx:key="rowIndex">
  <view  class="grid-col {{colIndex % 3 == 0 ? 'grid-col-index' : ''}}" wx:for-items="{{items}}" wx:for-index="colIndex" wx:for-item="item" wx:key="colIndex">
    <view class="fixed" wx:if="{{item}}">{{item}}</view>
    <view @tab="fillNumber({{rowIndex}},{{colIndex}})" wx:else></view>
  </view>
</view>
```

##### 7.6.3 事件 + data-  +  e.currentTarget.dataset.level  传值（原生方法）

```html
<template>
<view data-movie="{{movie}}" @tap="showMovie"></view>
</template>
<script>
methods = {
  showMovie (e) {
    console.log(e.currentTarget.dataset.movie) # 这样就可以获取到data属性绑定的对象
  }
}
</script>
```

```HTML
<template>
  <view class='levels'>
    <block wx:for-items="{{levels}}" wx:for-index="index" wx:for-item="level" wx:key="index">
      <view class='level' @tap='toPageGrid' data-level='{{level}}'>
        <text>{{level}}</text>
      </view>
    </block> -->
  </view>
  <!-- block 与 view 不同，block 不会在 DOM 中体现 ，这里 block 只是做循环用的-->
</template>
<script>
  methods = {
      toPageGrid(e) {
        // 这里的的 路径不要搞错
        let urlStr = './grid?level=' + e.currentTarget.dataSet
        console.log(e)
        wx.navigateTo({
          url: urlStr
        })
      }
  };
</script>
```

① `@tap='toPageGrid' data-level='{{level}}'` toPageGrid 这里没有写传值，那么在 js 里面我们可以获取到事件 e 的，并且可以在 html 中以 `data-level='{{level}}'` 这种方式传值，在事件 e 的 `e.currentTarget.dataSet` 中可以获取到属性值。

② `@tap='toPageGrid(22)'` 如果我们这样传值，将获取不到事件  e， 它就是我们 在html 中传入的 22， e 只是一个参数，就是 7.6.3 节的基本参数传值

**上面原生的方法与 wepy 优化之后的方法比较**

```HTML
<!-- // 原生的事件传参方式: -->
<view data-id="{{index}}" data-title="wepy" data-other="otherparams" bindtap="tapName"> Click me! </view>
```

```JS
Page({
    tapName: function (event) {
        console.log(event.currentTarget.dataset.id)// output: 1
        console.log(event.currentTarget.dataset.title)// output: wepy
        console.log(event.currentTarget.dataset.other)// output: otherparams
    }
});
```

```HTML
<!--  WePY 1.1.8以后的版本，只允许传 string。 -->
<view @tap="tapName({{index}}, 'xiaomi', '18')"> Click me! </view>
<script>
methods: {
    tapName (index, name, age, event) {
        console.log(index, name, age) // output: 1, xiaomi, 18 直接取值，不需要 event.currentTarget 这样取值了
    }
}
</script>
```

也就是说上面 7.6.3 的代码可以写成

```HTML
<template>
  <view class='levels'>
    <block wx:for-items="{{levels}}" wx:for-index="index" wx:for-item="level" wx:key="index">
      <view class='level' @tap='toPageGrid({{level}})' data-level='{{level}}'>
        <text>{{level}}</text>
      </view>
    </block> -->
  </view>
  <!-- block 与 view 不同，block 不会在 DOM 中体现 ，这里 block 只是做循环用的-->
</template>
<script>
  methods = {
      toPageGrid(level,e) {
        // 这里的的 路径不要搞错
        let urlStr = './grid?level=' + level
        // ES6 字符串模板 let urlStr = `./grid?level=${level}`
        wx.navigateTo({
          url: urlStr
        })
      }
  };
</script>
```

##### 7.6.4 获取 url 的传值

[获取 url 的传值](https://blog.csdn.net/qq_35909852/article/details/78956820)，注意这里是小程序的传值，不是 web 中 js 的传值，因此这个链接也有告诉我们分二者的传值。

```JS
// WEB 中的取值
 function getUrlParam(name){
         // 获取参数
        var url = window.location.search;
          // 正则筛选地址栏
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
          // 匹配目标参数
        var result = url.substr(1).match(reg);
         //返回参数值
     return result ? decodeURIComponent(result[2]) : null;
 },
```

```HTML
<template>
</template>
<script>
// 小程序取值
  onLoad(options) {
    // 小程序获取 url 传值：options 就是传过来的对象
    // let urlStr = './grid?level=' + e.currentTarget.dataset.level + '&id=3'  结果：{level: "1", id: "3"}
    // let urlStr = './grid?level=' + e.currentTarget.dataset.level  结果：{level: "1"}
    this.level = options.level
  }
</script>
```

### 7.7 本地存储-页面传值

```JS
// A 组件 存值
wepy.setStorageSync('level',level)
```

```JS
// B 组件 取值
wepy.getStorageSync('level')
```

### 7.8 全局属性传值

```js
// app.wepy
 globalData = {
    userInfo: null,
    level:1
  };
```

```JS
// pages 取值
this.$parent.globalData.level
```

### 7.9 正向传值 与 反向传值

#### 7.9.1 本次存储

```JS
// 正向传值：pagesA=>pagesB   !!!!!!!!!!!!!!!!!!!!!!!!!
// A 组件 存值
wepy.setStorageSync('level',2)

// B 组件 取值
wepy.getStorageSync('level') //2
```

```JS
// 反向传值：pagesB=>pagesA   !!!!!!!!!!!!!!!!!!!!!!!!!
// B 组件 存值
wepy.setStorageSync('level',5)
wepy.navigatorBack() // 返回上一页面

// A 组件 取值
onshow(){
  wepy.getStorageSync('level') //5
}
```

#### 7.9.2 APP 全局属性

```js
// 正向传值：app=>pages     !!!!!!!!!!!!!!!!!
// app.wepy 存储
 globalData = {
    userInfo: null,
    level:1
  };

// pages 取值
this.$parent.globalData.level
```

```js
// 反向传值：pagesA=>pagesB   !!!!!!!!!!!!!!!!!!!!!!!!!
// pagesA 存贮
this.$parent.globalData.level=2

// pagesB 取值
this.$parent.globalData.level=2
```

## 八、wepy 中的指令 以及 class 动态操作

### 8.1 class 的动态绑定

```HTML
<div class="class-a" :class="{true ? 'class-b': 'class-c'}"></div> <!-- 在vue中动态绑定class -->
```

```HTML
<!-- 在wepy中，要使用微信原生的绑定语法
其中 class-a 是不需要动态绑定的class， 双括号中才是需要绑定的class -->
<view class="class-a {{true ? 'class-b' : 'class-c'}}">
```

#### 8.1.1 单双引号的问题，外面单引号里面就双引号啊！！！！！！！！

```HTML
<view class='grid'>
  <view class='grid-row {{index % 3 == 0 ? 'grid-row-index' : ''}}' wx:for-items="{{grids}}" wx:for-index="index" wx:for-item="items" wx:key="index">
    <view class='grid-col {{index % 3 == 0 ? 'grid-col-index' : ''}}' wx:for-items="{{items}}" wx:for-index="index" wx:for-item="item" wx:key="index">
      <text>{{item}}</text>
    </view>
  </view>
</view>
```

```BASH
[Error] ERROR IN : src\pages\grid.wpy
[xmldom error]  element parse error: Error: attribute value must after "="
@#[line:26,col:9]
```

![t](http://liuxmoo.foryung.com/%25LSU9@E1W$TP~%5B4_BARDH@P.png)

错误解决：上面控制台说出了是单双引号的问题，命令行指出了 = 号的问题，是算是一个等号。注意这里一定要外面是双引号，里面是单引号，不然会出错的！！！！！！！！！！！！！！！！！！！！！！！！！！重要，重要，重要，更新如下

```HTML
<view class='grid'>
  <view class="grid-row {{index % 3 == 0 ? 'grid-row-index' : ''}}" wx:for-items="{{grids}}" wx:for-index="index" wx:for-item="items" wx:key="index">
    <view class="grid-col {{index % 3 == 0 ? 'grid-col-index' : ''}}" wx:for-items="{{items}}" wx:for-index="index" wx:for-item="item" wx:key="index">
      <text>{{item}}</text>
    </view>
  </view>
</view>
```

### 8.2

### 8.2 wx：for 与 repeat 循环渲染组件

当想在wx:for中使用组件时，需要使用辅助标签<repeat>？？？？有子组件的时候采用 repeat 把？？、其他的时候用 原生的 view 都可以的把。

wepy的循环渲染组件，使用 `<repeat/>`标签（1.4.6 版本新增），或者微信官方的<block/>标签(这两个标签不会渲染到视图层）否则就不会渲染成功。（但是用 view 与 wx：for 我成功了呀？？？？） 是不是说有子组件的时候使用 repeat 呀？？？？

```HTML
<!-- # wepy 提供的repeat组件 -->
<view class="movie" wx:if="{{movies}}">
  <repeat for="{{movies}}" key="index" index="index" item="item">
    <movie :movie.sync="item"></movie>
  </repeat>
</view>
```

```HTML
<!-- # 微信提供的block组件 -->
<block wx:for="{{imgArr}}" wx:key="index">
  <swiper-item class="item" data-movieId="{{item.id}}" @tap="showMovieDetail">
    <image class="img" src="{{item.img || item.image}}"></image>
  </swiper-item>
</block>
```

#### 8.2.1 问题？ 与 navigator 标签是怎么用的，

```HTML
 <view class='levels'>
   <block for="{{levels}}" key="index" index="index" item="level">
     <navigator clas='level' url='./grid?level={{level}}' open-type="navigate">
       <text>{{level}}</text>
       {{level}}
       这里怎么就不对呢？？？字怎么就不出来了，2 种办法都不出来，navigator 标签中部允许有字？？？？
     </navigator>
   </block>
 </view>
```

#### 8.2.2 存在的问题

WePY 1.x 版本中，组件使用的是静态编译组件，即组件是在编译阶段编译进页面的，每个组件都是唯一的一个实例，目前只提供简单的 repeat 支持。不支持在 repeat 的组件中去使用 props, computed, watch 等等特性。

```HTML
 <!-- 错误使用
 list.wpy -->
<view>{{test.name}}</view>

<!-- // index.wpy -->
<repeat for="{{mylist}}">
   <!-- 不要在 repeat 标签中使用 修饰 .sync -->
   <List :test.sync="item"></List>
</repeat>
```

```HTML
<!-- 推荐用法 // list.wpy -->
<repeat for="{{mylist}}">
    <view>{{item.name}}</view>
</repeat>

<!-- // index.wpy -->
<List :mylist.sync="mylist"></List>
```

### 自定义事件

1.4.8新增
可以使用@customEvent.user绑定用户自定义组件事件。其中，@表示事件修饰符，customEvent表示事件名称，.user表示事件后缀。
目前有三种后缀：

.default: 绑定小程序冒泡事件事件，如bindtap。

.stop: 绑定小程序非冒泡事件，如catchtap。

.user: 绑定用户自定义组件事件，通过$emit触发。

## 九、项目编辑过程中的问题与优化

### 9.1 后台报错的问题

#### 9.1.1 后台 VM17809:2 tabBar[0].pagePath  tabBar[1].pagePath 报错

```BASH
VM17809:2 tabBar[0].pagePath "pages/index/index" 需在 pages 数组中
tabBar[1].pagePath "pages/logs/logs" 需在 pages 数组中
```

因为 页面与配置不匹配。

app.wpy 中 的 config 对象中的 pages 与 tabBar 要对应起来，路径也不要出错。

#### 9.1.2  unclosed xml attribute 没有闭标签

```BASH
unclosed xml attribute # 没有闭标签
# 这个错误，就是我们复制粘贴的时候不小心，我们而且编辑器也不会提醒我们错误，如果是少了标签 斜杠，倒是简单，像上面的，其实是多了一个`</view>` 标签，都没有发现。
# 其实只要格式化页面，也比较好看出是多了呀一个标签。
```

### 9.2 less  与 css 的运用问题

#### 9.2.1 让小程序高度 100%

```CSS
/*在 app.wpy 文件中使用如下，这样所有的页面都是占据 100% 高度了
然后就占满了，当然还有顶部与底部是导航栏的。*/
page {
  height: 100%;
}
```

#### 9.2.2 让小程序高度==宽度

```less
//css 原生
.grid-col {
  width: 10%;
  height: 10vw;
  line-height: 10vw;
}

// 这里是  less， less 中关于运行的，都要使用 ~'' 括起来，
// 包括 calc 的公式运行，具体看 less 与 calc 这篇文章。
.grid-col {
  width: 10%;
  height: ~'10vw';
  line-height: ~'10vw';
}
```

### 9.3 第三方成熟 IDE 或编辑器-代码高亮

wepy-cli 框架的项目文件后缀为 .wpy，可共用 Vue（.vue）的高亮规则，但需要手动设置。下面提供一些常见IDE或编辑器中实现代码高亮的相关设置步骤以供参考(也可通过更改文件后缀名的方式来实现高亮，详见后文相关介绍)。

￥第三方成熟 IDE 或编辑器-代码高亮

wepy-cli 框架的项目文件后缀为 .wpy，可共用 Vue（.vue）的高亮规则，但需要手动设置。下面提供一些常见IDE或编辑器中实现代码高亮的相关设置步骤以供参考(也可通过更改文件后缀名的方式来实现高亮，详见后文相关介绍)。

#### 4.3.1 WebStorm/PhpStorm

  1. 打开 Settings，搜索 Plugins，搜索 Vue.js 插件并安装。
  2. 打开 Settings，搜索 File Types，找到 Vue.js Template，在 Registered Patterns 添加 *.wpy，即可高亮。

#### 4.3.2 VS Code

  1. 在 Code 里先安装 Vue 的语法高亮插件 Vetur。
  2. 打开任意 .wpy 文件。
  3. 点击右下角的选择语言模式，默认为纯文本。
  4. 在弹出的窗口中选择 .wpy 的配置文件关联...。(注意是灰色字体部分，不要去选择有颜色的 VUE，这样只是单个文件的语言选择)
  5. 在选择要与 .wpy 关联的语言模式 中选择 Vue。(注意是灰色字体部分，不要去选择有颜色的 VUE，这样只是单个文件的语言选择)

或者我们直接在在 vscode 编辑器设置中去设置。"*.wpy": "vue"

```JSON
//文件-首选项-设置-settings.json
settings.json
"files.associations": {
"*.wpy": "vue"
}
```

#### 4.3.3 Sublime

  1. 打开 Sublime->Preferences->Browse Packages..进入用户包文件夹。
  2. 在此文件夹下打开 cmd，运行 git clone git@github.com:vuejs/vue-syntax-highlight.git，无 GIT 用户可以直接下载 zip 包解压至当前文件夹。
  3. 关闭 .wpy 文件重新打开即可高亮。

其他的第三方编辑器查看官网介绍

### 9.4 wepy 框架中 自动补全的问题：minapp 插件

[minapp 插件](https://github.com/wx-minapp/minapp-vscode)

在 .wpy 文件中 的 `<template>` 开标签中使用如 `<template lang='wxml' minapp='wepy'>` 这样就可以自动补全了。不过要注意的是自动补全需要先打尖括号 `<` 输入标签名，这样才能补全的。

#### 9.4.1 使用 lang='wxml' minapp='wepy' 发生的问题

发现使用了这个之后，文件就不能使用 `shift + alt + f` 来格式化了。

### 9.5 API 接口使用的是 wpy 而不是 wx

wepy 框架中 wepy 继承了 mina 框架中 wx 对象的方法，因此在 wepy 框架中，所有的 API 都使用 wepy.

### 9.6 使用 async/await 的使用方式, 

需要开启 Promise 和 async/await 支持

```JS
// 原生代码:
wx.request({
    url: 'xxx',
    success: function (data) {
        console.log(data);
    }
});

// WePY 使用方式, 需要开启 Promise 支持，参考开发规范章节
wepy.request('xxxx').then((d) => console.log(d));
// async/await 的使用方式, 需要开启 Promise 和 async/await 支持，参考 WIKI
async function request () {
   let d = await wepy.request('xxxxx');
   console.log(d);
}
```

## 十、代码规范

### 10.1 变量 方法 驼峰式命名，并且注意避免使用 $ 开头。

以 $ 开头的标识符为 WePY 框架的内建属性和方法（可在 JavaScript 脚本中以 this. 的方式直接使用，具体请参考 API 文档。） 用 $ 符号会让自己的代码很乱。也不好区分是 变量名/方法名 还是 内建 API

### 10.2 小程序入口、页面、组件文件名的后缀为 .wpy；外链的文件可以是其它后缀。

具体请参考 wpy 文件说明。

### 10.3  使用 ES6 语法开发。

框架在 ES6(ECMAScript 6) 下开发，因此也需要使用 ES6 开发小程序，ES6 中有大量的语法糖可以让我们的代码更加简洁高效。

- 使用 Promise。 框架默认对小程序提供的 API 全都进行了 Promise 处理，甚至可以直接使用 async/await 等新特性进行开发。启用 Promise方法

### 10.4 事件绑定语法使用优化语法代替。 `@tap="click"` `@tap.stop="click"` 简化写法

    原 bindtap="click" 替换为 @tap="click"，原 catchtap="click" 替换为 @tap.stop="click"。
    原 capture-bind:tap="click" 替换为 @tap.capture="click"，原 capture-catch:tap="click" 替换为@tap.capture.stop="click"。
    更多 @ 符用法，参见组件自定义事件。
    事件传参使用优化后语法代替。 原 bindtap="click" data-index={{index}} 替换为 @tap="click({{index}})"。

### 10.4 自定义组件命名应 避开 微信原生组件名称以及功能标签 `<repeat>`。

不可以使用 input、button、view、repeat 等微信小程序原生组件名称命名自定义组件；另外也不要使用 WePY 框架定义的辅助标签 repeat 命名。有关 repeat 的详细信息，请参见循环列表组件引用。

### 10.5 事件名不要重复，不同页面也不要重复

原生小程序支持js模块化，但彼此独立，业务代码与交互事件仍需在页面处理。无法实现组件化的松耦合与复用的效果。

例如模板A中绑定一个bindtap="myclick"，模板B中同样绑定一样bindtap="myclick"，那么就会影响同一个页面事件。对于数据同样如此。因此，只有通过改变变量或者事件方法，或者给其加不同前缀才能实现绑定不同事件或者不同数据。当页面复杂之后就十分不利于开发维护。

## 十五、坑 与自己的放错

### 15.1 js 中的逗号，分号，错误，导致 js 代码无法格式化，代码也无法运行

```BASH
[Error] SyntaxError: unknown: Unexpected token, expected , (181:4)
  179 |     }
  180 |     # 这里缺少 , 号
> 181 |     del() {
      |     ^
  182 |       this.grids[rowIndex][colIndex] == 0
  183 |       this.$apply()
  184 |     }
  # 当发现自己的 js 代码无法格式化的话，就是自己的代码的逗号缺少或者是分号乱放了，看控制台或者是命令行有报错提示。
```

### 15.2 数据类型不对 data 中的数据给弄错了

```BASH
thirdScriptError
Cannot read property 'push' of null;at pages/grid page goBack function
TypeError: Cannot read property 'push' of null
    at _class.goBack (http://127.0.0.1:53324/appservice/pages/grid.js:209:24)
    at t.config.(anonymous function) (http://127.0.0.1:53324/appservice/npm/wepy/lib/bas
```

```JS
  data={
    fillArray:{
      rowIndex: null,
      colIndex: null,
      value: null
    },
    delArray: {
      rowIndex: null,
      colIndex: null,
      value: null
    }
  // 这里的数据设置成 对象了，怎么可以对一个 对象 中 push 元素呢。
  }
  goBack() {
    let backCellObj = this.fillArray.pop();
    if (backCellObj) {
      let rowIndex = backCellObj.colIndex;
      let colIndex = backCellObj.colIndex;
      this.currentCell.currentCellRowIndex = rowIndex;
      this.currentCell.currentCellColIndex = colIndex;
      this.grids[rowIndex][colIndex] = 0;
      this.delArray.push(backCellObj);// push
    }
 }
```

### 重复路由设置/链接 跳转错误 VM292910:1 appLaunch with an already exist webviewId 4542

```BASH
VM292910:1 appLaunch with an already exist webviewId 4542
```

答案解析：[网址](http://code.sike.wang/xcx/show-3162.html)

```JS
//在 onLoad 的函数里面先实现了 navigateTo，再实现 redirectTo 就会报错。
// 它们功能是一样的，这是一个 压入栈 可以返回一个不可以返回，不能两个都用
onLoad(){
  wx.navigateTo({
    url:'./page1'
  })
  wx.redirectTo({
    url:'./page2'
  })
}

// 下面这样也是错误的。因为 onLoad 的执行顺序比 onReady 优先。
onLoad(){
  wx.navigateTo({
    url:'./page1'
  })
}
onReady(){
  wx.redirectTo({
    url:'./page2'
  })
}

// 这样写就对了，先实现了redirectTo，再实现navigateTo就不会报这个错误。 为啥？？？？？
  wx.redirectTo({
    url:'./page2'
  })
  wx.navigateTo({
    url:'./page1'
  })


// 或者路由重复设置并不是写在一个页面中，是否在 app.js 中重复写了路由设置，链接跳转了、

//如果不是上面的原因，就是把微信开发者工具的IDE关闭重新启动就可以了，目前微信开发者工具的IDE实在是不够完善，也会存在一些未知的问题，所以以后如果遇到一些奇怪的问题，或者实在找不到原因的，就直接重启微信开发者工具试试。
```

#### 微信开发者工具 预览  真机测试

预览的效果是不全的，调试的话还是使用真机测试，就比如说有的时候 class 是三元表达式动态绑定的，仅仅是预览的话效果可能不会表现出来，但是实际上功能已经做好了，就是预览没有把自己完整的代码上传，而真机测试是完整的代码。

类似 问题的 [gitHub 网址](https://github.com/Tencent/wepy/issues/1669)，就是开启了代码上传 自动压缩，那么有部分代码可能就不会得到上传，自然效果就不会出来了。