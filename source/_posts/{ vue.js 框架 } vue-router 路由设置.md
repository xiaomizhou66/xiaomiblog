---
title: 'vue-router--[小白入门篇、速学篇]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue-router 路由设置
abbrlink: 22ffafd4
updated:
tags:
comments:
---
## 前言

Vue Router 是 Vue.js 官方的路由管理器。它和 Vue.js 的核心深度集成，让构建单页面应用变得易如反掌。

**包含的功能有：**

- 嵌套的路由/视图表
- 模块化的、基于组件的路由配置
- 路由参数、查询、通配符
- 基于 Vue.js 过渡系统的视图过渡效果
- 细粒度的导航控制
- 带有自动激活的 CSS class 的链接
- HTML5 历史模式或 hash 模式，在 IE9 中自动降级
- 自定义的滚动条行为


[官网地址](https://router.vuejs.org/zh/guide/essentials/navigation.html)

## 二、安装

### 2.1 npm安装

**步骤①：下载 vue-router**

```bash
  cnpm install vue-router
```

**步骤②：引入 vue-router**

如果在一个模块化工程中使用它，必须要通过 Vue.use() 手动引入/明确地安装路由功能：

```js
    //在 src/router 文件夹下的 index.js 路由设置文件中引入 vue-router
    import Vue from 'vue'
    import Router from 'vue-router'

    Vue.use(Router)
```

在创建 vue 项目`vue init webpack my-project` 的时候有选项是否选择安装 vue-router ,如果已经选择安装，在index.js 中已经存在了。只需要使用即可

### 2.2 CDN 安装（可以控制版本）

[CDN链接：](https://www.bootcdn.cn/vue-router/)如下引入 vue-router.js，这样 vue-router 会被注册为一个全局变量，不需要再手动引入。

```JS
<script src="https://cdn.bootcss.com/vue-router/3.0.1/vue-router.js"></script>
```

### 2.3 独立版本引入

官网下载文件放置在项目目录下。如下引入 vue-router.js，这样 vue-router 会被注册为一个全局变量，不需要再手动引入。

```JS
<script src="./vue-router.js"></script>
```

## 三、vue-router 工作原理

用 Vue.js + Vue Router 创建单页应用，是非常简单的。使用 Vue.js ，我们已经可以通过组合组件来组成应用程序，当你要把 Vue Router 添加进来，我们需要做的是，将组件 (components) 映射到路由 (routes)，然后告诉 Vue Router 在哪里渲染它们。

入口页面                    index.html                  id=app  
入口页面对应的 js 文件，     main.js          new Vue（el：APP）
入口页面 js 文件对应的组件   APP.vue        template script（export default） style
路由设置：router 文件夹下的  index.js   export default new Router
路由对应的组件：component 文件夹下的  HelloWorld.vue  template script（export default） style

以下是 vue-cli 框架中使用 vue-router 的示例解析：

### 3.1 **安装 vue-router**

根据第二章给项目安装 vue-router

### 3.2 **app.vue 文件：父组件设置路由出口**

**app.vue 文件**

```html
<template>
  <div id="app">
    <h1>Hello App!</h1>
    <p>
      <!-- 使用 router-link 组件来导航. -->
      <!-- 通过传入 `to` 属性指定链接. -->
      <!-- <router-link> 默认会被渲染成一个 `<a>` 标签 -->
      <router-link to="/foo">Go to Foo</router-link>
      <router-link to="/bar">Go to Bar</router-link>
    </p>
    <!-- 路由出口 -->
    <!-- 路由匹配到的组件将渲染在这里 -->
    <router-view>路由出口、路由匹配到的组件将渲染在这里</router-view>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
</style>
```

**router-view 标签**:（vue 内部定义的一个自定义组件），他默认代表的是“/”这个路径。 更新路由路径更新的就是这个部分的内容，其他内容是不变的。

**router-link 制作导航**

如果需要的是在页面上有个像样的导航链接，我们只要点击就可以实现页面内容的变化。制作链接需要<router-link>标签，我们先来看一下它的语法。

    `<router-link to="/">[显示字段]</router-link>`

- **to：`'`我们的导航路径`'`**，填写的是你在 router/index.js 文件里配置的 path 值，如果要导航到默认首页，只需要写成  to=`"/"`  ，
- **[显示字段]** 就是我们要显示给用户的导航名称，比如首页新闻页。明白了 router-link 的基本语法。我们可以在首页做如下的导航

```HTML
<p>导航 ：
   <router-link to="/">首页</router-link>
   <router-link to="/hi"> Hi 页面</router-link>
</p>
<p>导航 ：
   <router-link to="/">首页</router-link>
   <router-link to="/hi">Hi 页面</router-link>
</p>
```

### 3.3 **router文件夹下index.js文件：路由设置文件**

```js
  import Vue from 'vue'//如果使用模块化机制编程，导入 Vue 和 VueRouter，要调用 Vue.use(VueRouter)
  import Router from 'vue-router'//如果使用模块化机制编程，导入 Vue....
  import HelloWorld from '@/components/HelloWorld'//①导入(路由) 组件

  Vue.use(Router)//如果使用模块化机制编程，导入 Vue 和 VueRouter，要调用 Vue.use(VueRouter)

  export default new Router({  //③ new Roter 来创建 router 实例，然后传 `routes` 配置
    routes: [                  //②定义路由，每个路由应该映射一个组件。
      {                        //其中 "component" 可以是通过 Vue.extend() 创建的组件构造器
        path: '/',             // '/'链接路径
        name: 'HelloWorld',    // 'HelloWorld' 路由名称，
        component: HelloWorld  // HelloWorld 对应的组件模板 .vue 文件
      }
    ]
  })
  //上边的代码中已经对每行都进行了注释，其实在这个路由文件里只配置了一个功能，就是在进入项目时，显示//HelloWorld.vue 里边的内容代码。
```

### 3.4 **main.js文件：router 配置参数注入路由**

```JS
    // 4. 创建和挂载根实例。
    // 记得要通过 router 配置参数注入路由，
    // 从而让整个应用都有路由功能
    const app = new Vue({
      router
    }).$mount('#app')
```

### 3.5 **components 文件夹下的 Helloworld.vue 文件： 定义（路由）组件**

  ```HTML
    <template>
    <div class="hello">
      <h1>{{ msg }}</h1>
    </div>
  </template>

  <script>
  export default {
    name: 'HelloWorld',
    data () {
      return {
        msg: 'Welcome to Your Vue.js App'
      }
    }
  }
  </script>

  <!-- Add "scoped" attribute to limit CSS to this component only -->
  <style scoped>

  </style>
```

### 3.6 **访问路由**

通过上面的3.1-3.4步骤，注入路由器，我们可以在 **任何组件内通过 this.$router 访问路由器**，也可以通过 **this.$route 访问当前路由：**

**如下在 home.vue 组件访问路由**

```JS
  // Home.vue
  export default {
    computed: {
      username () {
        // 我们很快就会看到 `params` 是什么
        return this.$route.params.username
      }
    },
    methods: {
      goBack () {
        window.history.length > 1
          ? this.$router.go(-1)
          : this.$router.push('/')
      }
    }
  }
```

该文档通篇都常使用 router 实例。留意一下 this.$router 和 router 使用起来完全一样。我们使用 this.$router 的原因是我们并不想在每个独立需要封装路由的组件中都导入路由。

要注意，当 <router-link> 对应的路由匹配成功，将自动设置 class 属性值 .router-link-active

## 四、新建页面与路由设置：一级路由

最初的页面是 index.html，main.js，APP.vue，helloworld 插入到 app.vue 中 来做成一个入口页面。现在是有了helloworld 这个页面。我们知道 vue 是单页应用那么如何来做其他的页面呢。

如何更换页面：用 inde.js 路由设置，更换组件来达到更换页面的效果，这节学习的是在这些页面中我们还要再设置一些路由（子路由）组件，达到更局部的页面内容替换，比如：轮播图啦这种的局部替换的，总的说就是子路由（局部内容修改）在父路由（类似页面替换效果）中设置的。

从第三章我们知道 router-view 标签，（vue 内部定义的一个自定义组件），他默认代表的是“/”这个路径。 更新路由路径更新的就是这个部分的内容，其他内容是不变的。那么要做一个子路由，就是在新建立的页面替换的组件中新建一个 router-view 标签，也就是组件，用来替换内容

>具体步骤：
①：在 component 文件夹下建立 page1.vue 与 page2.vue 组件（作为页面组件）
②：在 router 文件下 index.js 路由设置新增页面的路由
③：在 app.vue 中设置页面切换 router-link 或者其他办法 push 都行，根据设计需要

index.js 文件改写

```JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Page1 from '@/components/Page1'
import Page2 from '@/components/Page2'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/page1',
      name: 'Page1',
      component: Page1
    },
    {
      path: '/page2',
      name: 'Page2',
      component: Page2
    }
  ]
})
```

## 六、children：页面局部更新与路由设置：子路由/孙子路由

假设页面 page1 中设置子组件 sub1.vue 与 sub2.vue。步骤如下：

>具体步骤：
①：在 component 文件夹下建立 sub1.vue 与 sub2.vue（作为局部组件）
②：在 router 文件下 index.js 路由设置子组件的路由
③：在 page1 中设置局部切换

index.js 文件改写

```JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Page1 from '@/components/Page1'
import Page2 from '@/components/Page2'
import Sub1 from '@/components/sub1'
import Sub2 from '@/components/sub1'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/page1',
      //name: 'Page1', 有了子组件之后，这个就不要写 name 了
      component: Page1,
      children: [
        {
          path: '/',
          name: 'Page1',
          component: Page1
        },
        {
          path: 'sub1',  //注意子组件这里是没有 / 的,没有为什么，就是 vue-router 的格式要求
          name: 'Sub1',
          component: Sub1
        },
        {
          path: 'sub2', //注意子组件这里是没有 / 的
          name: 'Sub2',
          component: Sub2
        }]
    },
    {
      path: '/page2',
      name: 'Page2',
      component: Page2
    }
  ]
})
```

结合第四第五章，我们知道有的组件是作为页面组件，有的是作为局部组件，为了区分，便于维护，我们可以将component 文件下创建两个文件夹。当然这样设置之后， import 导入的时候不要忘记路径的修改。

- pagevue 文件夹：存放页面组件
- commonvue 文件夹：存在一些局部组件，公用组件等等

## 五、参数传递

开发中，参数的传递是个最基本的业务需求。通过 URL 地址来传递参数是一个形式，这节课我们就看看 vue-router 为我们提供了那些传递参数的功能。我们先想象一个基本需求，就是在我们点击导航菜单时，跳转页面上能显示出当前页面的路径，来告诉用户你现在所看的页面位置（类似于面包屑导航）。

### 5.1 name 传递参数

假设 index.js 如下

```JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Page1 from '@/components/Page1'
import Page2 from '@/components/Page2'
import Sub1 from '@/components/sub1'
import Sub2 from '@/components/sub1'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },{
      path: '/page1',
      //name: 'Page1', 有了子组件之后，这个就不要写name了
      component: Page1,
      children: [{
        path: '/',
        name: 'Page1',
        component: Page1
      },{
        path: 'sub1',  //注意子组件这里是没有/的
        name: 'Sub1',
        component: Sub1
      },{
        path: 'sub2', //注意子组件这里是没有/的
        name: 'Sub2',
        component: Sub2
      }]
    },{
      path: '/page2',
      name: 'Page2',
      component: Page2
    }
  ]
})
```

APP.vue 文件：在入口组件 APP.vue 中写 {{$router.name}}, 用于接收参数输出参数

```JS
<template>
  <div id="app">
    <p>{{ $route.name}}</p>
  </div>
</template>

<script>
export default {
  name: 'APP'
}
</script>

<style scoped>
</style>

```

### 5.2 to 传递参数 [选择这种办法传参]

APP.vue 文件传参：这里传的是名字与 id，可以传递其他的，params 是个参数对象

```html
<template>
  <div id="app">
    <router-link to="/">首页</router-link>|
    <router-link to="/page1">page1页面</router-link>|
    <router-link :to="{name:'page2',params:{username:'xiaomi',id:18}}">page2</router-link>
    <router-link to="/page1/sub1">page1/sub1</router-link>
  </div>
</template>

<script>
export default {
  name: 'APP'
}
</script>

<style scoped>
</style>
```

sub1.vue 文件接收参数

```html
<template>
  <div class="sub1">
  {{$route.params.username}}{{$route.params.id}}
  </div>
</template>

<script>
export default {
  name: 'Sub1'
}
</script>

<style scoped>
</style>
```

### 5.3 url 传递参数

以前在前后端没有分开开发的时候，经常这样做。在实际开发也是有很多用 URL 传值的需求，比如我们在新闻列表中有很多新闻标题整齐的排列，我们需要点击每个新闻标题打开不同的新闻内容，这时在跳转路由时跟上新闻编号就十分实用。

①在 components 文件下做  params 页面组件 ，用{{ $route.params.newsId}} 等接受参数输出参数
②在 index.js 路由设置 path 路径
    例子： path:'/params/:newsId/:newsTitle',  
      :冒号的形式传递参数，这就是对参数的绑定。  
      语法：就是在路径后面斜杠冒号   /:名词
      这里我们需要传递参数是新闻 ID（newsId）和新闻标题（newsTitle）.所以我们在路由配置文件里制定了这两个值。
③在 APP.vue  中 router-link 标签中传参利用 url 传值。
    例子：
    <!-- <router-link to="/params/198/jspang website is very good">params</router-link> -->  

正则表达式在 URL 传值中的应用

- 我们希望我们传递的新闻 ID 只能是数字的形式，这时候我们就需要在传递时有个基本的类型判断，vue 是支持正则的。
- 加入正则需要在路由配置文件里（/src/router/index.js）以圆括号的形式加入。
- `path:'/params/:newsId(\\d+)/:newsTitle'`
- (\\d+) 代表的是\d 一个或者是多个
- 加入了正则，我们再传递数字之外的其他参数，params.vue 组件就没有办法接收到。

## 七、单页面多路由区域操作，就是一个页面多个局部路由

单页面多路由区域操作：实际需求是这样的，在一个页面里我们有 2 个以上区域，我们通过配置路由的 js 文件，来操作这些区域的内容。例如我们在 src/App.vue 里加上两个 router-view 标签。现在假如我们在 APP.vue 中设置两个区域 A，B。

>具体步骤：
①：在 component 文件夹下建立 A.vue 与 B.vue （单页面多路由区域局部组件）
②：在 router 文件下 index.js 路由设置子组件的路由
③APP.vue 文件中写两个 router-view 标签，用 name 属性来指定所关联的组件

index.js 如下

```JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import A from '@/components/A'
import B from '@/components/B'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      components:
      {
        default:HelloWorld,
        left:A,
        right:B
      }
      //注意component:XXX要变成components：{}
    }
  ]
})
```

APP.vue 文件

```html
<template>
  <div id="app">
    <router-view></router-view>    <!-- 这里是指默认页面替换 -->
    <router-view name="left"></router-view> <!-- 这里是值弄 name 所对应的组件替换 -->
    <router-view name="right"></router-view><!-- 这里是值弄 name 所对应的组件替换 -->
  </div>
</template>

<script>
export default {
  name: 'APP'
}
</script>

<style scoped>
</style>
```

单页面多路由：是指几个路由同时出现在一个页面，helloworld，A，B 是共存的。组件 A，B 可以做各自的替换组件

## 八、重定向：redirect（切换到统一页面）

开发中有时候我们虽然设置的路径不一致，但是我们希望跳转到同一个页面，或者说是打开同一个组件。这时候我们就用到了路由的重新定向 redirect 参数。简单说就是两个不同的路径打开的页面是一样的

### 8.1 实现重定向

重定向不需要组件，写的其实是两个路径。path：写的是当前路径，可以在这里传递参数。redirect 写的是需要跳转到的路径

①在 index.js 中配置路径，不需要减组件，只有路径
              {
                path: '/gohome',      配置路径
                redirect: '/'         重定向到首页的路径
              },
 ②在 app.vue 中写作链接
        <!-- <router-link to="/gohome">gohome</router-link> -->

```JS
//JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import A from '@/components/A'
import B from '@/components/B'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      components:{default:HelloWorld,left:A,right:B}
      //注意 component:XXX 要变成 components：{}
    },
    {
      path: '/gohome',      配置路径
      redirect: '/'         重定向到首页的路径
    }
  ]
})
```

### 8.2 重定向传递参数

{
  path:'/params/:newsId(\\d+)/:newsTitle',
  component:Params
},{
  path:'/goParams/:newsId(\\d+)/:newsTitle',     配置路径/并且传参
  redirect:'/params/:newsId(\\d+)/:newsTitle'   重定向到首页的路径
}

## 九、alias 别名的使用：给路径七个别名

通俗的说就是给路径起另外一个名字的这一个意思。
    ①index.js 中配置
      {
        path: '/hi1',
        component: Hi1,
        alias:'/xiaomi'
     }
     注意：如果有的时候不出来效果，看下别名中不要放'/',这个有的时候会是个 bug
          但是新版本的做成要写'/,
     ②在 App.vue 中做链接
     <!-- <router-link to="/xiaomi">xiaomi</router-link> -->

      redirect 和 alias 的区别
      redirect：仔细观察URL，redirect 是直接改变了 url 的值，把 url 变成了真实的 path 路径。
      alias：URL 路径没有别改变，这种情况更友好，让用户知道自己访问的路径，只是改变了<router-view>中的内容。

## 十、切换页面/局部替换：动画

在开发中有一种需求叫高端、大气、上档次。所以作为一个大前端有责任让你的程序开起来更酷炫。可以在页面切换时我们加入一些动画效果，提升我们程序的动效设计。这节课我们就学习一下路由的过渡动画效果制作。`<transition>`标签运用。[CSS3 学习深入学习](http://www.runoob.com/css3/css3-animations.html)

- fade-enter:进入过渡的开始状态，元素被插入时生效，只应用一帧后立刻删除。
- fade-enter-active:进入过渡的结束状态，元素被插入时就生效，在过渡过程完成后移除。
- fade-leave:离开过渡的开始状态，元素被删除时触发，只应用一帧后立刻删除。
- fade-leave-active:离开过渡的结束状态，元素被删除时生效，离开过渡完成后被删除。
    从上面四个类名可以看出，fade-enter-active 和 fade-leave-active 在整个进入或离开过程中都有效，
    所以 CSS 的 transition 属性在这两个类下进行设置。

步骤：
①**在组件外面嵌套一个 transition 标签,这里我们就给 router-view 标签外面嵌套。**
  `<transition name="fade" mode="out-in">
    <router-view ></router-view>
  </transition>`
②style 中设置 css，还有去深入学习 css3

```css
.fade-enter {
        opacity:0;
      }
      .fade-leave{
        opacity:1;
      }
      .fade-enter-active{
        transition:opacity .5s;
        -webkit-transition: opacity .5s;/* Safari */
        -moz-transition: opacity .5s;/* Safari */
        -o-transition: opacity .5s;/* Safari */
      }
      .fade-leave-active{
        opacity:0;
        transition:opacity .5s;
        -webkit-transition: opacity .5s;/* Safari */
        -moz-transition: opacity .5s;/* Safari */
        -o-transition: opacity .5s;/* Safari */
      }
```

## 十一、mode 的设置和 404 页面的处理

- mode 的设置：这个 mode 是设置 url 地址中的#号是否需要
- 404页面：用户会经常输错页面，当用户输错页面时，我们希望给他一个友好的提示，为此美工都会设计一个漂亮的页面，这个页面就是我们常说的 404 页面。 vue-router 也为我们提供了这样的机制.

### 11.1 mode设置

- history:当你使用 history 模式时，URL 就像正常的 url，例如 `http://jsapng.com/lms/`也好看！而不是`http://jsapng.com/#/lms/`跳转页面的时候还会出现闪烁。
- hash:默认’hash’值，但是 hash 看起来就像无意义的字符排列，不太好看也不符合我们一般的网址浏览习惯。

index.js 文件

```JS
//JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import A from '@/components/A'
import B from '@/components/B'

Vue.use(Router)

export default new Router({
  mode:'history', //mode设置
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      components:{default:HelloWorld,left:A,right:B}
      //注意 component:XXX 要变成 components：{}
    },{
      path: '/gohome',      配置路径
      redirect: '/'         重定向到首页的路径
    }
  ]
})
```

### 11.2 404 页面的处理

①error.vue 文件创建
②index.js 路由设计

index.js文件

```JS
//JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Error from '@/components/Error'

Vue.use(Router)

export default new Router({
  mode:'history', //mode 设置
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      components:{default:HelloWorld,left:A,right:B}
      //注意 component:XXX 要变成 components：{}
    },{
      path: '/gohome',      配置路径
      redirect: '/'         重定向到首页的路径
    },{
      path:'*',   //path:'*' 指的是找不到页面时的配置，404 页面设置
      component:Error
    }
  ]
})
```

## 十二、路由配置文件中的钩子函数

router 文件夹下 index.js 文件

```JS
//JS
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Page1 from '@/components/Page1'
import Error from '@/components/Error'

Vue.use(Router)

export default new Router({
  mode:'history', //mode 设置
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      components:{default:HelloWorld,left:A,right:B}
      //注意 component:XXX 要变成 components：{}
    },{
      path: '/gohome',                  //配置路径
      redirect: '/'                     //重定向到首页的路径
    },{
      path:'/page1',
      name:'Page1',
      component:Page1,
      beforeEnter:(to,from,next)=>{     //在进入此路由配置时
        console.log('我进入了params模板');
        console.log(to);
        console.log(from);
        next();
    },{
      path:'*',   //path:'*'指的是找不到页面时的配置
      component:Error
    }
  ]
})
```

三个参数：

- to:路由将要跳转的路径信息，信息是包含在对像里边的。
- from:路径跳转前的路径信息，也是一个对象的形式。
- next:路由的控制参数，常用的有 next(true) 和 next(false)。

Page1.vue组件

```JS
<template>
  <div class="page1">
   page1
  </div>
</template>

<script>
export default {
  name: 'Page1',
  data () {
    return {
      msg: 'page'
    }
  },
  beforeRouteEnter:(to,from,next)=>{
    console.log("准备进入路由模板");
    next();
  },
  beforeRouteLeave: (to, from, next) => {
    console.log("准备离开路由模板");
    next();
  }
}
</script>
```

## 十三、编程式导航

### 13.1 this.$router.push

`<router-link :to="...">`   编程式：`router.push(...)`

```JS
// 字符串
router.push('home')

// 对象
router.push({ path: 'home' })

// 命名的路由
router.push({ name: 'user', params: { userId: 123 }})

// 带查询参数，变成 /register?plan=private
router.push({ path: 'register', query: { plan: 'private' }})
```

```JS
const userId = 123
router.push({ name: 'user', params: { userId }}) // -> /user/123
router.push({ path: `/user/${userId}` }) // -> /user/123
// 这里的 params 不生效
router.push({ path: '/user', params: { userId }}) // -> /user
```

### 13.2 this.$router.replace

跟 router.push 很像，唯一的不同就是，它不会向 history 添加新记录，而是跟它的方法名一样 —— 替换掉当前的 history 记录。
history 记录，就是可以用 this.$router.go() 跳转的。

`<router-link :to="..." replace>`   编程式:router.replace(...)

### 13.3 this.$router.go()

这个方法的参数是一个整数，意思是在 history 记录中向前或者后退多少步

在业务逻辑代码中需要跳转页面我们如何操作？这就是我们要说的编程式导航，顾名思义，就是在业务逻辑代码中实现导航。

①this.$router.go(-1)  后退（到之前进入的页面）
② this.$router.go(1)  先后退然后再前进才有的效果，都是之前进入过的页面
    这两个编程式导航的意思是后退和前进，功能跟我们浏览器上的后退和前进按钮一样，这在业务逻辑中经常用到。比如条件不满足时，我们需要后退。
    router.go(-1) 代表着后退，我们可以让我们的导航进行后退，并且我们的地址栏也是有所变化的。
③this.$router.push('/xxx '')  之前跳转某页面
       比如说我们做登录的操作的时候，如果成功就跳转首页

写按钮绑定方法来跳转

```HTML
<template>
  <div class='#'>
    <button @click="back">后退</button>
    <button @click="go">前进</button>
    <button @click="gohome">返回首页</button>
  </div>
</template>
<script>
  export default {
    name: 'App',
    methods: {
      back () {
        this.$router.go(-1)
      },
      go () {
        this.$router.go(1)
      },
      gohome () {
        this.$router.push('/')
      }
    }
  }
</script>

<style>
</style>
```

## 十四、无知与不细心爬过的坑

### 14.1  导入组件的时候 import 不细心

![bug](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180923151839.png)

少了 from 导致的错误。