---
title: react.js--生命周期 与 对应周期函数
date: '2018/8/19 23:57:28'
tags:
  - react.js 生命周期
categories:
  - ⑤ react.js
  - react.js 框架学习
updated:
comments:
---

# 一、前言

```JS
class Greeting extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
```

生命周期中 render()  是必须的，这是最简单的 class 创建的组件。

每一个组件都有几个你可以重写以让代码在处理环节的特定时期运行的 “生命周期方法”。

方法中带有前缀 will 的在特定环节 **之前**被调用，
而带有前缀 did 的方法则会在特定环节 **之后**被调用。

# 二、生命周期

![tu](https://upload-images.jianshu.io/upload_images/4118241-d979d05af0b7d4db.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/488/format/webp)

<div style="color:red;">官网生命周期图纸，也就是上面的周期已经被废弃了，最新的周期看下面的图片（就是官网中新的周期图）。（官网有点乱。。。。）
</div>

>常用的周期

![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190301150349.png)

>完整的周期

![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190301150338.png)

官网最新的生命周期，[文档解析](https://reactjs.org/docs/react-component.html)

React生命周期主要包括三个阶段：**初始化阶段**、**运行中阶段**和 **销毁阶段**，在React不同的生命周期里，会依次触发不同的钩子函数。

```BASH
# 一、初始化阶段
static defaultProps={} # 设置组件的默认属性
constructor()          # 设置组件的初始化状态
                            # props 可以不写在小括号中（官网是写的），它是隐式的传参
                            # 如果不初始化状态,不绑定方法，则不需要为 React 组件实现构造函数。
static getDerivedStateFromProps() # 用来替代 react v16.3 中舍弃的周期
                                  # 组件  实例化后  和  接受新属性 时将会调用 getDerivedStateFromProps。
                                  # 它应该返回 一个对象 来更新状态，或者返回 null 来表明新属性 不需要 更新任何状态。
                                  # 注意，如果父组件导致了组件的重新渲染，即使属性没有更新，这一方法也会被调用。
                                  # 如果你只想处理变化，你可能想去比较新旧值。调用this.setState() 通常不会触发 getDerivedStateFromProps()。
                                  # componentWillMount() # react v16.3 舍弃了这个周期
                                  # UNSAFE_componentWillMount() # 这个已经被废弃了不要使用了
render()  # 组件渲染【虽然是中间执行的，但是习惯把代码放在最后，大众的习惯!!!!!!!!!!!!!!!!!!!!!!!!!!!!】
          # render() 方法是类组件中 唯一必需 的方法。
          # render()如果shouldComponentUpdate()返回false，则不会被调用。
componentDidMount()  # 组件已经被渲染到页面中后触发：此时页面中有了真正的 DOM 的元素，可以进行 DOM 相关的操作
                     # componentDidMount-componentWillUnmount成对出现
                     # 定时器开启，网络请求，事件监听，Redux 的订阅事件,然后在 componentWillUnmount()  中取消

# 二、运行中阶段:
                    # componentWillReceiveProps()  # react 16 已经舍弃了
shouldComponentUpdate(nextProps, nextState)      #  当组件接收到新属性，或者组件的状态发生改变时触发。组件首次渲染时并不会触发
                    # componentWillUpdate()      # react v16.3 舍弃了
getDerivedStateFromProps(prevProps, prevState)   # 在最新的渲染输出提交给DOM前将会立即调用。
                    # 将传入的 props 更新到 state 上
componentDidUpdate(prevProps, prevState, snapshot)  # 组件被更新完成后触发。
                    # 页面中产生了新的DOM的元素，可以进行DOM操作
                    # 如果shouldComponentUpdate()返回false，则 componentDidUpdate() 不会被调用。

# 三、销毁阶段：
componentWillUnmount()      #在组件被卸载和销毁之前立刻调用。 组件被销毁时触发。
                        # 这里我们可以进行一些清理操作，例如 清理定时器，取消 Redux 的订阅事件等等。
                        # 可以在该方法里处理任何必要的清理工作，例如解绑定时器，取消网络请求，清理任何在 componentDidMount 环节创建的 DOM 元素。

# 四、错误处理：
static getDerivedStateFromError()
componentDidCatch(error, info)
```

```JS
import React from 'react'
import ReactDOM from 'react-dom';

// 父组件
class Counter extends React.Component {
    static defaultProps = {
      // ①①①① 、加载默认属性：设置组件的默认属性，大多数情况下，这是处理需要重置的状态的最佳方法。
      name: 'sls',
      age:23
    };
    // Counter.defaltProps={name:'sls'} 或者默认属性是这样写，在 class 类外面写
    constructor() {
      super();//super(props) 在任何其他语句之前调用。否则，this.props 将在构造函数中未定义，这可能导致错误。
      // ②②②② 、加载默认状态：设置组件的初始化状态
      this.state = {
        number: 0,
        //color: props.color 错误的写法，也不要在这里用 this.setState
        color: this.props.color //正确的写法
        }
    }

    static getDerivedStateFromProps(nextProps, prevState){
      console.log('33333333333 666666666666 、替代了原来的三个 will 舍弃的周期');
              //组件实例化后和接受新属性时将会调用 getDerivedStateFromProps。
              // 它应该返回一个对象来更新状态，或者返回 null 来表明新属性 不需要更新任何状态。
              // 注意，如果父组件导致了组件的重新渲染，即使属性没有更新，这一方法也会被调用。如果你只想处理变化，你可能想去比较新旧值。
              //调用this.setState() 通常不会触发 getDerivedStateFromProps()
    }

    componentDidMount() {
      console.log('5555555555 、父组件挂载完成');
            //安装组件（插入树中）后立即调用，此时可以进行开启定时器、向服务器发 送请求 ajax,axios,request 等操作!!!!!!!!!!!!!!!!!
            //组件已经被渲染到页面中后触发：此时页面中有了真正的 DOM 的元素，可以进行DOM相关的操作
    }

    shouldComponentUpdate(newProps, newState) {//当组件接收到新属性，或者组件的状态发生改变时触发。组件首次渲染时并不会触发
      console.log('7777777777777777 、父组件是否需要更新');
      if (newState.number<15) return true;//该钩子函数可以接收到两个参数，新的属性和状态，返回true/false来控制组件是否需要更新。
      return false
            //一般我们通过该 周期函数来优化性能：
            //一个 React 项目需要更新一个小组件时，很可能需要父组件更新自己的状态。
            //而一个父组件的重新更新会造成它旗下所有的子组件重新执行 render() 方法，形成新的虚拟 DOM，
            //再用 diff 算法对新旧虚拟 DOM 进行结构和属性的比较，决定组件是否需要重新渲染
            //无疑这样的操作会造成很多的性能浪费，所以我们开发者可以根据项目的业务逻辑，在 shouldComponentUpdate() 中加入条件判断，
            //从而优化性能,不需要更新的时候就不要费力去更细了
            //例如 React 中的就提供了一个 PureComponent 的类，当我们的组件继承于它时，组件更新时就会默认先比较新旧属性和状态，从而决定组件是否更新。值得注意的是，      PureComponent 进行的是浅比较，所以组件状态或属性改变时，都需要返回一个新的对象或数组
    }

    getSnapshotBeforeUpdate(prevProps, prevState){
      console.log('99999999 、在最新的渲染输出提交给 DOM 前将会立即调用。它让你的组件能在当前的值可能要改变前获得它们。这一生命周期返回的任何值将会 作为参数被传递给componentDidUpdate()。 ');
      if (prevProps.list.length < this.props.list.length) {
        return this.listRef.current.scrollHeight;
      }
      return null;
    }

    componentDidUpdate(prevProps, prevState, snapshot) {
      console.log('10 10 10 10、父组件更新完成');//组件被更新完成后触发。页面中产生了新的 DOM 的元素，可以进行 DOM 操作
          //更新发生后立即调用。初始渲染不会调用此方法。
          //将此作为在 更新组件 时对 DOM 进行操作的机会。只要您将 当前道具 与 之前的道具 进行比较（例如，如果道具未更改，则可能不需要网络请求），这也是进行网络请求   的好地方。!!!!!!!!!!!!!!!!!!!!!!
          // Typical usage (don't forget to compare props):
      if (this.props.userID !== prevProps.userID) {
        this.fetchData(this.props.userID);
      }
      if (snapshot !== null) {
        this.listRef.current.scrollTop += this.listRef.current.scrollHeight - snapshot;
      }
    }

    componentWillUnmount(){
      console.log('11 11 11 11、销毁组件，卸载组件');
    }

    componentDidCatch(error, info){
      console.log('12 12 12 12 12、渲染发生错误');
    }
    // 其他自定义的方法，事件触发的方法，与周期函数 同级，react 的方法可以使用 箭头函数
    handleClick = () => {
      this.setState({
        number: this.state.number + 1// 这里怎么使用 this.state ？？？？？ 不应该去依赖 this.state 把？？？？
        // 看不懂，不是说状态更新是异步的么？？不应该是使用 this.state ， this.props
      })
      // 有运算的应该是给 this.setState 传入一个函数把？不能简单的使用对象吧？？？？应该是下面这样来写吧？？？
      this.setState((prevState)=>({
        number:prevState.number + 1
      )})
    }

    render() {
      console.log('4444444 888888、render(父组件挂载)');
      return (
        <div>
          <p>{this.state.number}</p>
          <button onClick={this.handleClick}>+</button>
          {this.state.number<10?<SubCounter number={this.state.number}/>:null}
          <div ref={this.listRef}>{/* ...contents... */}</div>
        </div>
      )
    }
}

ReactDOM.render(<Counter/>, document.getElementById('root'));
Counter.forceUpdate(callback) // 强制渲染，不理会 shouldComponentUpdate()，通常不要使用这个方法，还是在 render 做好措施比较好
Counter.defaultProps = {// 默认属性值的设置
  color: 'blue'//若未设置 props.color，其将被设置默认为'blue',若props.color设为null，则其值则为null：
};

// 子组件
class SubCounter extends React.Component {

    shouldComponentUpdate(newProps, newState) {
        console.log('10、子组件是否需要更新');
        if (newProps.number < 5) return true;
        return false
    }

    componentDidUpdate() {
        console.log('13、子组件更新完成');
    }

    render() {
        console.log('12、子组件挂载中');
        return (
                <p>{this.props.number}</p>
        )
    }
}
```