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

## 四、vuex 具体使用

**vuex 管理数据 store.js文件** **.vue 文件中 template 调用数据**

每一个 Vuex 应用的核心就是 store（仓库）。“store”基本上就是一个容器，它包含着你的应用中大部分的状态 (state)。Vuex 和单纯的全局对象有以下两点不同：

- Vuex 的状态存储是响应式的。当 Vue 组件从 store 中读取状态的时候，若 store 中的状态发生变化，那么相应的组件也会相应地得到高效更新。
- 你不能直接改变 store 中的状态。改变 store 中的状态的唯一途径就是显式地提交 (commit) mutation。这样使得我们可以方便地跟踪每一个状态的变化，从而让我们能够实现一些工具帮助我们更好地了解我们的应用。

script 中改写后 ，再在 template 调用。在第三章中我们子组件 .vue 文件，是 template 直接去调用 store.js 文件数据与 mutations 方法,这个状态是在 store.js 中的，在 .vue 文件的 data 中是不存在的。这样如果我们需要在 .vue 文件中多处调用同一个状态数据或者方法的话，就要写很多遍 this.$store.state.XXXX  ，this.$store.commit('xxx'),这样会很麻烦，我们可以现在 .vue 文件中用 computed 属性选项来改写 state 之后，再在 template 中调用。说白了，这样做的目的就是为了简化 template 中的调用 store.js 状态。

### 4.1 store 与 .vue 组件之间的完整使用

#### 4.1.1 例子一

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

#### 4.1.2 例子二

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
  // 一般来说把 mutations 中的携程常量，全都大写，可以有下划线
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

### 4.4 mutations 与 actions 的区别

```TEXT
commit    => mutation  //用来触发同步操作的方法
            如果想改变 vuex 的store 中的状态的
            唯一方法是提交 (commit) mutation

dispatch  => action   //用来触发异步操作的方法
            如果想在 action 中改变 store 中的状态，
            先要 dispatch 一个 action，action 中在 commit一个 mutation,在 mutation 中改变 store 中的值。
```



## 五、**JavaScript 的常见的算法类型执行时间**

```BASH
# 标记       名称     描述
# O(1)      常数      不管有多少值，执行的时间都是恒定的。一般表示简单值和存储在变量中的值|
# O(log n)  对数      总的执行时间和值的数量相关，但是要完成算法并不一定要获取每个值。例如：二分查找|
# O(log n)  线性      总执行时间和值的数量直接相关。例如：遍历某个数组中的所有元素|
# O(n2)     平方      总执行时间和值的数量有关，每个值至少要获取 n 次。例如：插入排序|
```

## 六、使用过程的坑/与自己的犯错

### 6.1 调用 mutations 方法错误

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

### 6.2 调用 mutations 方法错误