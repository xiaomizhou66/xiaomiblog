---
title: 'vuex 实际应用-web Storage全面认知与使用(localStorage,sessionStorage)'
date: '2018/8/28 10:35:25'
tags:
categories: 3-④ vuex 状态管理
abbrlink: b08890bf
updated:
comments:
---

## 一、前言

要使用vuex管理后端数据，首先要学习JavaScript如何 *获取 存贮* 后端数据。获取后端数据应去学习分类:[⑧axios前后端数据交互](http://liuxmoo.gofoer.com/categories/%E2%91%A7axios%E5%89%8D%E5%90%8E%E7%AB%AF%E6%95%B0%E6%8D%AE%E4%BA%A4%E4%BA%92/)，本文学习  *localStorage*  与  *vuex管理localStorage本地存储的数据 *。<br/>
第一阶段，什么是web存储机制。
第二阶段，localStorage如何使用
第三阶段，使用vuex管理localStorage本地存储的数据


## 二、什么是web存储机制 

### 1、web存储 Web Storage
<br/>
在JavaScript高级程序设计Nicholas C.Zakas著，李松峰译书中是这样解释的:
> Web Storage 最早是在 Web 超文本应用技术工作组（WHAT-WG）的 Web 应用 1.0 规范中描述的。这个规范的最初的工作最终成为了 HTML5 的一部分。Web Storage 的目的是克服由 cookie 带来的一些限制，当数据需要被严格控制在客户端上时，无须持续地将数据发回服务器。Web Storage 的两个主要目标是：
◆  提供一种在 cookie 之外存储会话数据的途径；
◆  提供一种存储大量可以跨会话存在的数据的机制。<br/>
&nbsp;&nbsp;&nbsp;&nbsp;最初的 Web Storage 规范包含了两种对象的定义： sessionStorage 和 globalStorage 这两个对象在支持的浏览器中都是以 windows 对象属性的形式存在的.后来修订之后的html5用localStorage对象取代了globalStorage对象。

**通俗一点解析**
- cookie是早期的数据存储机制 html4

  cookie指某些网站为了**辨别用户身份**而**储存在用户本地终端**(Client Side)上的数据（通常经过加密。需要深入了解cookie可以查看：[维基百科](https://zh.wikipedia.org/wiki/Cookie)
- Web Storage/sessionStorage/localStorage新数据存储机制 html5

  由于cookie的局限性，后来就在html5中添加了Web Storage存储机制。Web Storage包含了两种对sessionStorage对象与localStorage对象。

<br/>

### 2、cookie与session  HTML4的本地存储详解详解 

<br/>

浏览器有缓存机制，这个机制提供了可以将用户数据存储在客户端上的方式，可以利用cookie,session等跟服务端进行数据交互。
cookie和session都是用来跟踪浏览器用户身份的会话方式。


**区别：**
1. 保存状态：cookie保存在浏览器端，session保存在服务器端
2. 使用方式：
（1）cookie机制：如果不在浏览器中设置过期时间，cookie被保存在内存中，生命周期随浏览器的关闭而结束，这种cookie简称会话cookie。如果在浏览器中设置了cookie的过期时间，cookie被保存在硬盘中，关闭浏览器后，cookie数据仍然存在，直到过期时间结束才消失。Cookie是服务器发给客户端的特殊信息，cookie是以文本的方式保存在客户端，每次请求时都带上它<br/>
（2）session机制：当服务器收到请求需要创建session对象时，首先会检查客户端请求中是否包含sessionid。如果有sessionid，服务器将根据该id返回对应session对象。如果客户端请求中没有sessionid，服务器会创建新的session对象，并把sessionid在本次响应中返回给客户端通常使用cookie方式存储sessionid到客户端，在交互中浏览器按照规则将sessionid发送给服务器。如果用户禁用cookie，则要使用URL重写，可以通过response.encodeURL(url) 进行实现；API对encodeURL的结束为，当浏览器支持Cookie时，url不做任何处理；当浏览器不支持Cookie的时候，将会重写URL将SessionID拼接到访问地址后。<br/>
3. 存储内容：cookie只能保存字符串类型，以文本的方式；session通过类似与Hashtable的数据结构来保存，能支持任何类型的对象(session中可含有多个对象)
4. 存储的大小：cookie：单个cookie保存的数据不能超过4kb；session大小没有限制。
5. 安全性：cookie：针对cookie所存在的攻击：Cookie欺骗，Cookie截获；session的安全性大于cookie。
（1）sessionID存储在cookie中，若要攻破session首先要攻破cookie；
（2）sessionID是要有人登录，或者启动session_start才会有，所以攻破cookie也不一定能得到sessionID；
（3）第二次启动session_start后，前一次的sessionID就是失效了，session过期后，sessionID也随之失效。
（4）sessionID是加密的
（5）综上所述，攻击者必须在短时间内攻破加密的sessionID，这很难。
6. 应用场景：
cookie：
（1）判断用户是否登陆过网站，以便下次登录时能够实现自动登录（或者记住密码）。如果我们删除cookie，则每次登录必须从新填写登录的相关信息。
（2）保存上次登录的时间等信息。
（3）保存上次查看的页面
（4）浏览计数
session：Session用于保存每个用户的专用信息，变量的值保存在服务器端，通过SessionID来区分不同的客户。
（1）网上商城中的购物车
（2）保存用户登录信息
（3）将某些数据放入session中，供同一用户的不同页面使用
（4）防止用户非法登录
7. 缺点：
 cookie：
（1）大小受限
（2）用户可以操作（禁用）cookie，使功能受限
（3）安全性较低
（4）有些状态不可能保存在客户端。
（5）每次访问都要传送cookie给服务器，浪费带宽。
（6）cookie数据有路径（path）的概念，可以限制cookie只属于某个路径下。
session：
（1）Session保存的东西越多，就越占用服务器内存，对于用户在线人数较多的网站，服务器的内存压力会比较大。
（2）依赖于cookie（sessionID保存在cookie），如果禁用cookie，则要使用URL重写，不安全
（3）创建Session变量有很大的随意性，可随时调用，不需要开发者做精确地处理，所以，过度使用session变量将会导致代码不可读而且不好维护。
<br/>
### 3、Web Storage（sessionStorage和localStorage）解释及区别 HTML5的本地存储详解 

<br/>

sessionStorage和localStorage都是html5中Web Storage 规范的对象，拥有一样的方法或属性，即可使用的API都相同。
- 保存数据：localStorage.setItem(key,value);-sessionStorage.setItem(key,value); 
- 读取数据：localStorage.getItem(key); ——————sessionStorage.getItem(key); 
- 删除单个数据：localStorage.removeItem(key);-sessionStorage.removeItem(key);
- 删除所有数据：localStorage.clear();  ———————sessionStorage.clear(); 
- 得到某个索引的key：localStorage.key(index);-sessionStorage.key(index);<br/>

**异同：**
1. 保持状态：
- sessionStorage将数据 **暂时** 保存在客户端本地(本地磁盘)的
通俗一点就是说：session，是指用户在浏览某个网站时，从进入网站到浏览器关闭所经过的这段时间，也就是用户浏览这个网站所花费的时间。session对象可以用来保存在这段时间内所要求保存的任何数据。浏览器关掉了数据就没有了（当然了如果浏览器非正常关闭，崩溃重启这些数据可以恢复）
这里需要知道sessionStorage与前面的session不是一个东西，session是后端对象(配合cookie使用)，sessionStorage是前端对象。
- localStorage则将数据 **永久** 保存在客户端本地(本地磁盘)
通俗一点说：local嘛就是本地的意思。将数据保存在客户端本地的硬件设备(通常指硬盘，也可以是其他硬件设备)中，即使浏览器被关闭了，该数据仍然存在，下次打开浏览器访问网站时仍然可以继续使用。<br/>
一句话概括：sessionStorage为临时保存/回话存储，而localStorage为永久保存。localStorage与sessionStorage的唯一一点区别就是localStorage属于永久性存储，而sessionStorage属于当会话结束的时候，sessionStorage中的键值对会被清空
2. 生命周期：
（1）localStorage的生命周期是永久的，关闭页面或浏览器之后localStorage中的数据也不会消失。localStorage除非主动删除数据，否则数据永远不会消失。<br/> 
（2）sessionStorage的生命周期是在仅在当前会话下有效。sessionStorage引入了一个“浏览器窗口”的概念，sessionStorage是在同源的窗口中始终存在的数据。只要这个浏览器窗口没有关闭，即使刷新页面或者进入同源另一个页面，数据依然存在。但是sessionStorage在关闭了浏览器窗口后就会被销毁。同时独立的打开同一个窗口同一个页面，sessionStorage也是不一样的。<br/>
3. 存储大小：localStorage和sessionStorage的存储数据大小一般都是：5MB。
4. 存储位置：localStorage和sessionStorage都保存在客户端，不与服务器进行交互通信。
4. 存储内容类型：localStorage和sessionStorage只能存储字符串类型，对于复杂的对象可以使用ECMAScript提供的JSON对象的stringify和parse来处理
4. 获取方式：都是window下的对象
window.localStorage;
window.sessionStorage;
4. 应用场景：
localStoragese：常用于长期登录（+判断用户是否已登录），适合长期保存在本地的数据。
sessionStorage：敏感账号一次性登录

### 4、cookie 与 Web Storage（sessionStorage和localStorage）的区别详解

| 特性 | cookie | sessionStorage | localStorage |
| :----: | :----: |:----: |:----: |
| 数据生命周期 | 就会被指定一个maxAge值这就是cookie的生存周期，在这个周期内cookie有效,默认关闭浏览器失效| 页面会话期间可用| 除非数据被清除,否则-直存在|
| 存放数据大小 | 4K左右(因为每次http请求都会携带cookie )|同右 |  一般5M或更大详细看这(需科学，上网)| 
| 与服务器通信 | 由对服务器的请求来传递，每次都会携带在HTTP头中，如果使用cookie保存过多数据会带来性能问题|同右|  数据不是由每个服务器请求传递的，而是只有在请求时使用数据,不参与和服务器的通信| 
| 易用性 | cookie需要自己封装setCookie , getCookie | 同右  | 可以用源生接口,也可再次封装来对Object和Array有更好的支持|
| 共同点 | 都是保存在浏览器端,和服务器端的session机制不同   |  同左 | 同左 |
&nbsp;
## 三、localStorage的具体使用

经过上面的比较，我们知道cookie是浏览器提供的缓存，sessionStorage是会话存储，localStorage是永久存储。在使用vue做前端的时候，我们是要从后端获取的信息永久的保存在本地，提供我们使用。

### 1、localStorage的方法/属性

在第二节的中列出了localStorage的方法/属性，这些可以是API接口，也可以作为属性使用。** 但是浏览器不兼容这些属性，还是用方法比较妥当。**

- 保存数据：localStorage.setItem(key,value);-localStorage.key=value
- 读取数据：localStorage.getItem(key); ——————localStorage.key
- 删除单个数据：localStorage.removeItem(key);-delete localStorage.key
- 删除所有数据：localStorage.clear();  ———————
- 得到某个索引的key：localStorage.key(index);-

### 2、localStorage的优势与局限

学习localStorage之前先更详细的了解它优势与劣势。
>localStorage的优势
1、localStorage拓展了cookie的4K限制
2、localStorage会可以将第一次请求的数据直接存储到本地，这个相当于一个5M大小的针对于前端页面的数据库，相比于cookie可以节约带宽，但是这个却是只有在高版本的浏览器中才支持的
>&nbsp;&nbsp;&nbsp;&nbsp;localStorage的局限
1、浏览器的大小不统一，并且在IE8以上的IE版本才支持localStorage这个属性
2、目前所有的浏览器中都会把localStorage的值类型限定为string类型，这个在对我们日常比较常见的JSON对象类型需要一些转换
3、localStorage在浏览器的隐私模式下面是不可读取的
4、localStorage本质上是对字符串的读取，如果存储内容多的话会消耗内存空间，会导致页面变卡
5、localStorage不能被爬虫抓取到

### 3、保存数据localStorage.setItem(key,value)之localStorage的方法具体应用

在登录界面，使用axios向后端发送用户填写的用户名密码等信息，获取后端返货的数据。在这里使用localStorage来保存获取的数据，提供后续使用。通常需要保存的是后端设置的 token。 关于token可以学习:[cookie、session、token三者差异详解](http://liuxmoo.gofoer.com/2018/08/12/3-js1/)

如下登录页面中我们点击登录如果成功我们希望跳转主页，并且把个人信息展示在主页，如果没有获取token是没有办法获取后端存储的数据的。通俗一点说就是获得token通行证就过不了这个关。
![登录页面](http://liuxmoo.foryung.com/login.png)

```html
<!-- 登录按钮绑定点击事件触发dologin函数方法 -->
 <el-button
    type="primary"
    class="my-login"
    @click="dologin">登录
</el-button>
```

```js
<script>
export default {
  name: 'Home',
  data () {
    return {
      user: {
        username: '',
        email: '',
        password: ''
      },
      activeName: 'first'
    }
  },
  methods: {
    /* 这里是切换用户名/邮箱登录 */
    handleClick (tab, event) {
      console.log(tab, event)
    },
    /* 登录方法 */
    dologin () {
      var vm = this
      vm.axios.post('/v1/login', vm.user)
        .then(function (response) {
          window.localStorage.setItem('token', response.data.token)
          vm.$router.push('/home')
        }).catch(function (response) {
          if (vm.activeName === 'first') { vm.$message.error('用户名或者密码错误')
          } else {
            vm.$message.error('邮箱或者密码错误')
          }
        })
    }
  }
}
```

```js
    /* 由于不是所有浏览器都支持localStorage对象（ie8以下就不支持），
      如果需要兼容低版本的，需要判断浏览器是否存在这个对象属性，存在才可以使用*/
      if (window.localStorage) {
        var storage = window.localStorage
        storage.xiaomi = 'xiaomi'
      } else {
        alert('浏览器不支持localstorage')
        return false
      }
```

### 4、读取数据localStorage.getItem(key)之localStorage的方法具体应用

在上面代码中我们已经通过 ` window.localStorage.setItem('token', response.data.token)` 将token保存在localStorage中.在home主页我们就可以通过使用这个token来获取信息展示在页面上了。

```html
<!--给头像绑定js数据userInfo.imgURL 以下代码均为提取双向绑定了数据的代码，其他代码不展示-->
<img
   :src="userInfo.imgURL"
   style="width:40px;
   height:40px;
   border-radius:40px;"/>
<!--给表格的各行各单元格绑定数据 -->
   <template slot-scope="scope">{{ getShortTime(scope.row.createAt) }}</template>
   <template slot-scope="scope">{{ getShortName(scope.row.name) }}</template>
   <template
      v-if="!scope.row.isDir"
      slot-scope="scope">{{ getShortSize(scope.row.size) }}</template>
```

```js
<script>
export default {
  name: 'Home',
  data () {
    return {
      isfit: true,//是否是文件夹？
      userInfo: { //用户个人信息userTnfo
        'id': '',
        'username': '',
        'email': '',
        'phone': '',
        'isAdmin': false,
        'permit': '',
        'imgURL': '',
        'aliPlay': '',
        'capacity': '',
        'use': 0,
        'root': ''
      },
      input5: '',
      select: '',
      tableData3: [ //用户存储文件
        {
          'id': '',
          'label': '',
          'download': 0,
          'visit': 0,
          'remark': '',
          'name': '',
          'size': 0,
          'type': '',
          'isDir': false,
          'createAt': '',
          'updateAt': '',
          'belong': '',
          'uri': '',
          'kodeID': '',
          'parentID': '',
          'share': false
        }
      ],
      multipleSelection: []
    }
  },
  mounted () {
    var vm = this
    vm.getusermassage() //挂载时获取用户个人信息
    vm.getfiles()//挂载时获取用户存储文件
  },
  methods: {
    getShortTime (time) {
    },
    getShortName (name) {
    },
    getShortSize (size) {
    },
    //获取用户个人信息方法
    getusermassage () {
      var config = {
        headers: {
          'Authorization': window.localStorage.getItem('token')
        }
      }
      var vm = this
      vm.axios.get('/v1/account/profile', config)
        .then(function (response) {
          vm.userInfo = response.data
        })
        .catch(function (response) {
        })
    },
    /* 获取用户个人存储文件方法*/
    getfiles () {
      //定义请求头headers
      var config = {
        headers: {
          'Authorization': window.localStorage.getItem('token')
        }
      }
      var vm = this
      vm.axios.get('/v1/account/storage/files', config)
        .then(function (response) {
          vm.tableData3 = response.data
        })
        .catch(function (response) {
        })
    }
  }
}
</script>
```

在上面的代码中，我们使用`window.localStorage.getItem('token')`来读取信息获取token值，使用get方法传递给后端，后端验证通过将用户的信息反馈回来，前端才可以把获得的信息绑定给前端展示。

注意到我们使用在如下代码，将读取的数据赋值给config再使用axios传递给后端，

```TEXT
//定义请求头headers
      var config = {
        headers: {
          'Authorization': window.localStorage.getItem('token')
        }
      }
      vm.axios.get('/v1/account/storage/files', config)
```

![headers请求头](http://liuxmoo.foryung.com/postman.png)
请求头headers学习: [Google之Postman小工具](http://liuxmoo.gofoer.com/2018/08/12/00-others-postman/) 这里是谷歌浏览器的Postman，其他浏览器请学习相应的浏览器工具
请求头headers学习: [HTTP学习](http://liuxmoo.gofoer.com/2018/08/15/13-http/),要知道它是如何工作的，要弄懂，可以先去学些http协议。

### 5、删除单个数据localStorage.removeItem(key)之localStorage的方法具体应用

### 6、删除所有数据localStorage.clear()之localStorage的方法具体应用

### 7、得到某个索引的key值localStorage.key(index)之localStorage的方法具体应用

##  四、vuex管理localStorage本地存储的数据

通过第三章的学习，我们发现会有很多地方使用到localStorage存储的数据，我们会在许多地方使用到它的方法，这使得我们的代码复杂化，臃肿了很多，本章将学习使用vuex管理localStorage存储的状态值，简化代码，事半功倍。
