---
title: 'vue--[ref 子组件标识属性]'
date: '2018/8/19 23:57:28'
tags:
  - interceptor 请求拦截器
categories:
  - ④  vue.js
  - vue.js 框架学习
abbrlink: d6745f22
updated:
comments:
---
## 一、前言

- ref 在父组件 html 引用 子组件的标签中给 子组件 一个特殊的 ref 属性。用来指定子组件。
- ref 用于普通元素的时候，例如 ：div，p，等，就等价于类似给这些元素一个  ID 特殊属型，来指定其中的 Node 节点。

## 二、用于子组件：父组件 访问 子组件实例 或 子元素

尽管存在 prop 和事件，prop 父传子，事件 子传父。

有的时候你仍可能需要在 JavaScript 里直接访问一个子组件。为了达到这个目的，你可以通过 ref 特性为这个子组件赋予一个 ID 引用。例如：

### 2.1 例 一

```HTML
<!-- 父组件 -->
<base-input ref="usernameInput"></base-input>
<script>
  export default {
    name:'',
    data(){
      return{
        //
      }
    },
    methods:{
      getFromChild(){
        this.$refs.usernameInput.xxxx()// 获取到子组件实例 的某个方法
        this.$refs.usernameInput.name// 获取到子组件实例 的某个 数据
      }
    }
  }
</script>
```

```HTML
<!-- 子组件 -->
<script>
  export default {
    name: "baseinput",
    data(){
      return{
        name:''
      }
    },
    methods:{
      xxxx(){
        //
      }
    }
  }
</script>
```

### 2.2 例 二

```HTML
<!-- 父组件 -->
<div id="app">
    <navbar ref="navbar"></navbar>
    <pagefooter ref="pagefooter"></pagefooter>
</div>
<script>
new Vue({
  el:'#app',
  mounted() {
    console.log(this.$refs.navbar.navs);//[]
    console.log(this.$refs.pagefooter.footer);//''
  }
})
</script>
```

```JS
// 子组件
Vue.component('navbar',{
    template:'#navbar',
    data:function () {
        return {
            navs:[]
        }
    }
});

Vue.component('pagefooter',{
    template:'#pagefooter',
    data:function () {
        return {
            footer:''
        }
    }
});
```

## 三、用于普通元素：html 原始元素标签

```HTML
<div ref="demo"></div>
```

```JS
document.querySelector('[ref=demo]');// 获取的是 DOM 节点
// 等价于
this.$refs.demo
```
