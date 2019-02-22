---
title: markdown 的技巧
date: '2018/8/19 23:57:28'
categories:
  - ⑧ JS 工具集/ JS拓展语言
  - markdown
updated:
tags:
comments:
---

# 一、前言

markdown 是我们经常需要使用的，一些排版技巧。

# 二、Markdown 图片排版

## 2.1 图片链接地址

Markdown写博文时，插入图片不能直接从本地上传，需要挂图片的链接地址才可以。一定是上传到网络上面的照片。

问题：如果照片不显示，看下是不是自己的写法不正确，还有就是自己所在的网络不好，加载不来网络上的照片。

## 2.2 单张图片

直接使用 div 的 align 属性使得图片对其方式按照希望的这样。通过更改align属性可以修改图片左对齐、居中或者右对齐；

<div align="center">
<img src="http://liuxmoo.foryung.com/2222.jpg" height="300px" alt="图片说明" >
</div>

<div align="left">
<img src="http://liuxmoo.foryung.com/2222.jpg" height="300px" alt="图片说明" >
</div>

<div align="right">
<img src="http://liuxmoo.foryung.com/2222.jpg" height="300px" alt="图片说明" >
</div>

如果使用的是 markdown 的方法来插入图片的话，注意 div 要与 markdown 的语法要有一行的空行，不然会得到的是文本，没法显示图片的。

<div align="right">

![头像](http://liuxmoo.foryung.com/%E4%B8%80%E5%AF%B8%E7%85%A7.jpg)

</div>

## 2.3 多张张图片并排显示

通过调整两张图片的高度和宽度可以将两张图片并排显示，同样修改align属性可以改变两张图片的对齐方式；

问题：两张图片在markdown中已经并排显示了，但提交到网站后确实没有并排显示。注意要把这些 img 标签

<div align="center">
<img src="http://liuxmoo.foryung.com/2222.jpg" height="300px" alt="图片说明" ><img src="http://liuxmoo.foryung.com/2222.jpg" height="300px" alt="图片说明" >
</div>

markdown 的语法，空行也还是必须的。

<div align="right">

![头像](http://liuxmoo.foryung.com/%E4%B8%80%E5%AF%B8%E7%85%A7.jpg)
![头像](http://liuxmoo.foryung.com/%E4%B8%80%E5%AF%B8%E7%85%A7.jpg)
</div>

https://mazhuang.org/2017/09/01/markdown-odd-skills/
关于 Markdown 的一些奇技淫巧

但是导出pdf 之后，图片位置就不对了啊!!!!!!!!!!!!!!!!!!!!!

使用插件来直接导出就是正确的了，那个 typora 是又问题的。[Markdown pdf](https://blog.csdn.net/wrx331/article/details/66977715)，直接在文档区域右键就可以导出来了