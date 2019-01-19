---
title: render 函数 在 vue ，wepy，mpvue 双向绑定中 js 代码中的使用
date: '2018/8/19 23:57:28'
categories:
  - 八、JS 工具集/ JS拓展语言
  - render 函数
abbrlink: b4c68634
updated:
tags:
comments:
---

## 一、前言

在 jquery 中我们使用 js 集合 jquery 的 API 方法 动态的生成 一些 DOM 元素。

那么在 vue ，wepy，mpvue 双向绑定的框架中，我们使用的是 render 来动态生成  DOM 元素。

在 vue 官方文档有这么一段话：Vue 推荐在绝大多数情况下使用 template 来创建你的 HTML。然而在一些场景中，在这种场景中使用 template 并不是最好的选择：首先代码冗长，为了在不同级别的标题中插入锚点元素，我们需要重复地使用 `<slot></slot>`。虽然模板在大多数组件中都非常好用，但是在这里它就不是很简洁的了。那么，我们来尝试使用 render 函数，这时你可以用 render 函数，它比 template 更接近编译器。
就是说在一个 负载的 html 元素中，就比如表格，我们不是用 html 代码去编辑的，而是通过 render 函数来生成 虚拟 DOM 元素 ，通过 js 代码来放置到 DOM 中去的。

[vue 的 render](https://cn.vuejs.org/v2/guide/render-function.html)

## 二、Node 节点 与 VNode 虚拟节点

### 2.1 普通 DOM 节点与 虚拟 DOM 节点

```HTML
<!-- 普通 DOM -->
<div id="main">
  <p>111</p>
  <p>222</p>
  333
</div>
```

```JS
/* 虚拟 DOM */
var  vnode={
  tag:'div',
  attributes:{
    id:'main'
  },
  children:[
    {tag:'p','111'},
    {tag:'p','222'},
    '333'
  ],
}
```

### 2.2 vue 中的 vnode 虚拟节点

tag：当前节点的标签名
data：当前节点的数据对象（下⼀页）
children：⼦节点，数组，也是 VNode 类型
text：当前节点的⽂本，⼀般⽂本节点或注释节点会有该属性
elm：当前虚拟节点对应的真实的 DOM 节点
ns：节点的 namespace
content：编译作⽤域
functionalContext： 函数化组件的作⽤域
key：节点的key属性，⽤于作为节点的标识，有利于 patch 的优化
componentOptions：创建组件实例时会⽤到的选项信息
child：当前节点对应的组件实例
parent：组件的占位节点
raw：原始 html
isStatic：静态节点的标识
isRootInsert：是否作为根节点插被 `<transition>` 包裹的节点，
该属性的值为false
isComment：当前节点是否是注释节点
isCloned：当前节点是否为克隆节点
isOnce：当前节点是否有 v-once 指令

```JS
/* 源码中 VNode 的定义 */
export interface VNode{
  tag：//当前节点的标签名
  data：//当前节点的数据对象（下一页）
  children//节点，数组，也是 VNode 类型
  text：//当前节点的文本，一般文本节点或注释节点会有该属性
  elm：//当前虚拟节点对应的真实的 DOM 节点
  ns：//节点的 namespace
  content：//编译作用域
  functionalContext： //函数化组件的作⽤域
  key：//节点的key属性，用于作为节点的标识，有利于 patch 的优化
  componentOptions：//创建组件实例时会用到的选项信息
  child：//当前节点对应的组件实例
  parent：//组件的占位节点
  raw：//原始 html
  isStatic：//静态节点的标识
  isRootInsert：//是否作为根节点插入，被 <transition> 包裹的节点，  该属性的值为false
  isComment：//当前节点是否是注释节点
  isCloned：//当前节点是否为克隆节点
  isOnce：//当前节点是否有 v-once 指令
}
```

## 三、普通 组件 与 render 函数组件

```JS
//普通 组件
vue.component('ele',{
  template:`\
    <div id='element'
    :class='{show:show}'\
    @click='handleClick'>文本内容</div>`,
  data:function(){
    return{
      show:true
    }
  },
  methods:{
    handleClick(){
      //
    }
  }
})
```

```JS
//render 函数组件
vue.component('ele',{
  render:function(createElement){
    return createElement(
      'div',
      {
        class:{
          'show':this.show
        },
        attrs:{
          'id':'element'
        },
        on:{
          click:this.handleClick
        }
      },
      '文本内容'
    )
  },
  data:function(){
    return{
      show:true
    }
  },
  methods:{
    handleClick(){
      //
    }
  }
})
```

## 四、render /渲染函数 的使用

### 4.1 为什么要用 render 函数

普通组件在该场景下的问题

- • 代码冗长
- • template 中大部分代码是相同的
- • 外层必须包含以一个无用的 `<div>` （vue 中），或者是 `<view>`(小程序中)

### 4.2 工作原理/流程

render 函数:生成虚拟节点 =>
createElement():基于虚拟节点创建 DOM 节点 =>
diff: 状态更新后，进行对比，生成补丁对象 =>
patch:遍历补丁对象生成 DOM 节点

### 4.3 render 函数使用方法

#### 4.3.1 createElement(tag,dataObj,children/text) 函数

第 1 个参数必选，可以是 1 个 HTML 标签，也可以是 1 个组件或函数；
第 2 个是可选参数，数据对象
第 3 个是子节点，也是可选，

简单来说

第 1 个参数是 标签，
第 2 个参数是属性与特性，事件等等，
第 3 个参数是标签内的内容（文本或者是子标签）

```JS
createElement(
  'div',//第 1 个参数必选，可以是 1 个 HTML 标签，也可以是 1 个组件或函数；
  {
    // 第 2 个参数数据对象，可选参数
    class:{
      show:this.show
    },//v-bind:class
    style:{
      //
    },//v-bind:style
    attrs:{
      id:'idName'
    },//一般的 HTML 属性，比如 id
    props:{
      someProp:'foo'
    },//props
    on:{
      click:this.handleClick
    },//自定义定义事件
    nativeOn:''//原生事件，比如 click
    // 当然这里不只是这些，还有很多属性，参照 3.3.3 节
  },
  [
    // 第 3 个是子节点，子节点 array 数组，可选参数，也是用 createElement()  函数构造的
    createElment('h1','hello world'),
    createElment(MyComponent,{
      props:{
        someProp:'foo'
      }
    }),
    'bar'// 这个是什么子节点啊 指的是<div></div> 中的内容，文本，或者是其他的子标签
    // 这里的意思是 div 标签中有 一个 h1 标签，一个 MyComponent 子组件 还有直接文本 bar
  ]
)
```

```HTML
<!-- 得到的普通 DOM  效果如下代码-->
<div>
  <h1>hello world</h1>
  <MyComponent :someProp='foo'></MyComponent>
  bar
</div>
```

#### 4.3.2 createElement() 函数第 1 个参数（必填）

```BASH
'div'  # 一个 div 元素
'h' + this.level # 若 level 为 1 则是 h1 标签
```

#### 4.3.3 createElement() 函数第 2 个参数（可选） 【源码中 VNodeData 的定义】

```JS
/* 源码中 VNode 的定义 */
export interface VNodeData{
  key:'myKey' ,                  //string | number    //节点的 key 属性，用于作为节点的标识，有利于 patch 的优化
  slot:'name-of-slot',  //string  如果组件是其他组件的子组件，需为插槽指定名称
  scopedSlots:{
    // 作用域插槽格式  { name: props => VNode | Array<VNode> }
    default: props => createElement('span', props.text)//{[key:string],ScopedSlot}
  },
  ref:'myRef',//如果你在渲染函数中向多个元素都应用了相同的 ref 名，那么 `$refs.myRef` 会变成一个数组
  refInFor: true,
  tag:'',//当前节点的标签名
  staticClass:'',
  class:{
    //和`v-bind:class`一样的 API，接收一个字符串、对象或字符串和对象组成的数组
    foo: true,// 任何类型数据
    bar: false
  },
  staticStyles:{},//{[key:string],any}
  style:{
    //和`v-bind:style`一样的 API，接收一个字符串、对象或对象组成的数组
    color: 'red',
    fontSize: '14px'// object[],object
  },
  props:{
    someProp:'foo'//{[key:string],any}   组件 props
  },
  attrs:{
    id:'idName',//{[key:string],any}  普通的 HTML 特性
    name: headingId,
    href: '#' + headingId
  },
  domProps:{
    // DOM 属性
    innerHTML: 'baz'//{[key:string],any}
  },
  hook:{},//{[key:string],func}
  on:{
    //事件监听器基于 `on`，所以不再支持如 `v-on:keyup.enter` 修饰器，需要手动匹配 keyCode。
    click: this.clickHandler//{[key:string],func,func[]}
  },
  nativeOn:{
    //仅用于组件，用于监听原生事件，而不是组件内部使用，`vm.$emit` 触发的事件。
    click: this.nativeClickHandler//{[key:string],func,func[]}
  },
  transition:object,
  show:true,// boolean
  inlineTemplate:{
    render:function(){},
    staticRenderFns:function[]
  },
  directives: [
    // 自定义指令。注意，你无法对 `binding` 中的 `oldValue` 赋值，因为 Vue 已经自动为你进行了同步。
    //VNodeDirective[]
    {
      name: 'my-custom-directive',
      value: '2',
      expression: '1 + 1',
      arg: 'foo',
      modifiers: {
        bar: true
      }
    }
  ],
  keepAlive:true //boolean
}
```

#### 4.3.4 createElement() 函数第 3 个参数（可选）

```JS
[ createElement(tag,dataObj,children/text), // 子元素,
  createElement(tag,dataObj,children/text), //子元素,
  ''//标签中的文本内容
  ]
```

#### 4.3.5 完整示例

```JS
var getChildrenTextContent = function (children) {
  return children.map(function (node) {
    return node.children
      ? getChildrenTextContent(node.children)
      : node.text
  }).join('')
}

Vue.component('anchored-heading', {
  render: function (createElement) {
    // 创建 kebab-case 风格的ID
    var headingId = getChildrenTextContent(this.$slots.default)
      .toLowerCase()
      .replace(/\W+/g, '-')
      .replace(/(^\-|\-$)/g, '')

    //返回一个 createElement 构建的虚拟 DOM
    return createElement(
      'h' + this.level,//第一个参数
      [//第二个参数
        createElement('a', {
          attrs: {
            name: headingId,
            href: '#' + headingId
          }
        }, this.$slots.default)
      ]
    )
  },

  props: {
    level: {
      type: Number,
      required: true
    }
  }
})
```

#### 4.4.6 createElement 用 h 来替代 !!!!!!!!!!!!!!!!!!!!!!!!!

将 h 作为 createElement 的别名是 Vue 生态系统中的一个通用惯例，实际上也是 JSX 所要求的，如果在作用域中 h 失去作用，在应用中会触发报错。

```JS
Vue.component('anchored-heading', {
  render: function (h) {
    // 创建 kebab-case 风格的ID
    var headingId = getChildrenTextContent(this.$slots.default)
      .toLowerCase()
      .replace(/\W+/g, '-')
      .replace(/(^\-|\-$)/g, '')

    //返回一个 h 构建的虚拟 DOM
    return h(
      'h' + this.level,//第一个参数
      [//第二个参数
        h('a', {
          attrs: {
            name: headingId,
            href: '#' + headingId
          }
        }, this.$slots.default)
      ]
    )
  },

  props: {
    level: {
      type: Number,
      required: true
    }
  }
})
```

## 六、约束

### 6.1 VNodes 必须唯一

所有的组件树中，如果 VNode 是组件，或含有组件的 slot，那 VNode 必须唯一

### 6.2 组件的复用

```JS
//局部声明组件,
<div id="app">
  <ele></ele>
</div>
var Child={
  render:function(createElement){
    return createElement('p','text')
  }
}
vue.component('ele',{
  render:function(createElement){
    var ChildNode = createElement(Child)
    return createElement('div',
      ChildNode, //这里的做法是错误，因为组件重复了xxxxxxxxxxxxx
      ChildNode
    )
  }
})
```

```JS
//局部声明组件，我们可以哟弄 map 遍历的办法
var Child={
  render:function(createElement){
    return createElement('p','text')
  }
}
vue.component('ele',{
  render:function(createElement){
    return createElement('div',
      Array.apply(null,{ // 对的，√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√
        length:5
      }).map(function(){
        return createElement(Child)
      })
    )
  }
})
```

Array.apply() 函数与 ES6 的 `Array.from()` 有点类似.
`apply()` 的第一个参数是对象，第二个参数是数组，作为参数列表。`{length: 5}` 就可以看作一个类数组对象，长度是 5，每个元素，比如 `v[0] `是 `undefined`。
所以`Array.apply(null, { length: 5})` 相当于`Array(undefined, undefined, undefined, undefined, undefined)`

既然已经到了 ES6 了，那么我们还是用 Array.from() 方法比较好,  Array.from()

```JS
Array.from({ length: 3 });  //[ undefined, undefined, undefined ]
// 这个方案只需要一个参数就可以了，不需要再用 null 了，

//当然Array.from() 方法可以有第 2 个参数，就是对 第一个参数中 的每个值进行遍历。就类似 .map 
Array.from(arrayLike, x => x * x); // Array.from() 方法的 第 2 个参数
Array.from(arrayLike).map(x => x * x); // 数组的 map() 方法
```

如果用的是 Array.from 上面的 render 函数可以修改如下。

```JS
//局部声明组件，我们可以哟弄 map 遍历的办法
var Child={
  render:function(createElement){
    return createElement('p','text')
  }
}
vue.component('ele',{
  render:function(createElement){
    return createElement('div',
      Array.from({length:5},()=>createElement(Child))// 对的，√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√
    )
  }
})
```

### 6.3 slot 的克隆

```html
 <!-- 错误做法,因为 slot 包含了组件，并且重复了 -->
<div id='app'>
  <ele>
    <div>
      <Child></Child>
    </div>
  </ele>
<div>
<script>
   // 全局
  vue.component('Child',{ // 错的
    render:function(createElement){
      return createElement('p','text')
    }
  })
  vue.component('ele',{
    render:function(createElement){
      return createElement('div',
        [
          this.$slots.defalut,// 错的
          this.$slots.defalut
        ]
      )
    }
  })
  var app = new Vue({
    el:'#app'
  })
</script>
```

```JS
// 正确的做法
vue.component('ele',{
  render:function(createElement){
    // 克隆 slot 的节点方法
    function cloneVNode(VNode){
      // 递归遍历所有的子节点并且克隆
      const clonedChildren = VNode.children && VNode.children.map(function(vnode){
        return cloneVNode(vnode)
      })
      const cloned = createElement(
        vnode.tag,
        vnode.data,
        clonedChildren
      )
      cloned.text = vnode.text //当前节点的文本，一般文本节点或注释节点会有该属性
      cloned.isComment= vnode.isComment////当前节点是否是注释节点
      cloned.componentOptions= vnode.componentOptions//创建组件实例时会用到的选项信息
      cloned.elm= vnode.elm//当前虚拟节点对应的真实的 DOM 节点
      cloned.context= vnode.context
      cloned.ns= vnode.ns//节点的 namespace
      cloned.isStatic= vnode.isStatic//静态节点的标识
      cloned.key= vnode.key//节点的key属性，用于作为节点的标识，有利于 patch 的优化
      return cloned
    }
    const vNodes = this.$slots.default
    const clonedVNnodes = vNodes.map(function(vNode){
      return createElement('div',[
        vNodes,
        clonedVNnodes
      ])
    })
  }
})
```

## 七、 使用 js 代替模板功能

在 Render 函数中，没有指令，一切都可以⽤用 JS 来实现。就是说 v-if，v-else，wx-if，wx-for 这样的指令在 render 函数中是不存在的，
v-if，v-else，wx-if ：在 render 函数中 js 代码就是 if...else 语句来的，
v-for，wx-for：在 render 函数中 js 代码就是 map 遍历来做的

### 7.1 v-if，v-else，wx-if

```HTML
<div id='app'>
  <ele :show='show'></ele>  <!-- 这里是 ele 子组件 -->
  <button @click='show = !show'>切换 show</button>
<div>
<script>
//在 ele 这个组件中创建  子组件
  vue.component('ele',{
    render:function(createElement){
      if(this.show){
        return createElement('p','show 的值为 true')
      }else{
        return createElement('p','show 的值为 false')
      }
    },
    props:{ // 这是从 app 组件传来的 show 值 props 传值
      show:{
        type:Boolean,
        defalut:false
      }
    }
  })
  var app = new Vue({
    el:'#app',
    data:{
      show:{
        show:false
      }
    }
  })
</script>
```

### 7.2 v-for,wx-for

```html
<div id='app'>
  <ele :list='list'></ele>  <!-- 这里是 ele 子组件 -->
<div>
<script>
  vue.component('ele',{
    render:function(createElement){
      var nodes = []
      var n = this.list.length
      for(var i =0;i<n;i++){
        nodes.push(createElement('p',this.list[i])
      }
      return createElement('div',nodes)
    },
    props:{ // 这是从 app 组件传来的 show 值 props 传值
      list:{
        type:Array,
      }
    }
  });
  var app = new Vue({
    el:'#app',
    data:{
      list:['xiaomi','liuliu','meimei']
    }
  })
</script>
```

### 7.3 v-if 与 for 结合

```HTML
<div id='app'>
  <ele :list='list'></ele>  <!-- 这里是 ele 子组件 -->
<div>
<script>
//在 ele 这个组件中创建  子组件
  vue.component('ele',{
    render:function(createElement){
      var n = this.list.length
      if(n){
        return createElement('ul',this.list.map(function(item){
          return createElement('li',item)
        }))
      }else{
        return createElement('p','列表为空')
      }
    },
    props:{ // 这是从 app 组件传来的 show 值 props 传值
      list:{
        type:Array,
        defalut:function(){
          return []
        }
      }
    }
  });
  var app = new Vue({
    el:'#app',
    data:{
      list:['xiaomi','liuliu','meimei']
    }
  })
</script>
```

### 7.4 v-model

```JS
vue.component('ele',{
    render:function(createElement){
      var that = this
      return createElement('div',[
        createElement('input',{
          domProps:[
            value:this.value
          ],
          on:{
            input:function(e){
              than.value = e.target.value
            }
          }
        }),
        createElement('p','value:'+ this.value)
      ])
    },
    data:function(){
      return:{
        value:''
      }
    }
  })
```

## 八、render 事件修饰符

```BASH
.stop  =>  event.stopPropagation()
.prevent  =>  event.preventDefault()
.self  =>  if(event.target !== event.currentTarget) return
.enter / .13 =>  if(event.keyCode !== 13) return # 替代 13 位 需要的 keyCode
.ctrl/.alt/.shift/.mata =>  if(!event.ctrlKey) return
# 根据需要替换 ctrlKey 为 ctrlKey 或 altKey 又或者 shiftKey ，再或者 mataKey
```

### 8.1 事件修饰前缀

```BASH
.capture =>  !
.once  =>  ~
.capture.once/.once.capture  =>  ~!
```

```JS
on:{
  '!click':this.doThisInCapturingMode, // 发生在捕获阶段的事件函数
  '~keyup':this.doThisOnce,//按键执行一次
  '~!mouseover':this.doThisOnce,//鼠标经过捕获阶段执行一次
}
```

## 九、插槽 slot

插槽分为，

- 单个插槽  ：内容由父组件决定 （不传值）              静态插槽
    `<Child>333333</Child>`

    `<div>
      <slot></slot>
    </div>`
- 具名插槽  ：内容由父组件决定 （不传值）              静态插槽
    <Child>
      <span slot='header'>111</span>
      <span slot='body'>222</span>
      <span slot='footer'>333</span>
    </Child>

    `<div>
      <slot name='header'></slot>
      <slot name='body'></slot>
      <slot name='footer'></slot>
    </div>`
- 作用域插槽：内容由子组件决定（子组件绑定传值给父组件） 作用域插槽
    `<Child scoped-slot='props'>{{props.text}}</Child>`

    `<div>
      <slot :text="message"></slot>
    </div>`

### 9.1 this.$slots 访问 静态插槽 的内容

可以通过 `this.$slots` 访问 **静态插槽** 的内容，得到的是一个 `VNodes` 数组：

```JS
render: function (createElement) {
  //返回 `<div><slot></slot></div>`
  return createElement(
    'div',
    this.$slots.default
    )
}
```

### 9.2  this.$scopedSlots 访问作用域插槽 scoped-slot = 'props'

this.$scopedSlots 访问 **作用域插槽**，得到的是一个返回 VNodes 的函数：

```JS
  props: ['message'],
  render: function (createElement) {
    //返回 `<div><slot :text="message"></slot></div>`
    return createElement(
      'div',
      [
        this.$scopedSlots.default({
          text: this.message
        })
      ]
    )
  }
```

```JS
//用 渲染函数 向子组件 中 传递作用域插槽 参见 4.3.4
render: function (createElement) {
  return createElement(
    'div',
    [
      createElement(
        'child',
        {
          // 在数据对象中传递 `scopedSlots`
          // 格式：{ name: props => VNode | Array<VNode> }
          scopedSlots: {
            default: function (props) {
              return createElement(
                'span',
                props.text
              )
            }
          }
        }
      )
    ]
  )
}

//上面返回的 html 如下
<div>
  <child scoped-slot='props'>
    <span>{{props.text}}</span>
  </child>
</div>
```

### 9.3 slot 默认内容

`this.$slot.default = undefined`,说明父组件中没有定义 slot ，这时可以自定义显示的内容。

```HTML
<div id='app'>
  <ele :list='list'></ele>
  <ele>
    <p>slot 的内容，这里 ele 组件插槽里面是有这段 p 标签的内容的</p>
  </ele>
<div>
<script>
//在 ele 这个组件中创建  子组件
  vue.component('ele',{
    render:function(createElement){
      if(this.$slot.default){
        return createElement('div','没有使用 slot 时 显示的文本')
      }else{
        return createElement('div','this.$slot.default')
      }
    }
  });
  var app = new Vue({
    el:'#app'
  })
</script>
```

## 十、函数式组件

Vue.js 提供了 1 个 functional 的布尔值选项，设置为 true 可以使组件无状态和无实例，也就是没有data 和 this 上下文，这样用render 函数返回虚拟节点可以更容易渲染，因为函数化组件只是 1 个函数，渲染开销要⼩很多。

使用函数化组件时，Render 函数提供了第 2 个参数 context 来提供临时上下文，组件需要的 data、props、slots、children、parent 都是通过这个上下文 来传递，比如 `this.level` 要改写为`context.props.level`，而 `this.$slots.default` 改写为 `context.children。`











## 十二、vue.js 中 的 render

```JS
// 直接使用 h() 方法构建 虚拟 DOM
render: (h, params) => {
  return h("ButtonGroup", [
    h(
      "Button",
      {
        props: {
          type: "info",
          icon: "ios-analytics"
        },
        on: {
          click: () => {
            this.showDetail(params.index);
          }
        }
      },
      "详情"
    ),
    h(
      "Button",
      {
        props: {
          type: "error",
          icon: "ios-trash"
        },
        on: {
          click: () => {
            this.remove(params.index);
          }
        }
      },
      "删除"
    )
  ]);
}
// 直接使用 h() 方法构建 虚拟 DOM
// 触发事件
/*
on: {
  click: () => {
    this.showDetail(params.index);
  }
}
*/
```

```JS
// return 中写的是 html 片段
render: (h, params) => {
  return (
    <ButtonGroup size="default">
      <Button type="success" icon="md-create" onClick={() => {
        this.handleClickEditRobot(params.row)
      }}></Button>
      <Button type="warning" disabled={params.row.status === '掉线'}
              icon={params.row.status === '运行中' ? 'ios-pause' : 'ios-play'} onClick={() => {
        this.handleClickPlayOrPause(params.row)
      }}></Button>
      <Button type="error" icon="ios-trash" onClick={() => {
        this.handleClickDelete(params.row)
      }}></Button>
    </ButtonGroup>
  )
}

// return 中写的是 html 片段
// 触发事件
/*
onClick={() => {
  this.handleClickEditRobot(params.row)
}} */
// 通过一对花括号来写一个函数片段在里面!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!值得学习。
```