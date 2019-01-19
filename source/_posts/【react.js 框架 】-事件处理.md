---
title: 'react.js--[事件处理]'
date: '2018/8/19 23:57:28'
tags:
  - react.js事件处理
categories:
  - 五、react.js
  - react.js 框架学习
abbrlink: e63d7434
updated:
comments:
---

# 一、事件处理

- 在 react 的 ES6 class 组件中，事件函数与其他的周期选项是平级的
- 事件函数的 this 要处理好，（ES6 this 的关系）

# 二、绑定事件处理函数 this 的几种写法

## 2.1 在构造函数中绑定 this

.bind(this)  在 构造器中定义方法的时候使用 Function.prototype.bind

```JS
import React, { Component } from 'react';
class Toggle extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isToggleOn: true,
      msg:'some msg'
    };
    this.handleClick = this.handleClick.bind(this);//在构造函数加上这语句代码
    this.run = this.run.bind(this);
  }

  handleClick() {
    this.setState(prevState => ({// 注意这样不要使用  this.state 或者 this.props 因为可能是异步的，
      isToggleOn: !prevState.isToggleOn // 使用 函数，传参 prevState  props
    }));
  }
  run(){
    alert(this.state.name)
  }
  render() {
    return (
      <div>
      /* 上面的 this 要处理好，不然这里无法获取到 handleClick 事件处理方法，因为这里是回调函数，this 值不是原来的值了 */
        <button onClick={this.handleClick}></button>
        <button onClick={this.handleClick(this,id)}>{this.state.isToggleOn ? 'ON' : 'OFF'}
        </button>
        <button onClick={this.run}>按钮</button>
      </div>
    )
  }
}
export defalut Toggle;
```

必须谨慎对待 JSX 回调函数中的 this，ES6 中类的方法默认是不会绑定 this 的。如果你忘记绑定 this.handleClick 并把它传入 onClick, 当你调用这个函数的时候 this.handleClick 的值会是 undefined。

上面代码中也说了 vue 也存在 this 的问题，也要注意。因为这个 this 是 JS 中的问题，它是函数如何在 JavaScript 中运行的一部分。通常情况下，如果你没有在方法后面添加 () ，例如 onClick={this.handleClick}，你应该为这个方法绑定 this。

### 5.2.2 属性初始化器语法（使用箭头函数）（这个办法应该算是最简答的办法了！！！！！！！！！！！）

如果使用 bind 让你很烦，这里有两种方式可以解决。如果你正在使用实验性的属性初始化器语法，你可以使用属性初始化器来正确的绑定回调函数：

```JS
class LoggingButton extends React.Component {
  // 事件函数使用箭头函数写法
  handleClick = () => {
    console.log('this is:', this);
  }
  run=()=> {
    alert(this.state.name)
  }
  render() {
    return (
      <button onClick={this.handleClick}>
        Click me
      </button>
      <button onClick={this.run}>按钮</button>
    );
  }
}
export defalut LoggingButton;
```

### 5.2.3 在 render 中使用箭头函数，（不推荐这个办法，会有性能问题，所以不一般都没有说这个办法吧，不要在 render去处理这里问题）

使用这个语法有个问题就是 **每次** LoggingButton 渲染的时候 **都会创建一个不同的回调函数**。在大多数情况下，这没有问题。然而如果这个回调函数作为一个属性值传入低阶组件，这些组件可能会进行额外的重新渲染。我们通常建议在构造函数中绑定或使用属性初始化器语法来避免这类 **性能问题**。

```JS
class LoggingButton extends React.Component {
  handleClick() {
    console.log('this is:', this);
  }
  render() {
    // This syntax ensures `this` is bound within handleClick
    return (
      <button onClick={(e) => this.handleClick(e)}>Click me</button>// 不推荐
      // 不推荐在 render 中这样使用箭头函数，会有性能问题，虽然这也是一个办法
    );
  }
}
```

# 六、触发事件-传递参数：2 种办法

## 6.1 render 中回调函数传参（但是上面好像说这个办法不可取啊？？？？？）

- 事件 event 必须显示传参，并且是最后一位

```JS
class LoggingButton extends React.Component {
  constructor(){
    super(props)
    this.state={
      name:'xiaomi'
    }
  }
  preventPop=(name, e)=>{    //接收显示 传递过来的 event 是放在最后的
    e.preventDefault();
    alert(name);
  }
  deleteRow=(id,e)=>{
    //不需要传递参数的时候就不用写回调了。
  }
  render() {
    // This syntax ensures `this` is bound within handleClick
    return (
      <div>
        // 事件 event 要显示传递，放在最后传递
        <a href="https://reactjs.org" onClick={(e)=>this.preventPop(this.state.name,e)}>Click</a>
        <button onClick={(e) => this.deleteRow(id, e)}>Delete Row</button>
        // 参数 e 作为 React 事件对象将会被作为 第 2 个参数进行传递。通过箭头函数的方式，事件对象必须显式的进行传递。
      </div>
    );
  }
}
```

## 6.2 render 中 bind 传参（还是用这个办法好了）

- 事件 event 是隐示传参，接收参数也是在最后一位
- this 是一个显示传递的参数，但是接收没有它。

```JS
class LoggingButton extends React.Component {
  constructor(){
    super(props)
    this.state={
      name:'xiaomi',
      completeList:[]
    }
  }
  preventPop=(name, e)=>{    //接收隐式传递过来的 事件对象 e 要放在最后
    e.preventDefault();
    alert(name);
  }
  deleteRow=(id)=>{
    //
  }
  handleClick=(porps0, props1, ..., event)=>{
    // your code here
  }
  del=(index,e)=>{
    let completeList = this.state.completeList
    completeList.splice(index,1)
    this.setState({
      completeList:completeList
    })
    this.setLocaleData()
  }
  render() {
    return (
        // 事件 event 不需要显示传递，只是隐式的传递过来了
      <div>
        <a href="https://reactjs.org" onClick={this.preventPop.bind(this,this.state.name)}>Click</a>
        <button onClick={this.deleteRow.bind(this, id)}>Delete Row</button>
        <button /* onClick={this.handleClick.bind(this, props0, props1, ...} */></button>
        <List
          header={<div>已完成列表</div>}
          bordered
          dataSource={this.state.completeList}
          renderItem={(item,index) =>(<List.Item actions={[<Button size='small' onClick = {this.del.bind(this,index)}>
          删除</Button>] }>{item}</List.Item>)}/>
      </div>
        // 通过 bind 的方式，事件对象 e 以及更多的参数将会被隐式的进行传递。写的表达式中我们看不到传递，但是却可以使用了。
        // 但是需要注意的是，通过 bind 方式向监听函数传参，在类组件中定义的监听函数，事件对象 e 要排在所传递参数的后面
        //render 触发事件：this.handleclick.bind(this，要传的参数)
        // 事件  函数 处理：handleclick(传过来的参数，event)
    );
  }
}
```

# 七、事件函数注意的问题

## 7.1 onClick={activateLasers} 触发事件函数

**React 元素**的事件处理和 **DOM 元素**的很相似。但是有一点语法上的不同:

- React 事件绑定属性的命名采用 **驼峰式写法**，而不是小写。因为 React 是 JS ，而 DOM 元素 是 html
- 如果采用 JSX 的语法你需要传入一个函数作为事件处理函数，而不是一个字符串(DOM元素的写法)

```HTML
<!-- DOM 元素 绑定事件: 使用引号-->
<button onclick="activateLasers()">
  Activate Lasers
</button>
<!-- 使用返回 false 的方式阻止默认行为 -->
<a href="#" onclick="console.log('The link was clicked.'); return false">
  Click me
</a>
```

```JS
/* React 元素绑定事件：使用花括号，注意，使用花括号之后就不要用引号了 */
<button onClick={activateLasers}>
  Activate Lasers
</button>
/* 不能使用返回 false 的方式阻止默认行为。你必须明确的使用 preventDefault。 */
function ActionLink() {
  //在这里，e 是一个合成事件。React 根据 W3C spec 来定义这些合成事件，所以你不需要担心跨浏览器的兼容性问题。
  function handleClick(e) {
    e.preventDefault();
    console.log('The link was clicked.');
  }

  return (
    <a href="#" onClick={handleClick}>
      Click me
    </a>
  );
```

## 7.2 事件 e 的处理