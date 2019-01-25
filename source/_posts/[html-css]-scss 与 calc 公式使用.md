---
title: scss/less 与 calc 公式配合使用
date: '2018/8/18 21:57:28'
categories:
  - ① html-css
  - scss
updated:
tags:
comments:
---
## 一、前言

在 css3 中使用 calc 的方式就不能直接的使用在 scss 的处理中了。如果需要使用，还需要做额外的处理。

## 二、scss 与 calc 公式配合使用

```CSS
/* css3 */
.left{
  width:20px;
  height:100vh;
}
.right{
  width:calc(100vw - 20px);
}
```

```scss
// scss
.left{
  width:20px;
  height:100vh;
}
.right{
  width:calc(100vw - 20px);// scss 会比 less 简单一点，没有变量的话，就是直接像是 css3 与 calc 的使用
  width:calc(100vw - #{$--sidewidth*2}); //scss 变量 配合 calc 公式使用需要使用 #{} 包裹起来
}
```

## 三、less 与 calc 公式配合使用

```CSS
/* css3 */
.left{
  width:20px;
  height:100vh;
}
.right{
  width:calc(100vw - 20px);
}
```

```LESS
// less
.left{
  width:20px;
  height:100vh;
}
.right{
  width:calc(~"100vw - 20px");// 就是用 ~"" 包裹里面的公式，less 中只要涉及 calc 公式就要包裹起来
}
```

```LESS
// less 中使用 calc 并且带上变量
//目标`width:calc(100% + 50px);`以下两种办法都是正确的
//法一
@extra:50px;
width:calc(~"100% + @{extra}"); //√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√
// 还是用方法一比较好记吧，也比较好看，而且好像有的时候 2 会有错？？？？


//法二
@extra:50px;
width:calc(~"100% +"(@extra));  //变量外一定要加括号，结果中会自动添加空格
```