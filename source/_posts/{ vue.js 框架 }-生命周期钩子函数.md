---
title: 'vue--[ 生命周期钩子函数]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

## 一、前言

生命周期是一个重点，也是比较难以区分的选项。

## 二、生命周期

![周期图解](http://liuxmoo.foryung.com/20180203220502151.png)

在谈到 Vue 的生命周期的时候，我们首先需要创建一个实例，也就是在 new Vue ( ) 的对象过程当中，首先执行了 init（init 是 vue 组件里面默认去执行的），在 init 的过程当中首先调用了 beforeCreate，然后在 injections（注射）和 reactivity（反应性）的时候，它会再去调用 created。所以在 init 的时候，事件已经调用了，我们在beforeCreate 的时候千万不要去修改 data 里面赋值的数据，最早也要放在 created 里面去做（添加一些行为）。

当 created 完成之后，它会去判断 instance（实例）里面是否含有 “el”option（选项），如果没有的话，它会调用 vm.$mount(el) 这个方法，然后执行下一步；如果有的话，直接执行下一步。紧接着会判断是否含有 “template” 这个选项，如果有的话，它会把 template 解析成一个 render function ，这是一个 template 编译的过程，结果是解析成了render 函数：

```JS
render (h) {
  return h('div', {}, this.text)
}
```

render 函数里面的传参 h 就是 Vue 里面的 createElement 方法，return 返回一个 createElement 方法，其中要传 3 个参数，第一个参数就是创建的 div 标签；第二个参数传了一个对象，对象里面可以是我们组件上面的 props，或者是事件之类的东西；第三个参数就是 div 标签里面的内容，这里我们指向了 data 里面的 text。

使用 render 函数的结果和我们之前使用 template 解析出来的结果是一样的。render 函数是发生在 beforeMount 和 mounted 之间的，这也从侧面说明了，在 beforeMount 的时候，$el 还只是我们在  HTML 里面写的节点，然后到 mounted 的时候，它就把渲染出来的内容挂载到了 DOM 节点上。这中间的过程其实是执行了 render function 的内容。

在使用 .vue 文件开发的过程当中，我们在里面写了 template 模板，在经过了 vue-loader 的处理之后，就变成了 render function，最终放到了 vue-loader 解析过的文件里面。这样做有什么好处呢？原因是由于在解析 template 变成 render function 的过程，是一个非常耗时的过程，vue-loader 帮我们处理了这些内容之后，当我们在页面上执行vue 代码的时候，效率会变得更高。

beforeMount 在有了 render function 的时候才会执行，当执行完 render function 之后，就会调用 mounted 这个钩子，在 mounted 挂载完毕之后，这个实例就算是走完流程了。

后续的钩子函数执行的过程都是需要外部的触发才会执行。比如说有数据的变化，会调用 beforeUpdate，然后经过 Virtual DOM，最后 updated 更新完毕。当组件被销毁的时候，它会调用 beforeDestory，以及 destoryed。

以上就是 vue实例从新建到销毁的一个完整流程，以及在这个过程中它会触发哪些生命周期的钩子函数。


```JS
  data(){
    return{
      message:'xxx'
    }
  },
  beforeCreate(){
  // 状态：实例初始化之后，this 指向创建的实例。**数据观测 (data observer)** 和 **event/watcher 事件配置** 之前被调用。
  //      此时 $el 和 data 都为 undefined,没有初始化
  // 场景：常用于初始化非响应式变量。不能直接访问到 data、computed、watch、methods 上的方法和数据

  // 实际应用：
  //         可以进行 loading 事件 之类的动画加载，在加载实例时触发（就是避免 created 出现白屏，在这个钩子做的一个动画加载 ），在 created 时进行移除
  //         但是通常我们使用 css 来做到 loading 的效果，没有接触到使用 js 来做的。
  
  //面试题：vue 怎么在 beforeCreate 里获取 data
  // 实际上 data 的是 created() 初始化的，但是我们要在这里获取数据的话，就需要是使用到 this.$nextTick(callBack) 异步操作。
  // 这个 this.$nextTick 可以使得里面的 回调函数 到下次 DOM 更新循环结束后才会执行。（循环：数据更新--下一次数据更新之前）
  // this.$nextTick(function () {
  //   console.log(this.message);
  // })
  // 但是我们还是不要去这样做吧？ vue 给了我们什么周期该干什么就干什么，这样才能很好的利用啊。
  }
  created(){
    // 状态：在实例创建完成后被立即调用。，可访问 data、computed、watch、methods 上的方法和数据，未挂载到 DOM，不能访问到 $el 属性，$ref 属性内容为空数组
    //      创建后 data 初始化了,而 $el 没有
    // 场景：对 data 数据进行操作，常用于简单的 ajax 请求，页面初始化，将 ajax 请求将返回的数据赋给 data，还可以进行网络接口的请求操作；

    // 实际应用：
    //        在这结束 loading，然后做一些数据的初始化，实现函数自执行（这个在 Vue 的生命周期只会执行一次）

    // 实际工作：假如你需要中 vux 中取数据，在模版中使用，那么你需要在 dom 挂载之前获取到数据，这个操作就在 created 里面做
    //问题：页面视图未出现，如果请求信息过多，页面会长时间处于白屏状态
  }
  beforeMount(){
    // 状态：在挂载开始之前被调用，beforeMount 之前，会找到对应的 template，并编译成 render 函数
    //      $el和data都初始化了

    //在挂载开始之前被调用：相关的 render 函数首次被调用。
  }
  mounted(){
    // 状态：实例挂载到 DOM 上，此时可以通过 DOM API 获取到 DOM 节点，$ref 属性可以访问
    // 场景：常用于获取 VNode 信息和操作，ajax 请求，也可以进行后台获取数据操作

    // 实际应用：
    //        在这发起后端请求，拿回数据，配合路由钩子做一些事情 （会经常进行数据处理和更新）

    //el 提供一个在页面上已存在的 DOM 元素作为 Vue 实例的挂载目标
    //注意 mounted 不会承诺所有的子组件也都一起被挂载。如果你希望等到整个视图都渲染完毕，可以用 vm.$nextTick 替换掉 mounted：
    // 实际工作：如果需要手工操作 dom 或者其它非 vue 插件需要操作 dom，那么必须得在 dom 生成后，那这时候就得在 mounted 触发。
    // 问题：不会承诺所有的子组件也都一起被挂载。如果你希望等到整个视图都渲染完毕，可以用 this.$nextTick
  }
  beforeUpdate(){
    //状态：响应式数据更新时调用之前，发生在虚拟 DOM 打补丁之前。
    //场景：适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。

    // 实际应用：
    //        因为在 mounted 的时候就会经常进行数据的更新，所以就没必要在这个生命周期进行数据处理了
    //        可以做一个确认停止事件的确认框 nextTick : 更新数据后立即操作dom
  }
  updated(){
    //状态：虚拟 DOM 重新渲染和打补丁之后调用，组件 DOM 已经更新，可执行依赖于 DOM 的操作
    //      由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。
    //updated 不会承诺所有的子组件也都一起被重绘。如果你希望等到整个视图都重绘完毕，可以用 vm.$nextTick 替换掉 updated
    // 避免在这个钩子函数中操作数据，可能陷入死循环

    // 实际应用：
    //        对数据统一处理，在这里写上相应函数
  }
  activated(){
    //keep-alive 组件激活时调用。
    //在使用 vue-router 时有时需要使用 <keep-alive></keep-alive>来缓存组件状态，这样可以避免 created 钩子就不会被重复调用了，
    //场景：如果我们的子组件需要在每次加载的时候进行某些操作，可以使用 activated 钩子触发。
  }
  deactivated(){
    //keep-alive 组件停用时调用。
  }
  beforeDestroy(){
    // 状态：实例销毁之前调用。这一步，实例仍然完全可用，this 仍能获取到实例
    // 场合：常用于销毁定时器、解绑全局事件、销毁插件对象等操作

    // 实际应用：你确认删除 XX 吗、 点击下一步的时候、或者需要是存浏览器储存的时候、清除定时器等等，
    //          因为 vue 是一个单页面，如果定时器在 vue 生命周期销毁之前不清除的话，那就会导致定时器一直在运行，影响性能!!!!!!!!!!!!
  }
  destroyed(){
    //场合：Vue 实例销毁后调用，调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁
    //调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。

    // 实际应用；
    //        当前组件已被删除，清空相关内容。下一步，跳转路由。等等？？？？？？？？？？不懂这里
  }
  errorCaptured(err,vm,info){
    //当捕获一个来自子孙组件的错误时被调用。
    //(err: Error, vm: Component, info: string) => ?boolean
    //错误对象，发生错误的组件实例，错误来源信息的字符串
    //此钩子可以返回 false 以阻止该错误继续向上传播。
  }
```

### 2.1 created 阶段的 ajax 请求与 mounted 请求的区别：

* created：页面视图未出现，如果请求信息过多，页面会长时间处于白屏状态
* mounted ：不会承诺所有的子组件也都一起被挂载。如果你希望等到整个视图都渲染完毕，可以用 this.$nextTick

### 2.2 生命周期的执行情况

>单组件

* 初始化组件时，仅执行了beforeCreate、created、beforeMount、mounted 四个钩子函数（执行一次）
* 当改变 data 中定义的变量（响应式变量）时，会执行 beforeUpdate、updated 钩子函数（ -----可多次执行）
* 当切换组件（当前组件未缓存）时，会执行 beforeDestory、destroyed        钩子函数（执行一次）
* 初始化和销毁时的生命钩子函数均只会执行一次，beforeUpdate、updated 可多次执行

>父子组件

* 仅当子组件完成挂载后，父组件才会挂载
* 当子组件完成挂载后，父组件会主动执行一次beforeUpdate/updated钩子函数（仅首次）
* 父子组件在data变化中是分别监控的，但是在更新props中的数据是关联的（可实践）
* 销毁父组件时，先将子组件销毁后才会销毁父组件

1.父 beforeCreate、created、beforeMount
2.子 beforeCreate、created、beforeMount、mounted
3.父 mounted、beforeUpdate、updated（加载子组件之后自动的执行一次更新：理论上单组件的更新钩子是由于用户的操作 数据更新才会执行的，
                                  里相当于 子组件使得父组件的数据更新了）

4.在这里中间，如果用户操作数据更新，相应的执行父子组件中的周期钩子函数 beforeUpdate、updated。各自数据更新，执行各自的（自己的 data 改变，互不相干）
5.如果 props 发生改变，（父子有关系的）执行 父 beforeUpdate → 子 beforeUpdate → 子 updated → 父 updated
6.子组件销毁，子组件的 beforeDestory、destroyed
7.父组件销毁，子组件的  父 beforeDestory → 子 beforeDestory → 子 destroyed → 父 destroyed

> 父、兄弟组件的生命周期

* 组件的初始化（mounted 之前）分开进行，挂载是从上到下依次进行
* 当没有数据关联时，兄弟组件之间的更新和销毁是互不关联的

给子组件增加兄弟姐妹之后

1.父 beforeCreate、created、beforeMount
2.子一 beforeCreate、created、beforeMount
  子二 beforeCreate、created、beforeMount
  子一 mounted
  子二 mounted
3.父 mounted、beforeUpdate、updated（加载子组件之后自动的执行一次更新：理论上单组件的更新钩子是由于用户的操作 数据更新才会执行的，
                                  里相当于 子组件使得父组件的数据更新了）

4.在这里中间，如果用户操作数据更新，相应的执行父子组件中的周期钩子函数 beforeUpdate、updated。各自数据更新，执行各自的（自己的 data 改变，互不相干）
  子一更新数据：子一 beforeUpdate、updated
  子二更新数据：子二 beforeUpdate、updated
5.如果 props 发生改变，（父子有关系的）执行 父 beforeUpdate → 子 beforeUpdate → 子 updated → 父 updated
6.子组件销毁，子组件的 beforeDestory、destroyed
7.父组件销毁，子组件的  父 beforeDestory → 子一 beforeDestory → 子一 destroyed → 子二 beforeDestory → 子二 destroyed → 父 destroyed

>宏 mixin 的生命周期

* mixin 中的生命周期与引入该组件的生命周期是紧密关联的，且 mixin 的生命周期优先执行

1.mixin-beforeCreate 、beforeCreate、mixin-created、created、mixin-beforeMount、beforeMount、mixin-mounted、mounted
  如果有子组件，就会在 beforeMount 与  mounted 之间去执行
2.mixin-beforeUpdate、beforeUpdate、mixin-updated、updated
3.mixin-beforeDestory、beforeDestory、mixin-destroyed 、destroyed
  如果有子组件，就会在 beforeDestory 与 destroyed 之间去执行

总结执行顺序，对照 DOM 事件的捕获和冒泡过程来看：

* beforeCreate 、 created 、 beforeUpdate 、 beforeDestroy 是在“捕获”过程中调用的；
* mounted 、 updated 、 destroyed 是在“冒泡”过程中调用的。

同时，可以看到，在初始化流程、 update 流程和销毁流程中，子级的相应声明周期方法都是在父级相应周期方法之间调用的。
比如子级的初始化钩子函数（ beforeCreate 、 created 、 mounted ）都是在父级的 created 和 mounted 之间调用的，
这实际上说明等到子级准备好了，父级才会将自己挂载到上一层 DOM 树中去，从而保证界面上不会闪现脏数据。

## 三、实际应用

根据第二章的总结，对照 DOM 事件的捕获和冒泡过程来看：

* beforeCreate 、 created 、 beforeUpdate 、 beforeDestroy 是在“捕获”过程中调用的；
* mounted 、 updated 、 destroyed 是在“冒泡”过程中调用的。

同时，可以看到，在初始化流程、 update 流程和销毁流程中，子级的相应声明周期方法都是在父级相应周期方法之间调用的。
比如子级的初始化钩子函数（ beforeCreate 、 created 、 mounted ）都是在父级的 created 和 mounted 之间调用的，
这实际上说明等到子级准备好了，父级才会将自己挂载到上一层 DOM 树中去，从而保证界面上不会闪现脏数据。