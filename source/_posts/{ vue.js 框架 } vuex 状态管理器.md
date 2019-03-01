---
title: vuex 状态管理器
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vuex 状态管理器
updated:
tags:
comments:
---
## 一、Vuex 是什么

这篇文章的挺清晰的[地址](https://blog.csdn.net/sinat_36263705/article/details/80733199)

vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。Vuex 也集成到 Vue 的官方调试工具 vue-devtools。提供了诸如零配置的 time-travel 调试、状态快照导入导出等高级调试功能。

Vuex 是专门为 Vue.js 设计的状态管理库，以利用 Vue.js 的细粒度数据响应机制来进行高效的状态更新。

vuex 是一个专门为 vue.js 设计的集中式状态管理架构。**状态？** 我把它理解为在 data 中的属性需要共享给其他 vue 组件使用的部分，就叫做状态。简单的说 **就是 data 中需要共用的属性**。比如：我们有几个页面要显示用户名称和用户等级，或者显示用户的地理位置。如果我们不把这些属性设置为状态，那每个页面遇到后，都会到服务器进行查找计算，返回后再显示。在中大型项目中会有很多共用的数据，所以尤大神给我们提供了 vuex。相当于把需要公用的数据做放到一个仓库中，每次调用就 ok 了

## 二、vuex 深入了解

### 2.1 什么是“状态管理模式”？

```JS
//这个状态自管理应用包含以下 3 个部分：
new Vue({
  // state：驱动应用的数据源；
  data () {
    return {
      count: 0
    }
  },
  // view，以声明方式将 state 映射到视图；
  template: `
    <div>{{ count }}</div>
  `,
  // actions，响应在 view 上的用户输入导致的状态变化。
  methods: {
    increment () {
      this.count++
    }
  }
})
```

### 2.2 vuex 用来干什么？

多个组件共享状态时，单向数据流的简洁性很容易被破坏：

- 多个视图依赖于同一状态。
- 来自不同视图的行为需要变更同一状态。

对于问题一，传参的方法对于多层嵌套的组件将会非常繁琐，并且对于兄弟组件间的状态传递无能为力。对于问题二，我们经常会采用父子组件直接引用或者通过事件来变更和同步状态的多份拷贝。以上的这些模式非常脆弱，通常会导致无法维护的代码。

因此，我们为什么不把组件的共享状态抽取出来，以一个全局单例模式管理呢？在这种模式下，我们的组件树构成了一个巨大的“视图”，不管在树的哪个位置，任何组件都能获取状态或者触发行为！另外，通过定义和隔离状态管理中的各种概念并强制遵守一定的规则，我们的代码将会变得更结构化且易维护。
这就是 Vuex 背后的基本思想。

### 2.3 什么情况下我应该使用 Vuex？

虽然 Vuex 可以帮助我们管理共享状态，但也附带了更多的概念和框架。这需要对短期和长期效益进行权衡。

如果您不打算开发大型单页应用，使用 Vuex 可能是繁琐冗余的。确实是如此——如果您的应用够简单，您最好不要使用 Vuex。一个简单的 global event bus 就足够您所需了。但是，如果您需要构建是一个中大型单页应用，您很可能会考虑如何更好地在组件外部管理状态，Vuex 将会成为自然而然的选择。

说白了 vuex 是用来管理那些在多个组件中需要使用到的数据的。在大型应用设计上我们用 vuex 来管理那些多个页面需要使用到的数据。
也就是说小型设计就没有必要用了， eventBus.js 就可以解决数据公用问题了。
也不是什么数据都放在 vuex 来管理，  vuex 管理的数据越少才越好。

## 二、应该使用 vuex 的情况！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

根据 vue 传值的，学习，我们知道传值的方法非常的多，要适合的去选择传值的方式，有的情况下有的传值方式就是行不通的。

- localstorage 本地缓存，可以保存，但是它只能保存 JSON 字符串，如果是对象的话还需要 JS 对象与 JSON 字符串之间的转化来转化去的。
- 小项目有的时候我们希望使用 eventBus 来传值，但是会发现，旧组件页面 会被销毁，新组件页面 获取不到传递过来的值。旧组件不会被销毁的情况使用 eventBus 比较好。
虽然我们可以在旧页面销毁之前去截取数据，但是总感觉不太好。

<div style="color:red;font-size:20px;">下面的例子是看的网上别人的，不一定正确，要自己去琢磨的</div>

## 2.1 组件会被销毁

>场景：

假如有这样一个组件，他是弹窗，有一些复选框和输入框，用户会选择和填写信息；然后这个弹窗会被关闭和打开，由于业务需要，这个弹窗输入的内容，希望关闭后可以保留，在重新打开后，内容依然存在。

>解决办法：

我们可以考虑将值存在父组件中，也就是说，实际修改的是父组件的值；
存在比如 sessionStorage、cookies之类的里面，在 created 时从中读取，destroyed的时候写入其中；
可以存到 global-event-bus 里面；
  但事实上，最好的还是存在 Vuex 里：
  可以直接通过 $store.state 来调用，通过 commit() 来修改值；
  也可以在 created 的时候，读取存在 state 里面的值，在 destroyed 的时候，写回 state；
  这样处理的优点是 **解耦**，不跟其他组件打交道。

## 2.2 组件基于数据而创建

>场景：

用户登录后，读取权限配置表，这显然是一个异步操作；
这个配置表可能会影响很多页面。比如被影响的组件的加载条件，例如是 v-if="$store.state.userInfo.superVIP；
那么：因为读取权限配置表这个异步操作，可能影响多个组件，而这些组件之间的关系，显然是不可预料的（即不一定是在同一个父组件下面）；
那么这个异步操作，写在某一个组件里就不太合适（因为其他组件读取这个组件很不方便，即使他是根组件）；

>解决办法：

一个妥协的解决办法，是写在 global-event-bus 里面来实现(就是全局 eventBus)；但是显然，更好的解决办法是写在 vuex 里面更专业一些；

问题：其实这个场合看不懂，还没有去看，就是做 VIP 用户的情况咯，不知道使用 localstorage 可行不？

## 2.3 多对多事件——多处触发，影响多处

>场景：

假如有一个事件，比如：切换页面显示风格，他将改变某一个变量的值；
当该变量为 true 时，那么页面风格为白天（主要影响 v-bind:style 的值）；
当该变量为 false 时，那么页面风格为晚上（同上）；
在多个地方可以切换这个页面风格开关；
毫无疑问，这个变量将影响多个地方的 v-bind:style 的值；
这就是 多对多 场景；
那么：
无论这个变量放在哪个组件里，其他组件调用他都是很麻烦的事情；
即使存于根组件，然后通过 this.$root.xx 来获取这个变量，也是很麻烦的，而且很丑陋；

>解决办法：

如果不使用 Vuex，那么我们可能会去考虑使用 global-event-bus 来存储这个变量，并使用它；
这不是不可以，但不优雅，而且管理麻烦；
而使用 Vuex，那么这就是一件很方便的事情了；
我们可以通过 $store.state.xxx 来获取这个变量的值；
通过 $store.getters.yyy 来获取某些基于这个值的，表示通用样式（例如黑底白字）的对象；
通过 $store.commit() 来提交修改（比如在某些情况下可以禁止修改）；
甚至可以通过 $store.dispatch() 来获取其他风格的样式，并通过 $store.state 和 $store.getters 来返回新风格的样式；

## 2.10 总结

总而言之，假如你需要 **数据** 和 **组件** 分离，分别处理，那么使用 Vuex 是非常合适的。？？？？不太懂？？？？？？
相反，如果不需要分离处理，那么不使用 Vuex 也没关系。
比如某个数据只跟某组件打交道，是强耦合的。那么这个数据就应该存放在该组件的 data 属性中。

## 三、安装/引入

### 3.1 安装 vuex

```bash
# npm/cnpm 安装
$ npm install vuex --save
# 这个包我们在生产环境中是要使用的不用 dev，Development：开发坏境，指定是开发坏境需要，不需要在生产坏境中。
# 完成安装之后，可以在 vue-cli 的项目框架 package.json 文件中的 dependencies 中查看到版本


# CDN安装（可以控制版本）
# [CDN链接：](https://www.bootcdn.cn/vuex/)
<script src="https://cdn.bootcss.com/vuex/3.0.1/vuex.js"></script> # 这样 vuex 会被注册为一个全局变量，不需要再手动引入
# 然后这个全局引入就不需要了，可以使用 vuex 了 import Vue from 'vue', import Vuex from 'vuex',  Vue.use(Vuex)。


# 独立版本引入，就是将代码放在本地的意思，不用的
<script src="./vuex"></script># 这样 vuex 会被注册为一个全局变量，不需要再手动引入
# 然后这个全局引入就不需要了，可以使用 vuex 了 import Vue from 'vue', import Vuex from 'vuex',  Vue.use(Vuex)。
```

### 3.2 引入使用 vuex

#### 3.2.1 在 main.js 文件中引入 store.js 文件, .vue 获取状态数据与方法【使用这个方法】

```JS
// store.js
```

```JS
// main.js

import Vue from 'vue'
import App from './App'
import router from './router'
import iView from 'iview'
import 'iview/dist/styles/iview.css'
import store from '@/vuex/store'//导入 store.js 文件，vue-cli
import store from 'store'//导入 store.js 文件，vue-cli3

Vue.config.productionTip = false
Vue.use(iView)

new Vue({
  el: '#app',
  router,
  store, //注册 store，一种机制将状态从根组件“注入”到每一个子组件中
  //把 store 对象提供给 “store” 选项，这可以把 store 的实例注入所有的子组件
  //子组件能通过 this.$store 访问到。
  components: { App },
  template: '<App/>'
})
```

需要注意的是，通过在根实例中注册 store 选项，该 store 实例会注入到根组件下的所有子组件中，且子组件能通过 this.$store 访问到。简单的说，这样全局引用的话，必须以要用 this.$store.state.xxx ,才能获取数据了。没有 this 的话获取不到数据。

```html
<!-- .vue 子组件，不需要再引入 store.js 了，不要忘记加上 this -->
<template>
    <div>
        <h3>{{this.$store.state.count}}</h3>
        <button @click="this.$store.commit('add')">加</button>
        <button @click="this.$store.commit('reduce')">减</button>
    </div>
</template>

<script>
    export default{
        data(){
            return{
                msg:'Hello Vuex',
            }
        },
    }
</script>
```

#### 3.2.2 单个文件单独的引入 store.js（一般不用这个方法）

这种模式导致组件依赖全局状态单例。在模块化的构建系统中，在每个需要使用 state 的组件中需要频繁地导入，并且在测试组件时需要模拟状态。因此我们不要这样单独应用！！！一定要全局的引用 store.js 文件：即在，main.js 中引用

```js
//store.js
```

```html
<!-- 实际应用中会是这样来创建组件的，也是 $store.state.count 这样来调用数据的，而不是上面那样 -->
<!-- .vue 组件 -->
<template>
    <div>
        <h3>{{$store.state.count}}</h3>
        <button @click="$store.commit('add')">加</button>
        <button @click="$store.commit('reduce')">减</button>
    </div>
</template>

<script>
    import store from '@/vuex/store' // 路径相应的自己去看着自己的项目改变
    export default{
      data(){
        return{
            msg:'Hello Vuex',
        }
      },
      store  //注册 在子组件 .vue 中引入 store.js 的注册
    }
</script>
```

## 四、vuex 具体使用学习

**vuex 管理数据 store.js文件** **.vue 文件中 template 调用数据**

每一个 Vuex 应用的核心就是 store（仓库）。“store”基本上就是一个容器，它包含着你的应用中大部分的状态 (state)。Vuex 和单纯的全局对象有以下两点不同：

- Vuex 的状态存储是响应式的。当 Vue 组件从 store 中读取状态的时候，若 store 中的状态发生变化，那么相应的组件也会相应地得到高效更新。
- 你不能直接改变 store 中的状态。改变 store 中的状态的唯一途径就是显式地提交 (commit) mutation。这样使得我们可以方便地跟踪每一个状态的变化，从而让我们能够实现一些工具帮助我们更好地了解我们的应用。

script 中改写后 ，再在 template 调用。在第三章中我们子组件 .vue 文件，是 template 直接去调用 store.js 文件数据与 mutations 方法,这个状态是在 store.js 中的，在 .vue 文件的 data 中是不存在的。这样如果我们需要在 .vue 文件中多处调用同一个状态数据或者方法的话，就要写很多遍 this.$store.state.XXXX  ，this.$store.commit('xxx'),这样会很麻烦，我们可以现在 .vue 文件中用 computed 属性选项来改写 state 之后，再在 template 中调用。说白了，这样做的目的就是为了简化 template 中的调用 store.js 状态。

### 4.2 具体的介绍：state，getters，mutations，actions 的四个办法

- state:
- mutation:
    **更改 Vuex 的 store 中的状态的唯一方法是提交 mutation**。Vuex 中的 mutation 非常类似于事件：每个 mutation 都有一个字符串的 事件类型 (type) 和 一个 回调函数 (handler)。这个回调函数就是我们实际进行状态更改的地方，并且它会接受 state 作为第一个参数。简单来说就是一句话：Mutations 就是包含改变 state 的值的方法
- getters
    从 store 中的 state 中派生出一些状态，例如对列表进行过滤并计数,
    computed: {
      doneTodosCount () {
        return this.$store.state.todos.filter(todo => todo.done).length
      }
    }
    如果有多个组件需要用到此属性，我们要么复制这个函数，或者抽取到一个共享函数然后在多处导入它——无论哪种方式都不是很理想。Vuex 允许我们在 store 中定义 “getter”（可以认为是 store 的计算属性）。就像计算属性一样，getter 的返回值会根据它的依赖被缓存起来，且只有当它的依赖值发生了改变才会被重新计算。**简单来说：getters从表面是获得的意思，可以把他看作在获取数据之前进行的一种再编辑,相当于对数据的一个过滤和加工。你可以把它看作store.js的计算属性。**
    this.$store.getters.doneTodos,this.$store.getters.donecount 如果在 template 中多处使用同一个数据是很麻烦的，因此我们要在 script 中 computed 中对它进行改写，后再在 template 中调用。
- actions
    和之前讲的 Mutations 功能基本一样，不同点是，actions 是异步的改变 state 状态，而 Mutations 是同步改变状态。
    Action 提交的是 mutation，而不是直接变更状态。
    Action 可以包含任意异步操作。
    Action 函数接受一个与 store 实例具有相同方法和属性的 context 对象，因此你可以调用 context.commit 提交一个 mutation，或者通过 context.state 和 context.getters 来获取 state 和 getters。但是 context 并不是 store 实例本身。更复杂的异步处理学习：[vuex官网](https://vuex.vuejs.org/zh/guide/actions.html)

- 方法一：（少的时候可以用，但是通常不会少吧）
    state：直接在 template 中调用，一长串的 this.$store.state.xxx
    mutations：直接在 template 中调用，一长串的 @click="this.$store.commit('add',10)"
    getters:直接在 template中调用（用属性/方法都可以的）
    actions：直接在 template 中调用
- 方法二：
    state：通过 computed 的 computed 计算属性直接赋值，后在 template 中调用
    mutations：通过导入 mapMutations 的对象 methods 方法中放 **mapMutations 的对象**赋值，再在 template 中调用
    getters:通过导入 mapGetters 的对象 computed 方法中放 **mapGetters 的对象**赋值，再在 template 中调用
    actions：通过导入 mapActions 的对象 methods 方法中放 **mapActions 的对象**赋值，再在 template 中调用
- 方法三：（太复杂了不用了）
    state：通过导入 mapState 的对象 computed 的计算属性中放 **mapState 的对象**赋值，后在 template 中调用
- 方法四：（直白易懂，通常都使用这样的数组赋值方法！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！）
    state：通过导入 mapState 的对象 computed 的计算属性中放 **mapState 的数组**赋值
          (如果需要使用的数据很多时，通常使用这种，但是如果只使用一次的话，第一种显然又更合理了)
    mutations：通过导入 mapMutations 的对象 methods 方法中放 **mapMutations 的数组**赋值，再在 template 中调用
    getters:通过导入 mapGetters 的对象 computed 方法中放 **mapGetters 的数组**赋值，再在 template 中调用
    actions：通过导入 mapActions 的对象 methods 方法中放 **mapActions 的数组**赋值，再在 template 中调用

#### 4.2.1 直接在 template 中使用（见前面的第 3 章）

```html
<!-- //.vue子组件 -->
<template>

    <div class="count">  
    <!-- 一长串的 this.$store.state 全在这里 -->
        {{msg}} is {{this.$store.state.count}}  years old
    </div>

    <button @click="this.$store.commit('add',10)">加</button>
    <button @click="this.$store.commit('reduce',19)">减</button>

    <h3>{{this.$store.state.donecount}}这里用属性 </h3>
    <h3>{{this.$store.state.donecount()}}这里用方法 </h3>

    <button @click="this.$store.dispatch('increment')">加</button>
</template>

<script>
export default {
  name: 'Count', // 这里是组件名称
  data () {
    return{
      msg:'xiaomi'
    }
  }
</script>
```

#### 4.2.2 使用 computed=>state,methods=>mutations（这个其实就是别名的意义！！！）

```html
<!-- //.vue子组件 -->
<template>

    <div class="count">  
        <!-- /* 这里就不需要再像第三张那样复杂的写 {{this.$store.state.count}} 的长串了 */ -->
        {{msg}} is {{count}}  years old
    </div>

    <button @click="this.add(10)">加</button>
    <!-- 注意因为是用 main.js 引入的，不要忘记使用 this. -->
    <!-- 不需要这样麻烦的调用了this.$store.commit('add',10) -->
    <button @click="this.reduce(19)">减</button>

    <h3>{{this.aaaaacount}}</h3>
    <h3>{{this.doneTodos}}</h3>

    <button @click="this.qqincrement">自增</button>
    <button @click="this.sssaddAction">这里每次增加10</button>
    <button @click="this.sssaddAction(10)">这里每次增加20</button>
    <button @click="this.aaaaareduceAction"></button>

</template>

<script>
import { mapMutations,mapGetters,mapActions } from 'vuex'  //导入 mapState 的对象
export default {
  name: 'Count', // 这里是组件名称
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed: {
    count () {
      return this.$store.state.count
      //main.js 中已经将 store 实例会注入到根组件下的所有子组件中，子组件能通过 this.$store 访问到
      //一定要写 this，要不你会找不到 $store 的。
      //这种写法很好理解，但是写起来是比较麻烦的
    },
    ...mapGetters({
      aaaaacount:'donecount',
      // 把 `this.aaaaacount` 映射为 `this.$store.getters.doneTodosCount`
      aaaaatodos:'doneTodos'
      // 把 `this.aaaaatodos` 映射为 `this.$store.getters.doneTodosCount`
      //mapGetters 的对象赋值，其实就是 把这个过滤方法换一个名称，
      //不建议用这种方法，还是用数组赋值比较好
    })
  },
  methods:{
    ...mapMutations({
      add: 'add', // 将 `this.add()` 映射为 `this.$store.commit('add')`
      reduce: 'reduce' // 将 `this.reduce()` 映射为 `this.$store.commit('reduce')`
      //换句话说：想将一个 Mutations 属性另取一个名字，使用对象形式。，
      //上面可以随便改写名称
      //addrrrrr: 'add',   将 `this.addrrrrr()` 映射为 `this.$store.commit('add')`
      //reducerr:'reduce'  将 `thisreducerr()` 映射为 `this.$store.commit('reduce')`
    }),
    ...mapActions({
      qqincrement:'increment',
      // 将 `this.qqincrement()` 映射为 `this.$store.dispatch('increment')`
      sssaddAction:'addAction',
      // 将 `this.sssaddAction()` 映射为 `this.$store.dispatch('addAction')`
      aaaaareduceAction:'reduceAction'
      // 将 `this.aaaaareduceAction()` 映射为 `this.$store.dispatch('reduceAction')`
    })
  }
</script>
```

#### 4.2.3 这个方法太复杂了，不看了！！！！！！！！！！！

通过导入 mapState 的对象 computed 的计算属性中放 mapState 的对象赋值

方法①很简单，好理解，同一个状态值调用一次可以这样用，但是当一个组件需要获取多个状态时候，将这些状态都声明为计算属性会有些重复和冗余。为了解决这个问题，我们可以使用 mapState 辅助函数帮助我们生成计算属性，让你少按几次键：

```JS
//.vue 子组件
<template>
    <div class="count">  
        /* 这里就不需要再像第三张那样复杂的写{{this.$store.state.count}}的长串了 */
        {{msg}} is {{count}}  years old !
    </div>
</template>

<script>
import { mapState } from 'vuex'  //导入 mapState 的对象
export default {
  name: 'Count', // 这里是组件名称，给 template 中的 class 没有关系，原名为 HelloWorld
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed: mapState({  //这里 computed 属性,加上 mapState()，里面是对象
    count:state=>state.count,//函数 count 的 ES6 箭头函数写法
    countAlias: 'count',// 传字符串参数 'count' 等同于 `state => state.count`？？？不懂？？
    countPlusLocalState (state) {
      return state.count + this.localCount
      // 这里为了能够使用 `this` 获取局部状态，必须使用常规函数????budong
    }
  })
</script>
```

解析：count:state=>state.count，这里我们使用 ES6 的箭头函数来给 count 赋值。意思即使说一个 count 函数传入 state 参数返回值是 state.count。箭头函数是我们必须要理解学会的。这个 ES6 函数可以转化为以下 ES5 函数。便于看不懂 ES6 的理解。

```JS
computed:mapState({
  count:function(state){
    return state.count
  }
})
```

#### 4.2.4  类似拓展符号的方法引入！！！！！！！！！！！！！！！！！！！！！！！！！！重点，重点，重点，使用这方法来做！！！！！！！

通过导入 mapState 的对象 computed 的计算属性中放 mapState 的数组赋值。这个办法是在实际应用中常用的方法，也是最简单的方法。需要注意的是 computed 里面是用的的数组，但是导入的时候都是对象，vuex 里面就是有 mapState 这个对象

```html
<!-- //.vue 子组件 -->
<template>

  <div class="count">  {{msg}} is {{count}}  years old !</div>

  <button @click="this.add(10)">加</button><!-- 注意因为是用 main.js 引入的，不要忘记使用this. -->
  <!-- 不需要这样麻烦的调用了 this.$store.commit('add',10) -->
  <button @click="this.reduce(19)">减</button><!-- 不需要这样麻烦的调用了 this.$store.commit('reduce',19) -->

  <h3>{{this.donecount}}</h3>
  <h3>{{this.doneTodost}}</h3>

  <button @click="this.increment">自增</button>
  <button @click="this.addAction">这里每次增加 10</button>
  <button @click="this.addAction(10)">这里每次增加 20</button>
  <button @click="this.reduceAction"></button>

  <button @click="save">原方法直接用，不需要 this</button>
</template>

<script>
import { mapState, mapMutations,mapGetters, mapActions} from 'vuex' //导入 mapGetters 对象
export default {
  name: 'Count', // 这里是组件名称，给 template 中的 class 没有关系，原名为 HelloWorld
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
    newmsg(){ //原生 computed 计算属性方法
      //
    },
    ...mapState(['count']), //改写 store.js 的 state 状态(和原生的计算属性并列显示)
    ...mapGetters([  //数组赋值改写
      'donecount',
      'doneTodos'
    ])
  },
  methods:{
    ...mapMutations([
      'add', // 将 `this.add(n)` 映射为 `this.$store.commit('add',n)`
      'reduce' // 将 `this.reduce(n)` 映射为 `this.$store.commit('reduce',n)`
    ]),
    ...mapActions([ //数组赋值
      'increment',
      'addAction',
      'reduceAction'
    ]),
    save(){ //.vue 文件的原方法
      /*执行语句*/
    }
  }
</script>
```

### 4.3 module 模块组运用

随着项目的复杂性增加，我们共享的状态越来越多，这时候我们就需要把我们状态的各种操作进行一个分组，分组后再进行按组编写。那今天我们就学习一下 module：状态管理器的模块组操作。尤其是一个很大的项目很多人同时进行，为了不影响他人的数据，我们每个人都有自己的模块组。将 store 分割成模块（module）。每个模块拥有自己的 state、mutation、action、getter、甚至是嵌套子模块——从上至下进行同样方式的分割：避免 store 对象就有可能变得相当臃肿。但是 module 模块组使用有坑，如果项目不是那么的大，建议不要轻易使用模块组。更多的学习到：[vuex官网-module模块组](https://vuex.vuejs.org/zh/guide/modules.html)

```JS
//store.js文件
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面3句
const moduleA={
  state:{
    count:1,
  },
  mutations: { ... },
  getters: { ... },
  actions: { ... }
}

const moduleB={
  state: { ... },
  mutations: {... },
  getters: { ... },
  actions: {
    increment (context) { //①参数 context：上下文对象
      context.commit('increment')
    }
  },
}
export default new Vuex.Store({
  modules:{
    a:moduleA,
    b:moduleB
  }
})
```

```HTML
<!-- .vue 子组件调用，这里是 template 中直接调用，在 script 得到改些到官网学习，
太复杂了，如果项目不复杂不要用模块组，无形给自己增添麻烦 -->
<template>
    <div class="count">  
    {{this.$store.state.a.count}}
        <button @click="this.$store.dipatch.increment">-</button>
    </div>
</template>
```

太难了，后面如果实在项目麻烦，再去学习使用！！！！

其实 vuex 也要适当的用直接传递参数会比这个好用多

## 五、**JavaScript 的常见的算法类型执行时间**

```BASH
# 标记       名称     描述
# O(1)      常数      不管有多少值，执行的时间都是恒定的。一般表示简单值和存储在变量中的值|
# O(log n)  对数      总的执行时间和值的数量相关，但是要完成算法并不一定要获取每个值。例如：二分查找|
# O(log n)  线性      总执行时间和值的数量直接相关。例如：遍历某个数组中的所有元素|
# O(n2)     平方      总执行时间和值的数量有关，每个值至少要获取 n 次。例如：插入排序|
```

## 六、vuex 与 .vue 的配合 完成的使用例子！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

store 与 .vue 组件之间的完整使用

### 6.1 例子一

```JS
//store.js文件
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面 3 句

const state={
    count:1,  //这里写一些状态数据（就是类似组件中的 data(){return{//}} ） 中的数据
    todos: [
      { id: 1, text: '...', done: true },
      { id: 2, text: '...', done: false }
    ],
    name:'xiaomi',
    cartCount: 0
}

// 类似 .vue 中的 methods【mutations 是同步的】
const mutations={
    add(state){  //这里写一些方法，用来改变 state 中的状态值!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      state.count++;//store 中的状态的唯一途径就是显式地提交 (commit) mutation
                    // 提交(commit) mutation 改变 state 中的值。
    },
    reduce(state){
      state.count--;
    },
    increment (state) { //在这里面的方法都是同步进行的
      state.count++
    },
    updateName(state,newName){//state 是必填的参数，就是原来的状态值，newName 是 在组件中 commit 提交的时候传递过来的值。
      state.name = newName;
    },
    updateCartCount(state,newCartCount) {//newCartCount 是传递过来的值
　　　state.cartCount += newCartCount;
　　}
}

// 类似 .vue 中的 methods【actions 是异步的】
const actions={ //这里写一些方法，用来改变 state 中的状态值，在这里面的方法是异步进行的!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  addAction (context) {
    context.commit('add', 10) // 这里的 'add' 是 mutations 中的方法名称啦
                              // dispatch 一个 action，action 中在 commit一个 mutation,在 mutation 中改变 state 中的值。
    setTimeOut(()=>{context.commit(reduce)},3000);
    console.log('我先执行完，因为在这里允许前面的人没有做完，我也可以开始了，我要的时间短，我就先完成了');
    //console.log 先执行完毕，然后 setTimeOut(()=>{context.commit(reduce)},3000);才会被执行完，
    //事实上 setTimeOut 代码是先执行的，然后他执行时间比较长，后面的一个输出的执行时间比较短，后面一句都//比前面一句先执行完成了。
    //关于执行时间的问题可以查看 JavaScript 中代码的执行时间问题。
  },
  reduceAction ({commit}) {
    commit('reduce')// 这里的 'reduce' 是 mutations 中的方法名称啦
  },
  increment (context) { //①参数 context：上下文对象
    context.commit('increment') // 这里的 'increment' 是 mutations 中的方法名称啦
  },
  updateName(context) {
    context.commit("updateName");// 这里的 'updateName' 是 mutations 中的方法名称啦
  },
  updateCartCount(context) {
    context.commit("updateCartCount");// 这里的 'updateName' 是 mutations 中的方法名称啦
  }
}

/* ES6/ES2015 的写法，
actions: {
  increment ({ commit }) {//②参数{commit}：直接把 commit 对象传递过来，方法体逻辑和代码更清晰明了。
    commit('increment')
  }
}
*/

const getters={ //这些写一下方法过滤 state 状态的数据
  const getters={
    count:state=>state.count+10 //ES6 的写法，注意 ES6 返回值不能是赋值的形式，只能这样写
    //而不能写成state.count+=10 因为箭头后面就是返回值啊，
  },
  doneTodos: state => {
    return state.todos.filter(todo => todo.done)
    //返回值state.todos.filter(todo => todo.done)
  }
}

export default new Vuex.Store({
  state,
  mutations,
  actions,
  getters
})
```

```JS
//组件中：
methods: {
    increment(){
      this.$store.dispatch("updateUserInfo", 'nick');  
      //this.$store.commit("increment", 'nick');
    },
    decrement() {
      this.$store.dispatch("updateCartCount", 1);  
      // this.$store.commit("decrement", 1);
    }
}
```

```html
<!-- //.vue 子组件 -->
<!-- commit   => mutation  //用来触发同步操作的方法 -->
<!-- dispatch => action    //用来触发异步操作的方法 
具体的区别请查阅下面 4.4 -->

<template>

  <div class="count">  {{msg}} is {{count}}  years old !</div>
    <!-- count 不需要这样麻烦的调用了 this.$store.state.count -->

  <button @click="this.add(10)">加</button><!-- 注意因为是用 main.js 引入的，不要忘记使用this. -->
  <!-- 不需要这样麻烦的调用了 this.$store.commit('add',10) -->
  <button @click="this.reduce(19)">减</button>
  <!-- 不需要这样麻烦的调用了 this.$store.commit('reduce',19) -->

  <h3>{{this.donecount}}</h3>
  <h3>{{this.doneTodost}}</h3>

  <button @click="this.increment">自增</button>
  <!-- 不需要这样麻烦的调用了 this.$store.dispatch('increment') -->
  <button @click="this.addAction">这里每次增加 10</button>
  <!-- 不需要这样麻烦的调用了 this.$store.dispatch('addAction') -->
  <button @click="this.addAction(10)">这里每次增加 20</button>
  <!-- 不需要这样麻烦的调用了 this.$store.dispatch('addAction',10) -->
  <button @click="this.reduceAction"></button>

  <button @click="save">原方法直接用，不需要 this</button>
</template>

<script>
import { mapState, mapMutations,mapGetters, mapActions} from 'vuex' //导入 mapGetters 对象
export default {
  name: 'Count', // 这里是组件名称，给 template 中的 class 没有关系，原名为 HelloWorld
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
    newmsg(){ //原生 computed 计算属性方法
      //
    },
    ...mapState(['count']), //改写 store.js 的 state 状态(和原生的计算属性并列显示)
    ...mapGetters([  //数组赋值改写
      'donecount',
      'doneTodos'
    ])
  },
  methods:{
    ...mapMutations([
      'add', // 将 `this.add(n)` 映射为 `this.$store.commit('add',n)`
      'reduce' // 将 `this.reduce(n)` 映射为 `this.$store.commit('reduce',n)`
    ]),
    ...mapActions([ //数组赋值
      'increment', // 将 `this.increment(n)` 映射为 `this.$store.dispatch('increment',n)`
      'addAction',
      'reduceAction'
    ]),
    save(){ //.vue 文件的原方法
      /*执行语句*/
      // 上面的 ... 都是为了方便在 html，也就是 template 中去使用这个 mapState, mapMutations,mapGetters, mapActions
      // 如果需要在 methods 中的原方法，就比如这个 save() 原组件内的方法中去 commit 或者是 dispatch 也是一样的使用呀。
      this.add(33)// 去使用 mapMutations 提交 commit 一个 add 方法到 store
    }
  }
</script>
```

### 6.2 例子二

```JS
//store.js 这个是 vue-cli3 中的，
// 使用的也是 ES6 的写法
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
  },
  mutations: {
    increment(state,n){
　　　　state.count+=n;
　　},
    ADD_NUM:(state,n)=>{
　　　　state.data = n;
　　},
    SET: (state, productObj) => {
      state.updateProductFormData = productObj
    }
  // 一般来说把 mutations 中的常量，全都大写，可以有下划线，不是，这个去看 types 吧，是常量
  },
  actions: {
    incrementAction({commit},count){// {commit} 是 ES6 的写法
　　　commit('ADD_NUM',count.num)// 因为传入的 count 是对象，所以这里是 count.num
　　},
    //currentProduct 是传递过来的值
    setCurrentProductAction({
      commit
    }, currentProduct) {
      commit('SET', currentProduct)
    }
  },
  getters:{}
})
```

```JS
//.VUE 组件中使用（这里是没有使用简化的方法的，只是为了学习一下使用，还是要学会用 ... 简化方法）
methods:{
　　add(){
　　　　this.$store.commit('increment',10)
　　},
    add1(){
　　　　this.$store.dispatch('incrementAction',{num:1})//这里传过去的数据是 {num:1} 对象
　　}
}
```

```BASH
# {commit} es6 中函数的参数是一个对象，函数中用的是对象中的一个方法，是可以通过对象的解构赋值直接获取到该方法的

# 因为 actions 中的函数中 commit mutation, 所以会获取到一个默认的参数 context,它是一个 store 的实例，通过它可以获取到 store 的属性和方法，
# 如 context.state 获取 state 属性，context.commit 执行 commit命令。所以把

# ES5 写法
increment(context,count){
　　context.commit('ADD_NUM',count.num)
}

# 简写成 ES6 写法
increment({commit},count){
　commit('ADD_NUM',count.num)
}
```

## 七、mutations 与 actions 的区别 与 实际应用场景！！！！！！！！！！！！！！！！！！

一些比较复杂的学习：[地址](https://blog.csdn.net/wopelo/article/details/80285167)

```TEXT
commit    => mutation  //用来触发同步操作的方法
            如果想改变 vuex 的store 中的状态的
            唯一方法是提交 (commit) mutation

dispatch  => action   //用来触发异步操作的方法
            action 主要处理的是异步的操作，mutation 必须同步执行，而 action 就不受这样的限制，也就是说 action 中我们既可以处理同步，也可以处理异步的操作
            如果想在 action 中改变 store 中的状态，
            先要 dispatch 一个 action，action 中在 commit一个 mutation,在 mutation 中改变 store 中的值。（action 改变状态，最后是通过 mutation 提交）

  action    处理异步数据最终提交到数据库
  mutation  用来同步数据做业务的处理 ( vuex 中 store 数据改变唯一的方法就是 mutation)
  Action    提交的是 mutation，而不是直接变更状态。
```

```JS
mutations: {
  someMutation (state) {
    api.callAsyncMethod(() => {
      state.count++ //这句代码在这里是不会被执行的
    })
  }
}
// 在这个 mutations 中 someMutaion 函数里面是有一个回调函数的，是异步的。内部的代码块是不会被执行到的。

// 我们都知道 任何回调函数 中进行的状态改变都是无法追踪的,  devtools 会对 mutations 的每一条提交做记录,
// 记录上一次提交之前和提交之后的状态,在上面的例子中无法实现捕捉状态,因为在执行 mutations 时,内部回调函数还没有执行,所以此时无法捕捉状态.


//为了解决 mutations 只有同步的问题,提出了 actions(异步),专门用来解决 mutations 只有同步无异步的问题.
//（mutations 与 actions 最终的目的都是为了改变 state 状态中的值，只是 actions 需要更多的一个步骤而已，它需要通过去调用 mutations 来改变 state）
```

## 八、store.js 的完整使用 ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

上面我们是学会了 vuex 如何使用，但是如果是在一个大型项目中，我们都是多人开发的，会不利于管理。

- 通常就会用一个方法定义一个常量，也就是 types。
- 还有上面的 module 分模块进行的

### 8.1 types 常量

```JS
//在需要多人协作的项目中，我们可以使用常量代替 mutation 事件类型。这在各种 Flux 实现中是很常见的模式。同时把这些常量放在单独的文件中可以让协作开发变得清晰。


//store.js 这个是 vue-cli3 中的，使用的也是 ES6 的写法
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面 3 句


// 常量，通常会放到另外的文件里面，然后再引进来
const types = {
  SET_TARGET_USER: "SET_TARGET_USER" //详细资料
};


export default new Vuex.Store({
  state: {
    //用户初始化的状态
    targetUser: {} //用户详细资料数据
  },
  getters:{
    //获取到用户状态, 实时监听 state 值的变化(最新状态)
    targetUser: state => state.targetUser
  }
  mutations: {
    //自定义改变state初始值的方法
    [types.SET_TARGET_USER](state, targetUser) {
    if (targetUser) {
      state.targetUser = targetUser; //如果 targetUser 有内容就赋给状态信息
    } else {
      //如果没内容就给 targetUser 赋空对象
      state.targetUser = {};
    }
  },
  actions: {
    //这里面的方法是用来异步触发 mutations 里面的方法, context 与 store 实例具有相同方法和属性
    setGargetUser({ commit }, targetUser) {
      commit(types.SET_TARGET_USER, targetUser);
      // localStorage.setItem("SET_TARGET_USER", JSON.stringify(targetUser));
    }
  }
})
```

### 8.2 module

```JS
//store.js文件（这里是写在一个页面上的，实际开发中会分开成为几个文件，然后引入这里来。）
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面3句


// 常量
const types = {
  SET_TARGET_USER: "SET_TARGET_USER" //详细资料
};


const moduleA={
  state:{
    //用户初始化的状态
    targetUser: {} //用户详细资料数据
  },
  mutations: {
    //自定义改变 state 初始值的方法
    [types.SET_TARGET_USER](state, targetUser) {
    if (targetUser) {
      state.targetUser = targetUser; //如果 targetUser 有内容就赋给状态信息
    } else {
      //如果没内容就给 targetUser 赋空对象
      state.targetUser = {};
    }
  },
  getters: {
    //获取到用户状态,//实时监听state值的变化(最新状态)
    targetUser: state => state.targetUser
  },
  actions: {
    //这里面的方法是用来异步触发mutations里面的方法,context与store 实例具有相同方法和属性
    setGargetUser({ commit }, targetUser) {
      commit(types.SET_TARGET_USER, targetUser);
      // localStorage.setItem("SET_TARGET_USER", JSON.stringify(targetUser));
    }
  }
}

const moduleB={
  state: { ... },
  mutations: {... },
  getters: { ... },
  actions: {
    increment (context) { //①参数 context：上下文对象
      context.commit('increment')
    }
  },
}
export default new Vuex.Store({
  modules:{
    a:moduleA,
    b:moduleB
  }
})

//store.state.a // -> moduleA 的状态
//store.state.b // -> moduleB 的状态
```

## 十、使用过程的坑/与自己的犯错

### 10.1 调用 mutations 方法错误

```BASH
 [Vue warn]: Error in mounted hook: "SyntaxError: Unexpected token u in JSON at position 0" # 在 mounted 钩子的时候出错

found in

---> <Home> at src\components\home.vue # 在 home.vue 组件出错
       <App> at src\App.vue
         <Root>
vue.esm.js?efeb:1741 SyntaxError: Unexpected token u in JSON at position 0 # 在位置 0 的 JSON 中出现意外的标记 u
    at JSON.parse (<anonymous>) # JSON 数据解析出错 JSON.parse
    at Store.gettabledata (store.js?0dc8:23)
    at wrappedMutationHandler (vuex.esm.js?358c:697)
    at commitIterator (vuex.esm.js?358c:389)
    at Array.forEach (<anonymous>)
    at eval (vuex.esm.js?358c:388)
    at Store._withCommit (vuex.esm.js?358c:495)
    at Store.commit (vuex.esm.js?358c:387)
    at Store.boundCommit [as commit] (vuex.esm.js?358c:335)
    at VueComponent.mounted (home.vue?250d:180)
```

**填坑**

主要是好好的看报错信息，这样就可以看到我们错误的地方是哪里了，缩小错误的范围了。

### 10.2