---
title: react 中使用 less 或者 scss
date: '2018/8/18 21:57:28'
categories:
  - ⑤ react.js
  - less/scss
updated:
tags:
comments:
---

# 一、前言

其实 create-react-app 2.0 已经不需要这么麻烦了，不需要做下面的工作了。但是问题是 它是在 2018年10月1日 发布的，不知道现在是否已经可以使用了，这个还是大家都用，都熟练的时候再用好了。
[react 官网博客页面 create-react-app 2.0](https://react.docschina.org/blog/2018/10/01/create-react-app-v2.html)

# 二、react 中使用 less

## 2.1 配置命令步骤

react 项目没有原生的支持 css 预处理器（使用create-react-app 创建的项目默认不支持 less，以下增加 less 配置的步骤）

[配置步骤](https://segmentfault.com/a/1190000010162614)

```BASH
$ npm run eject #暴露配置文件
$ npm install less-loader less --save-dev #安装 less-loader 和 less
# 编辑配置文件 2.2
```

## 2.2 配置文件编辑

暴露配置之后，项目目录会多处两个文件夹，修改里面的文件

```JS
//webpack.config.dev.js
exclude: [
  /\.html$/,
  /\.(js|jsx)$/,
  /\.(css|less)$/,// ①①①①① 把 /\.css$/ 改为 /\.(css|less)$/
  /\.json$/,
  /\.bmp$/,
  /\.gif$/,
  /\.jpe?g$/,
  /\.png$/,
],
```

```JS
//webpack.config-prod.js
{
  test: /\.(css|less)$/,//①①①①①  把 test: /\.css$/ 改为 /\.(css|less)$/
  use: [
    require.resolve('style-loader'),
    {
      loader: require.resolve('css-loader'),
      options: {
        importLoaders: 1,
      },
    },
    {
      loader: require.resolve('postcss-loader'),
      options: {
        // Necessary for external CSS imports to work
        // https://github.com/facebookincubator/create-react-app/issues/2677
        ident: 'postcss',
        plugins: () => [
          require('postcss-flexbugs-fixes'),
          autoprefixer({
            browsers: [
              '>1%',
              'last 4 versions',
              'Firefox ESR',
              'not ie < 9', // React doesn't support IE8 anyway
            ],
            flexbox: 'no-2009',
          }),
        ],
      },
    },
    {
      loader: require.resolve('less-loader') // compiles Less to CSS，
      //②②②②② 把 test: /\.css$/ 的 use 数组配置增加 less-loader
    }
  ],
},
```

# 三、react 中使用 scss

## 2.1 配置命令步骤

react 项目没有原生的支持 css 预处理器（使用 create-react-app 创建的项目默认不支持 scss，以下增加 scss 配置的步骤）

[配置步骤](https://blockmood.github.io/2017/11/09/create-react-app%E9%A1%B9%E7%9B%AE%E6%B7%BB%E5%8A%A0less%20scss%E9%85%8D%E7%BD%AE/)

```BASH
$ npm run eject #暴露配置文件
$ npm install sass-loader node-sass --save-dev #安装 less-loader 和 less
# 编辑配置文件 2.2
```

## 2.2 配置文件编辑

暴露配置之后，项目目录会多处两个文件夹，修改里面的文件

```JS
//webpack.config.dev.js
exclude: [
  /\.html$/,
  /\.(js|jsx)$/,
  /\.(css|less)$/,// ①①①①① 把 /\.css$/ 改为 /\.(css|less)$/
  /\.json$/,
  /\.bmp$/,
  /\.gif$/,
  /\.jpe?g$/,
  /\.png$/,
],
```

```JS
//webpack.config-prod.js
{
  test: /\.(css|less)$/,//①①①①①  把 test: /\.css$/ 改为 /\.(css|less)$/
  use: [
    require.resolve('style-loader'),
    {
      loader: require.resolve('css-loader'),
      options: {
        importLoaders: 1,
      },
    },
    {
      loader: require.resolve('postcss-loader'),
      options: {
        // Necessary for external CSS imports to work
        // https://github.com/facebookincubator/create-react-app/issues/2677
        ident: 'postcss',
        plugins: () => [
          require('postcss-flexbugs-fixes'),
          autoprefixer({
            browsers: [
              '>1%',
              'last 4 versions',
              'Firefox ESR',
              'not ie < 9', // React doesn't support IE8 anyway
            ],
            flexbox: 'no-2009',
          }),
        ],
      },
    },
    {
      loader: require.resolve('less-loader') // compiles Less to CSS，
      //②②②②② 把 test: /\.css$/ 的 use 数组配置增加 less-loader
    }
  ],
},
```