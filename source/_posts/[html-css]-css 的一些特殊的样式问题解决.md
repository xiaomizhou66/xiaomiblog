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

## 2.4 文字太长，后边的省略显示

```CSS
text-overflow: ellipsis;/* 溢出省略  ellipsis：翻译为 省略*/
white-space: nowrap; /* 不能换行 */
```