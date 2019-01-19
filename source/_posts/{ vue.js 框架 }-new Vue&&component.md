---
title: 'new Vue({}) 与 export default{} 选项的写法区分'
date: '2018/8/19 23:57:28'
categories:
  - 四、vue.js
  - vue.js 框架学习
abbrlink: 33e8b3ae
updated:
tags:
comments:
---

## 一、前言

学习 vue 的时候我们知道，vue 有诸多选项。用在 new Vue({}),也叫做属性，这个 new Vue 是建立在 html 原生标签上的。

学习到组件 component [也就是自定义标签] 的时候。因为组件是可复用的 Vue 实例，所以它们与 new Vue 接收相同的选项（除了一些 vue 特别的选项 el 这些，component 没有之外）。component 的选项就不能写成属性形式了，要写成函数形式。

学习到 vue-cli 脚手架创建的项目的时候。

- main.js 文件使用的是 new Vue({})
- .vue 文件其实都是组件 component，而且它还使用了 ES6/ES2015 的方法。 es6 的 export default 相当于暴露组件，很好理解，前端底层无非是 html，css，js。而 .vue 文件是其他文件， .vue 或者 .js 文件引入的。最后都是解析为 html，css，js 的。肯定要把 .vue 文件做成导出件。 export default{}

这里区分一下 main.js 中可用的 `new Vue({})` 即`构造函数的选项`与 .vue 文件 `export default({})` 即`自定义组件(标签)的选项`写法

首先要知道一点：二者的选项是大多相同，有差不多一样的选项，但是不同，有特别的选项为其一所属。

## 二、new Vue({}) 与 export default{}

### 2.1  el 与 name  的特殊

el :是 new Vue({}) 特有的，el 是 element 的缩写，就是知道它是原生标签，对于自定义组件标签自然是没有的。
提供的元素只能作为挂载点。因此不推荐挂载 root 实例到 `<html>`或者 `<body>`上。
name：export default({}) 中组件的名称。

### 2.2 data 共有选项，组件中写成函数

data:{} 与 data:function(){} / data(){}

```HTML
<!-- new Vue({})----- -->
<div id="app">
  {{count}}
<div>
<script>
new Vue({
  el:'#app',
  data: {
    count: 0
  }
})
</script>
```

```html
<!-- export default({}) ----- -->
<template>
  <div class="home">
   {{count}}
  <div>
<template>

<script>
export default({
  name:'Home',
  data: function () {  //这里是 ES5 ，最佳是 ES6 写法 data () {return {count: 0}}
    return {
      count: 0
    }
  }
})
</script>

<style>
</style>
```

### 2.3 propsData 与 props 的特殊

propsData：new Vue({}) 特有
props：组件特有：父组件的数据传递给后代组件，用于接收来自父组件的数据，可以是数组或对象，学习这个选项之前可以先学习 components 选项

#### 2.2.1 propsData 是 new xxx({}) 构造函数的 全局扩展的数据传递

propsData 不是和属性有关，他用在全局扩展时进行传递数据。先回顾一下 `Vue.extend` 全局扩展的知识，作一个`<header></header>`的扩展标签出来。实际我们不推荐用全局扩展的方式作自定义标签，我们学了组件，完全可以使用组件来做.这里只是为了演示 propsData 的用法。全局拓展用的不多，那么这个 propsData 用的也不多，一般都是用组件。虽然用的不多，但是既然设计出来了，一定有它的特别的用处。

创建实例时传递 props。主要作用是方便测试。
我们用 propsData 三步解决传值：
  1、在全局扩展里加入 props 进行接收。
  2、传递时用 propsData 进行传递。
  3、用插值的形式写入模板。{{a }}

```HTML
<header></header>
<div id="header"></div>
<div class="header"></div>

<script>
  var header = Vue.extend({
    template: `<p>我有{{message}}车{{num}}辆</p>`, //用插值的形式写入模板。{{a }}
    //拓展的 data 不像 vue 里面的 data 不能直接写，而是应该在在函数的 return 里面
    data: function () {
      return {
        message: 'minicooper'
      }
    },
    props: ['num'] //在全局扩展里加入 props 进行接收。
  });
  var vm=new header({  //类似 new Vue 了
    propsData: {
      num: 18
    } //传递时用 propsData 进行传递。
  }).$mount('header'); //这里是拓展的挂载
  new header().$mount('#header'); //这里是拓展的挂载,这样用的话在 html 中这个就是一个 id 名，来使用
  new header().$mount('.header'); //这里是拓展的挂载,这样用的话在 html 中这个就是一个 class 名，来使用
</script>
```

#### 2.2.2 props 是 export default{}/components

**①在父组件的 js 中的 component 选项直接写**

```HTML
<div id="app">
    <panda here="China"></panda>
</div>
<script>
    var vmapp = new Vue({
      el: '#app',
      components: {
        'panda': { //指的是一个 panda 标签，这里是子组件
          template: '<p style="color:red;">panda from {{here}}!</p>',
          props: ['here'] // 这个参数 here 就是从父亲 id=app 那里传来的
        }
      }
    })
</script>
```

上面的代码更新成 vue-cli 中的写法就是
**②父子组件分开，在各自的文档**

```HTML
<!-- .APP父组件----------------------- -->
<template>
  <div id="app">
  <router-view> 用于渲染匹配的组件，它基于 Vue 的动态组件系统，所以它继承了一个正常动态组件的很多特性。
    <panda here="China">父组件从这里传参</panda>
  </div>
</template>

<script>
export default {
  name: 'App',
  props: ['here']  //app.vue 子组件中有 props 选项用于从父亲哪里接收参数
}
</script>

<style>
</style>
```

```HTML
<!-- Home子组件----------------------- -->
<template>
  <div class="home">
    {{ here }}
  </div>
</template>

<script>
export default {
  name: 'Home',
  props: {   //传进来的参数需要检查的，查看官网
    here: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      name: 'xiaomi'
    }
  }
}
</script>

<style >
</style>
```

**③注意属性尽量不要用连字符号**
我们在写属性名时经常会加入'-'来进行分词， 比如：`<panda from-here="China"></panda>`,那这时我们在 props 里如果写成`props:['form-here']`是错误的，我们必须用小驼峰式写法`props:['formHere']`。因此避免使用这种连字符号！

```HTML
<div id="app">
  <xiaomi from-here="China"></xiaomi>
</div>
<script>
  var app1 = new Vue({
    el: '#app',
    components: {
      'xiaomi': {
        template: `<div style="color:red;">Panda from {{ fromHere }}.</div>`,
        props: ['fromHere']
      }
    }
  })
</script>
```

### 2.4 computed 共有选项，组件中写成函数

```html
<!-- new Vue({}) -->
<div id="app">
  {{a}}-{{aDouble}}-{{aPlus}}   <!--  效果为1-2-2 -->
</div>
<script>
var vm = new Vue({
  el:'#app',
  data: { a: 1 },
  computed: {
      aDouble: function () {  // 仅读取
      return this.a * 2
    },
    aPlus: {                 // 读取和设置
      get: function () {
        return this.a + 1
      },
      set: function (v) {
        this.a = v - 1
      }
    }
  }
})
vm.aPlus   // => 2
vm.aPlus = 3
vm.a       // => 2
vm.aDouble // => 4
</script>
```

```html
<!-- export default{}------------ -->
<template>
  <div class="home">
    {{a}}-{{aDouble}}-{{aPlus}}
  </div>
</template>
<script>
var vm=export default {
  name:'Home',
  data() {
    return{
      a: 1
    }
  },
  computed: {
    // 仅读取
    aDouble () {
      return this.a * 2
    },
    // 读取和设置
    aPlus: {
      get () {
        return this.a + 1
      },
      set (v) {
        this.a = v - 1
      }
    }
  }
})
vm.aPlus   // => 2
vm.aPlus = 3
vm.a       // => 2
vm.aDouble // => 4
</script>
```

### 2.5 methods 共有选项

方法全部改为 es5 写法编写,不要写成 ES6 ，即不应该使用箭头函数来定义 method 函数 (例如 plus: () => this.a++)。理由是箭头函数绑定了父级作用域的上下文，所以 this 将不会按照期望指向 Vue 实例，this.a 将是 undefined。

```JS
//new Vue({})
<div id="app">
 {{a}}
  <button v-on:click="plus">Add 1</button>
</div>
<script>
var vm = new Vue({
  el:'#app',
  data: {
    a: 1
  },
  methods: {
    plus:function() {
      this.a++
    }
  }
})
</script>
```

```html
<!-- export default{}------------ -->
<template>
  <div class="home">
    {{a}}
    <button v-on:click="plus">Add 1</button>
  </div>
</template>
<script>
export default {
  name:'Home',
  data() {
    return{
      a: 1
    }
  },
  methods: {
    plus() {
      this.a++
    }
  }
})
</script>
```

### 2.6 watch 共有选项????是不是应该用function？？

一个对象，键是需要观察的表达式，值是对应回调函数。值也可以是方法名，或者包含选项的对象。
不应该使用箭头函数来定义 watcher 函数 (例如 searchQuery: newValue => this.updateAutocomplete(newValue))。理由是箭头函数绑定了父级作用域的上下文，所以 this 将不会按照期望指向 Vue 实例，this.updateAutocomplete 将是 undefined。

```html
<!-- new Vue({}) -->
<div id="app">
 {{a}}
  <button v-on:click="plus">Add 1</button>
</div>
<script>
var vm = new Vue({
  data: {
    a: 1,
    b: 2,
    c: 3,
    d: 4,
    e: {
      f: {
        g: 5
      }
    }
  },
  watch: {
    a: function (val, oldVal) {
      console.log('new: %s, old: %s', val, oldVal)
    },
    b: 'someMethod',  // 方法名，直接调用someMethod方法
    c: {
      handler: function (val, oldVal) { /* ... */ },
      deep: true      // 深度 watcher，参数 deep 的默认值是 false
    },
    d: {
      handler: function (val, oldVal) { /* ... */ },
      immediate: true  // 该回调将会在侦听开始之后被立即调用
    },
    e: [               //监听对象
      function handle1 (val, oldVal) { /* ... */ },
      function handle2 (val, oldVal) { /* ... */ }
    ],
    'e.f': function (val, oldVal) { /* ... */ } // watch vm.e.f's value: {g: 5}
  },
  methods: {
    someMethod: function () {
      lert("b is changed");
    }
  }
})
vm.a = 2 // => new: 2, old: 1
</script>
```

```HTML
<!-- 这里是export default{} -->
<template>
  <div class="home">
    <div>{{ here }}</div>
    <div> {{ a }}-{{ b }}-{{ c }}-{{ d }}</div>
    <div>{{ e.f.g }}</div>
    <button @click="plus">Add  1</button>
  </div>
</template>

<script>
export default {
  name: 'Home',
  props: {
    here: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      name: 'xiaomi',
      a: 1,
      b: 2,
      c: 3,
      d: 4,
      e: {
        f: {
          g: 5
        }
      }
    }
  },
  computed: {
    // 仅读取
    aDouble () {
      return this.a * 2
    },
    // 读取和设置
    aPlus: {
      get () {
        return this.a + 1
      },
      set (v) {
        this.a = v - 1
      }
    }
  },
  watch: {
    a (val, oldVal) {
      console.log('new: %s, old: %s', val, oldVal)
    },
    b: 'someMethod', // 方法名，直接调用 someMethod 方法
    c: {
      handler (val, oldVal) { /* ... */ },
      deep: true // 深度 watcher，参数 deep 的默认值是 false
    },
    d: {
      handler (val, oldVal) { /* ... */ },
      immediate: true // 该回调将会在侦听开始之后被立即调用
    },
    e: [ // 监听对象
      function handle1 (val, oldVal) { /* ... */ },
      function handle2 (val, oldVal) { /* ... */ }
    ],
    'e.f' (val, oldVal) { /* ... */ } // watch vm.e.f's value: {g: 5}
  },
  methods: {
    plus () {
      this.a++
      this.b++
      this.c++
      this.d++
      this.g++
    },
    someMethod () {
      alert('b is changed')
    }
  }
}
</script>

<style >
</style>
```

### 2.7 template 共有选项 ？？？？

一个字符串模板作为 Vue 实例的标识使用。模板将会 替换 挂载的元素。挂载元素的内容都将被忽略，除非模板的内容有分发插槽。

如果值以 # 开始，则它将被用作选择符，并使用匹配元素的 innerHTML 作为模板。常用的技巧是用 `<script type="x-template">` 包含模板。

出于安全考虑，你应该只使用你信任的 Vue 模板。避免使用其他人生成的内容作为你的模板。如果 Vue 选项中包含渲染函数，该模板将被忽略。

```HTML
<div id="app">11</div>
<script>
new Vue({
  el: '#app',
  store,
  router,
  components: {App},
  template: '<App/>'  这里什么鬼用啊？
})
</script>
```

```JS
//全局API创建组件？？？？default中呢？
Vue.component('custom-input', {
  props: ['value'],
  template: `
    <input
      v-bind:value="value"
      v-on:input="$emit('input', $event.target.value)"
    >
  `
})
```

### 2.8 render 渲染函数？？？？？ 共有选项

字符串模板的代替方案，允许你发挥 JavaScript 最大的编程能力。该渲染函数接收一个 createElement 方法作为第一个参数用来创建 VNode。

如果组件是一个函数组件，渲染函数还会接收一个额外的 context 参数，为没有实例的函数组件提供上下文信息。
Vue 选项中的 render 函数若存在，则 Vue 构造函数不会从 template 选项或通过 el 选项指定的挂载元素中提取出的 HTML 模板编译渲染函数。

Vue 推荐在绝大多数情况下使用 template 来创建你的 HTML。然而在一些场景中，你真的需要 JavaScript 的完全编程的能力，这就是 render 函数，它比 template 更接近编译器。

### 2.9 renderError错误时渲染函数？？？？？ 共有选项

只在开发者环境下工作。

当 render 函数遭遇错误时，提供另外一种渲染输出。其错误将会作为第二个参数传递到 renderError。这个功能配合 hot-reload 非常实用。

```JS
new Vue({
  render (h) {
    throw new Error('oops')
  },
  renderError (h, err) {
    return h('pre', { style: { color: 'red' }}, err.stack)
  }
}).$mount('#app')
```

### 2.10 周期函数/钩子函数  共用选项

- beforeCreate () {},
- created () {},
- beforeMount () {},
- mounted () {},
- beforeUpdate () {},
- updated () {},
- activated () {},
- deactivated () {},
- beforeDestroy () {},
- destroyed () {},
- errorCaptured () {},

### 2.11 directives 局部自定义组件 共有选项

```HTML
<template>
  <div class="home">
    <p v-focus>22</p>
  </div>
</template>

<script>
export default {
  name: 'Home',
  directives: {
    focus: { // 组件局部指令的定义
      bind: function (el) {
        //el.focus()  这个函数什么鬼意思?
        el.innerHTML ='xiaomi'
      }
    }
  }
}
//最后得到的是 xiaomi 这个字符串而不是 22
</script>
```

#### 2.11.1 自定义指令的周期函数/钩子函数

钩子函数
一个指令定义对象可以提供如下几个钩子函数 (均为可选)：

- bind: function (el,binding,vnode,oldVnode) {}
    只调用一次，指令第一次绑定到元素时调用。在这里可以进行一次性的初始化设置。
- inserted: function (el,binding,vnode,oldVnode) {}
    被绑定元素插入父节点时调用 (仅保证父节点存在，但不一定已被插入文档中)。
- update: function (el,binding,vnode,oldVnode) {}
    所在组件的 VNode 更新时调用，但是可能发生在其子 VNode 更新之前。指令的值可能发生了改变，
    也可能没有。但是你可以通过比较更新前后的值来忽略不必要的模板更新 (详细的钩子函数参数见下)。
- componentUpdated：指令所在组件的 VNode 及其子 VNode 全部更新后调用。
- unbind：只调用一次，指令与元素解绑时调用。

#### 2.11.2 钩子函数的参数 (即 el、binding、vnode 和 oldVnode)。

- el：指令所绑定的元素，可以用来直接操作 DOM 。
- binding：一个对象，包含以下属性：
    name：指令名，不包括 v- 前缀。
    value：指令的绑定值，例如：v-my-directive="1 + 1" 中，绑定值为 2。
- oldValue：指令绑定的前一个值，仅在 update 和 componentUpdated 钩子中可用。无论值是否改变都可用。
    expression：字符串形式的指令表达式。例如 v-my-directive="1 + 1" 中，表达式为 "1 + 1"。
    arg：传给指令的参数，可选。例如 v-my-directive:foo 中，参数为 "foo"。
    modifiers：一个包含修饰符的对象。例如：v-my-directive.foo.bar 中，
    修饰符对象为 { foo: true, bar: true }。
- vnode：Vue 编译生成的虚拟节点。移步 VNode API 来了解更多详情。
- oldVnode：上一个虚拟节点，仅在 update 和 componentUpdated 钩子中可用。

除了 el 之外，其它参数都应该是只读的，切勿进行修改。如果需要在钩子之间共享数据，建议通过元素的 dataset 来进行。

#### 2.11.3 钩子函数简写/默认包含 bind 和 update 钩子

```JS
Vue.directive('color-swatch', function (el, binding) {
  el.style.backgroundColor = binding.value
  //这里面是 bind 和 update 时候执行的语句
})
```

### 2.12 filters  共有选项？？？？？？

注册或获取全局过滤器。

// 注册
Vue.filter('my-filter', function (value) {
  // 返回处理后的值
})

// getter，返回已注册的过滤器
var myFilter = Vue.filter('my-filter')

### 2.13 components  共有选项

局部注册组件
局部注册组件局部注册组件和全局注册组件是相对应的，局部注册的组件只能在组件注册的作用域里进行使用，其他作用域使用无效。 （在不同 id 的 Vue 里面，作用就不一样）局部注册其实就是写在构造器里，需要注意的是，构造器里的 components 是加s的，而全局注册是不加s的。因为局部这样定义定义多个组件。对于 components 对象中的每个属性来说，其属性名就是自定义元素的名字(因此是要带字符串的),其属性值就是这个组件的选项对象

```JS
<div id="app">11</div>
<script>
new Vue({
  el: '#app',
  store,
  router,
  components: {App}, //这里注册APP组件
  template: '<App/>'  
})
</script>
```

```JS
  <div id="app">
    <zihua></zihua>
  </div>
  <div id="app1">
    <zihua></zihua>
    在这里使用这个组件标签是没有效果的，因为 zihua 局部组件是在 app 中注册的， app1 中没法使用
  </div>
  <script>
    var vmapp = new Vue({
      el: '#app',
      components: {
        'zihua': {
          template: '<p>我是局部组件</p>'
        }
      }
    })
  </script>
```

```JS
//把模板写在外面，赋值给变量
  <div id="app">
    <zihua></zihua>
    <zihua-a></zihua-a>
    <zihua-b></zihua-b>
  </div>
  <script>
    var component = {
        template: '<p>我是局部组件1</p>'
      },
      componentA = {
        template: '<p>我是局部组件2</p>'
      },
      componentB = {
        template: '<p>我是局部组件3</p>'
      };
    var vmapp = new Vue({
      el: '#app',
      components: {
        'zihua': component,
        'zihua-a': componentA,
        'zihua-b': componentB
      }
    })
  </script>
```

注意：组件名的要求

在注册一个组件的时候，我们始终需要给它一个名字。比如在全局注册的时候我们已经看到了：
`Vue.component('my-component-name', { /* ... */ })`该组件名就是 Vue.component 的第一个参数。
你给予组件的名字可能依赖于你打算拿它来做什么。当直接在 DOM 中使用一个组件 (而不是在字符串模板或单文件组件) 的时候，我们强烈推荐遵循 W3C 规范中的自定义组件名 (字母全小写且必须包含一个连字符)。这会帮助你避免和当前以及未来的 HTML 元素相冲突。你可以在风格指南中查阅到关于组件名的其它建议。

#### 2.13.1 父子组件

在实际开发中我们经常会遇到在一个自定义组件中要使用其他自定义组件，这就需要一个父子组件关系。

```HTML
<div id="app">
  <panda>
    <!-- 父组件 -->
    <city></city>
    <!-- 子组件 -->
  </panda>
</div>
<script>
  var panda = {
    template: `<p> panda form China <city></city></p>`,
    components: {
      'city': {
        template: `<span>city of Guangxi</span>`
      }
    }
  }
  var vmapp = new Vue({
    el: '#app',
    components: {
      'panda': panda
    }
  })

  //或者写成，但是上面更好，用一个变量来代替，把代码写在构造函数外边是比较好的选择。
  var vmapp = new Vue({
      el: '#app',
      components: {
        'panda': {
          template: `<p> panda form China <city></city></p>`,
          components: {
            'city': {
              template: `<span>city of Guangxi</span>`
            }
          }
        }
      }
    })
</script>
```

#### 2.13.2 内置组件`<component>`

`<component></component>`标签是 Vue 框架内部定义的标签，它的用途就是可以动态绑定我们的组件，根据数据的不同更换不同的组件。在 vue-cli 中用的是路由啦控制子组件，这个貌似也没有什么用处。

```HTML
<div id="app">
    <component v-bind:is="whichComponent"></component>
    <button @click="changeComponent">changeComponent</button>
  </div>
  <script>
    var componentA = {
        template: `<p style="color:red;">I am  A</p>`,
        props: ['massage']
      },
      componentB = {
        template: `<p style="color:pink;">I am  B</p>`
      },
      componentC = {
        template: `<p style="color:gray">I am  C</p>`
      };
    var vmapp = new Vue({
      el: '#app',
      data: {
        massage: 18,
        whichComponent: 'componentA'
      },
      components: {
        'componentA': componentA,
        'componentB': componentB,
        'componentC': componentC,
      },
      methods: {
        changeComponent: function () {
          switch (this.whichComponent) {
            case 'componentA':
              this.whichComponent = 'componentB';
              break;
            case 'componentB':
              this.whichComponent = 'componentC';
              break;
            default:
              this.whichComponent = 'componentA';
              break;
          }
        }
      }
    })
  </script>
  ```

### 2.14 mixins 共有选项？？？

mixins 选项接受一个混入对象的数组。这些混入实例对象可以像正常的实例对象一样包含选项，他们将在 Vue.extend() 里最终选择使用相同的选项合并逻辑合并。举例：如果你的混入包含一个钩子而创建组件本身也有一个，两个函数将被调用。
Mixin 钩子按照传入顺序依次调用，并在调用组件自身的钩子之前被调用。

Mixins一般有两种用途：

- 1、在你已经写好了构造器后，(项目已经上线了，或者是项目经理又要添加一些新功能)需要增加方法或者临时的活动时使用的方法。不想去改变之前已经写好的构造器。这时用混入会减少源代码的污染。
- 2、很多地方都会用到的公用方法，用混入的方法可以减少代码量，实现代码重用。

```HTML
  <div id="app">
    <p>{{num}}</p>
    <button v-on:click="add">add</button>
  </div>
  <script>
    Vue.mixin({
      updated: function () {
        console.log('全局方式混入');
      }
    })
    //这个也要写在Vue的上边，
    var appconsoleObject = {
      updated: function () {
        console.log("数据改变成了" + this.num);
      }
    }

    //上面的代码为什么一定要写在vue的前面，写在下面会出错？？？？？？
    var vmapp = new Vue({
      el: '#app',
      data: {
        num: 18
      },
      methods: {
        add: function () {
          this.num++;
        }
      },
      updated: function () {
        console.log("vue构造器的原生updated钩子");
      },
      mixins: [appconsoleObject]
    })
    /* 假如上面是我们已经完成的代码编辑，但是后期有要求要添加什么内容。
    我们不希望去修改原来的代码， 而是在外边去添加代码去添加新的功能。
    就是下面这样来添加。
      var appconsoleObject = {
      updated: function () {
        console.log("数据改变成了" + this.num);
      }
    }
    当然还是要在原来的 vue 里面添加一小行代码的，
    mixins: [appconsoleObject]  这个数组来表示这段外部的 diamante 是添加到哪里的 */

    /* 如果这时我们希望每次数据变化时都能够在控制台打印出提示：“数据发生变化”. 
        这里就是mixins的第一个作用。
      1、在你已经写好了构造器后，(项目已经上线了，或者是项目经理又要添加一些新功能)
          需要增加方法或者临时的活动时使用的方法。不想去改变之前已经写好的构造器。
          这时用混入会减少源代码的污染。 */
    /*     注意： 外部对象混入的的周期函数与 vue 内部的周期函数是有区别的，
        混入的函数要比 vue 内部的函数先执行
        从执行的先后顺序来说，都是混入的先执行，然后构造器里的再执行，
        需要注意的是，这并不是方法的覆盖，而是被执行了两边。  
        当混入方法和构造器的方法重名时，混入的方法无法展现，也就是不起作用。*/
  /*     ② 作用二学习
        <!--Mixins 一般有两种用途：
          1、在你已经写好了构造器后，(项目已经上线了，或者是项目经理又要添加一些新功能)
            需要增加方法或者临时的活动时使用的方法。不想去改变之前已经写好的构造器。
            这时用混入会减少源代码的污染。
          2、很多地方都会用到的公用方法，用混入的方法可以减少代码量，实现代码重用。
          就是单独的写成一个js用在其他的 --> */

    /*    全局API混入方式
            我们也可以定义全局的混入，这样在需要这段代码的地方直接引入js，就可以拥有这个功能了。
            我们来看一下全局混入的方法： */
    /* 全局混入的执行顺序要前于混入和构造器里的方法。 */
  </script>
```

### 2.15 extends 共有选项？？

允许声明扩展另一个组件(可以是一个简单的选项对象或构造函数)，而无需使用 Vue.extend。这主要是为了便于扩展单文件组件。

通过外部增加对象的形式，对构造器进行扩展。它和混入非常的类似。稍微有点区别

```HTML
<div id="app">
    <p>{{num}}</p>
    <button v-on:click="add">add</button>
  </div>
  <script>
    var ExtendsObject = {
      updated: function () {
        console.log(" extends的update")
      },
      methods: {
        /*         add: function () {
                  console.log("extends 的方法")
                } 方法名与原生的 Vue 方法重名，这里就不会被执行了 */
        /*         addnum: function () {
                  console.log("extends 的方法")
                }   这样写也是不能被执行的*/
      }
    }
    var vmapp = new Vue({
      el: '#app',
      data: {
        num: 18
      },
      methods: {
        add: function () {
          this.num++;
          console.log("Vue原生方法")
        }
      },
      updated: function () {
        console.log("Vue原生updated")
      },
      extends: ExtendsObject
      //扩展在 vue 里面放的是对象，24 节混入放的是数组，扩展只能有一个，混入可以是很多个。
    })
  </script>
  ```

### 2.16 provide / inject 共有选项？？？

provide 和 inject 主要为高阶插件/组件库提供用例。并不推荐直接用于应用程序代码中。
这对选项需要一起使用，以允许一个祖先组件向其所有子孙后代注入一个依赖，不论组件层次有多深，并在起上下游关系成立的时间里始终生效。如果你熟悉 React，这与 React 的上下文特性很相似。

provide 选项应该是一个对象或返回一个对象的函数。该对象包含可注入其子孙的属性。在该对象中你可以使用 ES2015 Symbols 作为 key，但是只在原生支持 Symbol 和 Reflect.ownKeys 的环境下可工作。

inject 选项应该是：

一个字符串数组，或
一个对象，对象的 key 是本地的绑定名，value 是：
在可用的注入内容中搜索用的 key (字符串或 Symbol)，或
一个对象，该对象的：
from 属性是在可用的注入内容中搜索用的 key (字符串或 Symbol)
default 属性是降级情况下使用的 value
提示：provide 和 inject 绑定并不是可响应的。这是刻意为之的。然而，如果你传入了一个可监听的对象，那么其对象的属性还是可响应的。

### 2.17 delimiters 共有选项

delimiters 的作用是改变我们插值的符号。Vue 默认的插值是双大括号{{xxx}}。但有时我们会有需求更改这个插值的形式。

```HTML
<div id="app">
    <p>${num}</p>
    <button v-on:click="add">add</button>
  </div>
  <script>
    var vmapp = new Vue({
      el: '#app',
      data: {
        num: 18
      },
      methods: {
        add: function () {
          this.num++;
          console.log("Vue 原生方法")
        }
      },
      delimiters: ['${', '}']
      //这里指的是将构造器改为 ${}，
      //['${', '}'] 这里是 2 项数组
      //现在我们的插值形式就变成了 ${}。
    })
  </script>
  ```

### 2.18 functional

### 2.19 model

### 2.20 inheritAttrs

### 2.21 comments

## 三、实例属性

### 3.1 vm.$el

### 3.2 vm.$props

### 3.3 vm.$data

### 3.4 vm.$options  用于当前 Vue 实例的初始化选项。需要在选项中包含自定义属性时会有用处：

```JS
new Vue({
  customOption: 'foo',
  created: function () {
    console.log(this.$options.customOption) // => 'foo'
  }
})
```

### 3.5 vm.$parent  父实例

### 3.6 vm.$root  当前组件树的根 Vue 实例。如果当前实例没有父实例，此实例将会是其自己。

### 3.7 vm.$children 当前实例的直接子组件。

需要注意 $children 并不保证顺序，也不是响应式的。如果你发现自己正在尝试使用 $children 来进行数据绑定，考虑使用一个数组配合 v-for 来生成子组件，并且使用 Array 作为真正的来源。

### 3.8 vm.$slots 用来访问被插槽分发的内容。

每个具名插槽 有其相应的属性 (例如：slot="foo" 中的内容将会在 vm.$slots.foo 中被找到)。default 属性包括了所有没有被包含在具名插槽中的节点。在使用渲染函数书写一个组件时，访问 vm.$slots 最有帮助。

### 3.9 vm.$scopedSlots