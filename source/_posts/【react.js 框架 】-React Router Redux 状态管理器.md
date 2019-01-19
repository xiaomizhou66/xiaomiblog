---
title: 'react.js----[React Router Redux 状态管理器]'
date: '2018/8/19 23:57:28'
categories:
  - 五、react.js
  - 状态管理器
abbrlink: 5200c947
updated:
tags:
comments:
---

# 一、简介

React Router v4 中已经包含了 Redux 状态管理器，只需要下载 React Router v4 就可使用状态管理器了。

4.x 中采用了单代码仓库模型架构，所以里面包含了若干个相互独立的包，如下所示：

- react-router  React Router 核心 这个是不需要重新安装了的。
- react-router-dom  用于 DOM 绑定的 React Router
- react-router-native  用于 React Native 的 React Router
- react-router-redux  React Router 和 Redux 的集成!!!!!!!!！！！！！！！！！
  不需要再重新的安装了的。
- react-router-config  用于配置静态路由

```BASH
# $ npm install -S react-router # npm 安装法
# $ yarn add react-router # yarn 安装法
# 以前是上面的方法安装的，但是 v4 版本之后就升级了，是安装 react-router-dom ，因为 react-router 不需要显示的安装了
$ npm install --save react-router-dom   # 这样安装时候也已经包含了 react-router
                                        # 也包含了 redux 状态管理器了
```

# 二、

[React Router v4 官网](https://router.happyfe.com/web/guides/redux)
[react router v4 与 redux 配合使用](https://cn.redux.js.org/docs/advanced/UsageWithReactRouter.html)


# 十五、BUG

## 15.1

```BASH
Module not found: Can't resolve 'react-redux' in 'F:\qianduan_dir\00program\react.js\test\src\app'
```

没有找到 'react-redux' ，注意虽然说 React Router v4 已经集合了 redux ，但是它还是需要安装一下 'react-redux'，就像是虽然说 create-react-app 2.0 已经包含了，scss，less，postcss，这些 CSS 预处理器，但是还是需要安装才能使用的。

要安装 react-redux 的，并且还要安装它依赖的 redux ，不然还会是报错的。
`warning " > react-redux@6.0.0" has unmet peer dependency "redux@^2.0.0 || ^3.0.0 || ^4.0.0-0".`

```BASH
# npm 安装
$ npm install --save redux react-redux
# yarn 安装
$ yarn add redux react-redux
```