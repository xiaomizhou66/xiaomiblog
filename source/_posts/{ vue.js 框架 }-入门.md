---
title: 'vue.js--[小白入门篇]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

## 一、前言

在前面已经学习了 jQurey.js 这个框架，既然有这样一个框架方便我们使用，肯定会有更加方便的框架给我们使用，那就是 vue.js 了。
Jquery 专注于dom操作，步骤一般为：获取 dom 元素--> 跟 dom 元素赋值+加事件-->插入 dom 元素。 其中 dom 元素赋值和加事件又需要获取 dom 元素和给dom元素赋值，代码量会很大。

Vue 专注于数据：用户只需要关注 dom 元素值对应绑定的数据，每次 dom 需要修改只需要去修改数据就可以了。vue.js 背后做了大量的工作，我们可以简单的实现 html 与 js 之间的数据绑定，达到前后端数据的便捷绑定。

- vue 优势在于去 dom 操作和双线数据绑定。
- 由于 Vue 帮我们省略了dom 操作，加上双向数据绑定，Vue 的代码量减少很多，代码变得比较简洁，逻辑更加清晰。
- 由于多个 dom 事件可能会同时修改一个元素的值， Vue 只需要关注元素对应绑定的数据就可以了，这使得 Vue 在逻辑上会更加清晰

## 二、vue.js 的安装

### 2.1 Vue Devtools 调试工具

在安装 vue.js 之前，推荐在浏览器上安装 Vue Devtools。它允许你在一个更友好的界面中审查和调试 Vue 应用。让开发者方便调试代码。

### 2.2 独立版本引入

官网下载文件放置在项目目录下。如下引入 vue.js，这样 Vue 会被注册为一个全局变量

```JS
  <script src="../vue.js"></script>
  //注意开发使用开发版本 vue.js，生产上线用 vue.min.js 版本
```

### 2.3 CDN引入

[CDN链接]]。如下引入 vue.js，这样 Vue 会被注册为一个全局变量

```JS
  <script src="https://cdn.bootcss.com/vue/2.5.17-beta.0/vue.js"></script>
  //注意开发使用开发版本 vue.js，生产上线用 vue.min.js 版本
```

## 三、vue.js 的 vue 属性选项：数据绑定, DOM，JS 交互原理

- MVVM  : model view view model
- model:指数据
- view:页面(页面上面输入数据会影响model)

### 3.1 原始的 html/js/css 写法

```html
<!-- 这里是没有使用 vue-cli 的写法,原始的 html/css 写法-->
<head>
<style>
/* css... */
</style>
</head>

<body>
  <div id="app">
    {{ number }}
    <!-- 数据绑定 “Mustache” 语法 (双大括号) -->
  </div>

  <script>
    var appvm = new Vue({
      el: '#app', //①el选项/属性：提供一个在页面上已存在的 DOM 元素作为 Vue 实例的挂载目标。
      //只在由 new 创建的实例中遵守，这里是用new Vue创建的
      data: {  //②data选项/属性：与html中的数据绑定，实现双向绑定
        nunber:18
      },
      watch: {//监听数据的变化
        number: function (newnumber , oldnumber) {
        }
      }
      created: function () {
      },
      computed: { //计算属性
        reversedMessage: function () {
        },
      },
      methods: {  //方法
        reverseMessage: function () {
        }
      },
      beforeCreate: function () {
        console.log('1-beforeCreate 初始化之后');
      },
      created: function () {
        console.log('2-created 创建完成');
      },
      beforeMount: function () {
        console.log('3-beforeMount 挂载之前');
      },
      mounted: function () {
        console.log('4-mounted 被挂载之后');
      },
      beforeUpdate: function () {
        console.log('5-beforeUpdate 数据更新前');
      },
      updated: function () {
        console.log('6-updated 被更新后');
      },
      activated: function () {
        console.log('7-activated');
      },
      deactivated: function () {
        console.log('8-deactivated');
      },
      beforeDestroy: function () {
        console.log('9-beforeDestroy 销毁之前');
      },
      destroyed: function () {
        console.log('9-destroyed 销毁之后');
      },
      errorCaptured: function () {
        console.log('11-errorCaptured 发生错误');
      }
    })
  </script>
</body>
```

### 3.2 vue-cli脚手架框架中.vue的写法

```html
<!-- 这里是/vue文件 -->
<tempalate>
  <!-- html -->
  <div class="home">
    {{ number }}
    <!-- 数据绑定 “Mustache” 语法 (双大括号) -->
  </div>
</tempalate>

<script>
//这里是使用了 vue-cli 脚手架建立框架之后的写法,因为 .vue 文件都是导出给 js 文件使用的
export default { //做成导出件
  name: 'Home', //  这里是组件的名称
  data () {
    return {
      number: 18
    }
  },
  watch: {//监听数据的变化
    number: function (newnumber , oldnumber) {
    }
  },
  created() {
  },
  computed: { //计算属性
    reversedMessage: function () {
    }
  },
  methods: {  //方法
    reverseMessage() {
    }
  }
}
</script>

<style>
/* css */
</style>
```

## 四、vue 的指令学习（ html 指令/template）

vue 指令是用于 template，也即是 html 编辑的时候使用的。

### 4.1 v-text、v-html 数据双向绑定

- ①{{massage}}可以说这个是后面两个的简写，这个不是指令
- ②v-text 纯文本的双向绑定，这个是指令，vue 中指令都是在前面有v-
- ③v-html 带 html 元素/标签 的 DOM 文本绑定，这个是指令，vue 中指令都是在前面有v-

{{massage}}可以说这个是后面两个的简写，这是 vue 中常用的数据绑定。如此双向绑定之后，DOM 中显示会出现{{massage}}，在 new Vue 的 data 中获取到数据之后 替代掉{massage}}显示真正要展示的文本。简单的说{massage}}是写在标签内容区。
**而vue指令是写在html的开标签中的。**
v-text 是纯文本的绑定，会将 data 中的数据照搬过来，即使里面存在元素标签不会转化为 DOM 元素。
v-html 是 html 元素/标签 的 DOM 文本绑定，如果 data 中有的数据是带标签的，绑定之后会解析为 html 标签元素.

```html
<body>
  <div id="app">
    <p>{{ name }}</p>
    <p v-text="msg"></p>
    <p v-html="msg"></p>
    <p>{{ number + 1 }}简单的可以这样用</p>
    <p>{{ ok ? 'YES' : 'NO' }}</p>
    <p>{{ text.split( '').reverse().join( '') }}不建议在这里这样用，应该在 script 的方法里面处理</p>
  </div>
  <script>
    var appvm = new Vue({
      el: '#app',
      data: {
        name:'xiaomi',
        msg:'<span style="color:red">hello!</span>',
        nunber:18,
        ok: true,
        text: 'danger',
      }
    })
  </script>
</body>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/v-html.png)

注意：
值得注意的是使用 v-html 需要小心，跟 js 使用 innerHtml 一样，注入带元素的标签是非常危险的。
在生产环境中动态渲染 HTML 是非常危险的，因为容易导致 XSS 攻击。所以只能在可信的内容上使用 v-html，
永远不要在用户提交和可操作的网页上使用。 ？？？比如说？？？

XSS 攻击全称跨站脚本攻击，是为不和层叠样式表 (Cascading Style Sheets, CSS) 的缩写混淆，
故将跨站脚本攻击缩写为 XSS，XSS 是一种在 web 应用中的计算机安全漏洞，
它允许恶意 web 用户将代码植入到提供给其它用户使用的页面中。

### 4.2 v-if v-else   条件渲染指令

根据 v-if 绑定的数据的真假来选择渲染对象、方式、css 样式等等。

```HTML
  <div id="app">
    <div v-if="loginStatue" style="background: yellow;">您好！</div>
    <div v-else style="background: gray;">请登录</div>
  </div>

  <script>
    var vm = new Vue({
      el: '#app',
      data: {
        loginStatue: true //这里使得 v-if="loginStatue" 绑定的 loginStatue 为真。
        //将会选择v-if所在的语句显示，v-else语句将不会得到渲染出来
      }
    })
  </script>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/v-if.png)

将 true 更改为 false 得到下面的效果图。当然了实际应用中我们不是手动的来修改这个数据为 false 的，而是根据 methods 选项中的方法来触发数据的修改。
![xiaoguo](http://liuxmoo.foryung.com/v-else.png)

#### 4.2.1 v-if v-else-if v-else 多重语句，更多的语句进行条件渲染。

```HTML
<!-- 注意：这几个绑定一定要紧跟着，不然没有效果的。中间不能插入其他的不绑定的语句 -->
<div v-if="type === 'A'">
  A
</div>
<!-- 不能在这些地方添加其他没有绑定if的元素 -->
<div v-else-if="type === 'B'">
  B
</div>
<!-- 不能在这些地方添加其他没有绑定if的元素 -->
<div v-else-if="type === 'C'">
  C
</div>
<!-- 不能在这些地方添加其他没有绑定if的元素 -->
<div v-else>
  Not A/B/C
</div>
```

#### 4.2.2 key 管理复用元素

Vue 会尽可能高效地渲染元素，通常会复用已有元素而不是从头开始渲染。这么做除了使 Vue 变得非常快之外，还有其它一些好处。例如，如果你允许用户在不同的登录方式之间切换。

```HTML
<template v-if="loginType === 'username'">
  <label>Username</label>
  <input placeholder="Enter your username">
</template>
<template v-else>
  <label>Email</label>
  <input placeholder="Enter your email address">
</template>
```

那么在上面的代码中切换 loginType 将不会清除用户已经输入的内容。因为两个模板使用了相同的元素，`<input>` 不会被替换掉——仅仅是替换了它的 placeholder.简单的说他们很懒惰别人有的他们也需要使用的话就直接用别人的，自己需要更新的部分才会更新。

**key的作用**

这样也不总是符合实际需求，所以 Vue 为你提供了一种方式来表达“这两个元素是完全独立的，不要复用它们”。只需添加一个具有唯一值的 key 属性即可：

```HTML
<template v-if="loginType === 'username'">
  <label>Username</label>
  <input placeholder="Enter your username" key="username-input">
</template>
<template v-else>
  <label>Email</label>
  <input placeholder="Enter your email address" key="email-input">
</template>
```

现在，每次切换时，输入框都将被重新渲染。注意：`<label>` 元素仍然会被高效地复用，因为它们没有添加 key 属性。

### 4.3 v-show  切换元素的CSS属性 display 

```HTML
  <div id="app">
    <div v-if="loginStatue" style="background: yellow;">您好！</div>
    <div v-else style="background: gray;">请登录</div>
  </div>

  <script>
    var vm = new Vue({
      el: '#app',
      data: {
        loginStatue: true //这里使得v-if="loginStatue"绑定的loginStatue为真。
        //将会选择v-if所在的语句显示，v-else语句将不会得到渲染出来
      }
    })
  </script>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/show.png)

将true更改为false得到下面的效果图。当然了实际应用中我们不是手动的来修改这个数据为false的，而是根据methods选项中的方法来触发数据的修改。
![xiaoguo](http://liuxmoo.foryung.com/show22.png)
注意设置为false的话，浏览器就么有内容了，但是在审查中这个DOM还是存在的，只是多了一个display:none,设置为不可见。DOM已经加载，只是CSS控制没有显示出来。

**v-if v-else 与v-show 的区别 **

- v-if  v-else  判断是否加载对应的html内容，判断是否加载，可以减轻服务器的压力，在需要时加载。
- v-show 判断是是否对文本进行隐藏或显示，相当display的效果，调整css dispaly属性，可以使客户端操作更加流畅
- v-if 是“真正”的条件渲染，因为它会确保在切换过程中条件块内的事件监听器和子组件适当地被销毁和重建。
- v-if 也是惰性的：如果在初始渲染时条件为假，则什么也不做——直到条件第一次变为真时，才会开始渲染条件块。
- 相比之下，v-show 就简单得多——不管初始条件是什么，元素总是会被渲染，并且只是简单地基于 CSS 进行切换。
- 一般来说，v-if 有更高的切换开销，而 v-show 有更高的初始渲染开销。因此，如果需要非常频繁地切换，则使用 v-show 较好；如果在运行时条件很少改变，则使用 v-if 较好。

### 4.4 v-for 模板循环指令

当 v-if 与 v-for 一起使用时，v-for 具有比 v-if 更高的优先级。

#### 4.4.1 循环数组

>v-for 指令循环渲染一组 data 的数组。要哪个 html 标签循环，v-for 就写在那个上边。v-for 指令需要以 item in items 形式的特殊语法，items 是源数据数组并且 item 是数组元素迭代的别名。
因为是形式，所以我们可以相应的写，text in texts 等等这样的来做循环数据渲染 html 模板写法 text 表示的是体现在 html 里面的文本，texts 指的是所有里面的 text 文本的数组集合.

**可以循环的参数：①item ②索引index**

```HTML
 <div id="app">
    <ol>
      <li v-for="item in items">{{item}}</li>
    </ol>
  </div>
  
  <script>
    var itemsArr = [10, 20, 30, 40, 50, 60]
    var vm = new Vue({
      el: '#app',
      data: {
        items: itemsArr
      }
    })
    </script>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/v-for1.png)

```HTML
<div id="app">
  <!-- 当然不只是是在list列表中循环，在其他元素上也是可以循环的。 -->
  <p v-for="(student,index) in sortStudents">
    {{index+1}}、名字:{{student.name}}
    <br/>
    &nbsp;&nbsp;&nbsp;&nbsp;年龄: {{student.age}},资产:{{student.money}}
  </p>
</div>
<script>
var vm1 = new Vue({
  el: '#app',
  data: {
    students: [{
      name: 'xiaomi',
      age: 18,
      money: 100000000
    },
    {
      name: 'xiaomizhou',
      age: 100,
      money: 450000000
    },
    {
      name: 'liuliu',
      age: 50,
      money: 2300000000
    },
    {
      name: 'meimeimei',
      age: 30,
      money: 224000000
    }]
  }  
})
</script>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/v-for2.png)

#### 4.4.2 循环对象

**可以循环的参数：①item ②索引index③键值key**

```HTML
<div id="app">
  <div v-for="(value, key, index) in object">
    {{ index }}. {{ key }}: {{ value }}
  </div>
</div>
<script>
new Vue({
  el: '#app',
  data: {
    object: {
      firstName: 'John',
      lastName: 'Doe',
      age: 30
    }
  }
})
</script>
```

效果：注意：每次的结果可能不一致，因为对象是无序的！！！
0.firstName:John
1.lastName:Doe
2.age:30

**需要注意的是！！！！！！！！！！！！！！！**

`v-for="(value, key, index) in object"` 

- 如果有两个参数，第一个参数是 value ，第二个参数是 index
- 如果有两个参数，第一个参数是 value ，第二个参数是 key ，第三个是 index

参数的顺序不能有错，如果错误的话，循环是会出错，key 绑定的值大多数情况是会报错的。

#### 4.4.3 key

当 Vue.js 用 v-for 正在更新已渲染过的元素列表时，它默认用“就地复用”策略。如果数据项的顺序被改变，Vue 将不会移动 DOM 元素来匹配数据项的顺序， 而是简单复用此处每个元素，并且确保它在特定索引下显示已被渲染过的每个元素。
**这个默认的模式是高效的，但是只适用于不依赖子组件状态或临时 DOM 状态 (例如：表单输入值) 的列表渲染输出。**
为了给 Vue 一个提示，以便它能跟踪每个节点的身份，从而重用和重新排序现有元素，你需要为每项提供一个唯一 key 属性。理想的 key 值是每项都有的且唯一的 id。它的工作方式类似于一个属性，所以你需要用 v-bind 来绑定动态值.

```HTML
<!-- 如果数组中的项存在 id，那么 key 可以直接绑定 id ，没有 id 的话通常用绑定的是 index -->
<div v-for="item in items" :key="item.id">
  <!-- 内容 -->
</div>
<div v-for="(item,index) in items" :key="index">
  <!-- 内容 -->
</div>
```

建议尽可能在使用 v-for 时提供 key，除非遍历输出的 DOM 内容非常简单，或者是刻意依赖默认行为以获取性能上的提升。

因为它是 Vue 识别节点的一个通用机制，key 并不与 v-for 特别关联，key 还具有其他用途，我们将在后面的指南中看到其他用途。

### 4.5 v-on 事件绑定指令

[官网地址：](https://cn.vuejs.org/v2/guide/events.html)

>v-on 就是监听事件，可以用v-on指令监听DOM事件来触发一些javascript代码。  
语法：`v-on:click="函数变量"`
用@简写的语法：`@click="函数变量"`
**键盘回车事件**`v-on:keyup.enter="???"`

#### 4.5.1 v-on事件绑定：方法名

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

#### 4.5.2 v-on事件绑定：方法传参

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

#### 4.5.2 特殊变量 $event

```HTML
<button v-on:click="warn('Form cannot be submitted yet.', $event)">
  Submit
</button>
// ...
methods: {
  warn: function (message, event) {
    // 现在我们可以访问原生事件对象
    if (event) event.preventDefault()
    alert(message)
  }
}
```

#### 4.5.3 事件修饰符

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

#### 4.5.4 按键修饰符

##### 4.5.4.1 keycode

keycode 是数字代码，（例如，enter 键的 keycode 是 13 ）但是要记住这里数字是很困难的，这时候我们就会有别名的存在

##### 4.5.4.2 keycode 别名

```BASH
.enter          # 回车键
.tab            # tab 键
.delete         # 捕获“删除”和“退格”键)
.esc            # 退出
.space          # 空格键
.up             # 向上
.down           # 向下
.left           # 后退
.right          # 前进
.arrow-right
.media-play-pause # 暂停
.v               # V 字母键
```

```HTML
<!-- 下面的 3 行代码是等效的（前提是没有全局配置别名的时候） -->
<input v-on:keyup.13="submit">
<input v-on:keyup.enter="submit">
<input @keyup.enter="submit">
<input type="text" @keyup.media-play-pause="method">
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.right="handleSubmit" />
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.arrow-right="handleSubmit" />
```

##### 4.5.4.3 全局配置别名 Vue.config.keyCodes

如果提供的别名不能满足我们的要求，可以自行配置

```JS
Vue.config.keyCodes = {
  v: 86,
  c: 87,
  x: 88,
  f1: 112,
  //mediaPlayPause: 179,// 这样是错误的 camelCase 不可用
  "media-play-pause": 179,// 取而代之的是 kebab-case 且用双引号括起来
  up: [38, 87]
}
```

#### 4.5.5 系统修饰键 ctrl alt shift meta

对于不同的键盘, 这四个系统修饰键对应各有不同

- mac 系统键盘, meta 键对应 command 键
- windows 系统,meta 键中对应 ⊞ 键

```HTML
<!-- ctrl+v 都被按下时候出发的事件，可能会有其他的按键也按下了-->
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.ctrl.v="handle"/>
<!-- exact 翻译：精确 当且仅当 同时按下 ctrl+v 时候触发的事件-->
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.ctrl.v.exact="handle"/>
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.ctrl.c="handle"/>
<input type="text" placeholder="请输入电话号码" v-model="phone" @keyup.ctrl.x="handle"/>
```

### 4.6 v-model 表单绑定指令

>就是说用户输入的文本与html显示文本的绑定是通过v-model来实现的，把两者都与vue构造函数的data里对应的属性值绑定起来就ok了。v-model绑定的是表单输入的数据。它负责监听用户的输入事件以更新数据

#### 4.6.1 v-model指令的修饰符，

三个修饰符都是可选择的，可以同时存在 的，不分先后的

- .lazy：取代 input 监听 change 事件.
        用法：v-model.lazy="",
        作用：lazy就是懒惰的意思， 所以这个属性的作用很好理解，就是让双向数据的改变变懒惰，不实时
              用了这个修饰之后，我们在输入框输入文字，p标签里面的文本不跟着改变，
              直到我们把光标移除输入框，p标签里面的文本才改变。
        在默认情况下，v-model 在每次 input 事件触发后将输入框的值与数据进行同步
        (除了上述输入法组合文字时)。你可以添加 lazy 修饰符，从而转变为使用 change 事件进行同步：
- .number：输入字符串转为数字。  
        用法：v-model.number="",
        作用：自动的将字符串隐式转化为数字
        问题：（如果原值的转换结果为 NaN 则返回原值即字符串）
- .trim：输入去掉首尾空格。  
        用法：v-model.trim="",
        作用：自动的将输入的文本消息中的空格修剪掉，也就是删除掉

#### 4.6.2 ① [单行文本框、多行文本框]-使用v-model数据绑定

```TEXT
<p>{{massage}}</p>
<input type="text" v-model="massage" />
这里就实现了最简单的数据双向绑定，input 里面 v-model 值改变，p 标签内的值也就跟着改变了，这个改变时实时的，就是立即改变的
```

```HTML
<div>
  <p v-text="massage"></p>
  <input v-model="massage" type="text" placeholder="请输入数字" />v-model
  <hr/>
  <input v-model.lazy="massage" type="text" placeholder="请输入数字" />v-model.lazy
  <hr/>
  <input v-model.number="massage" type="text" placeholder="请输入数字" />v-model.number
  <hr/>
  <input v-model.trim="massage" type="text" placeholder="请输入数字" />v-model.trim
  <hr/>
  <textarea name="ee" id="ee" cols="30" rows="10" v-model.number.trim="massage"></textarea>
</div>
<script>
  var vm = new Vue({
    el: '#app',
    data: {
      massage: 60
    }
  })
</script>  
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/model.png)

#### 4.6.3 ② [单选框]--使用v-model数据绑定

```HTML
<div>
    <label for="female">女</label>
    <input type="radio" name="sex" id="female" value="female" v-model="sex" />
    <label for="man">男</label>
    <input type="radio" name="sex" id="man" value="man" v-model="sex" />
    <br/>
    <span>勾选的是为:{{sex}}</span>
    <hr/>
</div>
<script>
  var vm = new Vue({
    el: '#app',
    data: {
      sex: 'female'
    }
  })
</script>  
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/model2.png)

注意的问题：
v-model 会忽略所有表单元素的 value、checked、selected ,特性的初始值而总是将 Vue 实例的数据作为数据来源。你应该通过 JavaScript 在组件的 data 选项中声明初始值。简单来说，他们的初始值不像是 html 那样在 html 标签里面设置的。在这里他们是根据 data 中的值决定的，即使在标签中有，它们还是会根据 data中 的值来决定的。

#### 4.6.3 ③ [多选框]--使用v-model 数据绑定

```HTML
<div>
    <p>多选框使用v-model数据绑定</p>
    <p>单个复选框，绑定到布尔值 </p>
    <label for="checkbox" v-text="datachecbox"></label>
    <input type="checkbox" id="checkbox" v-model="datachecbox" />
    <br/>
    <p>
      多个复选框，绑定到同一个数组：
    </p>
    <label for="car1">宝马</label>
    <input type="checkbox" name="car1" id="car1" value="宝马" v-model="cars" />
    <label for="car2">奔驰</label>
    <input type="checkbox" name="car2" id="car2" value="奔驰" v-model="cars" />
    <label for="car3">兰博基尼</label>
    <input type="checkbox" name="car3" id="car3" value="兰博基尼" v-model="cars" />
    <br/>
    <span>勾选的是为{{cars}}</span>
    <hr/>
</div>
<script>
  var vm = new Vue({
    el: '#app',
    data: {
      datachecbox: true,
      cars: ['奔驰', '宝马', '兰博基尼']
    }
  })
</script>  
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/model3.png)

#### 4.6.3 ④ [多选框]--使用v-model 数据绑定

```HTML
  <div id="div">
    <h2>下拉框使用v-model</h2>
    <p>单选下拉框，绑定到一个值</p>
    <select name="" id="" v-model="area">
      <option value="" disabled="disabled">请选择</option>
      <option value="广西">广西</option>
      <option value="上海">上海</option>
      <option value="广东">广东</option>
    </select>
    <span>选择的是{{area}}</span>


    <p>多选下拉框,绑定到数组</p>
    <select name="" id="" v-model="area1" multiple>
      <option value="" disabled="disabled">请选择</option>
      <option value="广西">广西</option>
      <option value="上海">上海</option>
      <option value="广东">广东</option>
    </select>
    <span>选择的是{{area1}}</span>
  </div>
  <script>
    new Vue({
      el: '#div',
      data: {
        area: '广东', //单选下拉框的初始值
        area1: ['上海','广西']  //多选下拉框的初始值
      }
    })
  </script>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/model4.png)

### 4.7 v-bind 绑定[标签属性]指令 ！！！重点

```TEXT
语法举例：  v-bind:src="???"
简写：     :src="???"    就是以冒号替代
```

#### 4.7.1 与标签的属性绑定（包括 class）

这里是简单的与属性绑定， 属性值写在 js 中赋值给一个 vue 构造函数的 data 属性，data 属性写在 html 中。简单来说，就是绑定的值必须在 vue 中的 data 属性中进行声明。我们绑定的只是属性名

```HTML
<style>
.red{color:red;}
.blue{color:blue;}
</style>
<div id="app">
  <img v-bind:src="imgSrc" />
  <a v-bind:href="aHref">兔子</a>
  <p v-bind:class="classA">v-bind 与 class 属性直接简单的绑定，</p>
  <p v-bind:title="message">鼠标悬停几秒钟查看此处动态绑定的提示信息！</p>
  <p title="mei">xiaomi xiaomixiaomi！</p>
  <div v-bind:id="'list-' + id"></div>
</div>
<script>
    new Vue({
      el: '#div',
      data: {
        imgSrc:'../.png',
        aHref:'http://...',
        classA:'red',
        message: '页面加载于 ' + new Date().toLocaleString(),
        id: 18
      }
    })
</script>
<!-- 
可以在 js 中去动态的修改 img 图片的 src，链接 a 中的 href，class 中的属性
上面的代码等价于原始的 html
<div id="app">
  <img src="../.png" />
  <a href="http://...">兔子</a>
  <p class="red"></p>
</div> -->
```

#### 4.7.2  class 绑定升华

**①class：值/数组绑定**

```HTML
<style>
.active {color: greenyellow;}
.px30 {font-size: 30px;}
.border1px {border: 1px blue solid;}
</style>

<div id="app">
  <p v-bind:class="classNameA">4.7.1节的简单绑定</p>
  <p v-bind:class="[classNameA]">v-bind 与class 属性值接简单的绑定，只有一项的数组</p>
  <p v-bind:class="[classNameA,classNameB]">简单绑定多个 class 名</p>
  <p class="border1px" :class="[classNameB]">v-bind:class 指令也可以与普通的 class 属性存。</p>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      classNameA: 'active',
      classNameB: 'px30'
    }
  })
</script>
```

**②class：对象绑定**

```HTML
<style>
.active {color: greenyellow;}
.px30 {font-size: 30px;}
</style>

<div id="app">
  <p v-bind:class="{active:isActive}">js控制isActive</p>
  判断active,isPx30这个属性值是否需要
  <p v-bind:class="{active:isActive,px30:isPx30}">js控制isActive/isPx30</p>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      isActive: true,
      isPx30: true
    }
  })
</script>
```

**③class：三元表达式绑定**

```HTML
<style>
.active {color: greenyellow;}
.danger {color: red;}
</style>

<div id="app">
  <p v-bind:class="isActive?classNameA:classNameB">三元</p>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      isActive: true,
      classNameA: 'active',
      classNameB: 'danger'
    }
  })
</script>
```

**④数组，三元表达式，对象 混合使用**

```HTML
<style>
.active {color: greenyellow;}
.danger {color: red;}
.px30 {font-size: 30px;}
</style>

<div id="app">
  <p v-bind:class="[isActive?classNameA:classNameB,classNameC]"> 三元表达式与数组混合使用</p>
  <p v-bind:class="[{active:isActive},classNameA]"> 对象与数组混合使用</p>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      isActive: false,
      classNameA: 'active',
      classNameB: 'danger',
      classNameC: 'px30'
    }
  })
</script>
```

**⑤class：computed属性值 绑定*

```HTML
<style>
</style>

<div id="app">
  <div v-bind:class="classObject">xiaomi</div>
</div>
  <script>
    new Vue({
      data: {
        error: null
      },
      computed: {
        classObject: function () {
          return {
            active: this.isActive && !this.error,
            'text-danger': this.error && this.error.type === 'fatal'
          }
        }
      }
    })
```

#### 4.7.3  style绑定

**①style：值/数组绑定**

```HTML
<div id="app">
  <p style="color: red;font-size: 30px;"> 这里是内联style原样式</p>
  <p v-bind:style="[colorStyle,fontSizestyle]">vue绑定</p>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      colorStyle: {
        color: 'yellow'
      },
      fontSizestyle: {
        fontSize: '30px'    //注意这里css中的font-size：变成fontSize
      }
    }
  })
</script>
```

 v-bind:style 的对象语法十分直观——看着非常像 CSS，但其实是一个 JavaScript 对象。CSS 属性名可以用驼峰式 (camelCase) 或短横线分隔 (kebab-case，记得用单引号括起来) 来命名：

**②style：对象绑定**

```HTML
<div id="app">
  <p v-bind:style="{color:colorValue,'font-size':sizeValue}">使用vue，</p>
  <p v-bind:style="{color:colorValue,fontSize:fontSize+'px'}">使用vue，</p>
  <p v-bind:style="styleObject">使用vue，</p>
</div>

<script>
  new Vue({
    el: '#app',
    data: {
      colorValue: 'blue',
      sizeValue: '30px',
      fontSize: '30',
      styleObject: {
        color: 'red',
        fontSize: '30px'
      }
    }
  })
</script>
```

### 4.8 v-pre 预定义格式绑定

>v-pre  
不需要表达式
跳过这个元素和它的子元素的编译过程。可以用来显示原始 Mustache 标签。跳过大量没有指令的节点会加快编译。在模板中跳过 vue 的编译，直接输出原始值。就是在标签中加入 v-pre 就不会输出 vue 中的 data 值了。

```HTML
<div v-pre id="app">{{massge}}
<!-- 会直接在网页中输出{{massage}} 这样的一个文本，不会是其他的信息。即使在 vue 的 data 中有定义 -->
</div>
<script>
  new Vue({
    el: '#div',
    data: {
      massge: 'hello'
    }
  })
</script>
```

效果展示：
![xiaoguo](http://liuxmoo.foryung.com/pre.png)

### 4.9 v-cloak 渲染好后展示指令

>v-cloak
不需要表达式
用法：放置一些渲染比较麻烦的列表啊，表格啊，还没有渲染完成就显示，可能会出错啊，不好看啊，用户体验不好。
这个指令保持在元素上直到关联实例结束编译。
和 CSS 规则如 [v-cloak] { display: none } 一起用时，这个指令可以隐藏未编译的 Mustache 标签直到实例准备完毕。在 vue 渲染完指定的整个 DOM 后才进行显示。它必须和 CSS 样式一起使用。

```HTML
<style>
[v-cloak] {
    display: none;
  }
</style>
<div id="app">
 <p v-cloak>
 {{massge}}
 </p>
<!-- {{massge}}不会先显示，直到编译结束。避免用户网络不好加载不出 data 中的值，而直接显示{{massge}} -->
</div>
<script>
  new Vue({
    el: '#div',
    data: {
      massge: 'hello'
    }
  })
</script>
```

效果展示：
这个不好展示效果，方正就是表格类数据复杂的，用 v-cloak 避免不好的用户体验

### 4.10 v-once 仅渲染一次指令

>v-once
不需要表达式
只渲染元素和组件一次。随后的重新渲染，元素/组件及其所有的子节点将被视为静态内容并跳过。
这可以用于优化更新性能。
可以说是data中的初始值，在外面再更新值，绑定 v-once 的插值不会改变

```HTML
  <div id="app">
    <div v-once>{{massage}}这里只会一直是 xiaomi</div>
    <div>{{massage}}这里会根据 input 输入框的输入而变化</div>
    <input type="text" v-model="massage" />
  </div>
  <script>
    var vm = new Vue({
      el: '#app',
      data: {
        massage: 'xiaomi',
      }
    })
  </script>
```

## 五、[选项/属性] && [实例方法/属性]  逐个解析

### 5.1  el 与  vm.$el

限制：只在由 new 创建的实例中遵守，因此在 vue-cli 脚手架中只会在 main.js 中出现，其他的 .vue 文件都是导出件，`export default {}` 创建的，没有 el，

提供一个在页面上已存在的 DOM 元素作为 Vue 实例的挂载目标。可以是 CSS 选择器，也可以是一个 HTMLElement 实例。

### 5.2 data 与 vm.$data

```html
<!-- 这里是没有使用 vue-cli 的写法,原始的 html/css 写法-->
<head>
<style>
/* css... */
</style>
</head>

<body>
  <div id="app">
    {{ number }}
  </div>

  <script>
    new Vue({
      el: '#app',
      data: {  //②data选项/属性：与html中的数据绑定，实现双向绑定
        nunber:18
      }
    })
  </script>
</body>
```

### 5.3 props 与：vm.$props

### 5.4 propsData

### 5.5 computed

computed 的作用主要是在给我们给用户展现之前对原数据进行改造输出。改造输出：包括格式的编辑，大小写转换，顺序重排，添加符号…… js 对原始数据有保护机制，不能修改原始数据的，但是我们确实有对原始数据进行改在的需求，那么就使用到这computed选项来改造数据,这个操作不会污染原数据。
有时，我们想要显示一个数组的过滤或排序副本，而不实际改变或重置原始数据。在这种情况下，可以创建返回过滤或排序数组的计算属性。

#### 5.5.1 **①格式化输出结果:把结果重新用新的方式熟输出展现给用户**：给数据添加其他东西

```HTML
<!-- 非vue-cli框架 -->
<div id="app">
    <p>{{good}}:{{newprice}}</p>
</div>
<script>
    new Vue({
      el: '#app',
      data: {
        good: '笔',
        price: 100
      },
      computed: {
        newprice: function () {
          return this.price = '$' + this.price;
        },
        reverseNewsItems: function () {
          return this.newsItems.reverse();
        }
      }
    })
  </script>
```

#### 5.5.2 **②格式化输出结果:用计算属性反转数组**：给数据倒过来输出

经常用在我们得到一些数组类型的数据时，我们经常需要按照一定的顺序来排序输出展现，那么就要用 computed 来重新   倒序输出

```HTML
<div id="app">
    <ol>
      <li v-for="item in  reverseNewsItems">{{item.title}}{{item.date}}</li>
    </ol>
  </div>
  <script>
    var dataObject = {
      good: '笔',
      price: 100,
      newsItems: [{
          title: '香港或就“装甲车被扣”事件追责 起诉涉事运输公司',
          date: '2017/3/10'
        },
        {
          title: '日本第二大准航母服役 外媒：针对中国潜艇',
          date: '2017/3/12'
        },
        {
          title: '中国北方将有明显雨雪降温天气 南方阴雨持续',
          date: '2017/3/13'
        },
        {
          title: '起底“最短命副市长”：不到40天落马，全家被查',
          date: '2017/3/23'
        },
      ]
    };
    new Vue({
      el: '#app',
      data: dataObject,
      computed: {
        reverseNewsItems: function () {
          return this.newsItems.reverse();
        }
      }
    })
  </script>
```

效果：

>1.起底“最短命副市长”：不到40天落马，全家被查2017/3/23
2.中国北方将有明显雨雪降温天气 南方阴雨持续2017/3/13
3.日本第二大准航母服役 外媒：针对中国潜艇2017/3/12
4.香港或就“装甲车被扣”事件追责 起诉涉事运输公司2017/3/10

#### 5.5.3  computed 的默认 getter 函数，与 setter 函数

计算属性默认只有 getter ，不过在需要时你也可以提供一个 setter

```HTML
  <div id="app">
    <p>{{firstName}}</p>
    <p>{{fullName}}</p>

  </div>
  <script>
    var vm = new Vue({
      el: '#app',
      data: {
        firstName: 'Foo',
        lastName: 'Bar'
      },
      computed: {
        fullName: {
          // getter
          get: function () {
            return this.firstName + ' ' + this.lastName
          },
          // setter
          set: function (newValue) {
            var names = newValue.split(' ')
            //split 根据字符串中的某个字符拆分字符串变成数组
            this.firstName = names[0]
            this.lastName = names[names.length - 1]
          }
        }
        /*         fullName: function (oldVal, newVal) {
                  var names = newValue.split(' ')
                  this.firstName = names[0]
                  this.lastName = names[names.length - 1]
                } */
      }
    })
    vm.fullName = 'John Doe'
    /* 没有set的话，上面这行代码是无效的，无法设置 。有set之后，vm.fullName = 'John Doe'这句有效。setter 会被调用，vm.firstName 和 vm.lastName 也会相应地被更新。*/
  </script>
```

#### 5.5.4 computed 与 v-modell 使用!!!!!!!!!!!!!!

上面的都是从 data 获取的数据，但是 v-model 是用户输入的数据，如果是只是简单的使用上面的办法，是没有办法做到双向绑定的。

会提示错误，`Computed property "XXXXXX" was assigned to but it has no setter. `

```HTML
<Slider
  v-model="newConfidence"
  show-input
  :min='0'
  :max='100'
  :tip-format="confidenceFormat"
></Slider>
<script>
  data: () => ({
    showMetadataModal: false,
    loading: false,
    robot_fre: 110,
    refresh_fre: 10,
    confidence: 0.6
  }),
  computed: {
    newConfidence: {
      set(value) {
        this.confidence = value/100;
      },
      get() {
        return this.confidence * 100;
      }
    }
  },
</script>
```

### 5.6 methods  

经常用在发生事件的时候触发方法。要在方法里面编辑一个方法。

```HTML
<div id="app">
    <p>{{num}}</p>
    <button @click="add(2)"></button>.
    <input type="button" value="add" v-on:click="add()" />
    <input type="button" value="addnumber" v-on:click="addnumber(2,$event)" />
    <btn v-on:click.native="add"></btn>
    <btn v-on:click.native="addnumber(2)"></btn>
  </div>

<script>
  var btncomponent = {
    template: `<button>组件add</button>`
  }
  var vmapp = new Vue({
    el: '#app',
    data: {
      num: 18
    },
    components: {
      'btn': btncomponent
    },
    methods: {
      add: function () {
        this.num++;
      },
      addnumber: function (number, event) {
        if (number != "") {
          this.num += number;
        } else {
          this.num++;
        }
        console.log(event);
      }
    }
  })
</script>
```

#### 5.6.1 methods中的$event参数

传递的$event参数都是关于你点击鼠标的一些事件和属性。我们先看看传递的方法。这个是做比较高级交互性的时候用的，一般来说简单的后台什么的，用不到这玩意,

```js
 //以下是打印event出来的数据,
//看看event到底是个怎样的对象。你会发现，它包含了大部分鼠标事件的属性。
MouseEvent {isTrusted: true, screenX: 123, screenY: 264, clientX: 123, clientY: 171, }
<!--  
altKey : false 
bubbles : true 
button : 0 
buttons : 0 
cancelBubble : false 
cancelable : true 
clientX : 95 
clientY : 179 
composed: true 
ctrlKey : false 
currentTarget : null 
defaultPrevented : false 
detail : 1 
eventPhase : 0 
fromElement : null 
isTrusted: true 
layerX : 95 
layerY : 179 
metaKey : false 
movementX : 0 
movementY : 0 
offsetX : 42 
offsetY : 16 
pageX : 95 
pageY :179 
path : (6) [input, div#app, body, html, document, Window] 
relatedTarget : null 
returnValue : true 
screenX : 95 
screenY: 272 
shiftKey : false 
sourceCapabilities : InputDevice
Capabilities {firesTouchEvents: false} 
srcElement : input 
target :input 
timeStamp : 2550.3000000026077 
toElement : input 
type : "click" 
view : Window {postMessage: ƒ, blur: ƒ, focus: ƒ, close:ƒ, frames: Window, …} 
which : 1 
x : 95 
y : 179 
 __proto__ : MouseEvent -->
```

#### 5.6.2 native 给组件绑定构造器里的原生事件

在实际开发中经常需要把某个按钮封装成组件，然后反复使用。如何让组件调用构造器里的方法，而不是组件里的方法。就需要用到我们的 .native 修饰器了。当你给一个vue组件绑定事件时候，要加上 native 如果是普通的 html元素！就不需要 native 就是把组件变回原生 DOM 的一种方式

自定义标签直接添加方法是不成功的，需要加上 .native，才可能在自定义标签上绑定事件。

```HTML
  <div id="app">
    <p>{{data}}</p>
    <button @click="plus">add</button>
    <!--  <btn @click="plus">这里不会成功</btn> -->
    <btn @click.native="plus">btn是自定义标签直接绑定事件是无效的，用.native</btn>
  </div>
  <script>
    var vmapp3 = new Vue({
      el: '#app',
      data: {
        data: 20
      },
      components: {
        'btn': {
          template: `<button>组件ADD</button>`
        }
      },
      methods: {
        plus: function () {
          this.data++;
        },
        plusnumber: function (number) {
          if (number != "") {
            this.data += number;
          } else {
            this.data++;
          }
        }
      }
    })
  </script>
```

#### 5.6.3 作用域外部调用构造器里的方法

这种不经常使用如果你出现了这种情况，说明你的代码组织不够好

```HTML
<!--  <button onclick="app.add(4)" >外部调用构造器里的方法</button> -->
<div id="app9">{{date}}
  <hr/>{{now}}</div>
<script>
  new Vue({
    el: '#app9',
    data: {
      date: Date
    },
    computed: {
      now: function () {
        return Date.now()
      }
    }
  })
</script>
  ```

#### 5.6.4  computed 与 Methods 的区别

- 数据处理
    computed 计算属性是对 data 中的数据进行格式化，简单的处理后输出，不会改变数据。 getter 作用。
    Methods 方法是做一些方法来改变数据。通常是按钮绑定事件来触发方法。
- 缓存
    ①computed 计算属性是基于它们的依赖进行缓存的。只在相关依赖发生改变时它们才会重新求值。这就意味着只要 message 还没有发生改变，多次访问 reversedMessage 计算属性会立即返回之前的计算结果，而不必再次执行函数。
    ②methods 每当触发重新渲染时，调用方法将总会再次执行函数。
    ③简单的就是说 data 中的数据更新了 computed 才会重新求值。method 方式是只要调用一次就执行一次。
    ④假设我们有一个性能开销比较大的计算属性 A，它需要遍历一个巨大的数组并做大量的计算。然后我们可能有其他的计算属性依赖于 A 。如果没有缓存，我们将不可避免的多次执行 A 的 getter 如果你不希望有缓存，请用方法来替代。

### 5.7   watch 与 vm.$watch

watch 侦听器(监听数据的变化)。数据一旦发生变化将会触发 watch 中相应的函数。来看一个简单的数据变化监控的例子。例如天气预报的穿衣指数，它主要是根据温度来进行提示的

假设：温度大于 26 度时，我们建议穿T恤短袖，温度小于 26 度大于 0 度时，我们建议穿夹克长裙，温度小于 0 度时我们建议穿棉衣羽绒服。

#### 5.7.1 选项 watch：

```HTML
<div id="app">
    <p>温度：{{temp}}℃</p>
    <p>穿搭建议：{{tips}}</p>
    <button v-on:click="up">tempUp</button>
    <button @click="down">tempDown</button>
  </div>
  <script>
    var tiparr = ['夹克长裙', 'T恤短袖', '棉衣羽绒']
    var vmapp = new Vue({
      el: '#app',
      data: {
        temp: 14,
        tips: '夹克长裙'
      },
      methods: {
        up: function () {
          this.temp++;
        },
        down: function () {
          this.temp--;
        }
      },
      watch: {
        temp: function (newVal, oldVal) {
          this.tips = (newVal > 26) ? tiparr[1] : ((newVal < 0) ? tiparr[2] : tiparr[0])
        }
      }
    })
  </script>
```

#### 5.7.2 实例方法 vm.$watch

有些时候我们会用实例属性的形式来写 watch 监控。也就是把我们 watch 写在构造器的外部，这样的好处就是降低我们程序的耦合度，使程序变的灵活。

```HTML
<div id="app">
    <p>温度：{{temp}}℃</p>
    <p>穿搭建议：{{tips}}</p>
    <button v-on:click="up">tempUp</button>
    <button @click="down">tempDown</button>
  </div>
  <script>
    var tiparr = ['夹克长裙', 'T恤短袖', '棉衣羽绒']
    var vm = new Vue({
      el: '#app',
      data: {
        temp: 14,
        tips: '夹克长裙'
      },
      methods: {
        up: function () {
          this.temp++;
        },
        down: function () {
          this.temp--;
        }
      }
    })
    vm.$watch('temp', function (newVal, oldVal) {
      this.tips = (newVal > 26) ? tiparr[1] : ((newVal < 0) ? tiparr[2] : tiparr[0])
    })
  </script>
```

#### 5.7.3 watch  与computed区别

Vue 提供了一种更通用的方式来观察和响应 Vue 实例上的数据变动：侦听属性。当你有一些数据需要随着其它数据变动而变动时，你很容易滥用 watch 特别是如果你之前使用过 AngularJS。然而，通常更好的做法是使用计算属性computed,而不是命令式的 watch 回调.

虽然计算属性在大多数情况下更合适，但有时也需要一个自定义的侦听器。这就是为什么 Vue 通过 watch 选项提供了一个更通用的方法，来响应数据的变化。当需要在数据变化时执行异步或开销较大的操作时，这个方式是最有用的。如下例子

```HTML
<div id="watch-example">
    <p>
      请提问:
      <input v-model="question">
    </p>
    <p>{{ answer }}</p>
  </div>
  <!-- 因为 AJAX 库和通用工具的生态已经相当丰富，Vue 核心代码没有重复 -->
  <!-- 提供这些功能以保持精简。这也可以让你自由选择自己更熟悉的工具。 -->
  <script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/lodash@4.13.1/lodash.min.js"></script>
  <script>
    var watchExampleVM = new Vue({
      el: '#watch-example',
      data: {
        question: '',
        answer: '你还没有输入问题，我无法作答'
      },
      watch: {
        // 如果 `question` 发生改变，这个函数就会运行
        question: function (newQuestion, oldQuestion) {
          this.answer = '我在等您停止输入'
          this.debouncedGetAnswer()
        }
      },
      created: function () {
        // `_.debounce` 是一个通过 Lodash 限制操作频率的函数。
        // 在这个例子中，我们希望限制访问 yesno.wtf/api 的频率
        // AJAX 请求直到用户输入完毕才会发出。想要了解更多关于
        // `_.debounce` 函数 (及其近亲 `_.throttle`) 的知识，
        // 请参考：https://lodash.com/docs#debounce
        this.debouncedGetAnswer = _.debounce(this.getAnswer, 500)
      },
      methods: {
        getAnswer: function () {
          if (this.question.indexOf('?') === -1) {
            this.answer = '提问通常应该带上问号？。 ;-)笑脸'
            return
          }
          this.answer = '我正在思考'
          var vm = this //这句是干嘛？？？为了解耦？
          axios.get('https://yesno.wtf/api')
            .then(function (response) {
              vm.answer = _.capitalize(response.data.answer)
            })
            .catch(function (error) {
              vm.answer = '错误，无法连接' + error
            })
        }
      }
    })
  </script>
  //在这个示例中，使用 watch 选项允许我们执行异步操作 (访问一个 API)，
  //限制我们执行该操作的频率，并在我们得到最终结果前，设置中间状态。
  //这些都是计算属性无法做到的。
```

### 5.8 template

一个字符串模板作为 Vue 实例的标识使用。模板将会 替换 挂载的元素。挂载元素的内容都将被忽略，除非模板的内容有分发插槽。

如果值以 # 开始，则它将被用作选择符，并使用匹配元素的 innerHTML 作为模板。常用的技巧是用 `<script type="x-template">` 包含模板。

出于安全考虑，你应该只使用你信任的 Vue 模板。避免使用其他人生成的内容作为你的模板。

如果 Vue 选项中包含渲染函数 render，该模板将被忽略。

### 5.9 render渲染函数

### 5.10 renderError渲染函数

render 函数遭遇错误时，提供另外一种渲染输出

### 5.11 生命周期/钩子函数选项

vue 的生命周期函数/钩子函数，我们可以利用这些函数在 vue 的每个阶段都进行操作数据或者改变内容

#### 5.11.1 beforeCreate

类型：Function
详细：在实例初始化之后，数据观测 (data observer) 和 event/watcher 事件配置之前被调用。

#### 5.11.2 created

类型：Function
详细：在实例创建完成后被立即调用。在这一步，实例已完成以下的配置：数据观测 (data observer)，属性和方法的运算，watch/event 事件回调。然而，挂载阶段还没开始，$el 属性目前不可见。

#### 5.11.3 beforeMount

类型：Function
详细：在挂载开始之前被调用：相关的 render 函数首次被调用。该钩子在服务器端渲染期间不被调用。

#### 5.11.4 mounted

类型：Function
详细：el 被新创建的 vm.$el 替换，并挂载到实例上去之后调用该钩子。 如果 root 实例挂载了一个文档内元素，当 mounted 被调用时 vm.$el 也在文档内。注意 mounted 不会承诺所有的子组件也都一起被挂载。如果你希望等到整个视图都渲染完毕，可以用 vm.$nextTick 替换掉 mounted：

```JS
mounted: function () {
  this.$nextTick(function () {
    // Code that will run only after the
    // entire view has been rendered
  })
}
//该钩子在服务器端渲染期间不被调用。
```

#### 5.11.5 beforeUpdate

类型：Function
详细：数据更新时调用，发生在虚拟 DOM 打补丁之前。这里适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。该钩子在服务器端渲染期间不被调用，因为只有初次渲染会在服务端进行。

#### 5.11.6 updated

Function
详细：由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用计算属性或 watcher 取而代之。
注意 updated 不会承诺所有的子组件也都一起被重绘。如果你希望等到整个视图都重绘完毕，可以用 vm.$nextTick 替换掉 updated：

```JS
updated: function () {
  this.$nextTick(function () {
    // Code that will run only after the
    // entire view has been re-rendered
  })
}
//该钩子在服务器端渲染期间不被调用。
```

#### 5.11.7 activated

类型：Function
详细：keep-alive 组件激活时调用。该钩子在服务器端渲染期间不被调用。
参考：构建组件 - keep-alive
      动态组件 - keep-alive

#### 5.11.8 deactivated

类型：Function
详细：keep-alive 组件停用时调用。该钩子在服务器端渲染期间不被调用。
参考：构建组件 - keep-alive
      动态组件 - keep-alive

#### 5.11.9 beforeDestroy

类型：Function
详细：实例销毁之前调用。在这一步，实例仍然完全可用。该钩子在服务器端渲染期间不被调用。

#### 5.11.10 destroyed

类型：Function
详细：Vue 实例销毁后调用。调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。该钩子在服务器端渲染期间不被调用。

#### 5.11.110 errorCaptured

类型：(err: Error, vm: Component, info: string) => ?boolean
详细：当捕获一个来自子孙组件的错误时被调用。此钩子会收到三个参数：错误对象、发生错误的组件实例以及一个包含错误来源信息的字符串。 此钩子可以返回 false 以阻止该错误继续向上传播。你可以在此钩子中修改组件的状态。因此在模板或渲染函数中设置其它内容的短路条件非常重要，它可以防止当一个错误被捕获时该组件进入一个无限的渲染循环。错误传播规则默认情况下，如果全局的 config.errorHandler 被定义，所有的错误仍会发送它，因此这些错误仍然会向单一的分析服务的地方进行汇报。如果一个组件的继承或父级从属链路中存在多个 errorCaptured 钩子， 则它们将会被相同的错误逐个唤起。如果此 errorCaptured 钩子自身抛出了一个错误，则这个新错误和原本被捕获的错误都会发送给全局的 config.errorHandler。一个 errorCaptured 钩子能够返回 false 以阻止错误继续向上传播。 本质上是说“这个错误已经被搞定了且应该被忽略”。它会阻止其它任何会被这个错误唤起的errorCaptured 钩子和全局的 config.errorHandler。

vue.js 官网 教程部分学习

## 十五、教程 细节注意点

### 15.1 创建新实例  new Vue({})

经常会使用 vm (ViewModel 的缩写) 这个变量名表示 Vue 实例。

```JS
var vm = new Vue({
  // 使用 Vue 函数创建一个  vue 实例，并且 赋值给 vm 这个变量
})
```

### 15.2 MVVM 响应式

视图层与逻辑层通过数据绑定来相关联。

只用 vue 实例中 data 选项中的数据 会存在 MVVM 模式，如果 data 中没有的属性，只是使用 `vm.name='name'`，这样来添加属性的话，这个 name 属性是不存在 MVVM 模式的。

### Object.freeze() 冻结属性，让他不会被改变，不存在 MVVM

```HTML
<div id="app">
  <p>{{ foo }}</p>
  <button v-on:click="foo = 'baz'">Change it</button><!-- 这里的 `foo` 不会更新！ -->
</div>
```

```JS
var obj = {
  foo: 'bar'
}

Object.freeze(obj)

new Vue({
  el: '#app',
  data: obj
})
```

### 生命周期 钩子函数/??????????????????????????


### 不要在选项属性或回调上使用箭头函数 会导致 this 指定不到 vue 实例

```JS
created: () => console.log(this.a)
Uncaught TypeError: Cannot read property of undefined
vm.$watch('a', newValue => this.myMethod())
Uncaught TypeError: this.myMethod is not a function
```
