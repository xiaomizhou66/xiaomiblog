---
title: '解决 input 高度不一致的问题'
date: '2018/8/12 00:57:25'
categories:
  - ① html-css
  - css
updated:
tags:
comments:
---
# 一、前言

input 输入框的高度与 button 还有 select 都是不同的，怎么让他们变得一致。

# 二、解决

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