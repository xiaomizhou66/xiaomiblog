---
title: 【npm & yarn 】-安装工具的工具
date: '2018/8/19 23:57:28'
categories:
  - ⑩ 打包工具-命令行工具-包管理器-github
  - npm & yarn
updated:
tags:
comments:
---

## 一、前言

[yarn 中文文档](https://yarnpkg.com/zh-Hans/docs)

没有翻墙的话用不了 npm，只能用，那用淘宝镜像拉下包，或者pnpm
有的时候有可能网络问题也会导致 npm 包安装有问题

## 二、npm

```BASH
#查看安装模块
$ npm list --depth=0npm # 查看本文件夹/本项目
$ npm list --depth=0 -global #查看 全局
```

## 三、yarn 但是 qq 群里有人说这个不靠谱？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？

### 3.1 yarn 的安装

```BASH
npm install -g yarn
``

[WZ](https://yarnpkg.com/zh-Hans/docs/install#mac-stable)

### 3.2 yarn 的使用（比 npm 快）

```BASH
# 下面三个是等效的，下载别人项目，都是这样还原依赖包
$ npm install
$ yarn install
$ pnpm install
```

```BASH
# yarn 的命令
$ yarn add     # 为当前正在开发的包新增一个依赖包
$ yarn init    # 初始化包
$ yarn install # 安装 package.json 文件里定义的所有依赖包
$ yarn publish # 发布一个包到包管理器；
$ yarn remove  # 从当前包里移除一个未使用的包。
```

```BASH
$ npm install taco --save-dev
# 等价于
$ yarn add taco --dev


$ npm install taco --global
# 等价于
$ yarn global add taco
```

## 四、cnpm 淘宝镜像安装

淘宝镜像，但是很多时候总是出现包安装不完全的现象，还是不了吧！

## 五、pnpm 缓存安装

优先使用缓存包来安装，这样会比 npm 快很多。