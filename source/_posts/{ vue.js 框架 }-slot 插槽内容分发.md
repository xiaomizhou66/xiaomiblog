---
title: 'vue【1】--[ slot 组件内容分发]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

# 一、什么是 内容分发？

内容分发：**把父组件的内容** 与 **子组件自己的模板**混合起来使用，这样的过程称为内容的分发 。
        也常常被叫作 slot ，也就是插槽。使用特殊的 `<slot>` 元素作为原始内容的插槽。

Vue中的插槽 `<slot>`。是一个空壳子，它显 示与否 以及 怎么显示 完全是由父组件来控制。
不过，插槽显示的位置由子组件自身决定，slot 写在组件 template 的哪里，父组件传过来的模板将来就显示在哪里。

在写一些组件的时候，slot 能帮助我们做很多事情，也能让组件可复用性变得更为灵活。

[vue.js 官网地址](https://cn.vuejs.org/v2/guide/components-slots.html)

# 二、slot 核心问题

slot 源于Web Components 规范草案，也被称之为插槽，**是组件的一块 HTML 模板**。 **而这块模板显示不显示，以及怎么显示由父组件来决定。**

## 2.1 slot 最核心的两个问题就

- 显示不显示
- 怎么显示

## 2.2 非插槽模板 和 插槽模板

任何一个组件，从模板种类的角度来分，共实都可分为 **非插槽模板**和 **插槽模板**。

```HTML
<template>
    <li :class="[prefixCls + '-item-group']">
       <!--  这里的 <div></div> 是 非插槽模板 -->
        <div :class="[prefixCls + '-item-group-title']" :style="groupStyle">{{ title }}</div>
         <!--  这里的 <slot></slot> 是 插槽模板 -->
        <ul><slot></slot></ul>
    </li>
</template>
```

非插槽模板：
    指的是 HTML 模板（也就是 HTML 的一些元素，比如 div、span 等构成的），其 **显与否**及 **怎么显示**完全由 **插件/子组件自身**控制;
插槽模板:（也就是 slot）是一个空壳子，它 **显与否**及 **怎么显示**完全是由 **父组件** 来控制。
    不过，**插槽显示的位置**由 **插件/子组件自身决定**: slot 写在组件 template 的哪里，**父组件传过来的模板**将来就显示在哪里。

父组件中 引入 子组件，在父组件的 template 中使用子组件标签，在 子组件标签 中写入的内容替换 自组件中 slot 元素 位置。

# 三、Vue 的编译作用域

父组件的内容是在父组件作用域编译，子组件的内容是在子组件作用域编译。
而 Vue 的 slot 一般用在父组件向子组件分发内容，该内容的编译作用域名为父组件作用域。

## 3.1 Vue 的模板在渲染成 UI 之前是有一个编译过程

slot 会涉及 Vue 的模板，而 Vue 的模板在渲染成 UI 之前是有一个编译过程的，也会存在模板编译作用域一说。理解清楚这部分内容，也更有助于我们理解 slot。

Vue 中的 template 编译成浏览器可识的过程会经过不少的过程。言外之意，最终在浏览器中呈现的并不是 `<template>`，而是会解析成标准的 HTML，然后将组件的标签替换为对应的 HTML 片段。

```HTML
<div id="app">
  <my-component></my-component>
</div>

<template id="myComponent">
  <div>
    <h2>{{ message }}</h2>
    <button @click="show">Show Message</button>
  </div>
</template>

<!-- 在 vue-cli 单页面中，通常是把 template 与其对应的 js 放置到 .vue文件中 -->
<script>
Vue.component('my-component', {
  template: '#myComponent',
  data () {
    return {
      message: '我是一个Vue组件!'
    }
  },
  methods: {
    show: function () {
      alert(this.message)
    }
  }
})

let app = new Vue({
  el: '#app'
})
</script>
```

在上面这段代码中，Vue 将会通过其自身的编译机制，将 `<my-component>` 编译成让浏览器可以识别的 HTML 代码。
例通过 new Vue() 创建一个 Vue 的实例，并且将这个实例挂载到 div#app 的元素下（通过 el 挂载），然后把组件 `<my-component>` 编译成 HTML，最终渲染所需要的 UI 效果。

![TU](https://www.w3cplus.com/sites/default/files/blogs/2018/1803/vue-slot-3.png)

## 3.2 编译作用域

模板编译的作用域，在Vue中，组件是有一个作用域的：**组件模板 `<template>` 内的就是组件作用域，而其之外的就不是组件的作用域了**，比如上面的示例，`my-component` 组件的作用域就是下面这部分。

```HTM
<template id="myComponent">
  <div>
    <h2>{{ message }}</h2>
    <button @click="show">Show Message</button>
  </div>
</template>
```

组件的模板是在其作用域内编译的，因此组件选项对象中的 data 也是在组件模板中使用的。简单来说就是：**父组件模板的内容在父组件作用域内编译；子组件模板的内容在子组件作用域内编译。**

如果我们在前面的示例中的 Vue 实例的组件 `my-component` 中同时追加一个 display 属性：

```html
<div id="app">
  <!-- 这里由 vue 实例操作 -->
  <my-component v-show="display"></my-component>
</div>

<template id="myComponent">
  <!-- 这里由 Vue.component('my-component', { 创建的子组件来控制的 -->
  <div>
    <h2>{{ message }}</h2>
    <button @click="show">Show Message</button>
  </div>
</template>

<script>
Vue.component('my-component', {
  template: '#myComponent',
  // 也就是说下面的 data 选项， methods 选项都是对 template 中的模板操作的，不能操作其他地方
  data () {
    return {
      message: '我是一个Vue组件!',
      display: false
    }
  },
  methods: {
    show: function () {
      alert(this.message)
    }
  }
})

let app = new Vue({
  el: '#app',
  // vue 实例的选项是操作 template 之外的模板的
  data () {
    return {
      display:true
    }
  }
})
</script>

<!-- 此时 display 是来源于 Vue 实例，还是 `my-component`组件呢？
答案：display 来源于 Vue 实例。也就是现在的 true 。

也就是说，在 Vue 中组件的作用域是独立的 -->
```

通俗地讲，**在子组件中定义的数据，只能用在子组件的模板**。在 **父组件**中定义的数据，只能用在 **父组件**的模板。当然了如果需要父子组件的值相互引用，就需要使用到的传值了，props 或者是 $emit 等等方法。

# 四、slot 的使用

## 4.1 父组件没有给 子组件标签插入内容（子组件中的 slot 没有被替换）

```HTML
<div id="app">
  <alert></alert>
  <!-- 这里使用了模板，但是没有写内容，那么模板中的 slot 不会被替换掉 -->
</div>

<template id="alert">
  <div class="alert info">
    <button class="close">&times;</button>
    <slot>如果父组件有些内容，我将会被替换掉</slot>
  </div>
</template>

<script>
Vue.component('alert', {
  template: '#alert'
})

let app = new Vue({
  el: '#app'
})
</script>
```

上面的组件真实渲染的结果是

```HTML
<div id="app">
  <div class="alert info">
    <button class="close">&times;</button>
    如果父组件有些内容，我将会被替换掉
  </div>
</div>
```

上面的代码在 alert 组件的模板中指定了一个 `<slot>` 元素，并且在该元素中放置了一个默认内容 `如果父组件有些内容，我将会被替换掉”`。 在调用 `alert` 组件时，并没有向该组件分发任何内容，这个时候运行的结果如下：

父组件没有写入内容，那么 slot 的内容没有被替换。**如果父组件未向模板中分发内容（插入内容），则显示插槽中默认内容（前提是slot中设置了默认内容）。**
![T](https://www.w3cplus.com/sites/default/files/blogs/2018/1803/vue-slot-5.png)

## 4.2 父组件 给 子组件标签插入内容（子组件中的 slot 的内容将被替换）

```HTML
<!-- 父组件 -->
<div id="app">
  <alert>
    <p>您好啊！</p>
  </alert>
</div>

<!-- 子组件 -->
<template id="alert">
  <div class="alert info">
    <button class="close">&times;</button>
    <slot>如果父组件有些内容，我将会被替换掉</slot>
  </div>
</template>

<script>
Vue.component('alert', {
  template: '#alert'
})

let app = new Vue({
  el: '#app'
})
</script>
```

上面的组件， 真实渲染得到的结果是

```HTML
<div id="app">
  <div class="alert info">
    <button class="close">&times;</button>
    <p>您好啊！</p>
  </div>
  <!-- 这里使用了模板，但是没有写内容，那么模板中的 slot 不会被替换掉 --> 
</div>
```

## 4.3 子组件没有设置 slot 插槽（父组件插入内容不成功）

模板中未设置插槽，父组件依旧向其分发了内容，但最终任何分发的内容都不会显示????值得是子组件放在父组件的内容没有了？？？？
下面的 `<button class="close">&times;</button>`也没有么？需要验证一下的。

```HTML
<div id="app">
  <alert>
    <p>您好啊</p>
  </alert>
</div>

<template id="alert">
  <div class="alert info">
    <button class="close">&times;</button>
    <!-- 子组件没有插槽 slot -->
  </div>
</template>

<script>
Vue.component('alert', {
  template: '#alert'
})

let app = new Vue({
  el: '#app'
})
</script>
```

## 4.4 slot 结合 props ，v-for 使用

```HTML
<div id="app">
  <alert v-for="statu in status" :status=statu>
   <!--  :status=statu 这里使用了 props 给子组件传值 -->
    <div>
      <h2>{{ statu }}</h2>
    </div>
  </alert>
</div>

<template id="alert">
  <!-- :class="[alertStatus]"  这里是使用的是 class 绑定的数组语法 -->
  <div class="alert" :class="[alertStatus]" v-show="isShow">
    <button class="close" @click="close">&times;</button>
    <slot>This is alert box!</slot>
  </div>
</template>

<script>
Vue.component('alert', {
  template: '#alert',
  props: ['status'],
  data () {
    return {
      isShow: true
    }
  },
  computed: {
    alertStatus: function () {
      return this.status
    }
  },
  methods: {
    close: function () {
      this.isShow = !this.isShow
    }
  }
})

let app = new Vue({
  el: '#app',
  data () {
    return {
      status: ['info', 'success', 'danger', 'warning']
    }
  }
})
</script>
```

上面的代码编译结果是

```HTML
<div id="app">
  <alert v-for="statu in status" :status=statu>
    <div class="alert" :class="[alertStatus]" v-show="isShow">
      <button class="close" @click="close">&times;</button>
      <div>
        <h2>{{ statu }}</h2>
      </div>
    </div>
  </alert>
</div>
```

```HTML
<div id="app">

    <div class="alert" :class="info" v-show="isShow">
      <button class="close" @click="close">&times;</button>
      <div>
        <h2>info</h2>
      </div>
    </div>

    <div class="alert" :class="success" v-show="isShow">
      <button class="close" @click="close">&times;</button>
      <div>
        <h2>success</h2>
      </div>
    </div>

    <div class="alert" :class="danger" v-show="isShow">
      <button class="close" @click="close">&times;</button>
      <div>
        <h2>danger</h2>
      </div>
    </div>

    <div class="alert" :class="warning" v-show="isShow">
      <button class="close" @click="close">&times;</button>
      <div>
        <h2>warning</h2>
      </div>
    </div>

</div>
```

# 五、slot 分类

## 5.1 单个插槽

在介绍 slot 大致使用方法的一节中，已经知道了，如果子组件 template 中没有包含任何一个 `<slot>`时，就算父组件分发再多的内容也将会被丢弃。只有子组件模板只要有一个没有属性的 slot（因为在模板中可以有多个带属性的 slot，后面的内容会介绍），父组件传入的整个内容片段将插入到slot 所在的 DOM 位置，并将替换掉 slot 本身。

最初在 `<slot>` 中的任何内容都被视为备用内容（也可以在最初的 `<slot>` 中不放置任何默认内容）。备用内容在子组件的作用域内编译，并且只有在宿主元素（父组件没有分发任何内容）为空，且没有要插入的内容时才显示备用内容。

在前面第 四 章使用的都是单个插槽。

## 5.2 具名插槽（多个插槽使用）

`<slot>` 可以用一个特殊的属性 name 来进一步配置父组件如何分发内容。多个插槽可以有不同的名字。具名插槽将匹配内容片段中有对应 slot 特性的元素。

仍然可以有一个匿名插槽，它是默认插槽，作为找不到匹配的内容片段的备用插槽。如果没有默认插槽，这些找不到匹配的内容片段将被抛弃。

对于一个modal组件，其主体结构包括了 modal-header、 modal-body 和 modal-footer（当然，很多时候可能不会同时出现，根据需要选择）。
那么在定义 modal 组件的 template 时，可以使用三个 slot，它们的 name 属性分别命名为 header 、body 和 footer。

```HTML
<!-- 父组件 -->
<div id="app">
  <modal v-show="toggleModal" @click="closeModal">
    <!-- slot="header" 插入 子组件 name='header' 插槽中 -->
    <div class="modal-header" slot="header">
      <div class="close rotate" @click="closeModal">
        <i class="fa-times fa"></i>
      </div>
      <h3 class="modal-title">Modal Header</h3>
    </div>

    <div class="modal-body" slot="body">
      <h3>Modal Body</h3>
      <p>Modal body conent...</p>
    </div>

    <div class="modal-footer" slot="footer">
      <button class="btn" @click="closeModal">关闭</button>
    </div>
  </modal>
  <button class="btn btn-open" @click="showModal">Show Modal</button>
</div>
```

```HTML
<!-- 子组件 -->
<template id="modal">
  <div class="modal-backdrop">
    <div class="modal" @click.stop>
      <!-- 下面三个是具名插槽，父组件中对用的 slot='' 属性与 子组件的 name 属性对应，才会替换-->
      <slot name="header"></slot>
      <slot name="body"></slot>
      <slot name="footer"></slot>
    </div>
  </div>
</template>
```

## 5.3 作用域插槽

### 5.3.1（ 在父组件使用 `<template slot-scope="props">`）

**这里的 props 是子组件 传来的数据对象**

作用域插槽是一种特殊类型的插槽，用作一个（能被传递数据的）可重用模板，来代替已经渲染好的元素。

在子组件中，只需将数据传递到插槽，就像你将 prop 传递给组件一样：

在父级中，具有特殊特性 `slot-scope` 的 `<template>` 元素必须存在，表示它是作用域插槽的模板。`slot-scope` 的值将被用作一个临时变量名，此变量接收从子组件传递过来的 prop 对象：

```HTML
<!-- 父组件 -->
<div class="parent">
  <child>
    <!-- 在父组件使用 子组件标签的时候，插入的内容和用一个  <template slot-scope="props"> 容器 -->
    <!-- `slot-scope` 的值将被用作一个临时变量名，此变量接收从子组件传递过来的 prop 对象：
    props 只是一个名称，数据就是 子组件中 slot 上的内容 -->
    <template slot-scope="props">
      <span>hello from parent</span>
      <!-- 这里的props.text 就是 hello from child -->
      <span>{{ props.text }}</span>
    </template>
  </child>
</div>
```

```HTML
<!-- 子组件 -->
<div class="child">
    <slot text="hello from child"></slot>
</div>
```

编译后得到如下

```HTML
<div class="parent">
  <div class="child">
    <span>hello from parent</span>
    <span>hello from child</span>
  </div>
</div>
```

### 5.3.2 在 2.5.0+，slot-scope 能被用在任意元素或组件中而不再局限于 `<template>`。

作用域插槽更典型的用例是在 **列表组件中**，允许使用者自定义如何渲染列表的每一项：

```HTML
<!-- 父组件 -->
<my-awesome-list :items="items"> <!-- :items="items" 传值给 子组件-->
  <!-- 作用域插槽也可以是具名的  slot="item" 与  name="item" 具名配对-->
  <li slot="item" slot-scope="props" class="my-fancy-item"> {{ props.text }} </li>
</my-awesome-list>
```

```HTML
<!-- 子组件 -->
<template>
  <div>
    <ul>
      <!-- 这里写入备用内容 -->
      <slot name="item" v-for="item in items" :text="item.text"></slot>
    </ul>
  </div>
</template>
<script>
  data(){
    return{
      //
    }
  },
  props:['items']
</script>
```

编译后

```HTML
<ul>
  <!-- 这里写入备用内容 -->
  <li v-for="item in items" class="my-fancy-item"> {{ item.text }} </li>
</ul>
```

### 5.3.3 slot-scope 可以 ES2015/ES6 解构

`slot-scope` 的值实际上是一个可以出现在函数签名参数位置的合法的 **JavaScript 表达式**。
这意味着在受支持的环境 ( 单文件组件 或 现代浏览器) 中，您还可以在表达式中使用 ES2015/ES6 解构：

```HTML
<child>
  <span slot-scope="{ text }">{{ text }}</span>
</child>
```