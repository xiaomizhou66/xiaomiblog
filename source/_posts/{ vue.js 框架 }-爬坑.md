---
title: 'vue.js--[爬坑集合]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

## 一、前言

使用过程中遇到的各种错误，自己不小心犯的错。

## 二、爬坑

### 2.1 快速定位错误的 html 段落

```BASH
[Vue warn]: Invalid prop: type check failed for prop "value". Expected Array, String, got Number.

found in

---> <Collapse> # 这里箭头就是错误的 html 段落，只要去这里面去找对应的错误就好了
       <Organization> at src/pages/organization/organization.vue
         <Content>
           <Layout>... (1 recursive calls)
             <Admin> at src/group/admin.vue
               <App> at src/App.vue
                 <Root>
```

### `Error in mounted hook: "TypeError: this.initInfo is not a function"`

```BASH
Error in mounted hook: "TypeError: XXXXX is not a function"
# 遇到这个问题一定是函数没有定义，
# 看下是不是函数名错误了
# 要不就是使用了混合组件但是没有导入，没有注册 mixin ？？？？
```

### 2.1 改变数据类型的坑

如下是希望将输入的数据保存在本地，刷新之后数据依然存在。也即是类似做个 todolist 项目的时候，遇到 push 数据不成功的情况。

```JS
//以下代码为需要展示不部分，其他无关的代码省略
<script>
export default {
  name: 'Home', // 这里是组件名称，给 template 中的 class 没有关系，原名为 HelloWorld
  data () {
    retrun {
      ...,
      todolist:[]//这里一定要写[]，是数组就写数组，不能写 null 其他类型的数据，
    }
  },
  watch: {
    // 此处为观察 todolist，一旦发生变化然后执行里面的函数
    todolist: {
      handler: function (newval, oldVal) {
        var vm = this
        window.localStorage.setItem('todolist', JSON.stringify(vm.todolist))
        //一旦数组数据有所改变，立即执行todolist的保存
      },
      deep: true
    }
  },
  mounted () {
    //获取本次保存的数据放置到数组中 tosolidt 中
    this.todolist = JSON.parse(window.localStorage.getItem('todolist'))
  },
  methods: {
    addtodolist () {
      //新建一个变量 newtododata，push 到表格数据数组 todolist 中，
      //避免表格数据与输入框双向绑定
      var newtododata = {
        input: this.newtodo.input,
        datestart: this.newtodo.datestart,
        timestart: this.newtodo.timestart,
        dateend: this.newtodo.datesend,
        timeend: this.newtodo.timeend,
        isFinish: this.newtodo.isFinish
      }
      this.todolist.push(newtododata)
      this.$Message.info('添加成功')
    }
  }
}
</script>
```

如上代码一执行，就会发现如下错误。

```bash
[Vue warn]: Error in callback for watcher "data": "TypeError: Cannot read property 'forEach' of null"
found in
---> <Table>
       <Content>
         <Layout>
           <Home> at src\components\home.vue
             <App> at src\App.vue
               <Root>
vue.esm.js?efeb:1741 TypeError: Cannot read property 'forEach' of null
    at VueComponent.makeObjData (iview.js?377a:22344)
    at VueComponent.handler (iview.js?377a:22495)
[Vue warn]: Error in event handler for "on-ok": "TypeError: Cannot read property 'push' of null"
found in

---> <Modal>
       <Content>
         <Layout>
           <Home> at src\components\home.vue
             <App> at src\App.vue
               <Root>
TypeError: Cannot read property 'push' of null
    at VueComponent.addtodolist (home.vue?250d:226)
    at VueComponent.invoker (vue.esm.js?efeb:2027)
```

检查代码发现逻辑没有错误。错在数据类型出错了。在mounted周期中，没有考虑'todolist'为空的情况，一开始todolist为空，保存到本地的将是undefined，但是实际上，我们的todolist应该是数组的。

```JS
//mounted () {
  //获取本次保存的数据放置到数组中 tosolist 中
// this.todolist = JSON.parse(window.localStorage.getItem('todolist'))
//},
//更新如下，保证为空的时候为'[]'，那么保存的将会是[]这个字符串，重新获取的也会是[]空数组了，
//不会是其他的数据类型
mounted () {
  //获取本次保存的数据放置到数组中 tosolist 中
  this.todolist = JSON.parse(window.localStorage.getItem('todolist' || '[]'))
},
```

**因此，我们在做变量赋值的时候一定要注意不要改变数据类型。**

### 2.2 项目目录不能有大写字母

```BASH
name can no longer contain capital letters.
```

### 2.3 v-for 指令中的参数顺序要正确

`v-for="(value,key,index) in items"`

- 三个参数的话，第一个是 value ，第二个是 key ，第三个是 index
- 两个参数的话，第一个是 value ，第二个是 index

错误的话写 :key="index" 的话是错误的。