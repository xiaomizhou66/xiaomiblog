---
title: '[在 vuei 中使用 less 或者 scss]'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue 中使用 less/scss 等预处理器
updated:
tags:
comments:
---

## 一、前言

使用 vue-cli 搭建项目有内置的 webpack 方案，但是没有使用 scss 与 less。

但是 vue 提供了初始化的 webpack 模板，其中使用了vue-loader。vue-loader 默认只支持 sass,要是想要使用scss，必须安装 node-sass 和sass-loader，并修改相关 webpack 配置。具体操作如下：

其实 vue-cli3 已经不需要这么麻烦了，学会了 vue-cli3 的话就不需要做下面的工作了。
反而是 crate-react-app 2.0 版本也是，已经不需要麻烦的配置了。如何查看自己的项目中 脚手架的版本，就是看 package.json 文件中字段
`"react-scripts": "2.1.2"` 这个就是 crate-react-app 的版本。如果版本是 1.0 的，那么可以直接更改为 2.0 的版本，然后 npm install 就可以得到新的版本了。

```BASH
NOTE: Create React App 2 supports TypeScript, Sass, CSS Modules and more without ejecting: `https://reactjs.org/blog/2018/10/01/create-react-app-v2.html`
```

## 二、vue 中安装 less 或者 sass

### 2.1  vue 使用 less

```BASH
$ npm install less less-loader --save-dev   # 或者安装 less ( -D 就是 -dev 的缩写)
$ npm i less less-loader -D # 这样缩写
```

```JS
//webpack.base.conf.js  的 module.rules  中加入如下规则？？？？？？？？？？？？这个需要修改么？
  {
    test: /\.less$/,
    loader: "style-loader!css-loader!less-loader",
  }
```

```HTML
<style scoped lang="less">
</style>
```

### 2.2 vue 使用 scss

```BASH
$ npm install node-sass sass-loader --save-dev # 安装 sass（npm 太慢的话就用 cnpm，当然 pnpm 其他都是可以的，有的话就 ok）
```

```JS
//webpack.base.conf.js  的 module.rules  中加入如下规则  ，？？？？？？？？？？？？这个需要修改么？
  {
    test: /\.scss$/,
    loaders: ["style", "css", "sass"]
  },
```

```HTML
<!-- 在 .vue 文件使用 scss -->
<style scoped lang="scss">
  @import "overview";
  /* 导入overview.scss */
</style>
```