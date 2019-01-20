---
title: react.js--入门教程
date: '2018/8/19 23:57:28'
tags:
  - react.js事件处理
categories:
  - ⑤ react.js
  - react.js 框架学习
abbrlink: f7bf9ef
updated:
comments:
---

# 一、前言

虽然我们有中国尤大神的 vue 做 web 端，有有 mpvue 做小程序，但是相比来说还是没有国外的 react 来的好，首先它支持的终端更多。 web 端，移动端，小程序，支付宝程序，等等，这些它都比 vue 延伸的一些源工具要好。ui 库 也有更多的人来维护。很多大公司使用的也是 reac.js。

[react 中文网](https://react.docschina.org/tutorial/tutorial.html)
[react 16.7.0英文网](https://reactjs.org/docs/getting-started.html)

**React** 是一个采用声明式，高效而且灵活的用来构建用户界面的 **框架**。

从第二章开始学习之前，**先要学习 ReactDOM.render() 这个 API 接口**，这样我们才能看得动下面的文章学习。
从第二章开始学习之前，**先要学习 ReactDOM.render() 这个 API 接口**，这样我们才能看得动下面的文章学习。
从第二章开始学习之前，**先要学习 ReactDOM.render() 这个 API 接口**，这样我们才能看得动下面的文章学习。

# 二、先需要学习一下 JSX 拓展语言 && render 函数

去相应的文章去学习。这里省略。

# 三、React 教程:组件 & Props

React 允许将代码封装成组件（component），然后像插入普通 HTML 标签一样，在网页中插入这个组件。
阮一峰的教程：React.createClass 方法就用于生成一个组件类，但是我们现在使用的是 ES6 ，要与时俱进，现在是 **React.Component**!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

**组件**可以将 UI 切分成一些 **独立的、可复用的部件**，这样你就只需专注于构建每一个单独的部件。组件从概念上看就 **像是函数**，它可以接收任意的输入值（称之为“props”），并返回一个需要在页面上展示的 React 元素。组件名称必须以 **大写字母开头**。
例如，`<div />` 表示一个 DOM 标签，但 `<Welcome />` 表示一个组件，并且在使用该组件时你必须定义或引入它。

## 3.1. 函数定义/类定义组件：JavaScript 函数 && ES6 class

两种方式得到的结果是一样的，下面就是用两种方法来创建同样的一个 React 元素。

### 3.1.2 JavaScript 函数

该函数是一个有效的 React 组件，它接收一个单一的 “props” 对象并返回了一个 React 元素。我们之所以称这种类型的组件为函数定义组件，是因为从字面上来看，它就是一个 JavaScript 函数。

```JS
//JavaScript函数： 定义组件
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}
```

### 3.1.2  ES6 class

```JS
class Welcome extends React.Component {
  render() {
    return <h1>Hello, {this.props.name}</h1>;
  }
}
```

## 3.2 组件渲染

`const element = <div></div>`;       这个 React 元素  是 DOM 标签/元素：
`const element = <Welcome name="Sara" />`;//这个 React 元素  是 用户自定义的组件：

```HTML
<div id='root'></div>
```

```JS
//当 React 遇到的元素是 用户自定义的组件，它会将 JSX 属性作为单个对象传递给该组件，这个对象称之为 “props”。
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

const element = <Welcome name="Sara" />;
ReactDOM.render(
  element,
  document.getElementById('root')
);
```

转译之后得到

```HTML
<div id='root'>
  <h1>Hello, Sara</h1>
</div>
```

解析上面的转译过程：

- 对 `<Welcome name="Sara" />` 元素调用了 `ReactDOM.render()` 方法。
- React 将 `{name: 'Sara'}` 作为 `props` 对象 传入并调用 Welcome 组件
- Welcome 组件将 `<h1>Hello, Sara</h1>` 元素作为结果返回
- React DOM 将 DOM 更新为 `<h1>Hello, Sara</h1>`。

**重点!!!!!!!!!!!!!!!!!!!!!!!!!!!!!**
组件名称必须以 **大写字母开头**。
例如，`<div/>` 表示一个DOM标签，但 <Welcome /> 表示一个组件，并且在使用该组件时你必须定义或引入它。

## 3.3 组合组件

组件可以在它的输出中引用其它组件，这就可以让我们用同一组件来抽象出任意层次的细节。在 React 应用中，按钮、表单、对话框、整个屏幕的内容等，这些通常都被表示为组件。

```JS
//创建一个 App 组件，用来多次渲染 Welcome 组件：就是多次复用 Welcome 组件 咯
function Welcome(props) {
  return <h1>Hello, {props.name}</h1>;
}

function App() {
  return (
    <div>
      <Welcome name="Sara" />
      <Welcome name="Cahal" />
      <Welcome name="Edite" />
    </div>
  );
}

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
//通常，一个新的 React 应用程序的顶部是一个 App 组件。
//但是，如果要将 React 集成到现有应用程序中，则可以从下而上使用像 Button 这样的小组件作为开始，并逐渐运用到视图层的顶部。?????看不懂
//组件的返回值只能 有一个根元素 !!!!!!!!!!!!!!!!。这也是我们要用一个 <div> 来包裹所有 <Welcome /> 元素的原因。
```

## 3.4 提取组件

提取组件一开始看起来像是一项单调乏味的工作，**但是在大型应用中，构建可复用的组件完全是值得的**。当你的 UI 中有一部分重复使用了好几次（比如，Button、Panel、Avatar），或者其自身就足够复杂（比如，App、FeedStory、Comment），类似这些都是抽象成一个可复用组件的绝佳选择，这也是一个比较好的做法。

```js
//可以将组件切分为更小的组件，这没什么好担心的。
function Comment(props) {
  return (
    <div className="Comment">
      <div className="UserInfo">
        <img className="Avatar"
          src={props.author.avatarUrl}
          alt={props.author.name}
        />
        <div className="UserInfo-name">
          {props.author.name}
        </div>
      </div>
      <div className="Comment-text">
        {props.text}
      </div>
      <div className="Comment-date">
        {formatDate(props.date)}
      </div>
    </div>
  );
}
//这个组件接收 author(对象)、 text(字符串) 、以及 date(Date对象)作为 props，用来描述一个社交媒体网站上的评论。
//这个组件由于嵌套，变得难以被修改，可复用的部分也难以被复用。所以让我们从这个组件中提取出一些小组件。
```

```JS
//提取 Avatar 组件：
function Avatar(props) {
  return (
    <img className="Avatar"
      src={props.user.avatarUrl}
      alt={props.user.name}
    />
  );
}
//Avatar 作为 Comment 的内部组件，不需要知道是否被渲染。因此我们将 author 改为一个更通用的名字 user。
//建议从组件 自身的角度 来命名 props，而不是 根据使用组件的 上下文命名。
```

```JS
function Comment(props) {
  return (
    <div className="Comment">
      <div className="UserInfo">
        <Avatar user={props.author} />
        <div className="UserInfo-name">
          {props.author.name}
        </div>
      </div>
      <div className="Comment-text">
        {props.text}
      </div>
      <div className="Comment-date">
        {formatDate(props.date)}
      </div>
    </div>
  );
}
```

```JS
//提取一个 UserInfo 组件，用来渲染 Avatar 旁边的用户名：
function UserInfo(props) {
  return (
    <div className="UserInfo">
      <Avatar user={props.user} />
      <div className="UserInfo-name">
        {props.user.name}
      </div>
    </div>
  );
}
```

```JS
function Comment(props) {
  return (
    <div className="Comment">
      <UserInfo user={props.author} />
      <div className="Comment-text">
        {props.text}
      </div>
      <div className="Comment-date">
        {formatDate(props.date)}
      </div>
    </div>
  );
}
```

### 3.1.5 Props的只读性

无论是使用函数或是类来声明一个组件，它决不能修改它自己的 props。
React 是非常灵活的，但它也有一个严格的规则：所有的 React 组件必须像纯函数那样使用它们的 props。

当然，应用的界面是随时间动态变化的，我们将在下一节介绍一种称为 “state” 的新概念，State 可以在不违反上述规则的情况下，根据用户操作、网络响应、或者其他状态变化，使组件动态的响应并改变组件的输出。

```JS
function sum(a, b) {
  return a + b;
}
//类似于上面的这种函数称为 “纯函数”，它没有改变它自己的输入值，当传入的值相同时，总是会返回相同的结果。
//与之相对的是非纯函数，它会改变它自身的输入值：
function withdraw(account, amount) {
  account.total -= amount;
}
```

# 四、react 教程: State & 生命周期

前面学习都是 ReactDOM.render() 方法来创建渲染，本节说的是使用 ES6 的 class 类来创建。

ES6 中class 类会有它自己的 **属性**与 **方法**，这个属性其实就是数据。

这里我们就使用 ES6 的 class 类来创建我们的组件。**状态 State** 与 属性 十分相似，但是 **状态是私有的，完全受控于当前组件**。
定义为类的组件有一些特性。局部状态就是如此：一个功能只适用于类。

## 4.1 将函数转化为类

上面的篇幅中提到一个创建间歇调用的函数，使用的是 函数形式来创建使用组件，这里我们就将它换成 类的形式。

```JS
// 函数
function Clock(props) {
  return (
    <div>
      <h1>Hello, world!</h1>
      <h2>It is {props.date.toLocaleTimeString()}.</h2>
    </div>
  );
}

function tick() {
  ReactDOM.render(
    <Clock date={new Date()} />,
    document.getElementById('root')
  );
}

setInterval(tick, 1000);
```

```JS
// Clock   类
// 使用类就允许我们使用其它 特性，例如 局部状态、生命周期钩子!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// 添加一个类构造函数来初始化状态 this.state ,其实也就是说将外面传进来的 props 放置在 构造函数 state 中
//传递 props 到基础构造函数，为一个类添加局部状态，
// render 的时候就冲 state 去获取相应的数据
class Clock extends React.Component {//创建一个 名称扩展 为 React.Component 的 ES6 类
  //① 构造函数 设置组件的初始化状态
  constructor(props) {
    super(props);// 这一句不要忘记了。
    this.state = {date: new Date()};// 需要在 render 中使用到 用状态，不使用到的不需要用。
  }
 // 组件已经被渲染到页面中后触发：此时页面中有了真正的 DOM 的元素，可以进行 DOM 相关的操作
  componentDidMount() {
    // 生命周期，当组件输出到 DOM 后会执行 componentDidMount() 钩子，这是一个建立定时器的好地方：
    this.timerID = setInterval(// 设置定时器
      () => this.tick(),
      1000
    );
  }
  //② 组件即将被渲染到页面之前触发，此时可以进行开启定时器、向服务器发送请求等操作 ??????? 正确么？？？？不对吧，
  // 官网的定时器都是在 componentDidMount() 周期去触发的。
  componentWillUnmount() {
    // 生命周期
    clearInterval(this.timerID);// 卸载定时器
  }
  // 更新组件局部状态，要正确的使用 更新状态 this.setState，有点像是小程序的 MINA 框架，更新数据的方式
  // 不要直接赋值，直接赋值是不会得到更新的，this.state.date = '2018'; 这个是不成功，这种的只能是在  constructor 初始化数据用的
  tick() {
    this.setState({
      date: new Date()
    });
  }
  xxx(){
    // Wrong, this.props 和 this.state 可能是异步更新的，你不应该依靠它们的值来计算下一个状态。
    //this.setState({
    //  counter: this.state.counter + this.props.increment,
    //});
    //setState() 来接受一个函数,不要使用任何的 this.props 和 this.state,直接使用一个传值。
    this.setState((prevState, props) => ({
      counter: prevState.counter + props.increment
    }));
    //this.setState(function(prevState, props) {   ES5 的写法
    //  return {
    //    counter: prevState.counter + props.increment
    //  };
    //});
  }
  // 组件渲染
  render() {
    //创建一个叫做 render() 的空方法,将函数体移动到 render() 方法中
    // toLocaleTimeString()  是哪里来的 ？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}

// 从 <Clock /> 元素移除 date 属性：
ReactDOM.render(
  <Clock />,
  document.getElementById('root')
);
```

- 当 `<Clock />` 被传递给 `ReactDOM.render()` 时，React 调用 Clock 组件的构造函数。 由于 Clock 需要显示当前时间，所以使用包含当前时间的对象来初始化 this.state 。 我们稍后会更新此状态。
- React 然后调用 Clock 组件的 render() 方法。这是 React 了解屏幕上应该显示什么内容，然后 React 更新 DOM 以匹配 Clock 的渲染输出。
- 当 Clock 的输出插入到 DOM 中时，React 调用 componentDidMount() 生命周期钩子。 在其中，Clock 组件要求浏览器设置一个定时器，每秒钟调用一次 tick()。
- 浏览器每秒钟调用 tick() 方法。 在其中，Clock 组件通过使用包含当前时间的对象调用 setState() 来调度UI更新。 通过调用 setState() ，React 知道状态已经改变，并再次调用 render() 方法来确定屏幕上应当显示什么。 这一次，render() 方法中的 this.state.date 将不同，所以渲染输出将包含更新的时间，并相应地更新DOM。
- 一旦Clock组件被从DOM中移除，React会调用 componentWillUnmount() 这个钩子函数，定时器也就会被清除。

## 4.2 生命周期

去相应的文章学习，这里省略。

## 4.3 数据自顶向下流动

父组件或子组件都不能知道某个组件是有状态还是无状态，并且它们不应该关心某组件是被定义为一个函数还是一个类。
这就是为什么状态通常被称为局部或封装。 除了拥有并设置它的组件外，其它组件不可访问。

```JS
// 组件可以选择将其状态作为属性传递给其子组件：
<h2>It is {this.state.date.toLocaleTimeString()}.</h2>
//这也适用于用户定义的组件：
<FormattedDate date={this.state.date} />
//FormattedDate 组件将在其属性中接收到 date 值，并且不知道它是来自 Clock 状态、还是来自 Clock 的属性、亦或手工输入：
function FormattedDate(props) {
  return <h2>It is {props.date.toLocaleTimeString()}.</h2>;
}
```

这通常被称为 **自顶向下**或 **单向数据流**。 任何状态始终由某些特定组件所有，并且从该状态导出的任何数据或 UI **只能影响树中下方的组件**。如果你想象一个组件树作为属性的瀑布，每个组件的状态就像一个额外的水源，它连接在一个任意点，但也流下来。

```JS
//为了表明所有组件都是真正隔离的，我们可以创建一个 App 组件，它渲染三个Clock：
function App() {
  return (
    <div>
      <Clock />
      <Clock />
      <Clock />
    </div>
  );
}

ReactDOM.render(
  <App />,
  document.getElementById('root')
);
// 每个 Clock 建立自己的定时器并且独立更新。
// 在 React 应用程序中，组件是有状态还是无状态被认为是可能随时间而变化的组件的实现细节。 可以在有状态组件中使用无状态组件，反之亦然。
```

# 五、事件处理

去看事件处理章节

# 六、react 教程:条件渲染

在 React 中，你可以创建不同的组件来封装各种你需要的行为。然后还可以根据应用的状态变化 **只渲染其中的一部分**。

React 中的条件渲染和 JavaScript 中的一致，使用 JavaScript **操作符 if** 或 **条件运算符** 来创建表示当前状态的元素，然后让 React 根据它们来更新 UI。

```JS
//两个组件: 子组件
// 已经登录显示
function UserGreeting(props) {
  return <h1>Welcome back!</h1>;
}
// 没有登录游客状态显示
function GuestGreeting(props) {
  return <h1>Please sign up.</h1>;
}
```

```JS
// 我们将创建一个 Greeting 组件，它会根据用户是否登录来显示其中之一：
function Greeting(props) {
  const isLoggedIn = props.isLoggedIn;
  if (isLoggedIn) {
    return <UserGreeting />;
  }
  return <GuestGreeting />;
}

// 根据 isLoggedIn 的值渲染不同的问候语。
ReactDOM.render(
  // Try changing to isLoggedIn={true}:
  <Greeting isLoggedIn={false} />,
  document.getElementById('root')
);
```

### 6.1 元素变量

#### 6.1.1 使用 JavaScript **操作符 if** 或 **条件运算符** 来创建表示当前状态的元素 条件渲染

可以使用 **变量**来 **储存元素**。它可以帮助你有条件的渲染组件的一部分，而输出的其他部分不会更改。

```JS
// 登录
function LoginButton(props) {
  return (
    <button onClick={props.onClick}>
      Login
    </button>
  );
}
// 登出
function LogoutButton(props) {
  return (
    <button onClick={props.onClick}>
      Logout
    </button>
  );
}
```

```JS
//一个名为 LoginControl 的 有状态 的组件。
class LoginControl extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoggedIn: false
    };
    this.handleLoginClick = this.handleLoginClick.bind(this);
    this.handleLogoutClick = this.handleLogoutClick.bind(this);
  }

  handleLoginClick() {
    this.setState({isLoggedIn: true});
  }

  handleLogoutClick() {
    this.setState({isLoggedIn: false});
  }

  render() {
    const isLoggedIn = this.state.isLoggedIn;

    let button = null;
    if (isLoggedIn) {
      button = <LogoutButton onClick={this.handleLogoutClick} />; //JSX
    } else {
      button = <LoginButton onClick={this.handleLoginClick} />;  //JXS
    }

    return (
      <div>
        <Greeting isLoggedIn={isLoggedIn} />
        {button}
      </div>
    );
  }
}

ReactDOM.render(
  <LoginControl />,
  document.getElementById('root')
);
```

声明变量并使用 if 语句是条件渲染组件的不错的方式，但有时你也想使用更简洁的语法，在 JSX 中有如下几种方法。

#### 6.1.2 变量 与  与运算符 &&  条件渲染

你可以通过用 **花括号包裹代码** 在 **JSX 中嵌入任何表达式** ，也包括 **JavaScript 的逻辑与 &&**，它可以方便地条件渲染一个元素。

之所以能这样做，是因为在 JavaScript 中，true && expression 总是返回 expression，而 false && expression 总是返回 false。
因此，如果条件是 true，&& 右侧的元素就会被渲染，如果是 false，React 会忽略并跳过它。

```JS
function Mailbox(props) {
  const unreadMessages = props.unreadMessages;
  return (
    <div>
      <h1>Hello!</h1>
      {unreadMessages.length > 0 &&
        <h2>
          You have {unreadMessages.length} unread messages.
        </h2>
      }
    </div>
  );
}

const messages = ['React', 'Re: React', 'Re:Re: React'];
ReactDOM.render(
  <Mailbox unreadMessages={messages} />,
  document.getElementById('root')
);
```

#### 6.1.3 变量 与 三目运算符 条件渲染

条件渲染的另一种方法是使用 JavaScript 的条件运算符 condition ? true : false。

像在 JavaScript 中一样，你可以根据团队的习惯选择更易读的方式。还要记住如果条件变得过于复杂，可能就是提取组件的好时机了。

```JS
render() {
  const isLoggedIn = this.state.isLoggedIn;
  return (
    <div>
      The user is <b>{isLoggedIn ? 'currently' : 'not'}</b> logged in.
    </div>
  );
}
```

```JS
render() {
  const isLoggedIn = this.state.isLoggedIn;
  return (
    <div>
      {isLoggedIn ? (
        <LogoutButton onClick={this.handleLogoutClick} />
      ) : (
        <LoginButton onClick={this.handleLoginClick} />
      )}
    </div>
  );
}
```

## 6.2 阻止组件渲染

在极少数情况下，你可能希望隐藏组件，即使它被其他组件渲染。让 render 方法返回 null 而不是它的渲染结果即可实现。

在下面的例子中，`<WarningBanner />` 根据属性 warn 的值条件渲染。如果 warn 的值是 false，则组件不会渲染：

```JS
function WarningBanner(props) {
  if (!props.warn) {
    return null;
  }

  return (
    <div className="warning">
      Warning!
    </div>
  );
}

class Page extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      showWarning:true
    }
    this.handleToggleClick = this.handleToggleClick.bind(this);
  }

  handleToggleClick() {
    this.setState(prevState => ({
      showWarning: !prevState.showWarning
    }));
  }

  render() {
    return (
      <div>
        <WarningBanner warn={this.state.showWarning} />
        <button onClick={this.handleToggleClick}>
          {this.state.showWarning ? 'Hide' : 'Show'}
        </button>
      </div>
    );
  }
}

ReactDOM.render(
  <Page />,
  document.getElementById('root')
);
```

组件的 render 方法返回 null 并不会影响该组件生命周期方法的回调。例如，componentWillUpdate 和 componentDidUpdate 依然可以被调用。?????????????????????? 什么鬼意思？？？？？？？

# 七、react 教程：列表 & Keys

```JS
//使用 map() 函数让数组中的每一项翻倍,我们得到了一个新的数列 doubled
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map((number) => number * 2);
console.log(doubled);
//在 React 中，把 数组 转化为 数列元素 的过程是相似的
```

## 7.1 渲染多个组件

```JS
//通过使用 {} 在 JSX 内构建一个元素集合
const numbers = [1, 2, 3, 4, 5];
const listItems = numbers.map((number) =>
  <li>{number}</li>
);
//使用 Javascript 中的 map() 方法遍历 numbers 数组。对数组中的每个元素返回 <li> 标签，最后我们得到一个数组 listItems
//把整个 listItems 插入到 ul 元素中，然后渲染进 DOM:
ReactDOM.render(
  <ul>{listItems}</ul>,
  document.getElementById('root')
);
```

## 7.2 基础列表组件:渲染一个列表到组件中

```JS
//给每个列表元素分配一个 key
// 没有设置的话 将会看到一个警告 a key should be provided for list items ，意思是当你创建一个元素时，必须包括一个特殊的 key 属性
function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    <li key={number.toString()}>
      {number}
    </li>
  );
  return (
    <ul>{listItems}</ul>
  );
}

const numbers = [1, 2, 3, 4, 5];
ReactDOM.render(
  <NumberList numbers={numbers} />,
  document.getElementById('root')
);
```

## 7.3 key

### 7.3.1 使用 key

Keys可以在DOM中的某些元素被增加或删除的时候帮助React识别哪些元素发生了变化。因此你应当给数组中的每一个元素赋予一个确定的标识。

```JS
const numbers = [1, 2, 3, 4, 5];
const listItems = numbers.map((number) =>
  <li key={number.toString()}>
    {number}
  </li>
);
```

一个元素的 key 最好是这个元素在列表中拥有的一个独一无二的字符串。通常，我们使用来自数据的 id ,作为元素的 key:

```JS
const todoItems = todos.map((todo) =>
  <li key={todo.id}>
    {todo.text}
  </li>
);
```

没有 id 就用 index 做, 但时 如果列表可以重新排序，我们不建议使用索引来进行排序，因为这会导致渲染变得很慢。如果你想要了解更多，请点击深度解析 key 的必要性

```JS
const todoItems = todos.map((todo, index) =>
  // Only do this if items have no stable IDs
  <li key={index}>
    {todo.text}
  </li>
);
```

### 7.3.2 用 keys 提取组件

元素的 key 只有在 它和它的兄弟节点 对比 时才有意义。

比方说，如果你提取出一个 ListItem 组件，你应该把 key 保存在数组中的这个 `<ListItem />` 元素上，而不是放在 ListItem 组件中的 `<li>`元素上。

```JS
//当你在 map()方法 的内部调用元素时，你最好随时记得为每一个元素加上一个独一无二的 key。
function ListItem(props) {
  // 对啦！这里不需要指定key:
  return <li>{props.value}</li>;
}

function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    // 又对啦！key应该在 数组的上下文 中被指定
    <ListItem key={number.toString()}
              value={number} />

  );
  return (
    <ul>
      {listItems}
    </ul>
  );
}

const numbers = [1, 2, 3, 4, 5];
ReactDOM.render(
  <NumberList numbers={numbers} />,
  document.getElementById('root')
);
```

### 7.3.3 元素的 key 在他的兄弟元素之间应该唯一

数组元素中使用的 key 在其兄弟之间应该是独一无二的。然而，它们不需要是全局唯一的。当我们生成两个不同的数组时，我们可以使用相同的键

```JS
function Blog(props) {
  const sidebar = (
    <ul>
      {props.posts.map((post) =>
        <li key={post.id}>
          {post.title}
        </li>
      )}
    </ul>
  );
  // key 会作为给 React 的提示，但不会传递给你的组件。如果您的组件中需要使用和 key 相同的值，请将其作为属性传递：
  // Post 组件可以读出 props.id，但是不能读出 props.key
  const content = props.posts.map((post) =>
    <div key={post.id}>
      <h3>{post.title}</h3>
      <p>{post.content}</p>
    </div>
  );
  return (
    <div>
      {sidebar}
      <hr />
      {content}
    </div>
  );
}

const posts = [
  {id: 1, title: 'Hello World', content: 'Welcome to learning React!'},
  {id: 2, title: 'Installation', content: 'You can install React from npm.'}
];
ReactDOM.render(
  <Blog posts={posts} />,
  document.getElementById('root')
);
```

## 7.4 在 jsx 中嵌入 map()

```JS
// 声明了一个单独的 listItems 变量并将其包含在 JSX 中
function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    <ListItem key={number.toString()}
              value={number} />

  );
  return (
    <ul>
      {listItems}
    </ul>
  );
}
```

```JS
// JSX 允许在大括号中嵌入任何表达式，所以我们可以在 map() 中这样使用：
// 这么做有时可以使你的代码更清晰，但有时这种风格也会被滥用。
//就像在 JavaScript 中一样，何时需要为了可读性提取出一个变量，这完全取决于你。
// 但请记住，如果一个 map() 嵌套了太多层级，那可能就是你提取出组件的一个好时机。
function NumberList(props) {
  const numbers = props.numbers;
  return (
    <ul>
      {numbers.map((number) =>
        <ListItem key={number.toString()}
                  value={number} />
      )}
    </ul>
  );
}
```

# 八、react 教程：表单

HTML 表单元素与 React 中的其他 DOM 元素有所不同,因为表单元素生来就保留一些内部状态。例如，下面这个表单只接受一个唯一的 name。

```JS
<form>
  <label>
    Name:
    <input type="text" name="name" />
  </label>
  <input type="submit" value="Submit" />
</form>
```

当用户提交表单时，HTML的默认行为会使这个表单跳转到一个新页面。在React中亦是如此。但大多数情况下，我们都会构造一个处理提交表单并可访问用户输入表单数据的函数。实现这一点的标准方法是使用一种称为“受控组件”的技术。

## 8.1 受控组件

# 十、API 接口

看相应的文章，本章省略。

# 十一、合成事件 SyntheticEvent

[文档](https://react.docschina.org/docs/events.html)

# 十五、this.props.children 组件的所有子节点

this.props 对象的属性与组件的属性一一对应，但是有一个例外，就是 this.props.children 属性。它表示组件的所有子节点。

```JS
class NotesList extends React.Component{
  render() {
    return (
      <ol>
      {
        React.Children.map(this.props.children, function (child) {
          return <li>{child}</li>;
        })
      }
      </ol>
    );
  }
});

ReactDOM.render(
  <NotesList>
    <span>hello</span>
    <span>world</span>
  </NotesList>,
  document.body
);
//上面代码的 NoteList 组件有两个 span 子节点，它们都可以通过 this.props.children 读取，运行结果如下。
```

![tu](http://www.ruanyifeng.com/blogimg/asset/2015/bg2015033110.png)

这里需要注意， `this.props.children` 的值有 `三种` 可能：
① 如果当前组件没有子节点，它就是 undefined ;
② 如果有一个子节点，数据类型是 object ；
③ 如果有多个子节点，数据类型就是 array 。所以，**处理 this.props.children 的时候要小心**。

React 提供一个工具方法 React.Children 来处理 this.props.children 。我们可以用 React.Children.map 来遍历子节点，而不用担心 this.props.children 的数据类型是 undefined 还是 object。更多的 React.Children 的方法，请参考官方文档。