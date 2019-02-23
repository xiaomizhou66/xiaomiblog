---
title: 'vue.js--事件 以及 vue 中的所有修饰符学习'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

# 一、前言

# 二、事件触发

## 2.1 v-on 事件绑定指令

[官网地址：](https://cn.vuejs.org/v2/guide/events.html)

>v-on 就是监听事件，可以用v-on指令监听DOM事件来触发一些javascript代码。  
语法：`v-on:click="函数变量"`
用@简写的语法：`@click="函数变量"`
**键盘回车事件**`v-on:keyup.enter="函数"`

## 2.2 事件触发-不传参

```HTML
<body>
  <div id="app">
    <p v-text="massage"></p>
    <button v-on:click="add">点击massage自增</button>
    <button @click="subtract">点击massage自减</button>
  </div>
  <script>
    var vm = new Vue({
      el: '#app',
      data: {
        massage: 60,
      },
      methods: {
        add: function () {
          this.massage++;
        },
        subtract: function () {
          this.massage--;
        }
      }
    })
  </script>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/v-on.png)

## 2.3 事件触发-传参

```HTML
<div id="app">
  <button v-on:click="say('hi')">Say hi</button>
  <button v-on:click="say('what')">Say what</button>
</div>
<script>
new Vue({
  el: '#app',
  methods: {
    say: function (message) {
      alert(message)
    }
  }
})
</script>
```

## 2.4 特殊变量 $event

```HTML
<button v-on:click="warn('Form cannot be submitted yet.', $event)">
  Submit
</button>
<script>
  // ...
  methods: {
    warn: function (message, event) {
      // 现在我们可以访问原生事件对象
      if (event) event.preventDefault()
      alert(message)
    }
  }
</script>
```

# 三、事件修饰

## 3.1 事件修饰符

在事件处理程序中调用 event.preventDefault() 或 event.stopPropagation() 是非常常见的需求。尽管我们可以在方法中轻松实现这点，但更好的方式是：方法只有纯粹的数据逻辑，而不是去处理 DOM 事件细节。

为了解决这个问题，Vue.js 为 v-on 提供了事件修饰符。之前提过，修饰符是由点开头的指令后缀来表示的。

.stop
.prevent
.capture
.self
.once
.passive

```HTML
<a v-on:click.stop="doThis"></a><!-- 阻止单击事件继续传播 -->

<form v-on:submit.prevent="onSubmit"></form><!-- 提交事件不再重载页面 -->

<a v-on:click.stop.prevent="doThat"></a> <!-- 修饰符可以串联 -->

<form v-on:submit.prevent></form><!-- 只有修饰符 -->

<!-- 添加事件监听器时使用事件捕获模式 -->
<!-- 即元素自身触发的事件先在此处理，然后才交由内部元素进行处理 -->
<div v-on:click.capture="doThis">...</div>
<!-- 只当在 event.target 是当前元素自身时触发处理函数 -->
<!-- 即事件不是从内部元素触发的 -->
<div v-on:click.self="doThat">...</div>

<a v-on:click.once="doThis"></a><!-- 点击事件将只会触发一次 -->

<!-- 滚动事件的默认行为 (即滚动行为) 将会立即触发 -->
<!-- 而不会等待 `onScroll` 完成  -->
<!-- 这其中包含 `event.preventDefault()` 的情况 -->
<!-- 尤其能够提升移动端的性能。 -->
<div v-on:scroll.passive="onScroll">...</div>
```

使用修饰符时，顺序很重要；相应的代码会以同样的顺序产生。因此，用 v-on:click.prevent.self 会阻止所有的点击，而 v-on:click.self.prevent 只会阻止对元素自身的点击。

不要把 .passive 和 .prevent 一起使用，因为 .prevent 将会被忽略，同时浏览器可能会向你展示一个警告。请记住，.passive 会告诉浏览器你不想阻止事件的默认行为。

## 3.2 按键修饰符

### 3.2.1 keycode（keyCode 的事件用法已经被废弃了并可能不会被最新的浏览器支持。）

keycode 是数字代码，（例如，enter 键的 keycode 是 13 ）但是要记住这里数字是很困难的，这时候我们就会有别名的存在。

```HTML
<input v-on:keyup.13="submit"> <!--这个是 keycode 的方法，但是现在不要用了，已经被废弃了的。 -->
```

### 3.2.2 keycode 别名(为了在必要的情况下支持旧浏览器，Vue 提供了绝大多数常用的按键码的别名：)

```BASH
@keyup.enter          # 回车键
@keyup.tab            # tab 键
@keyup.delete         # 捕获“删除”和“退格”键)
@keyup.esc            # 退出
@keyup.space          # 空格键
@keyup.up             # 向上
@keyup.down           # 向下
@keyup.left           # 后退
@keyup.right          # 前进
@keyup.arrow-right
@keyup.media-play-pause # 暂停
@keyup.v               # V 字母键
```

```HTML
<!-- 下面的 3 行代码是等效的（前提是没有全局配置别名的时候） -->
<input v-on:keyup.13="submit"> <!--这个是 keycode 的方法，但是现在不要用了，已经被废弃了的。 -->
<input v-on:keyup.enter="submit">
<input @keyup.enter="submit">

<input type="text" @keyup.media-play-pause="method">
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.right="handleSubmit" />
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.arrow-right="handleSubmit" />
```

## 3.3 系统修饰键

.ctrl
.alt
.shift
.meta


请注意修饰键与常规按键不同，在和 keyup 事件一起用时，事件触发时修饰键必须处于按下状态。换句话说，只有在按住 ctrl 的情况下释放其它按键，才能触发 keyup.ctrl。而单单释放 ctrl 也不会触发事件。如果你想要这样的行为，请为 ctrl 换用 keyCode：keyup.17

```HTML
<!-- Alt + C -->
<input @keyup.alt.67="clear">

<!-- Ctrl + Click -->
<div @click.ctrl="doSomething">Do something</div>



<!-- .exact 修饰符允许你控制由精确的系统修饰符组合触发的事件。 -->

<!-- 即使 Alt 或 Shift 被一同按下时也会触发 -->
<button @click.ctrl="onClick">A</button>

<!-- 有且只有 Ctrl 被按下的时候才触发 -->
<button @click.ctrl.exact="onCtrlClick">A</button>

<!-- 没有任何系统修饰符被按下的时候才触发 -->
<button @click.exact="onClick">A</button>
```

## 3.4 鼠标按钮修饰符

.left
.right
.middle

这些修饰符会限制处理函数仅响应特定的鼠标按钮。

```HTML
<button @click.right="shout(1)">ok</button>
```

# 四、拓展

vue 中的所有修饰符的学习[RR](https://segmentfault.com/a/1190000016786254)