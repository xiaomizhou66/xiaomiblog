---
title: 'vue 中使用 UEditor 富文本编辑器'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

# 一、前言

vue 富文本编辑器的使用

- UEditor 百度研发团队

<div style="color:red">太垃圾了，用不了，全是错，百度现在还关闭 issue  了，说是弄新的版本，现在根据网上的方法，都用不了这个东西，算了吧，太垃圾了，下面的方法是错的，用了搞不来</div>

# 二、百度 UEditor 插件安装

## 2.1 下载 引入

>下载

下载地址：[UEditor](https://ueditor.baidu.com/website/download.html#ueditor),一般都选择使用 JSP 版本，下载下来。

![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_2019030417000993.png)

PHP：
    PHP 语言
JSP:
    JSP全名为Java Server Pages，中文名叫java服务器页面，其根本是一个简化的Servlet设计，它 是由Sun Microsystems公司倡导、许多公司参与一起建立的一种动态网页技术标准。
ASP：
    ASP是动态服务器页面(Active Server Page)的英文缩写。 是微软公司开发的代替CGI脚本程序的一种应用，它可以与数据库和其它程序进行交互，是一种简单、方便的编程工具。

UTF-8：
    比较国际化，
    UTF－8 编码用以解决国际上字符的一种多字节编码，它对英文使用 8 位（即一个字节），中文使用 24 位（三个字节）来编码。对于英文字符较多的网站则用 UTF－8 节省空间。
    UTF8编码的优点:
      优点1：
          外国人的英文IE上也能显示中文，无需下载IE的中文语言支持包。
          香港台湾无需安装简体中文支持就能正常观看utf8编码的网页,网页上文字不会出现乱码。
      优点2：
          对于英文字符较多的网站则用UTF－8节省空间。
        （对于英文比较多的论坛 ，使用GBK则每个字符占用2个字节，而使用UTF－8英文却只占一个字节。）
GBK：
    版本与 UTF-8 版本功能是一样的．只不过编码方式不同。
    GBK 的文字编码是双字节来表示的，即不论中、英文字符均使用双字节来表示，只不过为区分中文，将其最高位都定成 1。
选择：（但是我们 vue 使用的都是 utf-8 吧）
   如果主要是做简体,网站访问者多数是国内,就用 gbk
   如果你计划做繁体和英文的,网站访问者多是国外,就用 uf8

discuz  论坛一般都推荐使用 GBK 版本,
因为：如果中文比较多,则 UTF-8 编码比 gbk 编码的占用更多的空间 .discuz 的 utf-8 版本的风格模板比较少.

>引入

将下载好的文件包放在工程目录中，就放在 src 目录下吧，比如自定义的一个 assets 文件夹下。或者是 static 文件夹

>main.js 引入 或者 index.html 引入

```JS
//index.html
  <script type="text/javascript" src="/static/js/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" src="/static/js/ueditor/ueditor.all.min.js"></script>
  <script type="text/javascript" src="/static/js/ueditor/lang/zh-cn/zh-cn.js"></script>
  <script type="text/javascript" src="/static/js/ueditor/ueditor.parse.min.js"></script>
 ```

 ```JS
 //main.js
import'../static/Ueditor/ueditor.config.js'
import'../static/Ueditor/ueditor.all.min.js'
import'../static/Ueditor/lang/zh-cn/zh-cn.js'
import'../static/Ueditor/ueditor.parse.min.js'

// 根据自己的路径改变

import'./assets/ueditor/ueditor.config.js'
import'./assets/ueditor/ueditor.all.min.js'
import'./assets/ueditor/lang/zh-cn/zh-cn.js'
import'./assets/ueditor/ueditor.parse.min.js'
```

## 2.2 修改配置

>修改 ueditor/ueditor.config.js 里的务器统一请求接口路径

```JS
(function () {

    /**
     * 编辑器资源文件根路径。它所表示的含义是：以编辑器实例化页面为当前路径，指向编辑器资源文件（即 dialog 等文件夹）的路径。
     * 鉴于很多同学在使用编辑器的时候出现的种种路径问题，此处强烈建议大家使用"相对于网站根目录的相对路径"进行配置。
     * "相对于网站根目录的相对路径"也就是以斜杠开头的形如 "/myProject/ueditor/" 这样的路径。
     * 如果站点中有多个不在同一层级的页面需要实例化编辑器，且引用了同一 UEditor 的时候，此处的 URL 可能不适用于每个页面的编辑器。
     * 因此，UEditor 提供了针对不同页面的编辑器可单独配置的根路径，具体来说，在需要实例化编辑器的页面最顶部写上如下代码即可。
     * 当然，需要令此处的 URL 等于对应的配置。
     * window.UEDITOR_HOME_URL = "/xxxx/xxxx/";
     */
    //！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！在这里定义 window.UEDITOR_HOME_URL
    window.UEDITOR_HOME_URL =  "/static/js/ueditor/" // 就是 放进来的 文件路径，假设是 src/static/js/ueditor/ ！！！！！！！（加上这个代码句子）
    var URL = window.UEDITOR_HOME_URL || getUEBasePath();

    /**
     * 配置项主体。注意，此处所有涉及到路径的配置别遗漏URL变量。
     */
    window.UEDITOR_CONFIG = {
        //为编辑器实例添加一个路径，这个不能被注释
        UEDITOR_HOME_URL: URL

        // 服务器统一请求接口路径
        , serverUrl: URL + "jsp/controller.jsp"
        //这里是你配置的上传内容的 url ；不需要可以删除；如果有上传图片的功能就不能删除啊！！！！
        // 这里是 配置 ueditor 的图片 以及 文件 的后台上传接口

 // 下面省略一堆代码..........
```

如果在设置 serverUrl 的时候错误，

```BASH
Uncaught TypeError: 'caller', 'callee', and 'arguments' properties may not be accessed on strict mode functions or the arguments objects for calls to them...
```

1. 这个问题是因为项目中的使用的 babel 默认添加了 use strict 造成，可参考 https://segmentfault.com/q/1010000007415253，选择其中的方法来解决
2. 或者在webpack.base.conf.js 添加
　　loaders: [{
　　　　test: /\.js$/,
　　　　exclude: /(node_modules|bower_components)/,
　　　　loader: 'babel',
　　　　query: {
　　　　presets: ['es2015']
　　}}]
3. 或者就 注释 serverUrl 字段（如果不注释还会报上传文件地址错误的问题），当然不能注释！就是需要可以填写图片的好么！

# 三、百度 UEditor 组件化使用

## 3.1 components 组件化

在 components 中新建 Ue.vue 文件 贴入这个代码

```HTML
<!-- components/Ue.vue -->
<template>
        <script :id=id type="text/plain"></script>
</template>

<script>
    export default {
        name: 'UE',
        data() {
            return {
                editor: null
            }
        },
        props: {
            content: {
                type: String,
                default:''
            },
            config: {
                type: Object,
            },
            id: {
                type: String
            }
        },
        mounted() {
            const _this = this;
            _this.editor = UE.getEditor(_this.id, _this.config); // 初始化UE
            _this.editor.addListener("ready", function () {
                _this.editor.setContent(_this.content); // 确保UE加载完成后，放入内容。
            });
        },
        methods: {
            getContent() {
                    // 获取内容方法
                return this.editor.getContentTxt();;
            }
        },
        destroyed() {
            this.editor.destroy();
        },
    }
</script>
```

## 3.2 在 页面或者其他组件使用 Ueditor 组件

```HTML
<template>
    <div class="content-wrapper">
        <div class="content">
            <div class="info">UE编辑器示例<br>需要使用编辑器时，调用UE公共组件即可。可设置填充内容content，配置信息config(宽度和高度等)，可调用组件中获取内容的方法。支持页面内多次调用。
            </div>
            <button @click="getUEContent()">获取内容</button>
            <ueditor :content=content1 :config=config1 :id="ue1"></ueditor> <!-- 使用组件 -->
            <ueditor :content=content2 :config=config2 :id="ue2"></ueditor> <!-- 使用组件 -->
        </div>
    </div>
</template>

<script>
    import ueditor from '../components/Ue/Ue.vue'  //路径还是按照自己的路径来

    export default {
        components: {
            ueditor
        },
        data() {
            return {
                content1: '这里是UE测试1',//
                content2: '这里是UE测试2',
                config1: {
                    initialFrameWidth: 1600,
                    initialFrameHeight: 350,
                    wordCount: false,
                },
                config2: {
                    autoHeight: false,
                    wordCount: false,
                },
                ue1: "ue1", // 不同编辑器必须不同的id
                ue2: "ue2"
            }
        },
        methods: {
            getUEContent() {
                // 获取 ueditor 值
                let content1 = UE.getEditor(this.ue1).getContent();
                let content2 = UE.getEditor(this.ue2).getContent();
                console.log(content1)
                console.log(content2)
            }
        }
    };
</script>
```

# 四、API

```JS
//1. 实例化编辑器到 id 为 container 的 dom 容器上：
var ue = UE.getEditor('container');

//2. 设置编辑器内容：
    ue.setContent('<p>hello!</p>');

//3. 追加编辑器内容：
    ue.setContent('<p>new text</p>', true);

//4. 获取编辑器html内容：
    var html = ue.getContent();

//5. 获取纯文本内容：
    ue.getContentTxt();

//6. 获取保留格式的文本内容：
    ue.getPlainTxt();

//7. 判断编辑器是否有内容：
    ue.hasContents();

//8. 让编辑器获得焦点：
    ue.focus();

//9. 让编辑器失去焦点
    ue.blur();

//10. 判断编辑器是否获得焦点：
    ue.isFocus();

//11. 设置当前编辑区域不可编辑：
    ue.setDisabled();

//12. 设置当前编辑区域可以编辑：
    ue.setEnabled();

//13. 隐藏编辑器：
    ue.setHide();

//14. 显示编辑器：
    ue.setShow();

//15. 清空内容：
    ue.execCommand('cleardoc');

//16. 读取草稿箱：
    ue.execCommand('drafts');

//17. 清空草稿箱：
  ue.execCommand('clearlocaldata');
```

# 五、bug

## 2.1 UE is not defined


## 2.2 

```BASH
* ../components/Ue/Ue.vue in ./node_modules/cache-loader/dist/cjs.js??ref--12-0!./node_modules/babel-loader/lib!./node_modules/cache-loader/dist/cjs.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./src/views/Addproduct/Addproduct.vue?vue&type=script&lang=js&
```

问题：
    在 Addproduct.vue 文件中引用的 config.js 文件找不到。
解决：
    确认 config.js 文件的相对路径是否正确，可以解决此问题

```BASH
# 类似不是 这个 ueditor 的问题
./config.js in ./node_modules/cache-loader/dist/cjs.js??ref--12-0!./node_modules/babel-loader/lib!./node_modules/cache-loader/dist/cjs.js??ref--0-0!./node_modules/vue-loader/lib??vue-loader-options!./src/view/HelloWorld.vue?vue&type=script&lang=js&
# 这个错误一般是指在 HelloWorld.vue 文件中引用的 config.js 文件找不到。确认 config.js 文件的相对路径是否正确，可以解决此问题
```