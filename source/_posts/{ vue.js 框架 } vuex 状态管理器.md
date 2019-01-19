---
title: vuex 状态管理器
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vuex 状态管理器
abbrlink: 49c067f4
updated:
tags:
comments:
---
## 一、Vuex 是什么

vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。Vuex 也集成到 Vue 的官方调试工具 vue-devtools。提供了诸如零配置的 time-travel 调试、状态快照导入导出等高级调试功能。

## 1.1 什么是“状态管理模式”？

```JS
new Vue({
  // state
  data () {
    return {
      count: 0
    }
  },
  // view
  template: `
    <div>{{ count }}</div>
  `,
  // actions
  methods: {
    increment () {
      this.count++
    }
  }
})
```

这个状态自管理应用包含以下几个部分：

- state，驱动应用的数据源；
- view，以声明方式将 state 映射到视图；
- actions，响应在 view 上的用户输入导致的状态变化。

Vuex 是专门为 Vue.js 设计的状态管理库，以利用 Vue.js 的细粒度数据响应机制来进行高效的状态更新。

vuex 是一个专门为 vue.js 设计的集中式状态管理架构。状态？我把它理解为在 data 中的属性需要共享给其他 vue 组件使用的部分，就叫做状态。简单的说就是 data 中需要共用的属性。比如：我们有几个页面要显示用户名称和用户等级，或者显示用户的地理位置。如果我们不把这些属性设置为状态，那每个页面遇到后，都会到服务器进行查找计算，返回后再显示。在中大型项目中会有很多共用的数据，所以尤大神给我们提供了vuex。

相当于把需要公用的数据做放到一个仓库中，每次调用就 ok 了

## 二、什么时候用 vuex， 不需要用的时候不要用！有的时候并不需要用到 vuex

### vuex 用来干什么？

多个组件共享状态时，单向数据流的简洁性很容易被破坏：

- 多个视图依赖于同一状态。
- 来自不同视图的行为需要变更同一状态。

对于问题一，传参的方法对于多层嵌套的组件将会非常繁琐，并且对于兄弟组件间的状态传递无能为力。对于问题二，我们经常会采用父子组件直接引用或者通过事件来变更和同步状态的多份拷贝。以上的这些模式非常脆弱，通常会导致无法维护的代码。

因此，我们为什么不把组件的共享状态抽取出来，以一个全局单例模式管理呢？在这种模式下，我们的组件树构成了一个巨大的“视图”，不管在树的哪个位置，任何组件都能获取状态或者触发行为！另外，通过定义和隔离状态管理中的各种概念并强制遵守一定的规则，我们的代码将会变得更结构化且易维护。
这就是 Vuex 背后的基本思想。

### 什么情况下我应该使用 Vuex？

虽然 Vuex 可以帮助我们管理共享状态，但也附带了更多的概念和框架。这需要对短期和长期效益进行权衡。

如果您不打算开发大型单页应用，使用 Vuex 可能是繁琐冗余的。确实是如此——如果您的应用够简单，您最好不要使用 Vuex。一个简单的 global event bus 就足够您所需了。但是，如果您需要构建是一个中大型单页应用，您很可能会考虑如何更好地在组件外部管理状态，Vuex 将会成为自然而然的选择。

说白了 vuex 是用来管理那些在多个组件中需要使用到的数据的。在大型应用设计上我们用 vuex 来管理那些多个页面需要使用到的数据。
也就是说小型设计就没有必要用了， eventBus.js 就可以解决数据公用问题了。
也不是什么数据都放在 vuex 来管理，  vuex 管理的数据越少才越好。

## 二、安装

### 2.1 npm安装

**步骤①：下载vuex**

```bash
  npm install vuex --save
```

这个包我们在生产环境中是要使用的不用 dev，Development：开发坏境，指定是开发坏境需要，不需要在生产坏境中。

完成安装之后，可以在 vue-cli 的项目框架 package.json 文件中的 dependencies 中查看到版本

**步骤②：引入 vuex **
如果在一个模块化工程中使用它，必须要通过 Vue.use() 手动引入/明确地安装状态管理功能：

```js
    //新建一个 vuex 文件夹下，文件夹下新建一个 store.js 文件
    //文件夹 vuex 作为仓库（不是必须的，但是这样结构会比较好）
    import Vue from 'vue'
    import Vuex from 'vuex'

    Vue.use(Vuex)
```

### 2.2 CDN安装（可以控制版本）

[CDN链接：](https://www.bootcdn.cn/vuex/)如下引入 vuex.js，这样 vuex 会被注册为一个全局变量，不需要再手动引入 import Vue from 'vue', import Vuex from 'vuex',  Vue.use(Vuex)。

```JS
<script src="https://cdn.bootcss.com/vuex/3.0.1/vuex.js"></script>
```

### 2.3 独立版本引入

官网下载文件放置在项目目录下。如下引入 vuex.js ，这样 vuex 会被注册为一个全局变量，不需要再手动引入    import Vue from 'vue', import Vuex from 'vuex',  Vue.use(Vuex)。

```JS
<script src="./vuex"></script>
```

## 三、vuex管理数据 .vue 文件中 template 调用数据

每一个 Vuex 应用的核心就是 store（仓库）。“store”基本上就是一个容器，它包含着你的应用中大部分的状态 (state)。Vuex 和单纯的全局对象有以下两点不同：

- Vuex 的状态存储是响应式的。当 Vue 组件从 store 中读取状态的时候，若 store 中的状态发生变化，那么相应的组件也会相应地得到高效更新。
- 你不能直接改变 store 中的状态。改变 store 中的状态的唯一途径就是显式地提交 (commit) mutation。这样使得我们可以方便地跟踪每一个状态的变化，从而让我们能够实现一些工具帮助我们更好地了解我们的应用。

### 3.1 vuex管理数据

```JS
//store.js文件
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面3句

const state={
    count:1  //这里写一些状态数据
}

const mutations={
    add(state){  //这里写一些方法，用来改变 state 中的状态值
        state.count++;//store 中的状态的唯一途径就是显式地提交 (commit) mutation
    },
    reduce(state){
        state.count--;
    }
}

export default new Vuex.Store({
  state,
  mutations
})
```

### 3.2  在 .vue 文件中引入 store.js 文件, .vue 获取状态数据与方法【不要用这个方法】

**在每个 .vue 文件中单独的引用**，

```JS
// 官网是这样来创建一个组件的，仅为了教学，实际应用中不会是这样创建组件的，没有意义
// 创建一个 Counter 组件，学习的时候不要看这个，实际应用中不会这样来创建模板的，
//store.state.count 这样使用也不看懂，不需要看这个了。
const Counter = {
  template: `<div>{{ count }}</div>`,
  computed: {
    count () {
      return store.state.count
    }
  }
}
```

```html
<!-- 实际应用中会是这样来创建组件的，也是 $store.state.count 这样来调用数据的，而不是上面那样 -->
<!-- .vue 子组件 -->
<template>
    <div>
        <h3>{{$store.state.count}}</h3>
        <button @click="$store.commit('add')">加</button>
        <button @click="$store.commit('reduce')">减</button>
    </div>
</template>

<script>
    import store from '@/vuex/store' //引入
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

这种模式导致组件依赖全局状态单例。在模块化的构建系统中，在每个需要使用 state 的组件中需要频繁地导入，并且在测试组件时需要模拟状态。因此我们不要这样单独应用！！！一定要全局的引用 store.js 文件：即在，main.js 中引用

### 3.3  在 main.js 文件中引入 store.js 文件, .vue 获取状态数据与方法【使用这个方法】

```JS
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import iView from 'iview'
import 'iview/dist/styles/iview.css'
import store from '@/vuex/store'//导入 store.js 文件

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

需要注意的是，通过在根实例中注册 store 选项，该 store 实例会注入到根组件下的所有子组件中，且子组件能通过 this.$store 访问到。简单的说，这样全局引用的话，必须以要用 this.$store.state.xxx ,才能获取数据了。没有this的话获取不到数据。

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

## 四、 vuex 管理数据、 .vue 文件中 script 中改写后 ，再在 template 调用

&nbsp;&nbsp;在第三章中我们子组件 .vue 文件，是 template 直接去调用 store.js 文件数据与 mutations 方法,这个状态是在 store.js 中的，在 .vue 文件的 data 中是不存在的。这样如果我们需要在 .vue 文件中多处调用同一个状态数据或者方法的话，就要写很多遍 this.$store.state.XXXX  ，this.$store.commit('xxx'),这样会很麻烦，我们可以现在 .vue 文件中用 omputed 属性选项来改写 state 之后，再在 template 中调用。说白了，这样做的目的就是为了简化 template 中的调用 store.js 状态。

### 4.1 state 状态数据的改写/调用

&nbsp;&nbsp;就是官网的-在 Vue 组件中获得 Vuex 状态，访问状态对象（它就是我们 SPA（单页应用程序）中的共享值。），学习状态对象赋值给内部对象，也就是把 stroe.js 中的值，给我们模板中的 computed 属性选项的值
我们有三种赋值方式：加上第三章有四种赋值方式

- ㉧第三章：直接在 template 中调用
- ①通过 computed 的 computed 计算属性直接赋值，后在 template 中调用
- ②通过导入 mapState 的对象 computed 的计算属性中放 **mapState 的对象**赋值，后在 template 中调用
- ③通过导入 mapState 的对象 computed 的计算属性中放 **mapState 的数组**赋值

实际应用中常用第③种方法，简单好用。（数组赋值）

下面的方法解析中，用的都是 main.js 全局引用 store.js 的方式

```JS
//store.js文件
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面3句

const state={
    count:1  //这里写一些状态数据
}

const mutations={
    add(state){  //这里写一些方法，用来改变 state 中的状态值
        state.count++;//store 中的状态的唯一途径就是显式地提交 (commit) mutation
    },
    reduce(state){
        state.count--;
    }
}

export default new Vuex.Store({
  state,
  mutations
})
```

**方法①**通过 computed 的计算属性直接赋值:重格式化数据用的：
由于 Vuex 的状态存储是响应式的，从 store 实例中读取状态最简单的方法就是在计算属性中返回某个状态：
学习 vue.js 的时候 computed 属性/选项：可以在输出前，对 data 中的值进行改变，我们就利用这种特性把store.js 中的 state 值赋值给我们模板中的 computed 属性选项的值。在 .vue 文件中修改。

```JS
//.vue子组件
<template>
    <div class="count">  
        /* 这里就不需要再像第三张那样复杂的写 {{this.$store.state.count}} 的长串了 */
        {{msg}} is {{count}}  years old !
    </div>
</template>

<script>
export default {
  name: 'Count', // 这里是组件名称，给 template 中的 class 没有关系，原名为 HelloWorld
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
    }
  }
</script>
```

**方法②**通过导入 mapState 的对象 computed 的计算属性中放 mapState 的对象赋值

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

**方法③**通过导入 mapState 的对象 computed 的计算属性中放 mapState 的数组赋值

这个办法是在实际应用中常用的方法，也是最简单的方法。需要注意的是 computed 里面是用的的数组，但是导入的时候都是对象，vuex 里面就是有 mapState 这个对象

```JS
//.vue子组件
<template>
    <div class="count">  
        {{msg}} is {{count}}  years old !
        /* 这里就不需要再像 3.3 节那样复杂的写 {{$store.state.count}}的长串了 */
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
  computed:mapState(['count'])
  //映射的计算属性的名称与 state 的子节点名称相同，这里 computed 属性,加上 mapState()，并且里面是数组
  // 映射 this.count 为 store.state.count ？？？？不懂
</script>
```

上面是直接写了`computed:mapState(['count'])`，但是在实际应用中 .vue 文件可能是原本就存在 computed 改写数据的方法，要使用 store.js 的状态，不能直接这样写，要做到共存应该这样写。

**最终简单合理的写法**

```JS
//.vue 子组件
<template>
    <div class="count">  
        {{msg}} is {{count}}  years old !
        /* 这里就不需要再像 3.3 节那样复杂的写 {{$store.state.count}} 的长串了 */
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
  computed:{
    newmsg:function(){                //原 computed 计算属性方法
      ...
    },
    ...mapState(['count']) //改写 store.js 的 state 状态
  }
</script>
```

### 4.2 mutations (同步)状态方法的改写/调用

&nbsp;&nbsp;更改 Vuex 的 store 中的状态的唯一方法是提交 mutation。Vuex 中的 mutation 非常类似于事件：每个 mutation 都有一个字符串的 事件类型 (type) 和 一个 回调函数 (handler)。这个回调函数就是我们实际进行状态更改的地方，并且它会接受 state 作为第一个参数。简单来说就是一句话：Mutations 就是包含改变 state 的值的方法

在第三章中我们是直接在 .vue 文件中的 template 中调用这个方法，这章我们先在 .vue 文件 script 中改写方法，再在 template 中简单的调用。在 .vue 的 methods 中先改写 mutations 方法，然后在在 template 中调用

methods 改写 mutations 两种方法，加上第三章的直接调用有三种方法。

- ㉧第三章：直接在 template 中调用
- ①通过导入 mapMutations 的对象 methods 方法中放 **mapMutations 的对象**赋值，再在 template 中调用
- ②通过导入 mapMutations 的对象 methods 方法中放 **mapMutations 的数组**赋值，再在 template 中调用

实际应用中常用第②种方法，简单好用。（数组赋值）

下面的方法解析中，用的都是 main.js 全局引用 store.js 的方式

```JS
//store.js 文件
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面3句

const state={
    count:1  //这里写一些状态数据
}

const mutatios={  //这里写一些方法，用来改变 state 中的状态值
      add(state,n){  //mutation 中同步函数
        state.count+=n
      },
      reduce(state,n)
      state.count-=n
      }
    }

export default new Vuex.Store({
  state,
  mutations
})
```

**方法①**通过导入 mapMutations 的对象 methods 方法中放 **mapMutations 的对象**赋值，再在 template中调用

**附加：mutations传参**

```HTML
<!-- .vue 子组件 -->
<template>
    <div class="count">  
        {{msg}} is {{count}}  years old !
         <!-- 这里就不需要再像 3.3 节那样复杂的写{{$store.state.count}}的长串了  -->
        <button @click="this.add(10)">加</button>
        <!-- 注意因为是用 main.js 引入的，不要忘记使用 this. -->
        <!-- 不需要这样麻烦的调用了this.$store.commit('add',10) -->
        <button @click="this.reduce(19)">减</button>
         <!-- 不需要这样麻烦的调用了this.$store.commit('reduce',19) -->
    </div>
</template>

<script>
import { mapState } from 'vuex'  //导入 mapState 的对象
export default {
  name: 'Count',  
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
            add(){
                ...
            },
            ...mapState(['count']),
        },
  methods: {
    ...mapMutations({
      add: 'add', // 将 `this.add()` 映射为 `this.$store.commit('add')`
      reduce: 'reduce' // 将 `this.reduce()` 映射为 `this.$store.commit('reduce')`
      //换句话说：想将一个 Mutations 属性另取一个名字，使用对象形式。，
      //上面可以随便改写名称
      //addrrrrr: 'add',   将 `this.addrrrrr()` 映射为 `this.$store.commit('add')`
      //reducerr:'reduce'  将 `thisreducerr()` 映射为 `this.$store.commit('reduce')`
    }),
    save(){ //.vue文件的原方法
      ...
    }
  }
</script>
```

**方法②通过导入 mapMutations 的对象 methods 方法中放 **mapMutations 的数组**赋值，再在 template 中调用

**附加：mutations 传参**

```HTML
<!-- .vue子组件 -->
<template>
    <div class="count">  
        {{msg}} is {{count}}  years old !
         <!-- 这里就不需要再像 3.3 节那样复杂的写 {{$store.state.count}} 的长串了  -->
        <button @click="this.add(10)">加</button>
        <!-- 注意因为是用 main.js 引入的，不要忘记使用this. -->
        <!-- 不需要这样麻烦的调用了 this.$store.commit('add',10) -->
        <button @click="this.reduce(19)">减</button>
         <!-- 不需要这样麻烦的调用了 this.$store.commit('reduce',19) -->
    </div>
</template>

<script>
import { mapState } from 'vuex'  //导入 mapState 的对象
export default {
  name: 'Count',  
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
            add(){
                ...
            },
            ...mapState(['count']),
        },
  methods: {
    ...mapMutations([
      'add', // 将 `this.add(n)` 映射为 `this.$store.commit('add',n)`
      'reduce' // 将 `this.reduce(n)` 映射为 `this.$store.commit('reduce',n)`
    ]),
    save(){ //.vue 文件的原方法
      ...
    }
  }
</script>
```

### 4.3 getters 过滤 state 状态数据的 改写/调用

&nbsp;&nbsp;前面我们一直讨论的是 state 与 mutations，其实 store.js 中还有一个选项属性，那就是 actions，getters，还有 module，这节我们就讲 getters

有时候我们需要从 store 中的 state 中派生出一些状态，例如对列表进行过滤并计数：

computed: {
  doneTodosCount () {
    return this.$store.state.todos.filter(todo => todo.done).length
  }
}

如果有多个组件需要用到此属性，我们要么复制这个函数，或者抽取到一个共享函数然后在多处导入它——无论哪种方式都不是很理想。Vuex 允许我们在 store 中定义 “getter”（可以认为是 store 的计算属性）。就像计算属性一样，getter 的返回值会根据它的依赖被缓存起来，且只有当它的依赖值发生了改变才会被重新计算。**简单来说：getters从表面是获得的意思，可以把他看作在获取数据之前进行的一种再编辑,相当于对数据的一个过滤和加工。你可以把它看作store.js的计算属性。**

Getter 接受 state 作为其第一个参数，Getter 也可以接受其他 getter 作为第二个参数：

```JS
//store.js文件
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面3句

const state={
  count:1,  //这里写一些状态数据
  todos: [
    { id: 1, text: '...', done: true },
    { id: 2, text: '...', done: false }
  ]
}
/* const getters={ //这些写一下方法过滤 state 状态的数据
  const getters={
    count:state=>state.count+10 //ES6 的写法，注意 ES6 返回值不能是赋值的形式，只能这样写
    //而不能写成state.count+=10
  },
  doneTodos: state => {
    return state.todos.filter(todo => todo.done)
    //返回值state.todos.filter(todo => todo.done)
  }
}, */

const getters={  //这些写一下方法过滤 state 状态的数据,可以看做出 store.js 中的计算属性，
//用来在输出前处理 state 中的数据的，名称不能用 state 中的一样
  donecount:function(state){ //ES5 写法
    return state.count+=10
  },
  doneTodos:function(state){
    return state.todos.filter ？？？然后呢，filter 怎么写？
  }
},

const mutatios={  //这里写一些方法，用来改变 state 中的状态值
  add(state,n){  //mutation 中同步函数
    state.count+=n
  },
  reduce(state,n)
    state.count-=n
  }
}

export default new Vuex.Store({
  state,
  getters,
  mutations
})
```

.vue文件调用 getters 有四种方法，

- ㉧第三章：直接在 template中调用（用属性/方法都可以的）
- ①通过导入 mapGetters 的对象 computed 方法中放 **mapGetters 的对象**赋值，再在 template 中调用
- ②通过导入 mapGetters 的对象 computed 方法中放 **mapGetters 的数组**赋值，再在 template 中调用

**以下都是将 store.js 导入在 main.js 中**

㉧第三章**：直接在 template 中调用（属性法）

```HTML
<template>
    <div>
        <h3>{{this.$store.state.donecount}}这里用属性 </h3>
        <h3>{{this.$store.state.donecount()}}这里用方法 </h3>
    </div>
</template>
```

像第三章那样，直接在 template 中麻烦的调用数据，
this.$store.getters.doneTodos,this.$store.getters.donecount 如果在 template 中多处使用同一个数据是很麻烦的，因此我们要在 script 中 computed 中对它进行改写，后再在 template 中调用。

①通过导入 mapGetters 的对象 computed 方法中放 **mapGetters的对象**赋值，再在 template 中调用

```html
<!-- .vue 子组件，不需要再引入 store.js 了，不要忘记加上 this -->
<template>
    <div>
        <h3>{{this.donecount}}</h3>
    </div>
</template>

<script>
import { mapState, mapMutations,mapGetters } from 'vuex' //导入 mapGetters 对象
export default {
  name: 'Count',  
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
    add(){                //原 computed 计算属性方法
      ...
    },
    ...mapState(['count'])  
    ...mapGetters({
      aaaaacount:'donecount',
      // 把 `this.aaaaacount` 映射为 `this.$store.getters.doneTodosCount`
      aaaaatodos:'doneTodos'
      // 把 `this.aaaaatodos` 映射为 `this.$store.getters.doneTodosCount`
      //mapGetters 的对象赋值，其实就是 把这个过滤方法换一个名称，
      //不建议用这种方法，还是用数组赋值比较好
    })  
  }
</script>
```

②通过导入 mapGetters 的对象 computed 方法中放 **mapGetters 的数组**赋值，再在 template 中调用

```html
<!-- .vue 子组件，不需要再引入 store.js ，不要忘记加上 this -->
<template>
    <div>
        <h3>{{this.donecount}}</h3>
    </div>
</template>

<script>
import { mapState, mapMutations,mapGetters } from 'vuex' //导入 mapGetters 对象
export default {
  name: 'Count',  
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
    add(){                //原 computed 计算属性方法
      ...
    },
    ...mapState(['count'])  
    ...mapGetters([  //数组赋值改写
      'donecount',
      'doneTodos'
    ])  
  }
</script>
```

### 4.4 actions （异步）状态方法的改写/调用

&nbsp;&nbsp;前面我们一直讨论的是 state 与 mutations，其实 store.js 中还有一个选项属性，那就是 actions，getters，还有 module，这节我们就讲 actions。actions 和之前讲的 Mutations 功能基本一样，不同点是，actions 是异步的改变 state 状态，而 Mutations 是同步改变状态。

**actions**
Action 类似于 mutation，不同在于：

- Action 提交的是 mutation，而不是直接变更状态。
- Action 可以包含任意异步操作。

在第三章中我们是直接在 .vue 文件中的 template 中调用这个方法，这章我们先在 .vue 文件 script 中改写方法，再在 template 中简单的调用。在 .vue 的 methods 中先改写 utations 方法，然后在 template 中调用

methods 改写 mutations 两种方法，加上第三章的直接调用有三种方法。

- ㉧第三章：直接在 template 中调用
- ①通过导入 mapActions 的对象 methods 方法中放 **mapActions 的对象**赋值，再在 template 中调用
- ②通过导入 mapActions 的对象 methods 方法中放 **mapActions 的数组**赋值，再在 template 中调用

实际应用中常用第②种方法，简单好用。（数组赋值）

下面的方法解析中，用的都是 main.js 全局引用 store.js 的方式

```JS
//store.js文件
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex)
// 如果在模块化构建系统中，请确保在开头调用了 Vue.use(Vuex),也就是上面3句

const state={
    count:1  //这里写一些状态数据
}

const mutatios={  //这里写一些方法，用来改变 state 中的状态值
  increment (state) { //在这里面的方法都是同步进行的
    state.count++
  },
  add(state,n){  //mutation 中同步函数
    state.count+=n
  },
  reduce(state,n)
    state.count-=n
  }
}

const actions={ //这里写一些方法，用来改变 state 中的状态值，在这里面的方法是异步进行的
  increment (context) { //①参数 context：上下文对象
    context.commit('increment')
  },
  addAction (context) {
    context.commit('add', 10)
    setTimeOut(()=>{context.commit(reduce)},3000);
    console.log('我先执行完，因为在这里允许前面的人没有做完，我也可以开始了，我要的时间短，我就先完成了');
    //console.log 先执行完毕，然后 setTimeOut(()=>{context.commit(reduce)},3000);才会被执行完，
    //事实上 setTimeOut 代码是先执行的，然后他执行时间比较长，后面的一个输出的执行时间比较短，后面一句都//比前面一句先执行完成了。
    //关于执行时间的问题可以查看 JavaScript 中代码的执行时间问题。
  },
  reduceAction ({commit}) {
    commit('reduce')
  }
}
/* actions: {
  increment ({ commit }) {//②参数{commit}：直接把 commit 对象传递过来，方法体逻辑和代码更清晰明了。
    commit('increment')
  }
} ES6/ES2015 的写法，
*/

export default new Vuex.Store({
  state,
  mutations,
  actions
})
```

**先来解析一下actions**
Action 函数接受一个与 store 实例具有相同方法和属性的 context 对象，因此你可以调用 context.commit 提交一个 mutation，或者通过 context.state 和 context.getters 来获取 state 和 getters。但是 context 并不是 store 实例本身。更复杂的异步处理学习：[vuex官网](https://vuex.vuejs.org/zh/guide/actions.html)

**JavaScript 的常见的算法类型执行时间**

|标记|名称|描述|
|:----|:----|:----|
|O(1)|常数|不管有多少值，执行的时间都是恒定的。一般表示简单值和存储在变量中的值|
|O(log n)|对数|总的执行时间和值的数量相关，但是要完成算法并不一定要获取每个值。例如：二分查找|
|O(log n)|线性|总执行时间和值的数量直接相关。例如：遍历某个数组中的所有元素|
|O(n2)|平方|总执行时间和值的数量有关，每个值至少要获取 n 次。例如：插入排序|

更多查看 JavaScript 分类学习

㉧第三章：直接在 template 中调用

```HTML
<template>
    <div class="count">  
        <button @click="this.$store.dispatch('increment')">加</button>
    </div>
</template>
````

方法①通过导入 mapMutations 的对象 methods 方法中放 mapMutations 的对象赋值，再在 template中调用
这个对象赋值的方法其实是改写了方法的名称
**附加：mutations 传参**

```HTML
<!-- .vue子组件 -->
<template>
    <div class="count">  
        <button @click="this.qqincrement">自增</button>
        <button @click="this.sssaddAction">这里每次增加10</button>
        <button @click="this.aaaaareduceAction"></button>
        <button @click="this.sssaddAction(10)">这里每次增加20</button>
    </div>
</template>

<script>
import { mapState, mapMutations, mapGetters, mapActions } from 'vuex'  //导入 mapMutations 的对象
export default {
  name: 'Count',  
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
    add(){   // computed 计算属性原生处理
      /*执行语句*/
    },
    ...mapState([
      'count'
    ])
  },
  methods: {
    ...mapMutations({
      add: 'add', // 将 `this.add()` 映射为 `this.$store.commit('add')`
      reduce: 'reduce' // 将 `this.reduce()` 映射为 `this.$store.commit('reduce')`
    }),
    ...mapActions({
      qqincrement:'increment',
      // 将 `this.qqincrement()` 映射为 `this.$store.dispatch('increment')`
      sssaddAction:'addAction',
      // 将 `this.sssaddAction()` 映射为 `this.$store.dispatch('addAction')`
      aaaaareduceAction:'reduceAction'
      // 将 `this.aaaaareduceAction()` 映射为 `this.$store.dispatch('reduceAction')`
    })
    save(){ //.vue文件的原方法
      /*执行语句*/
    }
  }
</script>
```

**方法②通过导入 mapMutations 的对象 methods 方法中放 **mapMutations 的数组**赋值，再在 template 中调用

**附加：mutations 传参**

```HTML
<!-- .vue子组件 -->
<template>
    <div class="count">  
        <button @click="this.increment">自增</button>
        <button @click="this.addAction">这里每次增加10</button>
        <button @click="this.reduceAction"></button>
        <button @click="this.addAction(10)">这里每次增加20</button>
    </div>
</template>

<script>
import { mapState, mapMutations, mapGetters, mapActions } from 'vuex'  //导入 mapMutations 的对象
export default {
  name: 'Count',  
  data () {
    return{
      msg:'xiaomi'
    }
  },
  computed:{
    add(){   //computed 计算属性原生处理
      /*执行语句*/
    },
    ...mapState([
      'count'
    ])
  },
  methods: {
    ...mapMutations([
      'add',
      'reduce'
    ]),
    ...mapActions([ //数组赋值
      'increment',
      'addAction',
      'reduceAction'
    ])
    save(){ //.vue 文件的原方法
      /*执行语句*/
    }
  }
</script>
```

### 4.5 module 模块组运用

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

## 五、使用过程的坑/与自己的犯错

### 5.1 调用 mutations 方法错误

```JS
 [Vue warn]: Error in mounted hook: "SyntaxError: Unexpected token u in JSON at position 0"

found in

---> <Home> at src\components\home.vue
       <App> at src\App.vue
         <Root>
vue.esm.js?efeb:1741 SyntaxError: Unexpected token u in JSON at position 0
    at JSON.parse (<anonymous>)
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

问题解析：在位置 0 的 JSON 中出现意外的标记 u