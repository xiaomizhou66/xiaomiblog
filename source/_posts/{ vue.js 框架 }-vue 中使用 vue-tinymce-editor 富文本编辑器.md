---
title: 'vue 中使用 vue-tinymce-editor 富文本编辑器 富文本编辑器'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

# 一、前言

vue-tinymce-editor 富文本编辑器 富文本编辑器的使用！！！！

看了这篇[文章](https://segmentfault.com/a/1190000012791569)之后的选择，看起来是比较好用的，而且 vue-admin 后台开发框架使用的也是这个，还是学习这个吧，感觉也比较简答，好上手。 bug 也不会太多。

[vue-tinymce-editor 的 gitub ](https://github.com/dyonir/vue-tinymce-editor)
[tinymce 官网文档](https://www.tiny.cloud/docs/general-configuration-guide/use-tinymce-inline/),注意这个不是为 vue 而准备的，所以看到 tinymce 官网并不直接是搭配 vue 使用的方法，而是一个广泛的方法，在 vue 中快速的使用的话还是看 vue-tinymce-editor ，现在 git 上面的 star 不多的，当然了也可以直接用 tinymce 的方法自己慢慢的做好了。

下文都是在说 vue-tinymce-editor 的使用方法。

# 二、安装引入使用

## 2.1 安装

```bash
$ $ npm install vue-tinymce-editor

$ yarn add vue-tinymce-editor

# 拓展学习
# yarn 中不需要 --save
# yarn 中还是需要 -dev 的，有需要的话就使用的
```

## 2.2 引入

```JS
//main.js  es6 引入方法
import tinymce from 'vue-tinymce-editor'

Vue.component('tinymce', tinymce)

// 这里是全局引入了，应该可以直接在 组件按需引入使用吧。后面自己去学习看看。
```

## 2.3 .vue 中使用

>tinymce 标签的属性值如下

* id: 组件的 textarea（tinymce 原文档使用） 的 id, `必填，字符串`
* toolbar1: 工具栏 1  `字符串`
          默认值：`'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify | numlist bullist outdent indent | removeformat'`
* toolbar2: 工具栏 2  `字符串`
          默认值：""
* plugins:插件 `数组`
          默认值：['advlist autolink lists link image charmap print preview hr anchor pagebreak', 'searchreplace wordcount visualblocks visualchars code fullscreen', 'insertdatetime media nonbreaking save table contextmenu directionality','template paste textcolor colorpicker textpattern imagetools toc help emoticons hr codesample']
* other_options: 其他 tinymce 选项。你也可以覆盖 tinymce 初始选项(默认选项) `对象`
              默认值：{}
              例如：语言设置
* readonly：富文本编辑器是否可以编辑，（只读？） `布尔值`
            默认值：Boolean
* 还有一个是 vue 的属性 ref：
          ref="test"
          this.$refs.tm.editor 这样可以访问到富文本实例

>标签事件

editorChange(event)：当 tinymce 调用 onchange 时将调用此事件,就是发生改变时
editorInit(editor)：初始化编辑器后将调用此事件

```HTML
<template>
  <div>
    <tinymce  
    id = "tinymceId"  
    v-model = "tinymce.tinymceData"
    :toolbar1="toolbar1"
    :toolbar2="toolbar2"
    :other_options="options"
    readonly="false"
    ></tinymce>
  <div>
<template>
<script>
  export  default {
    name:'xxx'
      data（）{
        return {
          tinymce: {
            tinymceData:'',
            toolbar1:'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify | numlist bullist outdent indent | removeformat'
            toolbar2:"",
            options:{
              language_url: 'http://example.com/js/langs/fa_IR.js'//云图库，文件地址
            }
          }
        };
      }
  }
<script>
```

# 三。改变语言

[语言包下载](https://www.tiny.cloud/get-tiny/language-packages/)，在这里下载语言包，上传到云图库，然后在