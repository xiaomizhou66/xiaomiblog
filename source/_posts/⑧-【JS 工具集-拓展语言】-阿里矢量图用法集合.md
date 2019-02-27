---
title: 阿里矢量图-在各个框架，组件，web端，移动端，小程序中的用法
date: '2018/8/19 23:57:28'
categories:
  - ⑧ JS 工具集/ JS拓展语言
  - 阿里矢量图用法（字符实体）
updated:
tags:
comments:
---

## 一、前言

为了方便我们开发者使用，网上会有很多的字体图标库，方便我们直接调用

阿里矢量图，提供了大量免费的图标，也提供了使用方法，但是在各个组件库中，各种场合其实使用时有所不一样的。
本文就是列举出来在各种场合应该如何使用。

阿里矢量图：[网址](http://www.iconfont.cn)

## 三、jquery.js 使用阿里图标

### 3.1.1 结合 jquery-ui

## 四、vue.js 使用阿里图标

阿里图标：[地址](http://www.iconfont.cn/collections/index?spm=a313x.7781069.1998910419.4&type=1)
阿里图标使用方法：[官方使用教程](http://www.iconfont.cn/help/detail?spm=a313x.7781069.1998910419.d8d11a391&helptype=code)，

### 4.1

>Unicode

>Font class

兼容性良好，支持 ie8+，及所有现代浏览器。
相比于 unicode 语意明确，书写更直观。可以很容易分辨这个 icon 是什么。
因为使用 class 来定义图标，所以当要替换图标时，只需要修改 class 里面的 unicode 引用，就是修改 icon-xxx 这些。
不过因为本质上还是使用的字体，**所以多色图标还是不支持的。**

```BASH
# ① 第一步：拷贝项目下面生成的 fontclass 代码：
#          vue-cli2 项目框架中引入使用：在 src 目录下的 index.html 文件中 link 标签引入
#          vue-cli3 项目框架中引入使用：在 public 目录下的 index.html 文件中 link 标签引入
# ② 第二步：挑选相应图标并获取类名，应用于页面：
#         <i class="iconfont icon-xxx"></i>   这里是在 html 中直接使用的 , 修改 icon-xxx 来改成需要的图标。

# 在 UI 框架中，有的时候我们不能直接在 template 中直接的使用 <i class="iconfont icon-xxx"></i>
```

>Symbol

这是一种全新的使用方式，应该说这才是未来的主流，也是平台目前推荐的用法。相关介绍可以参考这篇文章 这种用法其实是做了一个svg的集合，与上面两种相比具有如下特点：

支持多色图标了，不再受单色限制。
通过一些技巧，支持像字体那样，通过 font-size,color 来调整样式。
兼容性较差，支持 ie9+,及现代浏览器。
浏览器渲染 svg 的性能一般，还不如 png。

```BASH
# ① 第一步：拷贝项目下面生成的 symbol 代码：：
#          vue-cli2 项目框架中引入使用：在 src 目录下的 index.html 文件中 script 标签引入
#          vue-cli3 项目框架中引入使用：在 public 目录下的 index.html 文件中 script 标签引入
# ② 第二步：第二步：加入通用css代码（引入一次就行）：
#          vue-cli2 项目框架中引入使用：在 src 目录下的 index.html 文件
#          vue-cli3 项目框架中引入使用：在 public 目录下的 index.html 文件中
#         <style type="text/css">
#           .icon {
#              width: 1em; height: 1em;
#              vertical-align: -0.15em;
#              fill: currentColor;
#              overflow: hidden;
#           }
#         </style>
# ③ 第三步：挑选相应图标并获取类名，应用于页面：
#         <svg class="icon" aria-hidden="true">
#             <use xlink:href="#icon-xxx"></use>
#         </svg>

# 在 UI 框架中，有的时候我们不能直接在 template 中直接的使用 <i class="iconfont icon-xxx"></i>
```

#### 3.2.1 vue && element-ui 使用 阿里矢量图

#### 3.2.2 vue && iview-ui 使用 阿里矢量图



## 五、小程序使用阿里妈妈图标


### 3.3 微信小程序

**icon单个使用** 不建议使用下载的方法

- ①选择需要使用的图片
- ②调色/下载 png
- ③项目根目录中新建一个 src/images 文件夹，可以直接是 images 文件夹，自己喜好习惯

此种方式适合用在图标引用特别少，以后也不需要特别维护的场景。比如设计师用来做 demo 原型。
前端临时做个活动页。当然如果你只是为了下载图标做 PPT,也是极好的。

但是项目一旦需要到不少的图标的话，就不要使用这种方式使用，阿里官方也是不推荐使用这种方式的。

注意一个问题：

- ①图片文件夹创建/图片放置正确方式
    不能直接将图片拉到开发工具中，目前还不支持。
    不能直接将下载好的图片的文件夹直接粘贴到项目中，也不支持，无法识别到文件
    只能是在开发工具中建好文件夹，然后本地打开文件夹，将复制好的图片粘贴在文件夹下才对
- ②图片文件夹的目录，一定不能放置在 pages 文件夹中
    他会给你创建一个 images 页面的。然后 app.json 中的 pages 路径也会多出来一个 images 页面，
    `"pages/images"`这是不正确的，模拟器都无法正确运行

**垃圾问题**

项目会自动创建 images.json，images.wxml，images.wxss，images.js 文件！！！！！！

#### 3.3.1 微信小程序 && wepy-ui 使用 阿里矢量图

**unicode 引用方法**：注意修改为自己项目的链接与对应的代码

[网址](https://blog.csdn.net/Zhooson/article/details/80706791)
[网址](https://www.jianshu.com/p/67bbe4d95a85)

```BASH
# 阿里图标项目中 生成如下代码
#①：拷贝项目下面生成的 font-face 每次链接都是不一样呀的，每次重新生
@font-face {
  font-family: 'iconfont';  /* project id 922431 */
  src: url('//at.alicdn.com/t/font_922431_rf7ztse40wc.eot');
  src: url('//at.alicdn.com/t/font_922431_rf7ztse40wc.eot?#iefix') format('embedded-opentype'),
  url('//at.alicdn.com/t/font_922431_rf7ztse40wc.woff') format('woff'),
  url('//at.alicdn.com/t/font_922431_rf7ztse40wc.ttf') format('truetype'),
  url('//at.alicdn.com/t/font_922431_rf7ztse40wc.svg#iconfont') format('svg');
}

# ②第二步：定义使用 iconfont 的样式，这个可以不需要改变
.iconfont {
  font-size: 16px;
  font-style: normal;
  font-family: 'iconfont' !important;
  -webkit-font-smoothing: antialiased;
  -webkit-text-stroke-width: 0.2px;
  -moz-osx-font-smoothing: grayscale;
}

#  ③：在页面使用之前，先把这个文件，引入到全局 app.wpy 中  （这是小程序中特有的）
#      具体的链接地址根据自己的项目而定
<style lang="less" src="./assets/styles/iconfont.less"></style>

# ④：在页面使用：具体的 图标修改 代码 `&#xe625;`  这个代码当然是在 阿里图标 Unicode 的状态下的。
<i class="iconfont" style="font-size:30px">&#xe625;</i>
```

注意：这时候开发者工具看到的是 口，不要慌张，重新运行一下就好了。 `wepy build --watch`，注意一定是在命令行去运行一下，在开发者工具编译时无效的。

```BASH
λ wepy build --watch
[16:36:41] [编译] 入口: src\app.wpy
[16:36:49] [写入] JSON: dist\app.json
[WARNING] 找不到编译器：wepy-compiler-sass。
[Error] 未发现相关 sass 编译器配置，请检查wepy.config.js文件。
```

解决：如果编辑的是 scss 那么就要在 webpack.config.js 中配置 scss 的转译。

```BASH
VM884:2 Failed to load font http://1701630871.debug.open.wei ... flings-regular.woff : the server responded with a status of 404 (HTTP/1.1 404 Not Found)
From server 127.0.0.1
```

这个是什么意思？为什么开发者工具开始提示这个，然后谷歌了一下，再去开发者工具没干什么，它自己又好了。

更多关于 [阿里图标的坑](http://www.wxapp-union.com/thread-3145-1-1.html)

重新添加了图标，不要忘记重新生成新的代码，置换新的代码。 `@font-face` 的链接是更新的。

#### 3.3.2 微信小程序 && mpvue 使用 阿里矢量图




## 2.2 在线链接使用方法