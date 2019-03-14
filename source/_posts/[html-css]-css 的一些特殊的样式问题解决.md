---
title: 'CSS 一些特殊的样式问题解决'
date: '2018/8/17 21:57:27'
tags:
  - flex
categories:
  - ① html-css
  - css
updated:
comments:
---
# 一、前言

html ，css 会有一些特殊的问题需要解决。

# 二、小问题

## 2.1 img 标签，图片为空时 去掉默认边框（这个是谷歌高版本加的特性，当图片的src加载失败，就会这样显示）

如果 img 给了固定的宽高，并且初始 src 为 null，或者是 src 错误显示 alt 时，img 标签就会存在默认边框，很丑的。需要解决掉。
标签下面的两个属性可以解决，具体就看自己是怎么写的，哪个比较好解决。

```CSS
/* 1 */
img[src=""] {
    display: none;
}

/* 2 */
img:not([src]) {
    opacity: 0;
}


/* 3 */
img[src=""]{
opacity: 0;
}



/* 4 */
<img src="abc.jpg" onerror="src='123.jpg'" />


/* 5 */
<img src="error.jpg" onerror="whenError(this)">
<script>
function whenError(a){
    a.onerror=null;
    a.src='http://avatar.csdn.net/1/E/E/1_qq_27080247.jpg';
    console.log('图片出错的时候调用默认的图片');
}
</script>
```

## 2.2 子元素的 margin 会突破父元素

```BASH
# 问题1：
#   父元素与外界的边界原来希望是 10px 的，但是由于 `第一个子元素`设置的 margin-top:20px; 导致这个父元素与外界的边界变成 20px 了。
#   或者是 `最后一个子元素`设置的 margin-bottom:20px;导致这个父元素与外界的边界变成 20px 了。
<div style="height:200px;width:200px;background:red;">
</div>
<div style="height:200px;width:200px;background:gray;margin-top:10px;" >
  <div style="height:100px;width:100px;background:gold;margin-top:50px;"></div>
</div>
```

<div style="height:200px;width:200px;background:red;">
</div>
<div style="height:200px;width:200px;background:gray;margin-top:10px;" >
  <div style="height:100px;width:100px;background:gold;margin-top:50px;"></div>
</div>

```BASH
# 问题 2：
#    父元素的盒子包含一个子元素盒子，给子元素盒子一个垂直外边距margin-top,父元素盒子也会往下走margin-top的值，而子元素和父元素的边距则没有发生变化。
`<div style="height:200px;width:200px;background:gray;"> `
  `<div style="height:100px;width:100px;background:gold;margin-top:50px;"></div>`
`</div>`
```

<div style="height:200px;width:200px;background:gray;"> 
  <div style="height:100px;width:100px;background:gold;margin-top:50px;"></div>
</div>

这个 bug 原因：

In this specification, the expression collapsing margins means that adjoining margins (no non-empty content, padding or border areas or clearance separate them) of two or more boxes (which may be next to one another or nested) combine to form a single margin.
所有毗邻的两个或更多盒元素的 margin 将会合并为一个 margin 共享之。毗邻的定义为：同级或者嵌套的盒元素，并且它们之间没有非空内容、Padding 或 Border分隔。
“嵌套”的盒元素也算“毗邻”，也会 Collapsing Margins。

解决办法：
    1、修改父元素的高度，增加 padding-top 样式模拟（padding-top：1px；常用）。或者对应的是 padding-bottom 样式
    2、`为父元素添加 overflow：hidden; 样式即可（完美）！！！！！！！！！！！！！！！！！！！！！`这个简单好用
    3、为父元素或者子元素声明浮动（float：left；可用）
    4、为父元素添加border（border:1px solid transparent可用）
    5、为父元素或者子元素声明绝对定位

## 2.3 input 输入框的高度与 button 还有 select 都是不同的，怎么让他们变得一致。

原因：其实是因为 padding 导致的，修改 padding 也可以的，但是我们还是直接使得盒子模型是 border-box 就不需要考虑 padding 的问题了。

```HTML
    <style>
        input,select {
            height: 50px;
        }
        input{
            box-sizing: border-box;
        }
    </style>


    <div>
        如何解决input和select的宽高不一致问题
    </div>
    <input type="text">
    <input type="button" value="22222">
    <select name="" id=""></select>
```

![1](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190220192039.png)
![2](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190220192349.png)
![3](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190220192411.png)

## 2.4 首行缩进

```CSS
text-indent: 2em; /* 首行缩进 */
```

## 2.5 怎么让 Chrome支持小于12px 的文字

谷歌浏览器中，默认的中文汉字最小字体是12px，不管你设置成 8px 还是 10px，在浏览器中只会显示 12px

```HTML
<style>
  p span{
    font-size:10px;
    transform: scale(0.8);
    -webkit-transform:scale(0.8);
  }
</style>

<p>
  <span> 10px</span>
</p>
```

## 2.6 两个 div 一个固定宽度，另一个填充满窗口

```html
<div class="parents">
   <div class="div1"></div>
   <div class="div2"></div>
</div>
```

```CSS
.parents {
    display: flex;  
    height: 100px;
    line-height: 100px;
    background: pink;
    text-align: center;

    .div1 {
      width: 100px;
      height: 100%;
      background: yellow;
    }

    .div2 {
      flex: 1;
      background: green;
      height: 100%;
    }
}
```

```CSS
.product-box {
    width: 100%;
    margin: 10rpx;
    display: flex;
    flex-direction: row;
    align-items: center;/*flex 的子项在父元素中 垂直方向居中*/
    text-align: center; /*元素 在 盒子中居中 ，可以被继承*/

    image {
      width: 100px; /*flex 的子项设置固定宽度，就不会缩放 flex:0*/
    }

    .groupProduct-name {
      flex: 1;/*flex 的子项 设置为 1 表示的是会缩放*/
    }

    .price {
      width: 100px;/*flex 的子项设置固定宽度，就不会缩放 flex:0*/
    }
}
```

## 2.7 文本省略

> 单行文本后面多余的部分省略号表示

```CSS
/* 三行配合完成 */
text-overflow: ellipsis;/* 溢出省略  ellipsis：翻译为 省略*/
white-space: nowrap; /* 文本强制不换行； */
overflow:hidden;/* 溢出部分隐藏 */
```

> 2 行文本后面多余的部分省略号表示 (`css3`)！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

注意的问题是设置了这样之后，就不能设置高度了，设置了的话会发现，文字太多的话，高度还有的话，就会发现第 3 行就会出来了.

* 如果有布局的需求，就给它的父级去添加高度就好了
* padding 也不能有的，不然第 3 行还是会出来的

```CSS
overflow: hidden;
text-overflow: ellipsis;
text-overflow: -o-ellipsis-lastline;
display: -webkit-box;
/*! autoprefixer: off */
-webkit-box-orient: vertical; /*从上到下垂直排列子元素（设置伸缩盒子的子元素排列方式）*/
-webkit-line-clamp: 2; /*这个属性不是css的规范属性，需要组合上面两个属性，表示显示的行数。*/
 /* display: -webkit-box; 将对象作为弹性伸缩盒子模型显示。*/
 /* autoprefixer: off 这一行注释要加上，它是代码的一部分。不然下面一句有的时候不生效，-webkit-box-orient: vertical; 不兼容*/
 /*-webkit-box-orient: vertical; 从上到下垂直排列子元素（设置伸缩盒子的子元素排列方式）*/
 /* -webkit-line-clamp: 2; 这个属性不是css的规范属性，需要组合上面两个属性，表示显示的行数。*/
```

## 2.8 margin 与 width:100% 的问题

![T](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190310214646.png)

```CSS
.parents{
  width: 100%;
  background: red;
  .child {
      width: 100%;
      height: 100px;
      margin: 20px;
      background: blue;
  }
}
/* 看上面的图片， 就知道这样设置是错误的，这个就是 盒子模型的原理了。
除了 ie 浏览器是 box-sizing:boder-box 之外其他的都是 box-sizing:content-box
不管是什么浏览器 margin 都不会包含在 width 里面的。
而我们上面的样式设置中 width: 100%; 已经占满了父元素的 100% 了，还要设置一个 margin: 20px; 当然就会超出了

背景颜色是涵盖到 border 边框上，margin 是不包括的。*/
```

```CSS
/* 想要得到理想中的效果，可以在父元素去设置 padding 值,父元素的 padding 会包含在 父元素的 width 里面的。*/
.parents{
  width: 100%;
  background: red;
  padding:20px;
  .child {
      width: 100%;
      height: 100px;
      /* margin: 20px; */
      background: blue;
  }
}
/* 子元素之间希望有间隔的话可以设置上下的，不要设置左右的，设置就会超出了呀 margin: 20rpx 0;  */
```

![T](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190310214517.png)

## 2.9 felx 布局与 line-hieght

## 2.10 文本靠底部对其

使用相对，绝对定位的办法，其他的办法也有。

```css
.parents {
  width: 100%;
  height: 50%;
  position: relative;

  .child{
    position: absolute;
    bottom: 0;
  }
}
```

```CSS
/* 这个办法，并不成功，至少在微信小程序是不成功的 */
display:table-cell;
vertical-align:bottom;
```