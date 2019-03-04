---
title: ESlint 这个大坑
date: '2018/8/19 23:57:28'
categories:
  - ⑮ bug 集合
  - ESlint 这个大坑
updated:
tags:
comments:
---

# 一、前言

eslint 安装之后，在 vscode 中需要配置，不然使用 vue 做项目就会报出各种错误。在其他的时候也会发生这样那样的错误。

# 二、编辑保存的错误

去看 eslint 之坑这个文章，

# 三、在使用 ueditor 的时候报错。

```BASH
# ueditor.config.js
# 在这个配置文件中会发生错误。

Module Warning (from ./node_modules/@vue/cli-plugin-eslint/node_modules/eslint-loader/index.js):
error: Unnecessary escape character: \/ (no-useless-escape) at public\ueditor\ueditor.config.js:458:70:
  456 |         } else if (!/^[a-z]+:/i.test(confUrl)) {
  457 |
> 458 |             docUrl = docUrl.split("#")[0].split("?")[0].replace(/[^\\\/]+$/, '');
      |                                                                      ^
  459 |
  460 |             basePath = docUrl + "" + confUrl;
  461 |


1 error found.

You may use special comments to disable some warnings.
# 您可以使用下面这些 特殊注释 来禁用某些警告

Use // eslint-disable-next-line to ignore the next line.     【对下一行代码 禁止规则出现警告】
# 使用// eslint-disable-next-line 忽略下一行。
Use /* eslint-disable */ to ignore all warnings in a file.    【整个文件范围内 禁止规则出现警告】
#  使用   / * eslint-disable * /    忽略文件中的所有警告。。
#  就是在某个文件顶部写上   /* eslint-disable */
#  name整个文件将不受 eslint 的影响，eslint 就不会来检查这个文件了。
```

原因：
    就是因为代码中有不必要的空格，或者是空行，什么的
解决：
    上面的 2 种是其中的某些原因的解决办法，还有很多办法，写在夏下面。适当的选择使用，有的时候有的办法是不能使用的。

```JS
// ② 整个文件范围内 禁止规则出现警告
// Use /* eslint-disable */ to ignore all warnings in a file.    【】
//  使用   / * eslint-disable * /    忽略文件中的所有警告。。
//  就是在某个文件顶部写上 /* eslint-disable */ 然后整个文件就不会受到影响了
/* eslint-disable */
alert('foo');
alert('2');
alert('3');
//  name整个文件将不受 eslint 的影响，eslint 就不会来检查这个文件了。


// ④ 在文件中临时 禁止规则出现警告
//       将需要忽略的代码块用注释包裹起来
       /* eslint-disable */
       alert('foo');               // 这行代码是被包裹起来的，不会被 eslint 检查
       /* eslint-enable */


// ⑤ 对指定规则的启用或者禁用警告
/* eslint-disable no-alert, no-console */
alert('foo');
console.log('bar');
/* eslint-enable no-alert, no-console */


// ⑥ 对指定行禁用规则警告
// 有 2 种方式，一个当前行，一个是下一行
alert('foo'); // eslint-disable-line

// eslint-disable-next-line
alert('foo');


// ⑦ 在指定行上禁用指定的某个规则
alert('foo'); // eslint-disable-line no-alert

// eslint-disable-next-line no-alert
alert('foo');


//⑧ 在某个特定的行上禁用多个规则
alert('foo'); // eslint-disable-line no-alert, quotes, semi

// eslint-disable-next-line no-alert, quotes, semi
alert('foo');

```