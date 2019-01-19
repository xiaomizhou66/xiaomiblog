---
title: webpack 小白入门
date: '2018/8/19 23:57:28'
categories:
  - ⑩ 打包工具-命令行工具-包管理器-github上传下载工具
  - webpack
abbrlink: f482651e
updated:
tags:
comments:
---

## 一、前言

本质上，webpack 是一个现代 JavaScript 应用程序的静态模块打包器(static module bundler)。在 webpack 处理应用程序时，它会在内部创建一个依赖图(dependency graph)，用于映射到项目需要的每个模块，然后将所有这些依赖生成到一个或多个bundle。简而言之就是一个打包工具。

wenpack 的版本会不断的更新，每个时期的版本使用方法都是会存在差异的。具体使用的时候查阅官方文档。

英文文档：[网址](https://webpack.js.org/concepts/)
中文文档：[网址](https://webpack.docschina.org/configuration)

在开始前你需要先理解它的核心概念：

- 入口(entry)
- 输出(output)
- loader
- 插件(plugins)

## 二、webpack 应用实例

vue-cli 脚手架创建的项目，就是使用这个 webpack 来打包的。

其他工具没有做好打包的话，需要自己使用 webpack 工具自行打包。实战项目中的数独游戏便是使用 jQuery.js + webpack 自行实现打包的。[数独游戏项目网址]()






## vue 中 wepack

```js
//webpack.js
module.exports = {
  //mode: 'production'  //webpack 4+ 使用这个方式，webpack 3 或者以下 的版本使用下面的 plugins 插件放入'process.env.NODE_ENV'
  plugins: [
    // ...
    //webpack 3 及其更低版本中，你需要使用 DefinePlugin
    //Vue 源码会根据 process.env.NODE_ENV 决定是否启用生产环境模式，默认情况为开发环境模式。
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('production')
    })
  ]
}
```

# 十五、安装 webpack 、webpack-cli 过程中遇到的坑

## 15.1 Missing write access 没有正确的地址来安装

```BASH
λ npm install webpack@4.19.1 -g
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\async-each # 没有正确的地址来安装
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\balanced-match
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\brorand
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\buffer-from
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\chownr
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\console-browserify
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\constants-browserify
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\copy-descriptor
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\core-util-is
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\decode-uri-component
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\events
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\for-in
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\https-browserify
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\iferr
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\inherits
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\is-accessor-descriptor
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\is-data-descriptor
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\is-extglob
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\is-glob
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\kind-of
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\define-property\node_modules\is-descriptor
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\define-property
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\fsevents
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\util
npm WARN checkPermissions Missing write access to C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\define-property\node_modules
npm ERR! path C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\async-each
npm ERR! code ENOENT
npm ERR! errno -4058
npm ERR! syscall access
npm ERR! enoent ENOENT: no such file or directory, access 'C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\node_modules\async-each'
npm ERR! enoent This is related to npm not being able to find a file.
npm ERR! enoent
npm ERR! A complete log of this run can be found in:
npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-12-25T02_51_29_082Z-debug.log
```

这是因为，之前全局安装了，虽然现在项目搭建中没有找到 webpack ，但是这个包在电脑上是存在的，所以需要手动的删除 webpack。地址就是`\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\`  将这个 webpack 文件夹全局删除，有 webpack-cli 的话也顺便随手删除掉好了，

```BASH
# 删除本地 webpack 相关文件夹
$ npm uninstall webpack -g # 全局卸载 webpack
$ npm uninstall webpack-cli -g # 全局卸载 webpack-cli
$ npm cache verify # 清除缓存
$ npm install webpack@4.19.1 --save-dev -g # 重装 webpack
$ npm install webpack-cli@3.1.2 -D # 这个貌似不需要全局安装？？？
```

## 15.2 pm WARN optional SKIPPING OPTIONAL DEPENDENC

```BASH
λ npm install webpack@4.19.1 -g
C:\Users\Administrator\AppData\Roaming\npm\webpack -> C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\bin\webpack.js
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\webpack\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
# fsevent 是 mac osx 系统的，在 win 或者 Linux 下使用了 所以会有警告，忽略即可。意思就是你已经安装成功了。
```

你的项目有可能是团队项目，别人在他的 mac 上安装了 fsevents 相关依赖库，所以到这边你也就安装到你的 windows 上边了。你可以检查你的package.json 文件中是不是有 fsevents 相关依赖，删除即好！或者更这个只是警告，可以不用管理。

`C:\Users\Administrator\AppData\Roaming\npm\node_modules\webpack\`文件夹下的 package.json 文件夹下的删除
`"fetchSpec": "4.19.1"`

## 15.3 We will use "npm" to install the CLI via "npm install -D"

```BASH
λ webpack -v # 全局查看 webpack-cli 的版本，出现下面的错误因为是没有全局安装
One CLI for webpack must be installed. These are recommended choices, delivered as separate packages:
 - webpack-cli (https://github.com/webpack/webpack-cli)
   The original webpack full-featured CLI.
We will use "npm" to install the CLI via "npm install -D".
# webpack 单独分离出了wepack-cli，需要我们安装wepack-cli。
```

```BASH
# 安装 webpack-cli，好像我们也不需要这样全局来安装 webpack-cli 的版本的
$ npm install webpack-cli@3.1.2 -D
```

## 15.4