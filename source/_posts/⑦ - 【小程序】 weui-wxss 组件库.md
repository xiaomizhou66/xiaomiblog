---
title: weui-wxss 组件库
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - MINA 框架
updated:
tags:
comments:
---

## 一、前言

为了方便使用，小程序与 web 端一样，有官方或者是其他开发的 ui 组件库，方便开发者直接使用。WeUI 是一套同微信原生视觉体验一致的基础样式库，由微信官方设计团队为微信内网页和微信小程序量身设计，令用户的使用感知更加统一。包含 button、cell、dialog、 progress、 toast、article、actionsheet、icon 等各式元素。

## 二、we-ui组件库

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
**we-ui**：web 端

需要注意的是 we-ui 最开始是 web 端的，小程序版的是 weui-wxss。
如果我是需要在小程序中使用的话一定要使用 weui-wxss。两者区别：[github 网址](https://github.com/Tencent/weui-wxss/blob/master/DIFF.md)

[github 网址 we-ui](https://github.com/Tencent/weui/blob/master/README_cn.md)
[github 网址 we-ui 文档](https://github.com/Tencent/weui/wiki)
[we-ui 效果图](https://weui.io/)

**MINA 项目框架中使用 weui-wxss 组件库**：小程序端

[github 网址 weui-wxss](https://github.com/Tencent/weui-wxss)
weui-wxss 效果图：与 web 版一致（可以下载文件之后在开发者工具模拟器查看效果）。
或者使用开发者工具打开 dist 文件夹，就可以看到效果。
再或者在微信查看 weui 小程序。

## 三、weui-wxss 使用

### 3.1 引入 weui-wxss

#### 3.1.1  CDN 引入

微信官方、BootCDN 和 cdnjs 为 WeUI 提供了 CDN 链接，推荐使用，链接如下：

[CDN 链接地址](https://github.com/Tencent/weui/wiki/getting-started)

其中，1.0.0是目前 WeUI 最新的版本号，代码命名有较大的改变，因此保留0.4.2的CDN。
以上链接，均支持 http 和 https 协议，均包含未压缩版 weui.css 和压缩版 weui.min.css 。

```HTML
  <!-- 在 index.tempalate.html 中引入 -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="//res.wx.qq.com/open/libs/weui/1.1.3/weui.min.css">
  <title>数独</title>
```

#### 3.1.2 npm 或 yarn 或 bower 安装

```BASH
$ bower install --save weui
# 或
$ npm install --save weui
```

#### 3.1.3 下载文件使用（不推荐）

可以在 [https://github.com/weui/weui/releases](https://github.com/weui/weui/releases) 处，直接下载最新发布的版本。github 提供了 zip 和 tar.gz 两种格式的包，选择其中一种下载，解压后引用 dist/style/weui.css 文件即可。

也可以在 WeUI 的 github 主页，右上角的“Download ZIP”按钮，点击下载仓库中最新的代码，解压。注意： 该方式获取的是 WeUI 最新的、未经发布的代码，可能不稳定，不推荐通过此方式获取 WeUI 用于生产环境。

```HTML
<!-- 然后再 html 文件中引入文件即可，路径根据自己的项目而定，但是不建议使用这样下载的方式-->
<link rel="stylesheet" href="path/to/weui/dist/style/weui.min.css"/>
```

#### 3.2 在 wxml 中使用组件：

```HTML
<button class="weui-btn" type="primary">页面主操作 Normal</button>
```

1. 预览所有组件

- ①微信中搜索小程序：weui
- ②开发者工具打开下载的 dist 文件夹
- ③本文余下部分有各个组件的示意图

源代码：examples 目录中

### 3.2 布局

#### 3.2.1 Layout flex布局

```HTML
<!-- .wxml -->
<view class="weui-flex">
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
</view>
<view class="weui-flex">
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
</view>
<view class="weui-flex">
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
</view>
<view class="weui-flex">
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
</view>
<view class="weui-flex">
  <view><view class="placeholder">weui</view></view>
  <view class="weui-flex__item"><view class="placeholder">weui</view></view>
  <view><view class="placeholder">weui</view></view>
</view>
```

<div style="width:70%; float:left;margin:5px 0;">
```CSS
<!-- .wxss -->
.placeholder{
    margin: 5px;
    padding: 0 10px;
    text-align: center;
    background-color: rgb(221, 182, 182);
    height: 2.3em;
    line-height: 2.3em;
    color: #000000;
}
```
</div>

<div style="width:30%; float:left;margin:5px 0;">
预览图
![img](http://liuxmoo.foryung.com/flex.png)
</div>

<div style="clear:both;height:0;overflow:hidden;"></div>

#### 3.2.2 Grid 宫格

<div style="width:70%; float:left;margin:5px 0;">
```HTML
<!-- .wxml -->
<view class="weui-grids">
  <block wx:for="{{grids}}" wx:key="*this">
    <navigator url="" class="weui-grid" hover-class="weui-grid_active">
      <image class="weui-grid__icon" src="../images/icon_tabbar.png"/>
      <view class="weui-grid__label">Grid</view>
    </navigator>
  </block>
</view>
```

```JS
<!-- .js -->
Page({
    data: {
        grids: [0, 1, 2, 3, 4, 5, 6, 7, 8]
    }
});
```
</div>

<div style="width:30%; float:left;margin:5px 0;">
预览图
![img](http://liuxmoo.foryung.com/firld.png)
</div>

<div style="clear:both;height:0;overflow:hidden;"></div>

#### 3.2.3 Panel 面板

<div style="width:50%; float:left;margin:5px 0;">
预览图1
![img](http://liuxmoo.foryung.com/1.png)
</div>
<div style="width:50%; float:left;margin:5px 0;">
预览图2
![img](http://liuxmoo.foryung.com/2.png)
</div>
<div style="width:50%; float:left;margin:5px 0;">
预览图3
![img](http://liuxmoo.foryung.com/3.png)
</div>
<div style="width:50%; float:left;margin:5px 0;">
预览图4
![img](http://liuxmoo.foryung.com/4.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

```HTML
<!-- .wxml -->
<view class="weui-panel weui-panel_access">
  <view class="weui-panel__hd">图文组合列表</view>
  <view class="weui-panel__bd">
    <navigator url="" class="weui-media-box weui-media-box_appmsg" hover-class="weui-cell_active">
      <view class="weui-media-box__hd weui-media-box__hd_in-appmsg">
        <image class="weui-media-box__thumb" src="{{icon60}}" />
      </view>
      <view class="weui-media-box__bd weui-media-box__bd_in-appmsg">
        <view class="weui-media-box__title">标题一</view>
        <view class="weui-media-box__desc">由各种物质组成的巨型球状天体，叫做星球。</view>
      </view>
    </navigator>
    <navigator url="" class="weui-media-box weui-media-box_appmsg" hover-class="weui-cell_active">
      <view class="weui-media-box__hd weui-media-box__hd_in-appmsg">
        <image class="weui-media-box__thumb" src="{{icon60}}" />
      </view>
      <view class="weui-media-box__bd weui-media-box__bd_in-appmsg">
        <view class="weui-media-box__title">标题二</view>
        <view class="weui-media-box__desc">由各种物质组成的巨型球状天体，叫做星球。</view>
      </view>
    </navigator>
  </view>
  <view class="weui-panel__ft">
    <view class="weui-cell weui-cell_access weui-cell_link">
      <view class="weui-cell__bd">查看更多</view>
      <view class="weui-cell__ft weui-cell__ft_in-access"></view>
    </view>
  </view>
</view>

<view class="weui-panel weui-panel_access">
  <view class="weui-panel__hd">文字组合列表</view>
  <view class="weui-panel__bd">
    <view class="weui-media-box weui-media-box_text">
      <view class="weui-media-box__title weui-media-box__title_in-text">标题一</view>
      <view class="weui-media-box__desc">由各种物质组成的巨型球状天体，叫做星球。</view>
    </view>
    <view class="weui-media-box weui-media-box_text">
      <view class="weui-media-box__title weui-media-box__title_in-text">标题二</view>
      <view class="weui-media-box__desc">由各种物质组成的巨型球状天体，叫做星球。</view>
    </view>
  </view>
  <view class="weui-panel__ft">
    <view class="weui-cell weui-cell_access weui-cell_link">
      <view class="weui-cell__bd">查看更多</view>
      <view class="weui-cell__ft weui-cell__ft_in-access"></view>
    </view>
  </view>
</view>

<view class="weui-panel">
  <view class="weui-panel__hd">小图文组合列表</view>
  <view class="weui-panel__bd">
    <view class="weui-media-box weui-media-box_small-appmsg">
      <view class="weui-cells weui-cells_in-small-appmsg">
        <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
          <view class="weui-cell__hd">
            <image src="{{icon20}}" style="width: 20px;height: 20px;margin-right: 5px" />
          </view>
          <view class="weui-cell__bd weui-cell_primary">
            <view>文字标题</view>
          </view>
          <view class="weui-cell__ft weui-cell__ft_in-access"></view>
        </navigator>
        <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
          <view class="weui-cell__hd">
            <image src="{{icon20}}" style="width: 20px;height: 20px;margin-right: 5px" />
          </view>
          <view class="weui-cell__bd weui-cell_primary">
            <view>文字标题</view>
          </view>
          <view class="weui-cell__ft weui-cell__ft_in-access"></view>
        </navigator>
      </view>
    </view>
  </view>
</view>

<view class="weui-panel">
  <view class="weui-panel__hd">文字列表附来源</view>
  <view class="weui-panel__bd">
    <view class="weui-media-box weui-media-box_text">
      <view class="weui-media-box__title weui-media-box__title_in-text">标题一</view>
      <view class="weui-media-box__desc">由各种物质组成的巨型球状天体，叫做星球。</view>
      <view class="weui-media-box__info">
        <view class="weui-media-box__info__meta">文字来源</view>
        <view class="weui-media-box__info__meta">时间</view>
        <view class="weui-media-box__info__meta weui-media-box__info__meta_extra">其它信息</view>
      </view>
    </view>
  </view>
</view>
```

```JS
/* .JS */
var base64 = require("../images/base64");
Page({
    onLoad: function(){
        this.setData({
            icon20: base64.icon20,
            icon60: base64.icon60
        });
    }
});
```

#### 3.2.4 Gallery 画廊

建议采用小程序原生的 wx.previewImage 来实现。详情请看小程序文档。

#### 3.2.5 List 列表

<div style="width:50%; float:left;margin:5px 0;">
预览图1
![img](http://liuxmoo.foryung.com/11.png)
</div>

<div style="width:50%; float:left;margin:5px 0;">
预览图2
![img](http://liuxmoo.foryung.com/22.png)
</div>

<div style="clear:both;height:0;overflow:hidden;"></div>

```HTML
<!-- .wxml -->
<view class="weui-cells__title">
  带说明的列表项</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell">
    <view class="weui-cell__bd">标题文字</view>
    <view class="weui-cell__ft">说明文字</view>
  </view>
</view>

<view class="weui-cells__title">带图标、说明的列表项</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell">
    <view class="weui-cell__hd">
      <image src="{{icon}}" style="margin-right: 5px;vertical-align: middle;width:20px; height: 20px;">
      </image>
    </view>
    <view class="weui-cell__bd">标题文字</view>
    <view class="weui-cell__ft">说明文字</view>
  </view>
  <view class="weui-cell">
    <view class="weui-cell__hd">
      <image src="{{icon}}" style="margin-right: 5px;vertical-align: middle;width:20px; height: 20px;">
      </image>
    </view>
    <view class="weui-cell__bd">标题文字</view>
    <view class="weui-cell__ft">说明文字</view>
  </view>
</view>

<view class="weui-cells__title">带跳转的列表项</view>
<view class="weui-cells weui-cells_after-title">
  <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
    <view class="weui-cell__bd">cell standard</view>
    <view class="weui-cell__ft weui-cell__ft_in-access"></view>
  </navigator>
  <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
    <view class="weui-cell__bd">cell standard</view>
    <view class="weui-cell__ft weui-cell__ft_in-access"></view>
  </navigator>
</view>

<view class="weui-cells__title">带说明、跳转的列表项</view>
<view class="weui-cells weui-cells_after-title">
  <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
    <view class="weui-cell__bd">cell standard</view>
    <view class="weui-cell__ft weui-cell__ft_in-access">说明文字</view>
  </navigator>
  <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
    <view class="weui-cell__bd">cell standard</view>
    <view class="weui-cell__ft weui-cell__ft_in-access">说明文字</view>
  </navigator>
</view>

<view class="weui-cells__title">带图标、说明、跳转的列表项</view>
<view class="weui-cells weui-cells_after-title">
  <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
    <view class="weui-cell__hd">
      <image src="{{icon}}" style="margin-right: 5px;vertical-align: middle;width:20px; height: 20px;">
      </image>
    </view>
    <view class="weui-cell__bd">cell standard</view>
    <view class="weui-cell__ft weui-cell__ft_in-access">说明文字</view>
  </navigator>
  <navigator url="" class="weui-cell weui-cell_access" hover-class="weui-cell_active">
    <view class="weui-cell__hd">
      <image src="{{icon}}" style="margin-right: 5px;vertical-align: middle;width:20px; height: 20px;">
      </image>
    </view>
    <view class="weui-cell__bd">cell standard</view>
    <view class="weui-cell__ft weui-cell__ft_in-access">说明文字</view>
  </navigator>
</view>
```

```JS
/* .JS */
var base64 = require("../images/base64");
Page({
    onLoad: function(){
        this.setData({
            icon: base64.icon20
        });
    }
});
```

Card 卡片

#### 3.2.6 底部链接copyright

<div style="width:71%; float:left;margin:5px 0;">

```HTML
<view class="weui-footer">
    <view class="weui-footer__text">Copyright © 2008-2016 weui.io</view>
</view>

<view class="weui-footer">
    <view class="weui-footer__links">
        <navigator url="" class="weui-footer__link">底部链接</navigator>
    </view>
    <view class="weui-footer__text">Copyright © 2008-2016 weui.io</view>
</view>

<view class="weui-footer">
    <view class="weui-footer__links">
        <navigator url="" class="weui-footer__link">底部链接</navigator>
        <navigator url="" class="weui-footer__link">底部链接</navigator>
    </view>
    <view class="weui-footer__text">Copyright © 2008-2016 weui.io</view>
</view>

<view class="weui-footer weui-footer_fixed-bottom">
    <view class="weui-footer__links">
        <navigator url="" class="weui-footer__link">WeUI首页</navigator>
    </view>
    <view class="weui-footer__text">Copyright © 2008-2016 weui.io</view>
</view>
```
</div>
<div style="width:29%; float:left;margin:5px 0;">
预览图
![img](http://liuxmoo.foryung.com/333.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

```CSS
.weui-footer{
    margin-bottom: 50px;
}
.weui-footer_fixed-bottom{
    margin-bottom: 0;
}
```

### 3.3 基础

#### 3.3.1 按钮/Button

<div style="width:71%; float:left;margin:5px 0;">

```HTML
<button class="weui-btn" type="primary">
  页面主操作 Normal
</button>

<button class="weui-btn" type="primary" disabled="true">
  页面主操作 Disabled
</button>

<button class="weui-btn" type="default">
  页面次要操作 Normal
</button>
<button class="weui-btn" type="default" disabled="true">
  页面次要操作 Disabled
</button>

<button class="weui-btn" type="warn">警告类操作 Normal</button>

<button class="weui-btn" type="warn" disabled="true">
  警告类操作 Disabled
</button>

<button class="weui-btn" type="primary" plain="true">按钮</button>
<button class="weui-btn" type="primary" disabled="true" plain="true">按钮
</button>

<button class="weui-btn" type="default" plain="true">按钮</button>
<button class="weui-btn" type="default" disabled="true" plain="true">按钮
</button>

<button class="weui-btn mini-btn" type="primary" size="mini">按钮</button>
<button class="weui-btn mini-btn" type="default" size="mini">按钮</button>
<button class="weui-btn mini-btn" type="warn" size="mini">按钮</button>
```

```CSS
.mini-btn{
    margin-right: 5px;
}
```

</div>

<div style="width:29%; float:left;margin:5px 0;">
预览图
![img](http://liuxmoo.foryung.com/buttun.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

#### 3.3.2  Color 色彩

#### 3.3.3 Icon 图标

<div style="width:70%; float:left;margin:5px 0;">

```HTML
<view class="icon-box">
  <icon type="success" size="93"></icon>
  <view class="icon-box__ctn">
    <view class="icon-box__title">成功</view>
    <view class="icon-box__desc">用于表示操作顺利达成</view>
  </view>
</view>
<view class="icon-box">
  <icon type="info" size="93"></icon>
  <view class="icon-box__ctn">
    <view class="icon-box__title">提示</view>
    <view class="icon-box__desc">
      用于表示信息提示；也常用于缺乏条件的操作拦截，提示用户所需信息
    </view>
  </view>
</view>
<view class="icon-box">
  <icon type="warn" size="93" color="#FFBE00"></icon>
  <view class="icon-box__ctn">
    <view class="icon-box__title">普通警告</view>
    <view class="icon-box__desc">
      用于表示操作后将引起一定后果的情况
    </view>
  </view>
</view>
<view class="icon-box">
  <icon type="warn" size="93"></icon>
  <view class="icon-box__ctn">
    <view class="icon-box__title">强烈警告</view>
    <view class="icon-box__desc">
      用于表示操作后将引起严重的不可挽回的后果的情况
    </view>
  </view>
</view>
<view class="icon-box">
  <icon type="waiting" size="93"></icon>
  <view class="icon-box__ctn">
    <view class="icon-box__title">等待</view>
    <view class="icon-box__desc">用于表示等待</view>
  </view>
</view>
<view class="icon_sp_area">
  <icon type="success" size="23"></icon>
  <icon type="success_no_circle" size="23"></icon>
  <icon type="circle" size="23"></icon>
  <icon type="warn" size="23" color="#F43530"></icon>
  <icon type="download" size="23"></icon>
  <icon type="info_circle" size="23"></icon>
  <icon type="cancel" size="23"></icon>
  <icon type="search" size="20"></icon>
</view>
```

</div>
<div style="width:30%; float:left;margin:5px 0;">
预览图
![img](http://liuxmoo.foryung.com/0.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

```CSS
icon{
    margin-right: 13px;
}
.icon-box{
    margin-bottom: 25px;
    display: flex;
    align-items: center;
}
.icon-box__ctn{
    flex-shrink: 100;
}
.icon-box__title{
    font-size: 20px;
}
.icon-box__desc{
    margin-top: 6px;
    font-size: 12px;
    color: #888888;
}
.icon_sp_area {
    margin-top: 10px;
    text-align: left;
}
```

### 3.4 导航

#### 3.4.0 Navbar 导航栏/像 tabs 标签页

```HTML
<!-- wxml -->
<view class="page">
  <view class="page__bd">
    <view class="weui-tab">
      <view class="weui-navbar">
        <block wx:for="{{tabs}}" wx:key="*this">
          <view
            id="{{index}}" 
            class="weui-navbar__item {{activeIndex == index ? 'weui-bar__item_on' : ''}}"
            bindtap="tabClick">
            <view class="weui-navbar__title">{{item}}</view>
          </view>
        </block>
       <!--  这为了展示有空格，使用时记得删掉 -->
        <view
          class="weui-navbar__slider" 
          style="left: {{sliderLeft}}px; transform: translateX({{sliderOffset}}px); 
          -webkit-transform: translateX({{sliderOffset}}px);"></view>
      </view>
      <view class="weui-tab__panel">
        <view class="weui-tab__content" hidden="{{activeIndex != 0}}">选项一的内容</view>
        <view class="weui-tab__content" hidden="{{activeIndex != 1}}">选项二的内容</view>
        <view class="weui-tab__content" hidden="{{activeIndex != 2}}">选项三的内容</view>
      </view>
    </view>
  </view>
</view>
```

<div style="width:70%; float:left;margin:5px 0;">

```CSS
/* wxss */
page,
.page,
.page__bd{
    height: 100%;
}
.page__bd{
    padding-bottom: 0;
}
.weui-tab__content{
    padding-top: 60px;
    text-align: center;
}
```
</div>
<div style="width:30%; float:left;margin:5px 0;">
预览图
![img](http://liuxmoo.foryung.com/c.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

```JS
/* js */
var sliderWidth = 96; // 需要设置 slider 的宽度，用于计算中间位置
Page({
    data: {
        tabs: ["选项一", "选项二", "选项三"],
        activeIndex: 1,
        sliderOffset: 0,
        sliderLeft: 0
    },
    onLoad: function () {
        var that = this;
        wx.getSystemInfo({
            success: function(res) {
                that.setData({
                    sliderLeft: (res.windowWidth / that.data.tabs.length - sliderWidth) / 2,
                    sliderOffset: res.windowWidth / that.data.tabs.length * that.data.activeIndex
                });
            }
        });
    },
    tabClick: function (e) {
        this.setData({
            sliderOffset: e.currentTarget.offsetLeft,
            activeIndex: e.currentTarget.id
        });
    }
});
```

#### 3.4.1 TabBar 标签栏

底部导航，建议采用小程序原生的 tabbar，通过设置 app.json 来实现。详情请看小程序文档。

#### 3.4.2 Tabs 标签页/可以参考 navbar 导航栏

#### 3.4.3 Drawer 抽屉

#### 3.4.4 Page 分页

#### 3.4.5 Steps 步骤条

#### 3.4.6 NoticeBar 通告栏

#### 3.4.7 Index 索引选择器

#### 3.4.7  SearchBar 搜索栏

```HTML
<!-- wxml -->
<view class="weui-search-bar">
  <view class="weui-search-bar__form">
    <view class="weui-search-bar__box">
      <icon class="weui-icon-search_in-box" type="search" size="14"></icon>
      <input type="text"
      class="weui-search-bar__input" placeholder="搜索" value="{{inputVal}}" 
      focus="{inputShowed}}" bindinput="inputTyping" />
      <view class="weui-icon-clear" wx:if="{{inputVal.length > 0}}" bindtap="clearInput">
        <icon type="clear" size="14"></icon>
      </view>
    </view>
    <label class="weui-search-bar__label" hidden="{{inputShowed}}" bindtap="showInput">
        <icon class="weui-icon-search" type="search" size="14"></icon>
        <view class="weui-search-bar__text">搜索</view>
    </label>
  </view>
  <view class="weui-search-bar__cancel-btn" hidden="{{!inputShowed}}" bindtap="hideInput">取消</view>
</view>

<view class="weui-cells searchbar-result" wx:if="{{inputVal.length > 0}}">
  <navigator url="" class="weui-cell" hover-class="weui-cell_active">
      <view class="weui-cell__bd">
          <view>实时搜索文本</view>
      </view>
  </navigator>
  <navigator url="" class="weui-cell" hover-class="weui-cell_active">
      <view class="weui-cell__bd">
          <view>实时搜索文本</view>
      </view>
  </navigator>
  <navigator url="" class="weui-cell" hover-class="weui-cell_active">
      <view class="weui-cell__bd">
          <view>实时搜索文本</view>
      </view>
  </navigator>
  <navigator url="" class="weui-cell" hover-class="weui-cell_active">
      <view class="weui-cell__bd">
          <view>实时搜索文本</view>
      </view>
  </navigator>
</view>
```

<div style="width:70%; float:left;margin:5px 0;">

```CSS
/* WXSS */
.searchbar-result{
    margin-top: 0;
    font-size: 14px;
}
.searchbar-result:before{
    display: none;
}
.weui-cell{
    padding: 12px 15px 12px 35px;
}
```
</div>
<div style="width:30%; float:left;margin:5px 0;">
预览图
![img](http://liuxmoo.foryung.com/s.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

```JS
/* js */
Page({
    data: {
        inputShowed: false,
        inputVal: ""
    },
    showInput: function () {
        this.setData({
            inputShowed: true
        });
    },
    hideInput: function () {
        this.setData({
            inputVal: "",
            inputShowed: false
        });
    },
    clearInput: function () {
        this.setData({
            inputVal: ""
        });
    },
    inputTyping: function (e) {
        this.setData({
            inputVal: e.detail.value
        });
    }
});
```

#### 3.4.8 Sticky 吸顶容器

### 3.5 操作反馈

#### 3.5.1 ActionSheet 动作面板

```HTML
  <view class="weui-btn-area">
    <button type="default" bindtap="open">ActionSheet</button>
  </view>
```

```JS
Page({
    open: function(){
        wx.showActionSheet({
            itemList: ['A', 'B', 'C'],
            success: function(res) {
                if (!res.cancel) {
                    console.log(res.tapIndex)
                }
            }
        });
    }
});
```

#### 3.5.2 Toast 轻提示

```HTML
<view class="page">
    <view class="page__hd">
        <view class="page__title">Toast</view>
        <view class="page__desc">弹出式提示，采用小程序原生的 toast</view>
    </view>
    <view class="page__bd">
        <view class="weui-btn-area">
            <button class="weui-btn" type="default" bindtap="openToast">成功提示</button>
            <button class="weui-btn" type="default" bindtap="openLoading">加载中提示</button>
        </view>
    </view>
</view>
```

```JS
Page({
    openToast: function () {
        wx.showToast({
            title: '已完成',
            icon: 'success',
            duration: 3000
        });
    },
    openLoading: function () {
        wx.showToast({
            title: '数据加载中',
            icon: 'loading',
            duration: 3000
        });
    }
});
```

#### 3.5.3 Modal/dailog 对话框/弹出框

<div style="width:50%; float:left;margin:5px 0;">
预览图1
![img](http://liuxmoo.foryung.com/dailog1.png)
</div>
<div style="width:50%; float:left;margin:5px 0;">
预览图2
![img](http://liuxmoo.foryung.com/dailog12.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

```HTML
<view class="weui-btn-area">
  <button class="weui-btn" type="default" bindtap="openConfirm">
    Confirm Dialog
  </button>
  <button class="weui-btn" type="default" bindtap="openAlert">
    Alert Dialog
  </button>
</view>
```

```JS
Page({
    openConfirm: function () {
        wx.showModal({
            title: '弹窗标题',
            content: '弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内',
            confirmText: "主操作",
            cancelText: "辅助操作",
            success: function (res) {
                console.log(res);
                if (res.confirm) {
                    console.log('用户点击主操作')
                }else{
                    console.log('用户点击辅助操作')
                }
            }
        });
    },
    openAlert: function () {
        wx.showModal({
            content: '弹窗内容，告知当前状态、信息和解决方法，描述文字尽量控制在三行内',
            showCancel: false,
            success: function (res) {
                if (res.confirm) {
                    console.log('用户点击确定')
                }
            }
        });
    }
});
```

#### 3.5.4 Message/msg 全局提醒/提醒页

```HTML
<view class="weui-btn-area">
  <button class="weui-btn" type="default" bindtap="openSuccess">成功提示页</button>
  <button class="weui-btn" type="default" bindtap="openFail">失败提示页</button>
</view>
```

```JS
Page({
    openSuccess: function () {
        wx.navigateTo({
            url: 'msg_success'
        })
    },
    openFail: function () {
        wx.navigateTo({
            url: 'msg_fail'
        })
    }
});
```

```HTML
<!-- 失败提示页面 -->
<view class="page">
    <view class="weui-msg">
        <view class="weui-msg__icon-area">
            <icon type="warn" size="93"></icon>
        </view>
        <view class="weui-msg__text-area">
            <view class="weui-msg__title">操作失败</view>
            <view class="weui-msg__desc">内容详情，可根据实际需要安排，如果换行则不超过规定长度，居中展现<navigator url="" class="weui-msg__link">文字链接</navigator></view>
        </view>
        <view class="weui-msg__opr-area">
            <view class="weui-btn-area">
                <button class="weui-btn" type="primary">推荐操作</button>
                <button class="weui-btn" type="default">辅助操作</button>
            </view>
        </view>
        <view class="weui-msg__extra-area">
            <view class="weui-footer">
                <view class="weui-footer__links">
                    <navigator url="" class="weui-footer__link">底部链接文本</navigator>
                </view>
                <view class="weui-footer__text">Copyright © 2008-2016 weui.io</view>
            </view>
        </view>
    </view>
</view>
```

```HTML
<!-- 成功页面 -->
<view class="page">
    <view class="weui-msg">
        <view class="weui-msg__icon-area">
            <icon type="success" size="93"></icon>
        </view>
        <view class="weui-msg__text-area">
            <view class="weui-msg__title">操作成功</view>
            <view class="weui-msg__desc">内容详情，可根据实际需要安排，如果换行则不超过规定长度，居中展现<navigator url="" class="weui-msg__link">文字链接</navigator></view>
        </view>
        <view class="weui-msg__opr-area">
            <view class="weui-btn-area">
                <button class="weui-btn" type="primary">推荐操作</button>
                <button class="weui-btn" type="default">辅助操作</button>
            </view>
        </view>
        <view class="weui-msg__extra-area">
            <view class="weui-footer">
                <view class="weui-footer__links">
                    <navigator url="" class="weui-footer__link">底部链接文本</navigator>
                </view>
                <view class="weui-footer__text">Copyright © 2008-2016 weui.io</view>
            </view>
        </view>
    </view>
</view>
```

#### 3.5.5 Spin/loadmore 加载中/加载更多

```HTML
<view class="weui-loadmore">
  <view class="weui-loading"></view>
  <view class="weui-loadmore__tips">正在加载</view>
</view>
<view class="weui-loadmore weui-loadmore_line">
  <view class="weui-loadmore__tips weui-loadmore__tips_in-line">暂无数据</view>
</view>
<view class="weui-loadmore weui-loadmore_line weui-loadmore_dot">
  <view class="weui-loadmore__tips weui-loadmore__tips_in-line weui-loadmore__tips_in-dot">
  </view>
</view>
```

#### 3.5.6 Swipeout 滑动菜单

#### 3.5.7 Picker 选择器

```HTML
<view class="page">
    <view class="page__hd">
        <view class="page__title">Picker</view>
        <view class="page__desc">选择器，这里使用小程序原生的picker。</view>
    </view>
    <view class="page__bd">
        <view class="weui-btn-area">
            <picker bindchange="bindPickerChange" value="{{index}}" range="{{array}}">
                <button type="default">单列选择器</button>
            </picker>
            <picker class="weui-btn" mode="time" value="{{time}}" start="09:01" end="21:01" bindchange="bindTimeChange">
                <button type="default">时间选择器</button>
            </picker>
            <picker class="weui-btn" mode="date" value="{{date}}" start="2015-09-01" end="2017-09-01" bindchange="bindDateChange">
                <button type="default">日期选择器</button>
            </picker>
        </view>
    </view>
</view>
```

```JS
Page({
    data: {
        array: ['美国', '中国', '巴西', '日本'],
        index: 0,
        date: '2016-09-01',
        time: '12:01'
    },
    bindPickerChange: function(e) {
        console.log('picker 发送选择改变，携带值为', e.detail.value)
        this.setData({
            index: e.detail.value
        })
    },
    bindDateChange: function(e) {
        this.setData({
            date: e.detail.value
        })
    },
    bindTimeChange: function(e) {
        this.setData({
            time: e.detail.value
        })
    }
});
```

#### 3.5.8 toast 弹出式提示

```HTML
<style>
.page{
    background-color: #FFFFFF;
}
</style>
<template>
  <view class="page">
      <view class="page__hd">
          <view class="page__title">Toast</view>
          <view class="page__desc">弹出式提示，采用小程序原生的toast</view>
      </view>
      <view class="page__bd">
          <view class="weui-btn-area">
              <button class="weui-btn" type="default" bindtap="openToast">成功提示</button>
              <button class="weui-btn" type="default" bindtap="openLoading">加载中提示</button>
          </view>
      </view>
  </view>
</template>
<script>
  openToast: function () {
      wx.showToast({
          title: '已完成',
          icon: 'success',
          duration: 3000
      });
  },
  openLoading: function () {
      wx.showToast({
          title: '数据加载中',
          icon: 'loading',
          duration: 3000
      });
  }
</script>
```

### 3.6 视图

#### 3.6.1 Badge 徽章

```HTML
<view class="weui-cells__title">新消息提示跟摘要信息后，统一在列表右侧</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell weui-cell_access">
    <view class="weui-cell__bd">单行列表</view>
    <view class="weui-cell__ft weui-cell__ft_in-access" style="font-size: 0">
      <view style="display: inline-block;vertical-align:middle; font-size: 17px;">
        详细信息
      </view>
      <view class="weui-badge weui-badge_dot" style="margin-left: 5px;margin-right: 5px;"></view>
    </view>
  </view>
</view>

<view class="weui-cells__title">未读数红点跟在主题信息后，统一在列表左侧</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell">
    <view class="weui-cell__hd" style="position: relative;margin-right: 10px;">
      <image src="../images/pic_160.png" style="width: 50px; height: 50px; display: block" />
      <view class="weui-badge" style="position: absolute;top: -.4em;right: -.4em;">8</view>
    </view>
    <view class="weui-cell__bd">
      <view>联系人名称</view>
      <view style="font-size: 13px;color: #888888;">摘要信息</view>
    </view>
  </view>
  <view class="weui-cell weui-cell_access">
    <view class="weui-cell__bd">
      <view style="display: inline-block; vertical-align: middle">单行列表</view>
      <view class="weui-badge" style="margin-left: 5px;">8</view>
    </view>
    <view class="weui-cell__ft weui-cell__ft_in-access"></view>
  </view>
  <view class="weui-cell weui-cell_access">
    <view class="weui-cell__bd">
      <view style="display: inline-block; vertical-align: middle">单行列表</view>
      <view class="weui-badge" style="margin-left: 5px;">8</view>
    </view>
    <view class="weui-cell__ft weui-cell__ft_in-access">详细信息</view>
  </view>
  <view class="weui-cell weui-cell_access">
    <view class="weui-cell__bd">
      <view style="display: inline-block; vertical-align: middle">单行列表</view>
      <view class="weui-badge" style="margin-left: 5px;">New</view>
    </view>
    <view class="weui-cell__ft weui-cell__ft_in-access"></view>
  </view>
  ```

#### 3.6.2 Alert 警告提示

#### 3.6.3 Tag 标签

#### 3.6.4 Progress 进度条

```HTML
<view class="page">
    <view class="page__hd">
        <view class="page__title">Progress</view>
        <view class="page__desc">进度条，这里采用小程序原生的 progress</view>
    </view>
    <view class="page__bd page__bd_spacing">
        <view class="weui-progress">
            <view class="weui-progress__bar">
                <progress percent="0" stroke-width="3" />
            </view>
            <view class="weui-progress__opr">
                <icon type="cancel" size="22"></icon>
            </view>
        </view>
        <view class="weui-progress">
            <view class="weui-progress__bar">
                <progress percent="50" stroke-width="3" />
            </view>
            <view class="weui-progress__opr">
                <icon type="cancel" size="22"></icon>
            </view>
        </view>
        <view class="weui-progress">
            <view class="weui-progress__bar">
                <progress percent="80" stroke-width="3" />
            </view>
            <view class="weui-progress__opr">
                <icon type="cancel" size="22"></icon>
            </view>
        </view>
        <view class="weui-progress">
            <view class="weui-progress__bar">
                <progress percent="{{progress}}" stroke-width="3" />
            </view>
            <view class="weui-progress__opr">
                <icon type="cancel" size="22"></icon>
            </view>
        </view>
        <view class="weui-btn-area">
            <button type="primary" bindtap="upload" disabled="{{disabled}}">上传</button>
        </view>
    </view>
</view>
```

```CSS
.weui-progress{
    margin-bottom: 24px;
}
```

```JS
function _next(){
    var that = this;
    if(this.data.progress >= 100){
        this.setData({
            disabled: false
        });
        return true;
    }
    this.setData({
        progress: ++this.data.progress
    });
    setTimeout(function(){
        _next.call(that);
    }, 20);
}

Page({
    data: {
        progress: 0,
        disabled: false
    },
    upload: function(){
        if(this.data.disabled) return;

        this.setData({
            progress: 0,
            disabled: true
        });
        _next.call(this);
    }
});
```

#### 3.6.5 Avatar 头像

#### 3.6.6 Collapse 折叠面板

#### 3.6.7 CountDown 倒计时

#### 3.6.8 Divider 分隔符

#### 3.6.9 LoadMore 页底提示

### 3.7 表单

#### 3.7.1 Input 输入框

<div style="width:50%; float:left;margin:5px 0;">
预览图1
![img](http://liuxmoo.foryung.com/01.png)
</div>
<div style="width:50%; float:left;margin:5px 0;">
预览图2
![img](http://liuxmoo.foryung.com/02.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>
<div style="width:33%; float:left;margin:5px 0;">
预览图3
![img](http://liuxmoo.foryung.com/03.png)
</div>
<div style="width:33%; float:left;margin:5px 0;">
预览图4
![img](http://liuxmoo.foryung.com/04.png)
</div>
<div style="width:33%; float:left;margin:5px 0;">
预览图5
![img](http://liuxmoo.foryung.com/05.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

```HTML
<view class="weui-toptips weui-toptips_warn" wx:if="{{showTopTips}}">
  错误提示
</view>
<view class="weui-cells__title">单选列表项</view>
<view class="weui-cells weui-cells_after-title">
  <radio-group bindchange="radioChange">
    <label class="weui-cell weui-check__label" wx:for="{{radioItems}}" wx:key="value">
      <radio class="weui-check" value="{{item.value}}" checked="{{item.checked}}" />

      <view class="weui-cell__bd">{{item.name}}</view>
      <view class="weui-cell__ft weui-cell__ft_in-radio" wx:if="{{item.checked}}">
        <icon class="weui-icon-radio" type="success_no_circle" size="16"></icon>
      </view>
    </label>
  </radio-group>
  <view class="weui-cell weui-cell_link">
    <view class="weui-cell__bd">添加更多</view>
  </view>
</view>

<view class="weui-cells__title">复选列表项</view>
<view class="weui-cells weui-cells_after-title">
  <checkbox-group bindchange="checkboxChange">
    <label class="weui-cell weui-check__label" wx:for="{{checkboxItems}}" wx:key="value">
      <checkbox class="weui-check" value="{{item.value}}" checked="{{item.checked}}" />
      <view class="weui-cell__hd weui-check__hd_in-checkbox">
        <icon class="weui-icon-checkbox_circle" type="circle" size="23" wx:if="{{!item.checked}}">
        </icon>
        <icon class="weui-icon-checkbox_success" type="success" size="23" wx:if="{{item.checked}}">
        </icon>
      </view>
      <view class="weui-cell__bd">{{item.name}}</view>
    </label>
  </checkbox-group>
  <view class="weui-cell weui-cell_link">
    <view class="weui-cell__bd">添加更多</view>
  </view>
</view>

<view class="weui-cells__title">表单</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell weui-cell_input">
    <view class="weui-cell__hd">
      <view class="weui-label">qq</view>
    </view>
    <view class="weui-cell__bd">
      <input class="weui-input" placeholder="请输入qq" />
    </view>
  </view>
  <view class="weui-cell weui-cell_input weui-cell_vcode">
    <view class="weui-cell__hd">
      <view class="weui-label">手机号</view>
    </view>
    <view class="weui-cell__bd">
      <input class="weui-input" placeholder="请输入手机号" />
    </view>
    <view class="weui-cell__ft">
      <view class="weui-vcode-btn">获取验证码</view>
    </view>
  </view>
  <view class="weui-cell weui-cell_input">
    <view class="weui-cell__hd">
      <view class="weui-label">日期</view>
    </view>
    <view class="weui-cell__bd">
      <picker mode="date" value="{{date}}" start="2015-09-01" end="2017-09-01" bindchange="bindDateChange">
        <view class="weui-input">{{date}}</view>
      </picker>
    </view>
  </view>
  <view class="weui-cell weui-cell_input">
    <view class="weui-cell__hd">
      <view class="weui-label">时间</view>
    </view>
    <view class="weui-cell__bd">
      <picker mode="time" value="{{time}}" start="09:01" end="21:01" bindchange="bindTimeChange">
        <view class="weui-input">{{time}}</view>
      </picker>
    </view>
  </view>
  <view class="weui-cell weui-cell_input weui-cell_vcode">
    <view class="weui-cell__hd">
      <view class="weui-label">验证码</view>
    </view>
    <view class="weui-cell__bd">
      <input class="weui-input" placeholder="请输入验证码" />
    </view>
    <view class="weui-cell__ft">
      <image class="weui-vcode-img" src="../images/vcode.jpg" style="width: 108px"></image>
    </view>
  </view>
</view>
<view class="weui-cells__tips">底部说明文字底部说明文字</view>

<view class="weui-cells__title">表单报错</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell weui-cell_input weui-cell_warn">
    <view class="weui-cell__hd">
      <view class="weui-label">卡号</view>
    </view>
    <view class="weui-cell__bd">
      <input class="weui-input" placeholder="请输入卡号" />
    </view>
    <view class="weui-cell__ft">
      <icon type="warn" size="23" color="#E64340"></icon>
    </view>
  </view>
</view>

<view class="weui-cells__title">开关</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell weui-cell_switch">
    <view class="weui-cell__bd">标题文字</view>
    <view class="weui-cell__ft">
      <switch checked />
    </view>
  </view>
</view>

<view class="weui-cells__title">文本框</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell weui-cell_input">
    <view class="weui-cell__bd">
      <input class="weui-input" placeholder="请输入文本" />
    </view>
  </view>
</view>

<view class="weui-cells__title">文本域</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell">
    <view class="weui-cell__bd">
      <textarea class="weui-textarea" placeholder="请输入文本" style="height: 3.3em" />
      <view class="weui-textarea-counter">0/200</view>
    </view>
  </view>
</view>

<view class="weui-cells__title">选择</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell weui-cell_select">
    <view class="weui-cell__hd" style="width: 105px">
      <picker bindchange="bindCountryCodeChange" value="{{countryCodeIndex}}" range="{{countryCodes}}">
        <view class="weui-select">{{countryCodes[countryCodeIndex]}}</view>
      </picker>
    </view>
    <view class="weui-cell__bd weui-cell__bd_in-select-before">
      <input class="weui-input" placeholder="请输入号码" />
    </view>
  </view>
</view>

<view class="weui-cells__title">选择</view>
<view class="weui-cells weui-cells_after-title">
  <view class="weui-cell weui-cell_select">
    <view class="weui-cell__bd">
      <picker bindchange="bindAccountChange" value="{{accountIndex}}" range="{{accounts}}">
        <view class="weui-select">{{accounts[accountIndex]}}</view>
      </picker>
    </view>
  </view>
  <view class="weui-cell weui-cell_select">
    <view class="weui-cell__hd weui-cell__hd_in-select-after">
      <view class="weui-label">国家/地区</view>
    </view>
    <view class="weui-cell__bd">
      <picker bindchange="bindCountryChange" value="{{countryIndex}}" range="{{countries}}">
        <view class="weui-select weui-select_in-select-after">{{countries[countryIndex]}}</view>
      </picker>
    </view>
  </view>
</view>

<checkbox-group bindchange="bindAgreeChange">
  <label class="weui-agree" for="weuiAgree">
    <view class="weui-agree__text">
      <checkbox class="weui-agree__checkbox" id="weuiAgree" value="agree" checked="{{isAgree}}" />
      <view class="weui-agree__checkbox-icon">
        <icon class="weui-agree__checkbox-icon-check" type="success_no_circle" size="9" wx:if="{{isAgree}}"></icon>
      </view>
      阅读并同意
      <navigator url="" class="weui-agree__link">《相关条款》</navigator>
    </view>
  </label>
</checkbox-group>

<view class="weui-btn-area">
  <button class="weui-btn" type="primary" bindtap="showTopTips">确定</button>
</view>
```

```JS
Page({
    data: {
        showTopTips: false,

        radioItems: [
            {name: 'cell standard', value: '0'},
            {name: 'cell standard', value: '1', checked: true}
        ],
        checkboxItems: [
            {name: 'standard is dealt for u.', value: '0', checked: true},
            {name: 'standard is dealicient for u.', value: '1'}
        ],

        date: "2016-09-01",
        time: "12:01",

        countryCodes: ["+86", "+80", "+84", "+87"],
        countryCodeIndex: 0,

        countries: ["中国", "美国", "英国"],
        countryIndex: 0,

        accounts: ["微信号", "QQ", "Email"],
        accountIndex: 0,

        isAgree: false
    },
    showTopTips: function(){
        var that = this;
        this.setData({
            showTopTips: true
        });
        setTimeout(function(){
            that.setData({
                showTopTips: false
            });
        }, 3000);
    },
    radioChange: function (e) {
        console.log('radio发生change事件，携带value值为：', e.detail.value);

        var radioItems = this.data.radioItems;
        for (var i = 0, len = radioItems.length; i < len; ++i) {
            radioItems[i].checked = radioItems[i].value == e.detail.value;
        }

        this.setData({
            radioItems: radioItems
        });
    },
    checkboxChange: function (e) {
        console.log('checkbox发生change事件，携带value值为：', e.detail.value);

        var checkboxItems = this.data.checkboxItems, values = e.detail.value;
        for (var i = 0, lenI = checkboxItems.length; i < lenI; ++i) {
            checkboxItems[i].checked = false;

            for (var j = 0, lenJ = values.length; j < lenJ; ++j) {
                if(checkboxItems[i].value == values[j]){
                    checkboxItems[i].checked = true;
                    break;
                }
            }
        }

        this.setData({
            checkboxItems: checkboxItems
        });
    },
    bindDateChange: function (e) {
        this.setData({
            date: e.detail.value
        })
    },
    bindTimeChange: function (e) {
        this.setData({
            time: e.detail.value
        })
    },
    bindCountryCodeChange: function(e){
        console.log('picker country code 发生选择改变，携带值为', e.detail.value);

        this.setData({
            countryCodeIndex: e.detail.value
        })
    },
    bindCountryChange: function(e) {
        console.log('picker country 发生选择改变，携带值为', e.detail.value);

        this.setData({
            countryIndex: e.detail.value
        })
    },
    bindAccountChange: function(e) {
        console.log('picker account 发生选择改变，携带值为', e.detail.value);

        this.setData({
            accountIndex: e.detail.value
        })
    },
    bindAgreeChange: function (e) {
        this.setData({
            isAgree: !!e.detail.value.length
        });
    }
});
```

#### 3.7.2 Radio 单选

#### 3.7.3 Checkbox 复选

#### 3.7.4 Switch 开关

#### 3.7.0 Slider 滑块

```HTML
<view class="page">
    <view class="page__hd">
        <view class="page__title">Slider</view>
        <view class="page__desc">滑块，这里采用小程序原生的slider。</view>
    </view>

    <view class="page__bd page__bd_spacing">
        <slider/>
        <slider show-value value="50"/>
    </view>
</view>
```

```CSS
slider{
    margin-bottom: 30px;
}
```

#### 3.7.5 Rate 评分

#### 3.7.6 InputNumber 数字输入框

#### 3.7.0 Uploader 上传组件

```HTML
<view class="page">
    <view class="page__hd">
        <view class="page__title">Uploader</view>
        <view class="page__desc">上传组件</view>
    </view>
    <view class="page__bd">
        <view class="weui-cells">
            <view class="weui-cell">
                <view class="weui-cell__bd">
                    <view class="weui-uploader">
                        <view class="weui-uploader__hd">
                            <view class="weui-uploader__title">图片上传</view>
                            <view class="weui-uploader__info">{{files.length}}/2</view>
                        </view>
                        <view class="weui-uploader__bd">
                            <view class="weui-uploader__files" id="uploaderFiles">
                                <block wx:for="{{files}}" wx:key="*this">
                                    <view class="weui-uploader__file" bindtap="previewImage" id="{{item}}">
                                        <image class="weui-uploader__img" src="{{item}}" mode="aspectFill" />
                                    </view>
                                </block>
                                <view class="weui-uploader__file">
                                    <image class="weui-uploader__img" src="../images/pic_160.png" mode="aspectFill" />
                                </view>
                                <view class="weui-uploader__file">
                                    <image class="weui-uploader__img" src="../images/pic_160.png" mode="aspectFill" />
                                </view>
                                <view class="weui-uploader__file">
                                    <image class="weui-uploader__img" src="../images/pic_160.png" mode="aspectFill" />
                                </view>
                                <view class="weui-uploader__file weui-uploader__file_status">
                                    <image class="weui-uploader__img" src="../images/pic_160.png" mode="aspectFill" />
                                    <view class="weui-uploader__file-content">
                                        <icon type="warn" size="23" color="#F43530"></icon>
                                    </view>
                                </view>
                                <view class="weui-uploader__file weui-uploader__file_status">
                                    <image class="weui-uploader__img" src="../images/pic_160.png" mode="aspectFill" />
                                    <view class="weui-uploader__file-content">50%</view>
                                </view>
                            </view>
                            <view class="weui-uploader__input-box">
                                <view class="weui-uploader__input" bindtap="chooseImage"></view>
                            </view>
                        </view>
                    </view>
                </view>
            </view>
        </view>
    </view>
</view>
```

```JS
Page({
    data: {
        files: []
    },
    chooseImage: function (e) {
        var that = this;
        wx.chooseImage({
            sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
            sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
            success: function (res) {
                // 返回选定照片的本地文件路径列表，tempFilePath可以作为img标签的src属性显示图片
                that.setData({
                    files: that.data.files.concat(res.tempFilePaths)
                });
            }
        })
    },
    previewImage: function(e){
        wx.previewImage({
            current: e.currentTarget.id, // 当前显示图片的 http 链接
            urls: this.data.files // 需要预览的图片 http 链接列表
        })
    }
});
```

#### 3.7.0  Preview 表单预览

```HTML
<view class="page">
    <view class="page__hd">
        <view class="page__title">Preview</view>
        <view class="page__desc">表单预览</view>
    </view>
    <view class="page__bd">
        <view class="weui-form-preview">
            <view class="weui-form-preview__hd">
                <view class="weui-form-preview__item">
                    <view class="weui-form-preview__label">付款金额</view>
                    <view class="weui-form-preview__value_in-hd">¥2400.00</view>
                </view>
            </view>
            <view class="weui-form-preview__bd">
                <view class="weui-form-preview__item">
                    <view class="weui-form-preview__label">商品</view>
                    <view class="weui-form-preview__value">电动打蛋机</view>
                </view>
                <view class="weui-form-preview__item">
                    <view class="weui-form-preview__label">标题标题</view>
                    <view class="weui-form-preview__value">名字名字名字</view>
                </view>
                <view class="weui-form-preview__item">
                    <view class="weui-form-preview__label">标题标题</view>
                    <view class="weui-form-preview__value">很长很长的名字很长很长的名字很长很长的名字很长很长的名字很长很长的名字</view>
                </view>
            </view>
            <view class="weui-form-preview__ft">
                <navigator url="" class="weui-form-preview__btn weui-form-preview__btn_primary" hover-class="weui-form-preview__btn_active">操作</navigator>
            </view>
        </view>
        <view class="weui-form-preview">
            <view class="weui-form-preview__hd">
                <view class="weui-form-preview__label">付款金额</view>
                <view class="weui-form-preview__value_in-hd">¥2400.00</view>
            </view>
            <view class="weui-form-preview__bd">
                <view class="weui-form-preview__item">
                    <view class="weui-form-preview__label">商品</view>
                    <view class="weui-form-preview__value">电动打蛋机</view>
                </view>
                <view class="weui-form-preview__item">
                    <view class="weui-form-preview__label">标题标题</view>
                    <view class="weui-form-preview__value">名字名字名字</view>
                </view>
                <view class="weui-form-preview__item">
                    <view class="weui-form-preview__label">标题标题</view>
                    <view class="weui-form-preview__value">很长很长的名字很长很长的名字很长很长的名字很长很长的名字很长很长的名字</view>
                </view>
            </view>
            <view class="weui-form-preview__ft">
                <navigator class="weui-form-preview__btn weui-form-preview__btn_default" hover-class="weui-form-preview__btn_active">辅助操作</navigator>
                <navigator class="weui-form-preview__btn weui-form-preview__btn_primary" hover-class="weui-form-preview__btn_active">操作</navigator>
            </view>
        </view>
    </view>
</view>
```

```CSS
.weui-form-preview{
    margin-bottom: 25px;
}
```

### 3.8 文章

```html
<view class="page">
    <view class="page__hd">
        <view class="page__title">Article</view>
        <view class="page__desc">文章</view>
    </view>
    <view class="page__bd">
        <view class="weui-article">
            <view class="weui-article__h1">大标题</view>
            <view class="weui-article__section">
                <view class="weui-article__title">章标题</view>
                <view class="weui-article__section">
                    <view class="weui-article__h3">1.1 节标题</view>
                    <view class="weui-article__p">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                        consequat.
                    </view>
                    <view class="weui-article__p">
                        <image class="weui-article__img" src="../images/pic_article.png" mode="aspectFit" style="height: 180px" />
                        <image class="weui-article__img" src="../images/pic_article.png" mode="aspectFit" style="height: 180px" />
                    </view>
                </view>
                <view class="weui-article__section">
                    <view class="weui-article__h3">1.2 节标题</view>
                    <view class="weui-article__p">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    </view>
                </view>
            </view>
        </view>
    </view>
</view>
```


```css
page{
    background-color: #FFFFFF;
}
image{
    margin: 4px 0;
}
```


