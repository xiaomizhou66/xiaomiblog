---
title: 'CSS3 深入理解--[视差滚动]'
date: '2018/8/12 00:57:25'
categories:
  - ① html-css
  - css
updated:
tags:
comments:
---
# 一、前言

## 1.1 什么是滚动视差？

视差滚动（Parallax Scrolling）是指让多层背景以不同的速度移动，形成立体的运动效果，带来非常出色的视觉体验。

视差效果，原本是一个天文学术语，当我们观察星空时，**离我们远的星星移动速度较慢，离我们近的星星移动速度则较快。** 当我们坐在车上向车窗外 看时，也会有这样的感觉，远处的群山似乎没有在动，而近处的稻田却在飞速掠过。许多游戏中都使用视差效果来增加场景的立体感。**说的简单点就是网页内的元素 在滚动屏幕时发生的位置的变化，然而各个不同的元素位置变化的速度不同，导致网页内的元素有层次错落的错觉，这和我们人体的眼球效果很像。**我看到多家产品 商用视差滚动效果来展示产品，从不同的空间角度和用户体验，起到了非常不错的效果。其实 马里奥小游戏就是使用了这个设计效果。

## 1.2 滚动视差网站的特点

- 多场景
- 大图片
- 多屏
- 净色
- 横向分割
- 适合特性介绍
- 限制元素显示范围

## 1.3 视差设计应该注意的问题

- 以大量图片为特色的网站应该考虑 **图像的预加载问题**，以便 **为用户提供更好更流畅的视觉体验**；
- 某些网站页面在移动设备上的效果可能较之在 PC上 有所不同，一些功能也可能无法正常使用。

# 二、UI 设计过程

## 2.1 滚动视差网站设计流程（UI 设设计师）

![tu](https://image.uisdc.com/wp-content/uploads/2013/05/104.jpg)

1 了解需求分析交互：
    前期先要了解需求，决定是否要采用滚动视差毕竟不是所有项目都适合（UI 设计师需要考虑的问题）
2 整理内容构思场景
    这时脑海里要有一个大概的成品的构思（UI 设计师需要考虑的问题）
3 设计页面图形化场景
    设计稿毕竟不能“动”，这个时候需要输出关键状态的设计稿（UI 设计师需要考虑的问题）
4 沟通讲解述说思路
    需要跟重构人员当面详细讲解你的设计思路以及动画效果 （UI 设计师、前端设计师）
5 优化设计修改反馈
    当一些效果无法实现或成本过高时需要及时修改自己的设计稿 （UI 设计师、前端设计师）
6 不断优化追求完美
    不断跟重构开发沟通，调整设计稿 （UI 设计师、前端设计师）

- 毕竟视觉设计师输出的视觉稿都是静态图片，而滚动视差网站时一个随着滚动不断变化的，所以设计时与传统网页有很多不同。在设计初期设计师要判断这个页面适不适合采用滚动视差。
- 在决定采用滚动视差之后就需要设计者整理现有的内容资料，将其故事化或场景化，然后根据构思设计出关键状态的视觉设计稿。
- 传统 网页设计师做到这一步基本上工作就已经完成，可以交给其他人不管了。但是滚动视差的网站不行，视觉设计的工作才刚刚开始，这时，你需要负责跟重构设计师讲 解你的设计思路，你需要怎么分层怎么运动。
- 在重构设计师实现的时候通常并不会一帆风顺，通常会因为实现成本等各种问题需要设计师返回去重新修改设计稿。通 过反复的沟通，反复的磨合才能完成预想中的漂亮的滚动视差网站。

## 2.2 滚动视差网站设计中的一些小技巧和小细节（UI 设计师）

① 别忘了loading
    滚动视差网站由于内容分层会用到很多 大尺寸图片 或者 png 图片，所以体积往往比较大，所以这个时候千万别忘了设计 loading 动画。？？？？是什么意思？？？？？？？
② 斜线的巧妙运用
    当斜线从底部向上划入的时候，**通常视觉上会给人一种是从右下角以一定角度划入的错觉。**所以斜线的布局也经常被采用在滚动视差网站的设计中去。
③ 纯色的运用
    没有比纯色的背景更直观更简洁。纯色可以有很多种表达方式
    纯色比渐变和图片更容易延展，并且纯色很容易区分视差区间。在使用时我们可以调整颜色的透明度，来达到各种视觉效果。所以纯色的运用也是滚动视差设计者的大爱。

# 三、前端设计师

滚动视差在前端需要辅助 Javascript 才能实现。当然，其实 CSS 在实现滚动视差效果方面，也有着不俗的能力。

## 3.1 css + js 做成视差

## 3.2 css3 做视差

### 3.2.1 使用 background-attachment 属性

具体的去学习 background 简写属性

```BASH
background-attachment #设置背景图像是否固定或者随着页面的其余部分滚动
    scroll     # 背景图片随页面的其余部分滚动。这是默认值!!!!!!!!!!!!!!!!!!!!!!!!
               # 背景图像相对于元素本身固定!!!!!!!,它在的位置的内容走去别的的地方了它不动。但是窗口滚动的话，它就要动了
    fixed      # 背景图像相对于窗体固定（相对于窗口时固定的位置不变的）
#                移动的只有视口，而背景图是一直固定死的。！！！！！！！！！！！！！！！？？
    local      # 背景图像相对于元素内容固定!!!!!!!,它在的位置的内容移动了它就会移动。（CSS3）
    inherit    # 指定 background-attachment 的设置应该从父元素继承
```

```CSS
/* 可以设置多个背景，然后固定模式也是一一对应的 */
background-image: url("https://mdn.mozillademos.org/files/12057/starsolid.gif"),url("https://mdn.mozillademos.org/files/12059/startransparent.gif");
background-attachment: fixed, scroll;
```

做视差的时候，就是一些图片固定，一些图片滚动，就做成了简单的视差效果。

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>css视差滚动</title>
    <link rel="stylesheet" type="text/css" href="index.css">
</head>
<body>
        <div class="box">
            <div class="flowImage fixed-bg bg1">
                <p>
                    这个西红柿死了吗<br>
                    可是它的颜色<br>
                    还像鲜花一样奔放
                </p>
            </div>
            <div class="flowImage fixed-bg bg2">
                <p>为了跳到天上<br>
                   月亮先爬到树上。
                </p>
            </div>
            <div class="flowImage fixed-bg bg3">
                <p>
                    晚上<br>
                    我打着手电筒散步<br>
                    累了就拿它当拐杖<br>
                    我拄着一束光
                </p>
            </div>
            <div class="flowImage fixed-bg bg4">
                <p>
                我是在摸一颗星星<br>
                因为地球<br>
                也是一颗星星
            </p>
            </div>
            <div class="flowImage fixed-bg bg5">
                <p>
                    我在家等爸爸妈妈<br>
                       我饿了<br>
                    这时飞来一只金龟子<br>
                    可能金龟子也饿了
                </p>
            </div>
            <div class="flowImage fixed-bg bg6">
                <p>
                    每当见到加油站<br>
                    我就在心里大声地喊<br>
                    加油加油加油<br>
                    也不知为了谁
                </p>
            </div>
        </div>
</body>
</html>
```

```CSS
body, html {
    height: 100%;
    margin: 0;
    padding: 0
}

.box {
    height: 100%;
    position: relative;
    z-index: 1;
}

.flowImage {
    position: relative;
    height: 500px;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center center;
    z-index: 1;
   background-attachment: fixed; //划重点！！！
}

.flowImage>p {
    margin: 0;
    position: absolute;
    top: 50%;
    left: 10%;
    color: #fff;
    font-size: 30px;
    transform: translate(-10%, -50%);
}

.bg1 {
    background-image: url(images/1.jpg);
}

.bg2:nth-child(2) {
    background-image: url(images/2.jpg);
}

.bg3:nth-child(3) {
    background-image: url(images/3.jpg);
}

.bg4:nth-child(4) {
    background-image: url(images/4.jpg);
}

.bg5:nth-child(5) {
    background-image: url(images/5.jpg);
}

.bg6:nth-child(6) {
    background-image: url(images/6.jpg);
}
```

### 3.2.2 使用 transform: translate3d 实现滚动视差

利用 CSS 3D 来做视差滚动

原理：
① 我们给 **父容器**设置上 `transform-style: preserve-3d;` 和 `perspective: xpx;`，那么处于这个容器的 **子元素就将位于 3D 空间中**，
② 再给子元素设置不同的 transform: translateZ()，这个时候，不同元素在 3D Z 轴方向距离屏幕（我们的眼睛）的距离也就不一样
③ 滚动滚动条，由于子元素设置了不同的 transform: translateZ()，那么他们滚动的上下距离 translateY 相对屏幕（我们的眼睛），也是不一样的，这就达到了滚动视差的效果。

```HTML
<div class="g-container">
    <div class="section-one">translateZ(-1)</div>
    <div class="section-two">translateZ(-2)</div>
    <div class="section-three">translateZ(-3)</div>
</div>
```

```CSS
html {
    height: 100%;
    overflow: hidden;
}

body {
    perspective: 1px;
    transform-style: preserve-3d;
    height: 100%;
    overflow-y: scroll;
    overflow-x: hidden;
}

.g-container {
    height: 150%;

    .section-one {
        transform: translateZ(-1px);
    }
    .section-two {
        transform: translateZ(-2px);
    }
    .section-three {
        transform: translateZ(-3px);
    }
}
```

# 十、视差滚动

## 10.1 左右移动效果

![效果图](https://ask.qcloudimg.com/http-save/yehe-2156395/d75pst5nvg.gif)

```HTML
<div id="wrapper">
  <div id="clouds"></div> <!-- 天空和云 -->
  <div id="ground"></div> <!-- 地面草地 -->
</div>
```

```CSS
html {
  height:100%;
  background:#63D0FF;
}

body{
  margin:0;
  padding:0;
  background:#63D0FF;
  height:100%;
  #wrapper {
    position:relative;
    width:100%;
    height:100%;

    #clouds{
      background:url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/56901/bg-clouds2-tinypng.png") repeat-x 0 bottom #ACE6FF;
      width:100%;
      height:230px; /*190px*/
      min-height:230px;
      position:absolute;
      top:0;
      left:0;
      z-index:1;
      -webkit-transform:translate3d(0,0,0.01);/*  3D 转换 */
      transform:translate3d(0,0,0.01);
    }

    #ground {
      background:url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/56901/grass_tile-tinypng.png") repeat-x 0 0 transparent;
      position: absolute;
      bottom: 0;
      left: 0;
      z-index:2;
      width: 100%;
      height: 192px;
      min-height:192px;
      border:0 none transparent;
      outline:0 none transparent;
      -webkit-transform:translate3d(0,0,0.01);
      transform:translate3d(0,0,0.01);
      will-change: transform;
    }
  }
}
```

```JS
// wait until DOM is ready 监听 DOM 加载完成
// 就像是 vue.js 的 mounted() 的周期函数
// 也像是 react.js 的 componentDidMount() 周期函数一样
document.addEventListener("DOMContentLoaded", function(event) {

  function ground() {
    var tl = new TimelineMax({
      repeat: -1
    });

    tl.to("#ground", 20, {
        backgroundPosition: "1301px 0px",
        force3D:true,
        rotation:0.01,
        z:0.01,
        autoRound:false,
        ease: Linear.easeNone
      });
    return tl;
  }
  function clouds() {
    var tl = new TimelineMax({
      repeat: -1
    });
    tl.to("#clouds", 52, {
      backgroundPosition: "-2247px bottom",
      force3D:true,
      rotation:0.01,
      z:0.01,
      //autoRound:false,
      ease: Linear.easeNone
    });
    return tl;
  }
  var masterTL = new TimelineMax({
    repeat: -1
  });
  
  // window load event makes sure image is
  // loaded before running animation
  window.onload = function() {
    masterTL
    .add(ground(),0)
    .add(clouds(),0)
    .timeScale(0.7)
    .progress(1).progress(0)
    .play();
  };
});
```

这个例子使用到了 GASP  这个动画插件，如果搭配 vue.js 或者是 react.js 使用，要去 GASP 官网去学习。

## 10.2 滚动模糊视觉效果

滚动模糊这种视觉效果也应用的非常广，特别是当你想使用背景图片吸引用户而且还能让用户在滚动的时候阅读图片上文字的时候，就很适合使用它。只需要借助一点点 JavaScript 来改变图片的 background-size 属性就可以实现这样的效果：

```HTML
<style>
  p{
    height:1500px;
  }
</style>
<div class="feature"></div>
<div class="content">
  <h2>Heading</h2>
  <p>111111</p>
</div>
<!--[if IE 8]>         </div> <![endif]-->
```

```CSS
* {box-sizing:border-box}
body, html {
  padding:0; margin:0
}
body {
  background:#232323; color:#fff
}
.opaque {
  position:absolute; top:0; left:0; right:0; bottom:0; opacity:0; background:#d2d6f1;
}
.lt-ie9 .opaque {
  display:none;
}

.content {
  position:relative;
  z-index:1;
  padding-top:45%;
  width:90%;
  margin:0 auto;

  .feature {
    position:fixed;
    top:0; z-index:0;
    width:100%;
    padding-top:50%;
    background: url(http://s3.nikecdn.com/pass/NikeBasketball/LeBron_Poster.jpg) center center no-repeat;
    -webkit-background-size:250%;
       -moz-background-size:250%;
         -o-background-size:250%;
            background-size:250%;
    -webkit-box-shadow: 0 -50px 20px -20px #232323 inset;
       -moz-box-shadow: 0 -50px 20px -20px #232323 inset;
            box-shadow: 0 -50px 20px -20px #232323 inset;
  }
}

@media only screen and (min-width:36.250em) {
  .content {
    width:60%; padding-top:35%
  }
}
```

```JS
$(function(){
    zoom = $('.feature').css('background-size')
    zoom = parseFloat(zoom)/100
    size = zoom * $('.feature').width();
    $(window).on('scroll', function(){
      fromTop = $(window).scrollTop();
      newSize = size - (fromTop/3);
      if (newSize > $('.feature').width()) {
          $('.feature').css({
              '-webkit-background-size': newSize,
              '-moz-background-size': newSize,
              '-o-background-size': newSize,
              'background-size': newSize,
              '-webkit-filter':'blur('+ 0 + (fromTop/100) + 'px)',
              'opacity': 1 - ((fromTop / $('html').height()) * 1.3)
          });
      }
    });
});

$(function (){
    var isChrome = /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);
    var isSafari = /Safari/.test(navigator.userAgent) && /Apple Computer/.test(navigator.vendor);

    if (isChrome || isSafari) {
    } else {
        $('.feature').append('<div class="opaque"></div>');
        $(window).on('scroll', function(){
            var opacity = 0 + ($(window).scrollTop()/5000);
            $('.opaque').css('opacity', opacity);
        });
    }
});
```

## 10.3 视差滚动Hero Image图片效果

这个没有使用到 JS 代码。

![TU](https://ws3.sinaimg.cn/large/006tKfTcgy1fkq36xoh0jg31220gae8g.gif)

```HTML
<header>
  <div class="container">
    <h1>-Do Work That Matters-</h1>
    <h3>You'll never regret it.</h3>
  </div><!-- /.container -->
</header>
<section>
  <div class="container">
  </div><!-- /.container -->
</section>
```

```CSS
/* Variables */
$bg-image: "https://images.unsplash.com/photo-1441716844725-09cedc13a4e7?q=80&fm=jpg&s=c895a1f219d174952415b9b7a0811e62";
$bg-overlay: rgba(0,235,235,0.7);

$primary-color: #FFFFFF;
$primary-font: "Amatic SC", cursive;
$secondary-color: #FFF0A5;
$secondary-font: "Abril Fatface", cursive;
$body-color: #999999;
$body-font: Helvetica, Arial, sans-serif;

/* Fonts */
@import url(https://fonts.googleapis.com/css?family=Abril+Fatface);
@import url(https://fonts.googleapis.com/css?family=Amatic+SC);

/* Mixins */
@mixin bg-images(
    $image-path: "https://images.unsplash.com/photo-1441716844725-09cedc13a4e7?q=80&fm=jpg&s=c895a1f219d174952415b9b7a0811e62",
    $overlay-color: rgba(255,255,255,0.8),
    $position: center center) {

    animation: bgFadeIn 1s ease-in both;
    position: relative;

    &:before {
        background:
            linear-gradient(
              $overlay-color,
              $overlay-color
            ),
            url($image-path);
        background-color: #CCCCCC;
        background-attachment: fixed;
        background-position: $position;
        background-repeat: no-repeat;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
        bottom: 0;
        content: ' ';
        left: 0;
        position: absolute;
        right: 0;
        top: 0;
        z-index: -1;
    }

    @keyframes bgFadeIn {
        0% { background-color: rgba(255, 255, 255, 1); }
        100% { background-color: rgba(255, 255, 255, 0); }
    }
}

/* Base Styles */
* {
  box-sizing: border-box;
}

html, body {
  color: $body-color;
  font-family: $body-font;
  font-size: 10px;
  font-weight: 100;
  margin: 0;
  padding: 0;
}

.container {
  margin: 0 auto;
  max-width: 750px;
  padding: 0 24px;
}

header {
  @include bg-images(
    $image-path: $bg-image,
    $overlay-color: $bg-overlay
  );
  padding: 28px;
  text-align: center;
  
  .container {
    margin: 12rem auto;
  }
  
  h1 {
    border-bottom: 2px solid $primary-color;
    border-top: 2px solid $primary-color;
    color: $primary-color;
    font-family: $primary-font;
    font-size: 8.75rem;
    margin: 0;
  }
  
  h3 {
    color: $secondary-color;
    font-family: $secondary-font;
    font-size: 3.75rem;
    font-style: italic;
    font-weight: 100;
    margin: 0;
  }
}

section {
  padding: 2rem;
  
  p {
    font-size: 2.5rem;
    line-height: 3.5rem;
    &.lead-in {
      font-size: 3rem;
      &:first-letter {
        font-size: 7.25rem;
        display: block;
        float: left;
        position: relative;
        line-height: .1;
        top: -0.200em;
      }
    }
  }
}
```