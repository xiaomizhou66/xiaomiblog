---
title: 'react.js--[网络请求 axios,jquery-ajax，浏览器内置的 window.fetch]'
date: '2018/8/19 23:57:28'
categories:
  - ⑤ react.js
  - axios 在 react.js 中使用
updated:
tags:
comments:
---

# 一、前言

react.js 中前后端数据请求交换，可以使用 axios，jquery-ajax，浏览器内置的 window.fetch 中的认可一种的。

# 二、axios

去看 vue 中的就好了。

# 三、jquery-ajax

去看 jquery 中的就好了。

# 四、浏览器内置的 window.fetch

内置的没有用过，不用了。

# 五、示例：在 react.js 中实际使用

## 5.1  fetch

```JSON
// 请求反馈的数据
{
  items: [
    { id: 1, name: 'Apples', price: '$2' },
    { id: 2, name: 'Peaches', price: '$5' }
  ]
}
```

```JS
class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      error: null,
      isLoaded: false,
      items: []
    };
  }

  componentDidMount() {
    fetch("https://api.example.com/items")// 这里用的就是内置的 fetch 方法。
      .then(res => res.json())
      .then(
        (result) => {
          this.setState({
            isLoaded: true,
            items: result.items
          });
        },
        // Note: it's important to handle errors here
        // instead of a catch() block so that we don't swallow
        // exceptions from actual bugs in components.
        (error) => {
          this.setState({
            isLoaded: true,
            error
          });
        }
      )
  }

  render() {
    const { error, isLoaded, items } = this.state;// 结构赋值
    if (error) {
      return <div>Error: {error.message}</div>;
    } else if (!isLoaded) {
      return <div>Loading...</div>;
    } else {
      return (
        <ul>
          {items.map(item => (
            <li key={item.name}>
              {item.name} {item.price}
            </li>
          ))}
        </ul>
      );
    }
  }
}
```

## 5.2 ajax

```JS
class Posts extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      posts: []
    }
  }
  
  componentDidMount() {
    this.serverRequest = axios.get('/api')
      .then(posts => {
        this.setState({
          posts
      })
    })
  }
  
  componentWillUnmount() {
    this.serverRequest.abort()// 现在这个周期函数已经被取消了啊
  }
  
  render() {
    return <PostList posts={this.state.posts} />
  }
}
```