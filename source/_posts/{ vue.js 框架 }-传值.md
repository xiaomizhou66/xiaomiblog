---
title: 'vue.js--[ 父子组件传值，非父子组件传值，兄弟姐妹传值]'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

## 一、前言

vue.js 框架中组件之间的传值方法。

1.prop 属性  父传【值】给子组件  在父组件的子组件标签中 设置 prop 属性，名称可以不是 props
2.emit 事件  子传【值】给父组件
3.eventBus  各个组件之间传【值】【方法】调用     **（订阅模式 $emit 负责发布消息， $on 负责消费消息）**
4.url 路由  路由传值，页面传值
5.Storage  缓存传值
6.vuex 状态管理器 共同使用的数据保存在 store 中
7.this.$root.xxx        获取根组件的实例方法属性                           （所有父组件）
  this.$parent.xxx      获取 父 组件的实例方法属性   传【值】【方法】给子组件 （直接父组件）
  this.$ref.refName.xxx 获取 孙子 组件的实例方法属性 传【值】【方法】给父组件 （所有子组件+孙子组件）
  this.$children.xxx    获取 子   组件的实例方法属性 传【值】【方法】给父组件 （直接子组件）             不保证顺序，不是响应式的
8.slot 插槽传值  在子组件中设置 prop 属性，名称一定是 props ，它代表的是 传了一个 slot 插槽 文本对象，可以获取对应值

## 二、prop（父-子）

### 2.1 父组件传递 prop 各种数据类型的传递（数字，字符串，布尔值，对象，数组）

其中，对象与数组是特殊的。注意在 JavaScript 中对象和数组是通过引用传入的，所以对于一个数组或对象类型的 prop 来说，
**在子组件中改变这个对象或数组本身将会影响到父组件的状态。** 所以不要试图在子组件去修改父组件传递过来的 prop 属性值。

如果传递的参数很多，推荐使用 json 数组 {} 的形式？？？？？比如说例子的

```HTML
<!-- 父组件 -->
<!-- 不管传递的是静态值还是动态值，都要使用 ：绑定 ！！！！！！！！！！！！！！！！！！！！！！！！！！！！-->
<template>
  <div class="home">
    <blog-post v-bind:likes="42"></blog-post>
    <blog-post :likes="42"></blog-post>  <!-- 省略写法！！！！！！！！！！！！！！！！！！！！！！！！！！-->

    <blog-post v-bind:likes="post.likes"></blog-post> <!-- 用一个变量进行动态赋值。-->

    <blog-post is-published></blog-post> <!-- 包含该 prop 没有值的情况在内，都意味着 `true`。-->
    <!-- 即便 `false` 是静态的，我们仍然需要 `v-bind` 来告诉 Vue -->
    <blog-post v-bind:is-published="false"></blog-post><!-- 这是一个 JavaScript 表达式而不是一个字符串。
    就是说这里传递过去的是 false 布尔值-->
    <blog-post v-bind:is-published="post.isPublished"></blog-post><!-- 用一个变量进行动态赋值。-->

    <blog-post v-bind:comment-ids="[234, 266, 273]"></blog-post>
    <blog-post v-bind:comment-ids="post.commentIds"></blog-post><!-- 用一个变量进行动态赋值。-->

    <blog-post v-bind="postobj"></blog-post><!-- 传递的是对象的话，这样来传递 -->
    <blog-post v-bind:id="post.id" v-bind:title="post.title"></blog-post>
  </div>
</template>

<script>
import Children from '@/components/commons/children'
export default {
  name: 'Home',
  components: {
    'blog-post': Children// 当然标签其实是不能重复的，html中的写法也是错误的，但是这里就不修正了。文章太长。
  },
  data () {
    return {
      post:{
        likes:42,
        isPublished:false,
        commentIds:[234, 266, 273]
      },
      postobj:{
        id: 1,
        title: 'My Journey with Vue'
      }
    }
  }
}
</script>
```

### 2.2 子组件接受 prop（可以设置接受的要求）

如果不考虑数据类型，直接 `props:["number","string"]` 就可以了,中括号包裹，多个值使用，分隔。

```HTML
<!-- 子组件 -->
<template>
  <div class="children">
  </div>
</template>
<script>
  export default {
    name: 'Children',
    // ① 简单接收值，数组
    props:["likes","is-published"]/* 如果不考虑数据类型，直接 数组接收就可以了,中括号包裹，多个值使用，分隔。
    数组中的字符串就是父组件中绑定 ： 后面的名称 */

    /* 子组件通过 props 获取父组件传递过来的值。props 中可以定义能接收的数据类型，如果不符合会报错。 */
    /* 这样写的话冒号前面是父组件中定义的名称，后面是数据类型，或者是检查函数 */
    // ② 复杂检查接收值，对象
    props: {
      // 基础的类型检查 (`null` 匹配任何类型)
      likes: Number,
      // 多个可能的类型
      likes: [String, Number],
      // 必填的字符串
      likes: {
        type: String,
        required: true
      },
      // 带有默认值的数字
      likes: {
        type: Number,
        default: 100
      },
      // 带有默认值的对象
      postobj: {
        type: Object,
        // 对象或数组默认值必须从一个工厂函数获取
        default: function () {
          return { message: 'hello' }
        }
      },
      // 自定义验证函数
      propF: {
        validator: function (value) {
          // 这个值必须匹配下列字符串中的一个
          return ['success', 'warning', 'danger'].indexOf(value) !== -1
        }
      }
    /* 这个 prop 用来传递一个初始值；这个子组件接下来希望将其作为一个本地的 prop 数据来使用。
    在这种情况下，最好定义一个本地的 data 属性并将这个 prop 用作其初始值：
    props: ['initialCounter'],
    data() {
      return {
        counter: this.initialCounter
      }
    } */

    /* 这个 prop 用来传递一个初始值；这个子组件接下来希望将其作为一个本地的 prop 数据来使用。
    在这种情况下，最好定义一个本地的 data 属性并将这个 prop 用作其初始值：
    props: ['size'],
    computed: {
      normalizedSize: function () {
        return this.size.trim().toLowerCase()
      }
    }, */
}
</script>
```

### 2.3 假如接收的参数 是动态的，比如 input输入的内容 v-model的形式

传递的参数名称 支持驼峰命名

```HTML
<!-- 父组件 -->
<template>
  <div class="parent ">
    <input type="text" v-model="inputText">
    <children :input-val='inputText'></children>
    <!-- :input-val 这里只能用连字符号，不能驼峰
    那就不要连字都不要驼峰不就别这么麻烦了 -->
  </div>
</template>
<script>
  import children f rom 'components/children'
  export default{
    components:{
      Children
    }
  }
```

```HTML
<!-- 子组件 -->
<template>
  <div class="children ">
    {{inputVal}} 显示这里用驼峰
  </div>
</template>
<script>
  export default{
    props:{
      'input-val':[String]
    }
  }
</script>
```

### 2.4 父子组件传值，数据是异步请求，有可能数据渲染时报错

原因：异步请求时，数据还没有获取到但是此时已经渲染节点了
解决方案：可以在 父组件需要传递数据的节点加上  v-if = false，异步请求获取数据后，v-if = true ？？？？？？？？看不动什么意思？？？

### 2.5 .sync 异步（实现 prop 传值 父子组件的 MVVM ：但是这样并不好，所以不建议使用）

不要试图在子组件中修改从父组件中获取的 prop 值，这样会报错的。可以使用下面的获取实例方法的办法来替代 prop 传值。

- this.$root.xxx        获取根组件的实例方法属性                           （所有父组件）
- this.$parent.xxx      获取 父 组件的实例方法属性 传【值】【方法】给子组件   （直接父组件）
- this.$ref.refName.xxx 获取 孙子 组件的实例方法属性 传【值】【方法】给父组件 （所有子组件+孙子组件）
- this.$children.xxx    获取 子   组件的实例方法属性 传【值】【方法】给父组件 （直接子组件）

## 三、$emit  （子 => 父）（在父组件自定义事件 触发传值）

这里使用的是 v-on 自定义事件（省略写法 @）
当然想在组件根元素上使用原生事件，可以使用 .native 修饰符。？？？？不懂

另外子组件调用父组件事件则可以使用 $parent 或者 $root

### 3.1 例子一

```HTML
<!-- 父组件 -->
<template>
  <div class="parent">
    <children @child-event='parentEvent'></children><!-- 在这里传的值不需要 显性的写出来！！！！！！！！！！！！！！！
    <!-- child-event 这里是子组件 methods 中定义的方法名（要一致），
    就是监听子组件数据变化执行的父组件函数的。（parentEvent 这里是触发的父组件的函数方法） 
    这里只能用连字符号，不能驼峰。那就不要连字都不要驼峰不就别这么麻烦了 -->
  </div>
</template>
<script>
  import children f rom 'components/children'
  export default{
    components:{
      Children
    },
    methods:{
      parentEvent(data){
        /* data 就是子组件传递过来的数据 */
        console.log(data)
      }
    }
  }
```

```HTML
<!-- 子组件 -->
<template>
  <div class="children ">
    <button @click="toParent"></button>
  </div>
</template>
<script>
  export default{
    methods:{
      toParent(){
        this.$emit('child-event',"我是 子组件 传给 父组件 的内容")
      }
    }
  }
</script>
```

### 3.2 例子二

```HTML
<!-- 父组件 -->
<template>
  <div class="parent">
    <p>{{ total }}</p>
    <!--父组件通过 v-on 在子组件使用的地方监听子组件触发的事件：
      increment 是子组件中的事件，意思就是在子组件中 increment 执行的时候，执行父组件中的 incrementTotal 方法 -->
    <button-counter v-on:increment="incrementTotal"></button-counter>
    <button-counter v-on:increment="incrementTotal"></button-counter>
  </div>
</template>
<script>
  import children f rom 'components/children'
  export default{
    data(){
      return{
        total: 0
      }
    },
    components:{
      Children
    },
    methods:{
      incrementTotal(arg) {
        this.total += 1
      }
    }
  }
```

```HTML
<!-- 子组件 -->
<template>
  <div class="children ">
    <button v-on:click="increment">{{ counter }}</button>
  </div>
</template>
<script>
  export default{
    data(){
      return{
        counter: 0
      }
    },
    methods:{
      increment() {
        this.counter += 1
        this.$emit('increment')//子组件中使用 $emit() 主动抛出事件
         //传递参数
         //this.$emit('increment',arg)
      }
    }
  }
</script>
```

## 四、路由传值 url 带参数    【适用于所有组件之间】

### 3.1 `<router-link>` 标签传参（写在 html 中）

```HTML
<!-- A 组件 -->
<template>
  <div class="app_page">
    <h1>从这个路由传参到别的路由</h1>
    <router-link :to="{ name:'/conponentsB',params: { id: status ,id2: status3},query: { queryId:  status2 }}" >
      router-link 跳转 /conponentsB
    </router-link>
  </div>
</template>
<script>
export default {
  name: 'app_page',
  data () {
    return {
      status:110,
      status2:120,
      status3:119
    }
  },
}
</script>
```

```HTML
<!-- B 组件 -->
<!-- 获取路由上面的参数，用的是 $route，后面没有 r。 -->
<template>
  <div class="router1">
    <h1>接收参数的路由</h1>
    <h1> params.id：{{ $route.params }}</h1>
    <h1> query.status:{{ $route.query.queryId }}</h1>
    <keep-alive>
      <router-view></router-view>
    </keep-alive>
  </div>
</template>
```

### 3.2 编程式传参（写在 JS 中）

```JS
// A 组件
this.$router.push({ path: '/conponentsB', query: { orderId: 123 } })// 跳转到B
this.$router.push({  name:'/conponentsB',params: { id: status ,id2: status3},query: { orderId:  status2 }}); // 跳转到B
//编程跳转写在一个函数里面，通过 click 等方法来触发
```

```JS
//B 组件
// 获取路由上面的参数，用的是 $route，后面没有 r。
this.$route.query.orderId
```

编程式导航，可以用来做判断跳转，比如是否授权，是否登录，等等状态，这种办法会比较好，并且是写在 js 里面，而不是 html 里面。

### 3.3 params 与 query 传参

#### 3.3.1 params、query 是什么

params：/conponentsB/:id ，/conponentsB/123，/conponentsB/789 ,这里的 id 叫做 params
query：/conponentsB?id=123 ,/conponentsB?id=456 ,这里的 id 叫做 query。

#### 3.3.2 router.js 路由设置文件设置问题

```JS
//router.js
limport Vue from' vue'
import Router from' vue router'Vue. use(Router);

export default new Router ( {
  mode: 'history',
  routes: [
    {
      path:' /',
      redirect:' /app',
    },
    {
      path:'/app',
      name:' app',
      component: resolve => System import('./page/app page')
    },
    {
      path:'/app/conponentsA',//将要从这个路由跳转过去
      name:'conponentsA',//这里是路由的名字，建议大家每个路由都加一个名字，这样跳转的时候比较方便
      component: resolve => System import('./page/app page')
    }
    {
      path:'/app/conponentsB/:id' , //接收参数的路由，使用params传参要加参数名，这里的 id 就是参数名
      // 如果使用 params 传参，这里必须先这是好 :id 否则在 html 中写了传参也不会正确
      name:'conponentsB',
      component: resolve => System imort( '. /page/app_ level/conponentsB' )//这种写法是路由懒加载的写法
    }
```

#### 3.3.3 params、query 传参区别

- 当你使用 params 方法传参的时候，要在路由后面加参数名，并且传参的时候，参数名要跟路由后面设置的参数名对应。
  使用query方法，就没有这种限制，直接在跳转里面用就可以。
- params 是路由的一部分,必须要有。params 一旦设置在路由，params 就是路由的一部分，如果这个路由有 params 传参，
  但是在跳转的时候没有传这个参数，会导致跳转失败或者页面会没有内容。
  query 是拼接在 url 后面的参数，没有也没关系。
- query 不设置也可以传参，但是 params 不设置的时候，刷新页面或者返回参数会丢失，query 并不会出现这种情况，

```HTML
  <!-- 跳转/conponentsB/:id -->
  <router-link :to="{ name:'conponentsB',params: { id: status}}" >正确，路由中写的是 id 不是 id2，要一致</router-link>
  <router-link :to="{ name:'conponentsB',params: { id2: status}}">错误，路由中写的是 id 不是 id2，要一致</router-link>
```

```JS
    {
      path:'/app/conponentsA',
      name:'conponentsA',
      component: resolve => System import('./page/app page')
    }
    {
      path:'/app/conponentsB/:id' , //接收参数的路由，使用params传参要加参数名，这里的 id 就是参数名
      // 如果使用 params 传参，这里必须先这是好 :id 否则在 html 中写了传参也不会正确
      name:'conponentsB',
      component: resolve => System imort( '. /page/app_ level/conponentsB' )
    }
 ```

## 五、Storage 缓存传值    【适用于所有组件之间】

[Storage](http://www.cnblogs.com/st-leslie/p/5617130.html)，学习  Session Storage（程序退出销毁） 和 Local Storage（长期保存） 的区别。

```JS
// A 组件
const orderData = { 'orderId': 123, 'price': 88 }
sessionStorage.setItem('缓存名称', JSON.stringify(orderData)) // 保存值
```

```JS
// B 组件
onst dataB = JSON.parse(sessionStorage.getItem('缓存名称')) // 取值
```

## 六、eventBus.js 兄弟姐妹 & 父子 通通可用（小项目少页面用 事件巴士 eventBus，大项目多页面使用 vuex）

目前中央通信是解决兄弟间通信，祖父祖孙间通信的最佳方法，
当然兄弟姐妹都可以的话，肯定不仅限于此，也可以解决父组件子组件间的相互通信的啦。

### 6.1 例子一（订阅模式 $emit 负责发布消息， $on 负责消费消息）

>创建一个 eventBus.js 文件来 定义一个新的vue实例专门用于传递数据，并导出

![TU](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181205135131.png)

```JS
/* eventBus.js 的内容如下即可，网上有很复杂的，*/
import Vue from 'vue'
export default new Vue()
```

> 发送事件的组件：组件 A 使用 eventBus.js 给组件 B 传值

```html
<!-- componentA.vue -->
<template>
  <div class="componenA"> <!--  组牛 A 点击按钮往组件 B 传递数据 -->
    <button @click="emitToB">按钮点钮传递数据给兄弟组件B</button>
  </div>
</template>
<script>
//引入 eventBus,其实就是引入另一个 vue 实例
import eventBus from 'common/js/eventBus.js'// 两个组件都要引入这个 新的 eventBus 实例
export default{
  methods: {
    emitToB(){
      eventBus.$emit('eventFromA', '我是 组件A 传递给 组件B 的数据')//定义方法名，以及传输的数据
      //定义传递的方法名和传输内容，点击事件 methods 中或 钩子函数触发 eventBus.$emit 事件
    }
  }
}
</script>
```

>组件内监听事件：enentBus 是一个另一个新的 Vue 实例，区分两个 this 所代表得 vue 实例

```html
<!-- componentB.vue -->
<template>
  <div class="componenB"> <!--  接收组件 A 传来的数据 -->
    {{title}}
  </div>
</template>
<script>
//引入 eventBus,其实就是引入另一个 vue 实例
import eventBus from 'common/js/eventBus.js' // 两个组件都要引入这个 新的 eventBus 实例
export default{
  data(){
    return{
      title:''
    }
  },
  mounted(){
    this.getEventData()
  }
  methods: {
    getEventData(){
      const that = this // 这个 this 是 vue 实例的 this 用 that 保存，避免作用域的改变导致找不到原值
      //避免与 eventBus 实例 冲突
      eventBus.$on("eventFromA", function(val) {
        that.title = val
        //this.title = val 这里的 this 指的是 eventBus 的 this
      })
    }
  }
}
</script>
```

### 6.2 例子二(这个其实是 this.$root 的方法，不是 eventBus 模式）

```JS
//一般在 vue 的开发中都是模块化开发，所以当涉及到兄弟组件之间的通信的时候，我们可以在入口文件中事先声明一个全局的事件巴士（即一个全局的供 vue 实例），
// 然后通过他来传导数据。
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import App from './App';
import FastClick from 'fastclick';
import router from './router';
import Vue_resource from 'vue-resource';
import axios from 'axios';
import './common/style/index.less';
Vue.config.productionTip = false;
FastClick.attach(document.body);
Vue.prototype.$http = axios;
/* eslint-disable no-new */
new Vue({
    el: '#app',
    router,
    render: h => h(App),
    data: {
        eventHub: new Vue()
    }
});
router.push('/goods');
```

```JS
//全局的使用该实例，进行数据的传输
//在组件a中触发事件add，并且传递参数1
this.$root.eventHub.$emit('add',1);
//在组件b中监听事件的触发，并处理参数
this.$root.eventHub.$on('add',function(data) {
  //...
})
```

## 七、vuex 状态管理传值 兄弟姐妹 & 父子 通通可用（小项目少页面用eventBus，大项目多页面使用 vuex）(就是解决多页面使用同一个值的问题的)

父子组件传值可以很容易办到 props 就可以解决，但是兄弟组件间传值（兄弟组件下又有父子组件），或者大型 spa 单页面框架项目，页面多并且一层嵌套一层的传值，异常麻烦，用 vuex 来维护共有的状态或数据会显得得心应手。因为vuex 主要就是做数据交互。对于大型应用，用 vuex 再方便不过了。

需求：两个组件 A 和 B，vuex 维护的公共数据是 餐馆的名称 resturantName,默认餐馆名称是 飞歌餐馆，那么现在A和B页面显示的就是飞歌餐馆。如果A修改餐馆名称 为 A 餐馆，则 B 页面显示的将会是 A 餐馆，反之 B 修改同理。这就是 vuex 维护公共状态或数据的魅力，在一个地方修改了数据，在这个项目的其他页面都会变成这个数据。

### 6.1 创建 store

![TU](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181205141233.png)

在 vue-cli 脚手架创建的项目中，如果创建的时候勾选了 vuex ，那么我们的项目目录会有 sotre 文件夹

```JS
// store.js  原始的文件内容如下，
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {}
})
```

原始的内容如上面，但是这样不便于维护，我们同上是分为四个文件来维护。分开维护 actions mutations getters，以及原始的 index.js。

下面列举的是的使用 vuex 传值的方法，具体的是 如果使用 vuex 可以去学习 [vuex](https://liuxmoo.com/2018/08/28/3-%E2%91%A3-19.2-vuex1-rumen/)

```JS
//store/index.js
import Vue from 'vue'
import Vuex from 'vuex'
import * as getters from './getters' // 导入响应的模块，*相当于引入了这个组件下所有导出的事例
import * as actions from './actions'
import * as mutations from './mutations'

Vue.use(Vuex)
// 首先声明一个需要全局维护的状态 state,比如 我这里举例的resturantName
const state = {
    resturantName: '飞歌餐馆' // 默认值
    // id: xxx  如果还有全局状态也可以在这里添加
    // name:xxx
}

// 注册上面引入的各大模块
const store = new Vuex.Store({
    state,    // 共同维护的一个状态，state里面可以是很多个全局状态
    getters,  // 获取数据并渲染
    actions,  // 数据的异步操作
    mutations  // 处理数据的唯一途径，state的改变或赋值只能在这里
})

export default store  // 导出store并在 main.js中引用注册。
```

```JS
// actions.js
// 给action注册事件处理函数。当这个函数被触发时候，将状态提交到mutations中处理
export function modifyAName({commit}, name) { // commit 提交；name即为点击后传递过来的参数，此时是 'A餐馆'
    return commit ('modifyAName', name)
}
export function modifyBName({commit}, name) {
    return commit ('modifyBName', name)
}

// ES6精简写法
// export const modifyAName = ({commit},name) => commit('modifyAName', name)
```

```JS
//mutations.js
// 提交 mutations是更改Vuex状态的唯一合法方法
export const modifyAName = (state, name) => { // A组件点击更改餐馆名称为 A餐馆
    state.resturantName = name // 把方法传递过来的参数，赋值给state中的resturantName
}
export const modifyBName = (state, name) => { // B组件点击更改餐馆名称为 B餐馆
    state.resturantName = name
}
```

```JS
// geter.JS
// 获取最终的状态信息
export const resturantName = state => state.resturantName
```

### 6.2 引入 store

```JS
//main.js
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'//导入 store

Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,  // 全局注册 store 这样就能全局使用 vuex 了
  components: { App },
  template: '<App/>'
```

### 6.3 使用 store

...mapactions 和 ...mapgetters 都是 vuex 提供的语法糖，在底层已经封装好了，拿来就能用，简化了很多操作。

...mapActions(['clickAFn']) 相当于  `this.$store.dispatch('clickAFn'，{参数})`
mapActions中只需要指定方法名即可，参数省略。

...mapGetters(['resturantName'])相当于 `this.$store.getters.resturantName`

```HTML
<!-- componentA.vue -->
<!-- 在组件A中，定义点击事件，点击 修改 餐馆的名称，并把餐馆的名称在事件中用参数进行传递 -->
<template>
  <div class="componentsA">
      <P class="title">组件A</P>
      <P class="titleName">餐馆名称：{{resturantName}}</P>
      <div>
          <button class="btn" @click="modifyAName('A餐馆')">修改为A餐馆</button><!-- 点击修改 为 A 餐馆 -->
      </div>
      <div class="marTop">
          <button class="btn" @click="trunToB">跳转到B页面</button>
      </div>
  </div>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'
export default {
  name: 'A',
  data () {
    return {
    }
  },
  methods:{
      ...mapActions( // 语法糖
          ['modifyAName'] // 相当于this.$store.dispatch('modifyName'),提交这个方法
      ),
      trunToB () {
          this.$router.push({path: '/componentsB'}) // 路由跳转到B
      }
  },
  computed: {
      ...mapGetters(['resturantName']) // 动态计算属性，相当于this.$store.getters.resturantName
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
```

```HTML
<!-- componentB.vue -->
<template>
  <div class="componentsB">
      <P class="title">组件B</P>
      <P class="titleName">餐馆名称：{{resturantName}}</P>
      <div>
          <!-- 点击修改 为 B 餐馆 -->
          <button class="btn" @click="modifyBName('B餐馆')">修改为B餐馆</button>
      </div>
      <div class="marTop">
          <button class="btn" @click="trunToA">跳转到A页面</button>
      </div>
  </div>
</template>

<script>
import {mapActions, mapGetters} from 'vuex'
export default {
  name: 'B',
  data () {
    return {
    }
  },
  methods:{
      ...mapActions( // 语法糖
          ['modifyBName'] // 相当于this.$store.dispatch('modifyName'),提交这个方法
      ),
      trunToA () {
          this.$router.push({path: '/componentsA'}) // 路由跳转到A
      }
  },
  computed: {
      ...mapGetters(['resturantName']) // 动态计算属性，相当于this.$store.getters.resturantName
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
```

## 八、root、parent、ref、children 传递实例方法属性

- this.$root.xxx        获取根组件的实例方法属性                           （所有父组件）
- this.$parent.xxx      获取 父 组件的实例方法属性 传【值】【方法】给子组件   （直接父组件）
- this.$ref.refName.xxx 获取 孙子 组件的实例方法属性 传【值】【方法】给父组件 （所有子组件+孙子组件）
- this.$children.xxx    获取 子   组件的实例方法属性 传【值】【方法】给父组件 （直接子组件）

### 8.1 this.$root

### 8.2 this.$parent

### 8.3 this.$ref

尽管存在 prop 和事件，prop 父传子，事件 子传父。有的时候你仍可能需要在 JavaScript 里直接访问一个子组件。为了达到这个目的，你可以通过 ref 特性为这个子组件赋予一个 ID 引用。例如：

```HTML
<!-- 父组件 -->
<base-input ref="usernameInput"></base-input>
<script>
  export default {
    name:'',
    data(){
      return{
        //
      }
    },
    methods:{
      getFromChild(){
        this.$refs.usernameInput.xxxx()// 获取到子组件实例 的某个方法
        this.$refs.usernameInput.name// 获取到子组件实例 的某个 数据
      }
    }
  }
</script>
```

```HTML
<!-- 子组件 -->
<script>
  export default {
    name: "baseinput",
    data(){
      return{
        name:''
      }
    },
    methods:{
      xxxx(){
        //
      }
    }
  }
</script>
```

### 8.4 this.$children

父组件可以通过 $children，获取到所有的直接子组件，不包括孙组件；
需要注意 $children 并不保证顺序，也不是响应式的。？？？？？什么意思，没有看懂

## 九 、slot 传值