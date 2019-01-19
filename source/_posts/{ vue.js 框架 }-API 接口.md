---
title: vue---API 接口
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue.js 框架学习
abbrlink: 70fb91f2
updated:
tags:
comments:
---
## 一、前言

学会了vue.js怎么使用的之后，后续使用文档应该看API来查看使用。

## 二、全局配置

指的是给创建的vue项目做全局配置。在vue-cli脚手架创建的项目中是在.editorconfig文件中。

先来了解一下什么是EditorConfig：
EditorConfig帮助开发人员在不同的编辑器和IDE之间定义和维护一致的编码样式的插件。EditorConfig项目由用于定义编码样式的文件格式和一组文本编辑器插件组成，这些插件使编辑器能够读取文件格式并遵循定义的样式。EditorConfig文件易于阅读，并且与版本控制系统配合使用。
这个插件在很多编辑器都含有，不必要额外的安装，vscode，webstorm等等编辑器都有的，直接创建一个**.editorconfig：项目全局配置文件** 编辑即可。为vue-cli脚手架会自动生成这个文件.

```JS
//vue-cli脚手架创建的项目下该文件的默认的配置
root = true

[*]
charset = utf-8
indent_style = space
indent_size = 2
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
```

### 2.1 编辑的代码格式配置

合作项目的时候,项目经理会在这里设置好代码的统一格式.

### 2.2 vue的全局配置

[vue官网全局配置](https://cn.vuejs.org/v2/api/#%E5%85%A8%E5%B1%80%E9%85%8D%E7%BD%AE)

- silent                Vue 所有的日志与警告配置。
- optionMergeStrategies 自定义合并策略/自定义选项的混入策略
- devtools              是否允许 vue-devtools 检查代码
- errorHandler
- warnHandler
- ignoredElements
- keyCodes              自定义键位别名。[方便键盘事件修饰]
- performance           组件初始化、编译、渲染和打补丁的性能追踪
- productionTip         阻止 vue 在启动时生成生产提示

## 三、全局API

[vue官网全局API](https://cn.vuejs.org/v2/api/#%E5%85%A8%E5%B1%80-API)

**什么是全局API？**
构造器：Constructor 别称:构造方法、构造函数、建构子  new Vue()
全局API并不在构造器里，而是先声明全局变量或者直接在Vue上定义一些新功能。说的简单些就是，在构造器外部用Vue提供给我们的API函数来定义新的功能。Vue内置了一些全局API，如下：

- Vue.extend
- Vue.nextTick
- Vue.set
- Vue.delete
- Vue.directive     注册或获取全局指令
- Vue.filter
- Vue.component
- Vue.use
- Vue.mixin
- Vue.compile
- Vue.version

### 3.1 Vue.extend

这里的data里面与new Vue({})不同，不是直接写属性了，而是需要些一个匿名函数，在返回值里面写data的属性与值

Vue.extend 返回的是一个“扩展实例构造器”,也就是预设了部分选项的Vue实例构造器。经常服务于Vue.component用来生成组件，可以简单理解为当在模板中遇到该组件名称作为标签的自定义元素时，
会自动调用“扩展实例构造器”来生产组件实例，并挂载到自定义元素上。

①：在普通标签上使用拓展
可以通过HTML标签上的id或者class来生成扩展实例构造器，Vue.extend里的代码是一样的，只是在挂载的时候，我们用类似jquery的选择器的方法，来进行挂载就可以了。

```HTML
<div id="app"></div>
<script>
  var appExtend = Vue.extend({
    template: '<p>{{somebody}} has {{carname}} car!</p>',
    data: function () {
      return {
        somebody: 'xiaomi',
        carname: 'minicooper'
      }
    }
  })
  new appExtend().$mount('#app')
</script>
```

②：自定义标签上拓展
想象一个需求，需求是这样的，要在博客页面多处显示作者的网名，并在网名上直接有链接地址。我们希望在html中只需要写`<author></author>` ，这和自定义组件很像，但是他没有传递任何参数，只是个静态标签。  

```HTML
<author></author>
<script>
  var authorExtend = Vue.extend({
    template: '<p><a href="aHref">{{name}}<a></p>',
    data: function () {
      return {
        aHref: '../assets/img/rabbit.gif',
        name: '兔子'
      }
    }
  })
  new authorExtend().$mount('author')
</script>
```

### 3.2 Vue.nextTick

在下次 DOM 更新循环结束之后执行延迟回调。在修改数据之后立即使用这个方法，获取更新后的 DOM。

### 3.3 Vue.set

向响应式对象中添加一个属性，并确保这个新属性同样是响应式的，且触发视图更新。它必须用于向响应式对象上添加新属性，因为 Vue 无法探测普通的新增属性 (比如 this.myObject.newProperty = 'hi')

#### 3.3.1 什么是外部数据

就是不在Vue构造器里里的data处声明，而是在构造器外部声明，然后在data处引用就可以了。外部数据的加入让程序更加灵活，我们可以在外部获取任何想要的数据形式，然后让data引用

```HTML
<div id="app">
  <p>{{count}}</p>
  <input type="button" value="add" @click="addevent" />
</div>
<script>
  //在vue构造器外部定于数据
  var outdata = {
    count: 1,
    good: 'car'
  }
  //然后再vue构造器内部data去引用外部的数据
  var app = new Vue({
    el: '#app',
    data: outdata,
    methods: {
      addevent: function () {
        this.count++;
      }
    }
  })
</script>
```

#### 3.3.2  使用 Vue.set

Vue.set 的作用就是在构造器外部操作构造器内部的数据、属性或者方法。比如在vue构造器内部定义了一个count为1的数据，我们在构造器外部定义了一个方法，要每次点击按钮给值加1.就需要用到Vue.set。

```HTML
  <div id="app2">
    <ol>
      <li v-for="car in cars">{{car}}</li>
    </ol>
  </div>
  <p>
    <input type="button" value="换车" onclick="changeCar()" />
  </p>
  <script>
    var myCars = {
      cars: ['minicooper', '奔驰', '法拉利', '兰博基尼']
    }
    var carsvue = new Vue({
      el: '#app2',
      data: myCars
    })

    function changeCar() {
      // cars[1] = '宝马';//这样写是改变不了数据数组里面的值的，因为js有保护原数据的机制。
      Vue.set(myCars.cars, 1, '宝马'); //这样设置才会改变里面的数据
    }
  </script>
  ```

### 3.4 Vue.delete

删除对象的属性。如果对象是响应式的，确保删除能触发更新视图。这个方法主要用于避开 Vue 不能检测到属性被删除的限制，但是你应该很少会使用它。

### 3.5 Vue.directive

注册或获取全局指令。自定义指令。指令的名称不能有大写字母！！ 也就是changecolor不能存在大写字母，否则会出错。

vue中有v-if  v-else  v-show就是vue的内部指令，我们如果有自己的需求，可以自定义指令。如下指令为v-changelolor。

#### 3.5.1 自定义指令中传递的三个参数

el: 指令所绑定的元素，可以用来直接操作DOM。
binding:  一个对象，包含指令的很多信息。             binding：捆绑
vnode: Vue编译生成的虚拟节点。                      vnode ：vue编译生成的虚拟node节点
语法：Vue.directive('自定义指令名称',function(el,binding,vnode){....})

```HTML
<div id="app">
    <div v-changecolor="{color:red}">{{text}}</div>
    <input type="button" value="add" v-on:click="add" />
</div>

<script>
Vue.directive('changecolor', function (el, binding, vnode) {
  // 这里将会被 `bind` 和 `update` 调用
  //el:代表的是运用该自定义命令的DOM元素
  //binding:一个对象，包含自定义命令名称name属性{name: "changecolor", rawName: "v-changecolor", value: "red", expression: "color", modifiers: {…}, …}
  //vnode:VNode {tag: "div", data: {…}, children: Array(1), text: undefined, elm: div, …}
  el.style.color = binding.value.color;
})
var vm = new Vue({
  el: '#app',
  data: {
    text: 18,
    red: 'red'
  },
  methods: {
    add: function () {
      this.text += 1;
    }
  }
})
```

#### 3.5.2 自定义指令中传递的三个参数自定义指令的生命周期

  自定义指令有五个生命周期（也叫钩子函数）
  分别是 bind,inserted,update,componentUpdated,unbind
  bind:只调用一次，指令第一次绑定到元素时调用，用这个钩子函数可以定义一个绑定时执行一次的初始化动作。
  inserted:被绑定元素插入父节点时调用（父节点存在即可调用，不必存在于document中）。
  update:(常用)被绑定于元素所在的模板更新时调用，而无论绑定值是否变化。通过比较更新前后的绑定值，可以忽略不必要的模板更新。
  componentUpdated:被绑定元素所在模板完成一次更新周期时调用。
  unbind:只调用一次，指令与元素解绑时调用。

  钩子函数的参数有：

  el: 指令所绑定的元素，可以用来直接操作 DOM 。
  binding: 一个对象，包含以下属性：
  name: 指令名，不包括 v- 前缀。
  alue: 指令的绑定值， 例如： v-my-directive="1 + 1", value 的值是 2。
  oldValue: 指令绑定的前一个值，仅在 update 和 componentUpdated 钩子中可用。无论值是否改变都可用。
  expression: 绑定值的表达式或变量名。 例如 v-my-directive="1 + 1" ， expression 的值是 "1 + 1"。
  arg: 传给指令的参数。例如 v-my-directive:foo， arg 的值是 "foo"。
  modifiers: 一个包含修饰符的对象。 例如： v-my-directive.foo.bar, 修饰符对象 modifiers 的值是 { foo: true, bar: true }。
  vnode: Vue 编译生成的虚拟节点。
  oldVnode: 上一个虚拟节点，仅在 update 和 componentUpdated 钩子中可用。

```HTML
  <div id="app">
    <div v-xiaomi="{color:red}">{{text}}</div>
    <input type="button" value="add" v-on:click="add" />
  </div>
  <p>
    <input type="button" value="解绑" onclick="unbind()" />
  </p>

  <script>
    Vue.directive('xiaomi', {
      bind: function () {
        console.log('bind');
      },
      inserted: function () {
        console.log('inserted');
      },
      update: function () {
        console.log('update');
      },
      componentUpdated: function () {
        console.log('componentUpdated');
      },
      unbind: function () {
        console.log('unbind');
      }
    })
    var vm = new Vue({
      el: '#app',
      data: {
        text: 18,
        red: 'red'
      },
      methods: {
        add: function () {
          this.text += 1;
        }
      }
    })
    function unbind() {
      vm1.$destroy();
    }
  </script>
```

### 3.6 Vue.filter

注册或获取全局过滤器。

### 3.7 Vue.component

注册或获取全局组件。注册还会自动使用给定的id设置组件的名称

component组件是Vue学习的重点、重点、重点，重要的事情说三遍。必须学好Vue component。其实组件就是制作自定义的标签，这些标签在HTML中是没有的！！！！！！！`比如：<xiaomi></xiaomi>`

这里说的是全局自定义组件。在选项中会有局部组件。

      一、全局化注册组件
      语法：Vue.component('my-component-name', { template: ...  })
      全局化就是在构造器的外部用Vue.component来注册，
      我们注册现在就注册一个<xiaomi></xiaomi>的组件来体验一下。 -->
  <!--       我们在javascript里注册了一个组件，在HTML中调用了他。
      这就是最简单的一个组件的编写方法，并且它可以放到多个构造器的作用域里。 -->

```HTML
<div id="app">
  <xiaomi></xiaomi>
</div>
<div id="app1">
  <xiaomi></xiaomi>
</div>
<!--<xiaomi></xiaomi>这样写是没有效果的，即使是全局的组件，也需要对应的写一个Vue构造函数行的。-->
<script>
  Vue.component('xiaomi', {
    template: '<p>我是全局组件</p>',
  })
  var vmapp = new Vue({
    el: '#app'
  })
  var vmapp1 = new Vue({
    el: '#app1'
  })
  </script>
```

全局注册往往是不够理想的。比如，如果你使用一个像 webpack 这样的构建系统，全局注册所有的组件意味着即便你已经不再使用一个组件了，它仍然会被包含在你最终的构建结果中。这造成了用户下载的JavaScript 的无谓的增加。不要这来来注册组件，后面学习局部组件创建。

### 3.8 Vue.use

会自动阻止多次注册相同插件，届时只会注册一次该插件

### 3.9 Vue.mixin

全局混入

### 3.10 Vue.compile

在 render 函数中编译模板字符串。只在独立构建时有效

```JS
var res = Vue.compile('<div><span>{{ msg }}</span></div>')

new Vue({
  data: {
    msg: 'hello'
  },
  render: res.render,
  staticRenderFns: res.staticRenderFns
})
```

### 3.11 Vue.version

提供字符串形式的 Vue 安装版本号。这对社区的插件和组件来说非常有用，你可以根据不同的版本号采取不同的策略。

```JS
var version = Number(Vue.version.split('.')[0])

if (version === 2) {
  // Vue v2.x.x
} else if (version === 1) {
  // Vue v1.x.x
} else {
  // Unsupported versions of Vue
}
```

## 四、选项

[vue官网选项](https://cn.vuejs.org/v2/api/#%E9%80%89%E9%A1%B9-%E6%95%B0%E6%8D%AE)

[选项 / 数据](https://cn.vuejs.org/v2/api/#%E9%80%89%E9%A1%B9-%E6%95%B0%E6%8D%AE)

- data
- props
- propsData
- computed
- methods
- watch

选项 / DOM

- el
- template
- render
- renderError

选项 / 生命周期钩子

- beforeCreate
- created
- beforeMount
- mounted
- beforeUpdate
- updated
- activated
- deactivated
- beforeDestroy
- destroyed
- errorCaptured

选项 / 资源

- directives
- filters
- components

选项 / 组合

- parent
- mixins
- extends
- provide / inject

选项 / 其它

- name
- delimiters
- functional
- model
- inheritAttrs
- comments

#### 4.1 data  Vue 实例的数据对象。

#### 4.2 props 可以是数组或对象，用于接收来自父组件的数据。

props选项就是设置和获取标签上的属性值的，例如我们有一个自定义的组件`<xiaomi></xiaomi>`,
这时我们想给他加个标签属性写成`<panda here="China"></panda>` 意思就是熊猫来自中国，当然这里的China可以换成任何值。定义属性的选项是props。China就是属性的值

```HTML
<div id="app">
    <panda here="China"></panda>
</div>
<script>
  var vmapp = new Vue({
    el: '#app',
    components: {
      'panda': {
        //指的是一个panda标签，标签里面的文本以及标签元素就是template模板里面的字符串，
        //插值{{}}值就是在html中panda标签的属性，值是在写html的panda标签的时候设置的。
        //这里的属性与我们的原生的htmlclass属性有？？？？？
        template: '<p style="color:red;">panda from {{here}}!</p>',
        props: ['here'] // 属性设置
      }
    }
  })
//上面的代码定义了panda的组件，并用props设置了here的属性值，
//在here属性值里传递了China给组件。
//最后输出的结果是红色字体的Panda from China.
</script>
```