---
title: less--[less，css 中的 calc 公式运用]
date: 2018/8/18 21:57:28
categories:
  - 一、html-css
  - less
updated:
tags:
comments:
---
## 一、前言

习惯用 Less 之后，简直一点都不想再乖乖地写 CSS 了。光是“嵌套”的语法特性就让人爱不释手。但是 less 也会有 less 的问题。

## 二、css3 中使用 calc 函数

### 5.1 css 中 felx 与 calc 公式

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
  <style>
    body{
      padding: 0;
      margin: 0;
    }
    .head{
      height: 50px;
      background: firebrick;
    }
    .content{
      display: flex;
      width: 100%;
      background: blue;
      height: calc(100vh - 100px);
    }
    .left{
      width: 240px;
      background: red;
      height: 100%;
    }
    .right{
      width: calc(100vw - 240px);
      background: yellow;
      height: 100%;
      overflow:auto; //这里是auto，是hidden的话就不对的
    }
    .footer{
      height: 50px;
      background: teal;
    }
  </style>
</head>
<body>
  <div class="head">head</div>
  <div class="content">
    <div class="left">left</div>
    <div class="right">
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
      right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right right
    </div>
  </div>
  <div class="footer">footer</div>
</body>
</html>
```

以上代码的效果图如下

![TU](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181001150254.png)

### 5.2 css 中  calc 与 100%

```CSS
#div1 {
    position: absolute;
    left: 50px;
    width: calc(100% - 100px);
    border: 1px solid black;
    background-color: yellow;
    padding: 5px;
    text-align: center;
}
```
### 5.3 css 中让 高度 == 宽度

```CSS
{
  width:50%;
  height: calc(width);
}
```

```html
//通过 js 动态生成 DOM
<script type="text/javascript">
$(document).ready(function(){
    $('#box1').css('height',$('#box1').css('width'));
})
</script>
<style type="text/css">
#box{
    width: 900px;
    height: 400px;
    border:1px solid red;
}
#box1{
    width:50%;
    border:1px solid green;
}
</style>
<body>
<div id='box'>
    <div id='box1'></div>
</div>
</body>
```

## 三、 Less 中使用 CSS3 的 calc 函数（有时候很有用），怎么都不起作用。

**运算符前后不要忘记空格，否则公式是没有效果的！！！！！！！！！！！！！！**
**运算符前后不要忘记空格，否则公式是没有效果的！！！！！！！！！！！！！！**
**运算符前后不要忘记空格，否则公式是没有效果的！！！！！！！！！！！！！！**

### 2.1 原因

原来是跟 Less 的语法冲突了，Less 把 calc 的参数当作运算式执行了。解决方式是使用 Less 的转义字符~。它的具体用法可以看文章结尾的参考阅读中的 Less Language Escaping。文档中说到：[GIT:https://github.com/SomMeri/less4j/wiki/Less-Language-Escaping](https://github.com/SomMeri/less4j/wiki/Less-Language-Escaping) 这个文档就有说明.

### 2.2 普通加减

```LESS
CSS3：width:calc(100% + 50px);  编译为width:calc(100% + 50px); //CSS3
less：width:calc(100% + 50px);  编译为width:calc(150%);        //错误的less
less：width:calc(~"100% + 50px");编译为width:calc(100% + 50px); //正确less使用
```

```LESS
CSS3：width:calc(100% - 50px);  编译为width:calc(100% - 50px);//CSS3
less：width:calc(100% - 50px);  编译为width:calc(59%);         //错误的less
less：width:calc(~"100% - 50px");编译为width:calc(100% - 50px);//正确less使用
```

### 2.3 带变量加减

```LESS
//目标`width:calc(100% + 50px);`以下两种办法都是正确的
//法一
@extra:50px;
width:calc(~"100% + @{extra}");
//法二
@extra:50px;
width:calc(~"100% +"(@extra));  //变量外一定要加括号，结果中会自动添加空格
```

```LESS
//目标`width:calc(100% + 50px + 2em);`以下两种办法都是正确的
//法一
@extra:50px;
width:calc(~"100% + @{extra} + 2em");
//法二
@extra:50px;
width:calc(~"100% +"(@extra)~"+ 2em");  //变量外一定要加括号，结果中会自动添加空格
```

顺便，如果习惯使用 Less 语法，但是又不想在 HTML 中引入Less.js等其他的库，可以使用编辑器的插件，把 Less 文件编译成 CSS 文件之后，再引入到 HTML 中。比如，VSCode 有一个插件叫 Easy LESS。每当 Less 文件被保存时，就会自动编译生成对应的 CSS 文件。