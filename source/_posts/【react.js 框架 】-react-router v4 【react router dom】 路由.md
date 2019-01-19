---
title: 'react.js--[react-router v4 (react-router-dom) 路由]'
date: '2018/8/19 23:57:28'
categories:
  - ⑤ react.js
  - react-router v4 路由管理器
abbrlink: 1eea6aff
updated:
tags:
comments:
---

# 一、前言

react.js 是 单页应用，页面切换需要依靠 路由。

[github 官方](https://github.com/ReactTraining/react-router/issues)
[npm 官方](https://www.npmjs.com/package/react-router-dom)
[中文文档](https://router.happyfe.com/web/guides/quick-start/installation)

# 二、React Router V4 讲解

React Router V4 于 17 年 3 月升级，本次升级 React Router V4 吸取了 React 的理念：所有的东西都是 Component。因此 升级之后的 Route、Link、Switch……等都是一个普通的组件。

React Router V4 基于 Lerna 管理多个 Repository。在此代码库包括：

```BASH
- react-router React    # Router 路由的核心功能
- react-router-dom      # 用于 DOM 绑定的 React Router!!!!!!!!!!!!!!!!!!!!!!!!!!!! DOM bindings for React Router
- react-router-native   # 用于 React Native 的 React Router
- react-router-redux    # React Router 和 Redux 的集成
- react-router-config   # 静态路由配置帮助助手
```

[React Router V4 中文文档](https://router.happyfe.com/web/guides/quick-start)

## 2.1 react-router 和 react-router-dom 还有 react-router-native 的区别

[区别网址](https://github.com/mrdulin/blog/issues/42)
[区别网址](https://github.com/ReactTraining/react-router/issues/4648)

**react-router** 实现了路由的核心功能
**react-router-dom**基于react-router，加入了在浏览器运行环境下的一些功能，
    Link 组件，会渲染一个 a 标签，Link 组件源码 a 标签行; BrowserRouter 和 HashRouter 组件，前者使用 pushState 和 popState 事件构建路由，后者使用 window.location.hash 和 hashchange 事件构建路由。
    react-router-dom 依赖 react-router，所以我们使用 npm 安装依赖的时候，只需要安装相应环境下的库即可，**不用再显式安装 react-router**。基于浏览器环境的开发，只需要安装 react-router-dom；
    安装了 react-router-dom，npm 会解析并安装上述依赖包。可以看到，其中包括 react-router。
**react-router-native** 基于react-router，类似 react-router-dom，加入了 eact-native 运行环境下的一些功能。
    基于 react-native 环境的开发，只需要安装 react-router-native 。npm 会自动解析 react-router-dom 包中 package.json 的依赖并安装。

# 二、安装引入

## 2.1 npm 安装、引入

[网址](https://www.npmjs.com/package/react-router-dom)

```BASH
# $ npm install -S react-router # npm 安装法
# $ yarn add react-router # yarn 安装法
# 以前是上面的方法安装的，但是 v4 版本之后就升级了，是安装 react-router-dom ，因为 react-router 不需要显示的安装了
$ npm install --save react-router-dom   # 这样安装时候也已经包含了 react-router
```

## 2.3 create-react-app 2.0 项目示例!!!!!!!!!!!!!!!!！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

### 2.3.1 React Router 4.0 之前

```JS
// src/App.js！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
// React Router 4.0 之前 路由可以单独的写在一个文件里面，其他页面不需要设置  Route ，但是现在不可以这样了
// 但是现在使用的是 4.0 + 版本的，不再是这样嵌套路由的写法了，而是将子路由写在对应的 子组件里面。
<Router>
  <div className="App">
    <div>
         一些导航条或者是其他的上面 html 文档
    </div>
    <Route exact path="/" component={Home} />
    <Route path="/login" component={Login} />
    <Route path="/groups" components={Groups} /> {/* 1 级路由 */}
    <Route path="/users"  components={Users}>    {/* 1 级路由 */}
      <Route path="/users/:userId" component={Profile} />{/* 2 级路由 */}
    </Route>
  </div>
</Router>
```

### 2.3.1 React Router 4.0+

4.0以后，嵌套的路由 与 之前 的就完全不同了，需要单独放置在嵌套的根 component 中去处理路由，否则会一直有警告。

`warning:You should not use <Route component> and <Route children> in the same route`

```JS
// src/App.js！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
// 根组件
import React, { Component } from 'react';
/* import logo from '../assets/logo.svg'; */
//import BasicExample from '../router/BasicExample/BasicExample';
import Home from '../views/Home/Home';
import Login from '../views/Login/Login';
import './App.scss';
import {
  BrowserRouter as Router,
  Route/* ,
  Link */
} from 'react-router-dom'//导入路由插件，组件

class App extends Component {
  render() {
    return (
      // router react 4.0 之后，多级路由嵌套不再是 写在一个单独文件里面 而是在 每个需要路由的组件中去配置
      // App.js 根组件 配置 1 级路由，首先是需要一个 <Router> 标签来包裹
      <Router>
        <div className="App">
          <div>
            一些导航条或者是其他的上面 html 文档
          </div>
          <Route path="groups" components={Groups} /> {/* 1 级路由 */}
          <Route path="users"  components={Users}>    {/* 1 级路由 */}
            {/*<Route path="users/:userId" component={Profile} />  2 级路由 不能在这里设置了，
             而是应该到 Users 组件里面去设置*/}
          </Route>
        </div>
      </Router>
    );
  }
}

export default App;
```

```JS
//Users.js
// 这里不需要 router 标签包裹了
  <div>
    <div className="left">
       <Link to="/user/">个人中心</Link>
       <Link to="/user/info">用户信息</Link>
       <Link to={`${this.props.match.params.url}/components`}>Components</Link>
    </div>
      <Route exact path="/user/" component={Main} />
      <Route path="/user/info" component={Info} />
      <Route path={`${this.props.match.params.url}/:userId`} component={Profile}/>
  </div>
```

```JS
//Home 组件
import React, { Component } from 'react';
import './Home.scss';
import { Input,List,Button } from 'antd';
class Home extends Component {
  constructor(){
    super()
    this.state={
      title:'待办列表',
      list:[],
      value:'',
      completeList:[]
    }
    /* this.addList=this.addList.bind(this) */
  }
/*   static getDerivedStateFromProps(nextProps, prevState){
    //
  } */
  componentDidMount() {
    this.getLocaleData()
  }
  getLocaleData=()=>{
    this.setState({
      list:JSON.parse(localStorage.getItem('todoList'))||[],
      completeList:JSON.parse(localStorage.getItem('completeList'))||[]
    })
  }
  setLocaleData=()=>{
    localStorage.setItem('todoList',JSON.stringify(this.state.list||[]))
    localStorage.setItem('completeList',JSON.stringify(this.state.completeList||[]))
  }
  getValue = (e)=>{
    this.setState({
      value:e.target.value
    })
  }
  addList = ()=>{
    let value = this.state.value
    if(value){
      let newList = this.state.list
      newList.push(value)//返回值是 索引值
      this.setState({
        list: newList,//这里一定是这样修改值，才行，与 vue 是有区别的，this.setState 类似程序
        value: ''// 如何做到添加之后 value 为空啊？？？？？、
      })
      this.setLocaleData()
    }
  }
  complete=(index,e)=>{
    /* console.log(e,'9999',index) */
    let newList = this.state.list
    let completeList = this.state.completeList
    let value = newList.splice(index,1)//返回被删除的元素
    completeList.push(value)
    this.setState({
      list: newList,//这里一定是这样修改值，才行，与 vue 是有区别的，this.setState 类似程序
      completeList:completeList
    })
    this.setLocaleData()
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
      <div className="Home">
        <p>{this.state.title}</p>
        <Input
          placeholder="请输入待办事项"
          addonAfter={<Button type="primary" ghost onClick={this.addList}>添加待办</Button>}
          size="large"
          value={this.state.value}
          onChange={(e)=> this.getValue(e)}
          onPressEnter = {this.addList}
        />
        <br/>
        <br/>
        <List
          header={<div>待办列表</div>}
          /* footer={<div>Footer</div>} */
          bordered
          dataSource={this.state.list}
          renderItem={(item,index) => (<List.Item actions={[<Button size='small' onClick = {(e)=>this.complete(index,e)}>完成</Button>]}>{item}</List.Item>)}
        />
        <br/>
        <br/>
        <List
          header={<div>已完成列表</div>}
          /* footer={<div>Footer</div>} */
          bordered
          dataSource={this.state.completeList}
          renderItem={(item,index) =>(<List.Item actions={[<Button size='small' onClick = {(e)=>this.del(index,e)}>删除</Button>] }>{item}</List.Item>)}
        />
      </div>
    );
  }
}

export default Home;
```

```JS
//Login 组件
import React, { Component } from 'react';
import './Login.scss';

class Login extends Component {
  constructor(){
    super()
    this.state={
      title:'欢迎使用待办列表APP'
    }
  }
  render() {
    return (
      <div className="Login">
        <tag>{this.state.title}</tag>
      </div>
    );
  }
}

export default Login;
```

# 三、工作原理

## 3.1 路由器(Router)

在你开始项目前，你需要决定你使用的路由器的类型。对于网页项目，存在 `<BrowserRouter>` 与 `<HashRouter>`两种组件。
当存在服务区来管理动态请求时，需要使用 `<BrowserRouter>` 组件，而 `<HashRouter>` 被用于静态网站。

通常，我们更倾向选择 `<BrowserRouter>`，但如果你的网站仅用来呈现静态文件，那么 `<HashRouter>`将会是一个好选择。

对于我们的项目，将设将会有服务器的动态支持，因此我们选择 `<BrowserRouter>` 作为路由器组件。肯定现在做的都是需要服务器的。

渲染 `<Router>`

路由器组件无法接受两个及以上的子元素。基于这种限制的存在，创建一个 `<App>` 组件来渲染应用其余部分是一个有效的方法（对于服务端渲染，将应用从 router 组件中分离也是重要的）。

```JS
//index.js
import { BrowserRouter } from 'react-router-dom'
ReactDOM.render((
  // App 组件要包裹在 BrowserRouter 组件里面。
  <BrowserRouter>
    <App />
  </BrowserRouter>
), document.getElementById('root'))
```

```JS
// 实际项目中，通常不是上面那样来包裹 App 组件，而是下面这样来包裹的， 其实都是一样的。
// 习惯上是这样来的做的， router-react v4 官网也是这样来做的。
//App.js
import {
  BrowserRouter as Router,// 这里就是引入我们的 `<BrowserRouter>` 然后使用 Router 简写!!!!!!!!!!!!!!!!!!!!!!!1
  Route/* ,
  Link */
} from 'react-router-dom'//导入路由插件，组件

class App extends Component {
  render() {
    return (
      <Router> {/* 在这个根组件，要有个 路由器 组件来包裹 */}
      <div className="App">
        <AuthButton/>
        <ul>
          <li><Link to="/public">公开页面</Link></li>
          <li><Link to="/protected">非公开页面</Link></li>
        </ul>
        <Route path="/public" component={Public}/>
        <Route path="/login" component={Login}/>
        <PrivateRoute path="/protected" component={Protected}/>
      </div>
    </Router>
    );
  }
}

export default App;

// 通常都是这样来做成一个布局把。具体都是栏自己的项目页面的需求了
/*
<div>
  <Header />
  <Main />
</div> */
```

## 3.2 历史(History)

每个路由器都会创建一个 history 对象并用其保持追踪当前 location 并且在有变化时对网站进行重新渲染。这个 history 对象保证了 React Router提供的其他组件的可用性，所以其他组件必须在 router 内部渲染。一个 React Router 组件如果向父级上追溯却找不到 router 组件，那么这个组件将无法正常工作。

```JS
// [1] locations 是一个含有描述 URL 不同部分属性的对象：
// 一个基本的 location 对象
{
  pathname: '/',
  search: '',
  hash: '',
  key: 'abc123',
  state: {}
}
```

## 3.3 路由(Route)

`<Route>` 组件是 React Router 中主要的结构单元。在任意位置只要匹配了URL 的路径名 (pathname) 你就可以创建 <Route> 元素进行渲染。

## 3.4 路径(Path)

`<Route>` 接受一个数为 string 类型的 path，该值路由匹配的路径名的类型。

```JS
// 当路径名为'/'时, path不匹配
// 当路径名为'/roster'或'/roster/2'时, path匹配
<Route path='/roster'/>
// 当你只想匹配'/roster'时，你需要使用"exact"参数
// 则路由仅匹配'/roster'而不会匹配'/roster/2'
<Route exact path='/roster'/>

// 注意：在匹配路由时，React Router 只关注 location 的路径名。当 URL 如下时：
// http://www.example.com/my-projects/one?extra=false
// React Router 去匹配的只是 '/my-projects/one' 这一部分。
```

注：你可以渲染无路径的 `<Route>`，其将会匹配所有 location。此法用于访问存在上下文中的变量与方法。????
例如：`<Route path='/roster'/>` 会匹配以 /roster[注2] 开头的路径名。
[2] 在当前 path 参数与当前 location 的路径相匹配时，路由就会开始渲染 React 元素。若不匹配，路由不会进行任何操作[注3]。
[3] 如果你使用 children 参数，即便在当前 location 不匹配时 route 也将进行渲染。??????

### 3.4.1 匹配路径**????说的什么玩意

path-to-regexp 包用来决定 route 元素的 path 参数与当前 location 是否匹配。它将路径字符串编译成正则表达式，并与当前 location 的路径名进行匹配比较。除了上面的例子外，路径字符串有更多高级的选项，详见 [path-to-regexp文档]。
当路由地址匹配成功后，会创建一个含有以下属性的match对象：

url ：与当前 location 路径名所匹配部分
path ：路由的地址
isExact ：path 是否等于 pathname
params ：从 path-to-regexp 获取的路径中取出的值都被包含在这个对象中(传递的参数)

使用 [route tester](https://pshrmn.github.io/route-tester/#/) 这款工具来对路由与 URL 进行检验。

注意：本例中路由路径仅支持绝对路径[注4]。
//[4] 当需要支持相对路径的 `<Route>` 与 `<Link>` 时，你需要多做一些工作。相对 <Link> 将会比你之前看到的更为复杂。
//    因其使用了父级的 match 对象而非当前 URL 来匹配相对路径。?????

### 3.4.2 创建路由

可以在 路由器 (router) 组件 中的任意位置创建多个 `<Route>`，但通常我们会把它们放在同一个位置。使用 `<Switch>` 组件来包裹一组 `<Route>`。`<Switch>`会遍历自身的子元素（即路由）并对 **第一个匹配** 当前路径的元素进行渲染。

对于本网站，我们希望匹配一下路径：

/ ： 主页
/roster ： 团体列表
/roster/:number ：运动员页面，使用运动员的编号作为标识
/schedule ：团队的赛程表

为了在应用中能匹配路径，在创建 `<Route>`元素时必须带有需要匹配的 path 作为参数。

```JS
<Switch>
  <Route exact path='/' component={Home}/>
  <Route path='/roster' component={Roster}/>  {/* both /roster and /roster/:number begin with /roster */}
  <Route path='/schedule' component={Schedule}/>
</Switch>
```

## 3.5 <Route> 是如何渲染的

当一个路由的 path 匹配成功后，路由用来确定渲染结果的参数有 三种。只需要提供其中一个即可。

```JS
// ① component: 一个 React 组件。当带有 component 参数的 route 匹配成功后，
// route 会返回一个新的元素，其为 component 参数所对应的 React组件（使用 React.createElement 创建）。
<Route path='/page' component={Page} />

// ② render :   一个返回 React element 的函数 [注5]。当匹配成功后调用该函数。
// 该过程与传入 component 参数类似，并且对于行级渲染与需要向元素传入额外参数的操作会更有用。????什么鬼意思
//[5] 这是一个本质上无状态的函数组件。内部实现，component 参数与 render 参数的组件是用很大的区别的。
//    使用 component 参数的组件会使用 React.createElement 来创建元素，
//    <Route path='/one' component={One}/>        // React.createElement(props.component)
//    使用 render 参数的组件则会调用 render 函数。
//    <Route path='/two' render={() => <Two />}/> // props.render()
//    如果我们定义一个内联函数并将其传给 component 参数，这将会比使用 render 参数慢很多。
const extraProps = { color: 'red' }
<Route path='/page' render={(props) => (
  <Page {...props} data={extraProps}/>
)}/>

// ③ children : 一个返回 React element 的函数。与上述两个参数不同，无论 route 是否匹配当前 location，其都会被渲染!!!!!!!!!!!!!!
<Route path='/page' children={(props) => (
  props.match
    ? <Page {...props}/>
    : <EmptyPage {...props}/>
)}/>
```

通常 component 参数与 render 参数被更经常地使用。**children 参数偶尔会被使用，它更常用在 path 无法匹配时呈现的'空'状态**。在本例中并不会有额外的状态，所以我们将使用 `<Route>`的 component 参数。

通过 `<Route>` 渲染的元素会被传入一些参数。**分别是 match 对象**，当前 **location 对象**[注6] 以及 **history 对象**（由 router 创建）[注7]。
[6] ` <Route>` 与 `<Switch>` 组件都会带有 location 参数。这能让你使用与实际 location 不同的 location 去匹配地址。?????
[7]  可以传入 staticContext 参数，不过这仅在服务端渲染时有用。??????

## 3.7 路径参数

this.props.match.params.xxx

## 3.8 Link 链接

我们应用需要在各个页面间切换。如果使用锚点元素（就是）实现，在每次点击时页面将被重新加载。React Router 提供了 `<Link>` 组件用来避免这种状况的发生。当你点击 `<Link>`时，URL 会更新，组件会被重新渲染，但是页面不会重新加载。

```JS
import { Link } from 'react-router-dom'
//在项目中应该是 class 类来创建组件的
const Header = () => (
  <header>
    <nav>
      <ul>
        <li><Link to='/'>Home</Link></li>
        <li><Link to='/roster'>Roster</Link></li>
        <li><Link to='/schedule'>Schedule</Link></li>
      </ul>
    </nav>
  </header>
)

//<Link> 使用 'to' 参数来描述需要定位的页面。它的值即可是 字符串 也可是 location对象（包含pathname，search，hash与state属性）。
// 一个基本的 location 对象
/*
{
  pathname: '/',
  search: '',
  hash: '',
  key: 'abc123',
  state: {}
} */
//如果其值为字符床将会被转换为 location 对象。
`<Link to={{ pathname: '/roster/7' }}>Player #7</Link>` //本例的 link 的 pathname 属性只能是绝对路径？？？？？
//[4] 当需要支持相对路径的 `<Route>` 与 `<Link>` 时，你需要多做一些工作。相对 <Link> 将会比你之前看到的更为复杂。
//    因其使用了父级的 match 对象而非当前 URL 来匹配相对路径。?????
```

## 3.9 获取路由

我们已经了解了构建网站所需要的所有必须组件（`<BrowserRouter>`, `<Route>`, 以及 `<Link>`）。当然，还有一些我们没有涉及的组件。所幸React Router 拥有优质的文档，可以查看并从中了解更多的信息。文档也提供一系列的例子与源代码。

# 三、路由传值

## 3.1 to 动态路由传值- componentDidMount 生命周期获取值

```JS
//App.js  路由设置
 <Route exact path="/" component={Home} />
 <Route path="/news" component={News} />
 <Route path="/product" component={Product} />
 <Route path="/productcontent" component={ProductContent} />
 <Route path="/content/:aid" component={Content} />  // 路由的传值与 link 连接处相互对应起来
```

```JS
//new.js 路由发起页面
this.state = {  
    list:[
        {
            aid:'11',
            title:'我是新闻1111'
        },
        {
            aid:'222',
            title:'我是新闻222'
        },
        {
            aid:'3',
            title:'我是新闻333'
        },
        {
            aid:'4',
            title:'我是新闻4444'
        }
    ]
};
// 下面就是动态传值
<li key={key}>
  <Link to={`/content/${value.aid}`}>{value.title}</Link>
</li>
```

```JS
//content.js 路由跳转到页面
// props 获取传值
constructor(props) {
  super(props);
  this.state = {
    //
  };
}
//生命周期函数
componentDidMount(){
  //获取动态路由的传值
  console.log(this.props.match.params.aid);  
}
```

## 3.2 url get 传值-componentDidMount 生命周期获取值

```JS
//new.js 路由发起页面
this.state = {  
    list:[
        {
            aid:'11',
            title:'我是新闻1111'
        },
        {
            aid:'222',
            title:'我是新闻222'
        },
        {
            aid:'3',
            title:'我是新闻333'
        },
        {
            aid:'4',
            title:'我是新闻4444'
        }
    ]
};
// 下面就是动态传值
<li key={key}>
  <Link to={`/content/${value.aid}`}>{value.title}</Link>
</li>
```

```JS
//content.js 路由跳转到页面
// props 获取传值
constructor(props) {
  super(props);
  this.state = {
    //
  };
}
//生命周期函数
componentDidMount(){
  //获取动态路由的传值
  console.log(this.props.location.serach);  // 这个获取到的是 ？ 号后面的一串字符串，需要解析。
}
```

## 3.3 缓存传值









# 五、

## 5.1 基本 Basic

```JS
//App.js
import React from "react";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import Home from '../views/Home/Home';
import Login from '../views/Login/Login';
import About from '../views/About/About';
import Topics from '../views/Topics/Topics';

class App extends Component {
  render() {
    return (
      <Router>{ /* 只有根组件才需要这个 <Router> 标签 */}
        <div className="App">
          {/* 导航 */}
          <ul>
            <li><Link to="/">Home</Link></li>
            <li><Link to="/about">About</Link></li>
            <li><Link to="/topics">Topics</Link></li>
          </ul>
          {/* 1 级路由配置 exact 表示精确查看，如果没有的话 路径 / 就会匹配到很多页面了*/}
          <Route exact path="/" component={Home} />
          <Route path="/login" component={Login} />
          <Route path="/about" component={About} />
          <Route path="/topics" component={Topics} />
        </div>
      </Router>
    );
  }
}

export default App;
```

```JS
//Home.js
import React from "react";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

class Home extends Component {
  render() {
    return (
      <div className="Home">
        <h2>Home</h2>
      </div>
    );
  }
}

export default Home;
```

```JS
//Login.js
import React from "react";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

class Home extends Component {
  render() {
    return (
      <div className="Login">
        <h2>Login</h2>
      </div>
    );
  }
}

export default Login;
```

```JS
//About.js
import React from "react";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

class About extends Component {
  render() {
    return (
      <div className="About">
        <h2>About</h2>
      </div>
    );
  }
}

export default About;
```

```JS
//Topics.js
import React from "react";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import Topic from 'Topic';//这个子组件应该放在哪里比较好呢？？？

class Topics extends Component {
  constructor(props){
    super(props)
    this.state={
      list: []
    }
  }
  render() {
    return (
      <div className="Topics">
        <h2>Topicst</h2>
        <ul>
        { /* 这里是 3 个链接，怎么下面路由只有两个？？？看不懂啊 */}
          <li><Link to={`${this.props.match.url}/rendering`}>Rendering with React</Link></li>
          <li><Link to={`${this.props.match.url}/components`}>Components</Link></li>
          <li><Link to={`${this.props.match.url}/props-v-state`}>Props v. State</Link></li>
        </ul>
        { /* 这里是 2 级 路由 外层不需要 router 标签了？？？？？？？
          还有为什么要 ${this.props.match.path} 一定这样么？？可以用它字符串地址的吧？
          还是为了后期不需要更改 二级路由的 url 与 路径？方便管理用的？*/}
        <Route path={`${this.props.match.path}/:topicId`} component={Topic} />
        <Route
          exact
          path={this.props.match.path}
          render={() => <h3>Please select a topic.</h3>}
        />
      </div>
    );
  }
}

export default Topics;
```

```JS
//Topic.js
import React from "react";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";

class Topic extends Component {
  constructor(props){
    super(props)
    this.state={
      list: []
    }
  }
  render() {
    return (
      <div className="Topic">
        <h3>{this.props.match.params.topicId}</h3>
      </div>
    );
  }
}

export default Topic;
```

## 5.2 URL 参数 URL Parameters

```JS
//App.js 根组件
import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom'
import Child from './Child'
import ComponentWithRegex from './ComponentWithRegex'

class App extends Component {
  render() {
    return (
      <Router>
       <div className="App">
          <ul>
            <li><Link to="/netflix">Netflix</Link></li>
            <li><Link to="/zillow-group">Zillow Group</Link></li>
            <li> <Link to="/yahoo">Yahoo</Link></li>
            <li><Link to="/modus-create">Modus Create</Link></li>
          </ul>
          <Route path="/:id" component={Child} />  { /* 传递参数 id */ }
          <Route
            path="/order/:direction(asc|desc)"     { /* 传递参数 :direction(asc|desc) */ }
            component={ComponentWithRegex}
          />
       </div>
      </Router>
    );
  }
}

export default App;
```

```JS
//Child 组件
import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom'

class Child extends Component {
  constructor(props){
    super(props)
    this.state={
      //
    }
  }
  render() {
    return (
      <div className="Child">
        <h3>ID: {this.props.match.params.id}</h3>
      </div>
    )
  }
}

export default Child;
```

```JS
//ComponentWithRegex 组件
import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom'

class ComponentWithRegex extends Component {
  constructor(props){
    super(props)
    this.state={
      //
    }
  }
  render() {
    return (
      <div className="ComponentWithRegex">
        <h3>Only asc/desc are allowed: {this.props.match.params.direction}</h3>
      </div>
    )
  }
}

export default ComponentWithRegex;
```

## 5.3 认证重定向 Redirects (Auth) ？？？？？？？？？？？、实在是看不懂

在 3.x 版本中的 Router 里需配置 history 属性,
当前版本中无需配置此属性，4.x 版本中提供 三种不同的路由组件用来代替 history 属性的作用，分别是
`<BrowserRouter>`：
`<HashRouter>`：有 # 号，一般不会使用这个
`<MemoryRouter>`：

```JS
//App.js 根组件
import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Link,
  // 需要重定向的，还有 2 个需要导入 重定向 Redirect 与 是否推入 history 栈 withRouter
  Redirect,
  withRouter
} from 'react-router-dom'
import Public from './Public'// 不需要登录就可以访问的页面
import Login from './Login'
import Protected from './Protected'// 需要登录之后才能登录的页面


class App extends Component {
  render() {
    return (
      <Router>
        <div className="App">
          <AuthButton/>
          <ul>
            <li><Link to="/public">公开页面</Link></li>
            <li><Link to="/protected">非公开页面</Link></li>
          </ul>
          <Route path="/public" component={Public}/>
          <Route path="/login" component={Login}/>
          <PrivateRoute path="/protected" component={Protected}/>
        </div>
      </Router>
    );
  }
}

export default App;
```

```JS
//AuthButton.js 组件
const AuthButton = withRouter(({ history }) => (
  fakeAuth.isAuthenticated ? (
    <p>
      欢迎! <button onClick={() => {
        fakeAuth.signout(() => history.push('/'))
      }}>登出</button>
    </p>
  ) : (
    <p>请先登录</p>
  )
))
```

## 5.4 自定义链接

```JS
//App.js
import React, { Component } from 'react';
import './App.scss';
import '../interactor.js'
import {
  BrowserRouter as Router,
  Route,
  Link/* ,
  Redirect,
  withRouter */
} from 'react-router-dom'
import OldSchoolMenuLink from '../component/OldSchoolMenuLink'
import Home from '../pages/Home'
import About from '../pages/About'

class App extends Component {
  render() {
    return (
      <Router>
      <div>
        <OldSchoolMenuLink activeOnlyWhenExact={true} to="/" label="首页"/>
        <OldSchoolMenuLink to="/about" label="关于"/>
        <hr/>
        <Route exact path="/" component={Home}/>
        <Route path="/about" component={About}/>
      </div>
    </Router>
    );
  }
}

export default App;
```

```JS
// OldSchoolMenuLink 组件
const OldSchoolMenuLink = ({ label, to, activeOnlyWhenExact }) => (
  <Route path={to} exact={activeOnlyWhenExact} children={({ match }) => (
    <div className={match ? 'active' : ''}>
      {match ? '> ' : ''}<Link to={to}>{label}</Link>
    </div>
  )}/>
)
```

# 十五、各种错误

## 15.1 这个错误是路由配置导致的其实，？？？？？？

```BASH
Warning: Can’t perform a React state update on an unmounted component. # 警告：无法对卸载的组件执行React状态更新。
This is a no-op, but it indicates a memory leak in your application.#这是一个无操作，但它表示应用程序中存在内存泄漏。
To fix, cancel all subscriptions and asynchronous tasks in the componentWillUnmount method.
#要修复，请取消 componentWillUnmount 中的所有订阅 和 异步任务方法。
```

但是其实现在 componentWillUnmount 周期函数已经不推荐使用的，在组件中也没有使用这个周期函数，还是报出这个错误。