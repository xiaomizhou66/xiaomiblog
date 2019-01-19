---
title: 'JQurey-ui--[ui 组件库]'
date: '2018/8/19 23:57:28'
tags:
  - Jquery->ajax
categories:
  - ③ Jquery.js
  - Jquery.js 框架学习
updated:
comments:
---
## 一、前言

jQuery 是一个 JavaScript 库。
jQuery 极大地简化了 JavaScript 编程，jQuery 是一个轻量级的"写的少，做的多"的 JavaScript 库。它封装了很多js的方法，实现了很多有用的功能。使得一些 JS 的特效方法使用起来很方便。它就是用 JS 封装的一些方法，开发者可以直接调用这些方法。不必再为了实现一些特效而费时费力的去编写大段的 JS 脚本。（但是不能不会 JS ，开发者也可以去开发封装函数，做一套新的 JS 库也创建类似 jqurey 的东西出来给开发用）jqurey还封装了浏览器的兼容性问题，使用它我们不必再担心浏览器的兼容问题。目前网络上有大量开源的 JS 框架, 但是 jQuery 是目前最流行的 JS 框架，而且提供了大量的扩展。

jQuery库包含以下功能：

- HTML 元素选取
- HTML 元素操作
- HTML DOM 遍历和修改
- CSS  操作
- JavaScript 特效和动画
- HTML 事件操作
- AJAX 异步请求方式：在不刷新的同时更新页面的内容
- Utilities

Jquery 还提供了大量的插件。

菜鸟教程：[网址](http://www.runoob.com/jquery/jquery-tutorial.html)
jquery ：[官网](https://api.jquery.com/)

## 二、jQuery 浏览器兼容问题

jQuery 版本 2 以上不支持 IE6，7，8 浏览器。

①如果需要支持 IE6/7/8，那么请选择1.9，但是不建议这样，新版本有它的新功能。
②你还可以通过条件注释在使用 IE6/7/8 时只包含进1.9。

```HTML
<!--[if lt IE 9]>
    <script src="jquery-1.9.0.js"></script>
<![endif]-->
<!--[if gte IE 9]><!-->
    <script src="jquery-2.0.0.js"></script>
<!--<![endif]-->
```

## 三、jQuery 库的安装/引入

### 3.1 下载 jQuery 库，将文件直接放置在项目中，不建议这种方式，会让项目文件太大。

```HTML
<head>
  <script src="jquery-1.10.2.min.js"></script>
</head>
```

### 3.2 CDN 中载入 jQuery

百度服务器 CDN [jQurey](http://libs.baidu.com/jqurey/3.31/jqurey.min.js)
谷歌服务器 CDN [jQurey](http://ajax.googleapis.com/ajax/libs/jqurey/jqurey.min.js)
boot      CDN [jQurey](https://www.bootcdn.cn/jquery/)

```HTML
<head>
  <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js">
  </script>
</head>
```

## 四、jQuery 的语法

### 4.1 jQuery 基本语法 与 概念

#### 4.1.1 jQuery 基本语法

jQuery 语法是通过选取 HTML 元素，并对选取的元素执行某些操作。基础语法： `$(selector).action()`
selector: 选择器，选择符（选择符 "查询"和"查找" HTML 元素）
action(): 操作（执行对元素的操作）

```JS
$(document).ready(function(){
  $(this).hide()     //隐藏当前元素
  $("p").hide()      //隐藏所有 <p> 元素
  $("p.test").hide() //隐藏所有 class="test" 的 <p> 元素 ！！！！
  $("#test").hide()  // 隐藏所有 id="test" 的元素
}
```

`$()` 的几种用法

前面 2 个是及其关键的。选择 html 中的 DOM  来操作，或者在 html 中生成 DOM。

- **DOM 选择** 就是获取到上下文，不就是在html中查找元素？？？？
- **DOM 创建** 就是使用 jQuery.js 代码来生成 html，可以指定所属的document、属性、事件、甚至所有jQuery方法
    见实战：[数独游戏](https://liuxmoo.com/2018/09/23/21.2-shu-du-you-xi/) ,九宫格就是使用 jQuery.js 代码生成的。
- **DOM 加载完成事件监听**
    $(document).ready()的简化写法。就是 4.2 节中的 2 种写法咯。
    `$()=$(document).ready()`，`$(func)=$(document).ready(func)`

#### 4.1.2 jQuery 基本概念了解

- window
    window 是浏览器端的全部数据变量的引用。          比如 `window.window === window`
    window.jQuery 就是浏览器中的全局变量里的 jQuery。    `window.jQuery === jQurey`
    但是 jQurey 特殊，要写 `window.jQuery`，不然会出错的。
- $ 就是 jQuery的别称
    因此  `window.jQuery === window.$` ,`$=jQuery`

### 4.2 jQuery 的入口函数

```JS
$(document).ready(function(){
    // 执行代码
});

//或者
$(function(){
    // 执行代码
});

// 也就是 $() = $(document).ready() , $() 就代表了 DOM 监听加载完成
```

**这是为了防止文档在完全加载（就绪）之前运行 jQuery 代码，也就是说在 DOM 加载完成后才可以对 DOM 进行操作。** 如果在文档没有完全加载之前就运行函数，操作可能失败。

### 4.3 JavaScript 入口函数

```JS
window.onload = function () {
    // 执行代码
}
```

### 4.4 $(document).ready(function(){}  与 window.onload = function () {} 的区别

$(document).ready(function(){}： jQuery 的入口函数是在 html 所有标签 (DOM) 都加载之后，就会去执行。
window.onload = function () {}： JavaScript 的 window.onload 事件是等到所有内容，包括外部图片之类的文件加载完后，才会执行。

可以看出 $(document).ready(function(){} 速度是要快一些的。

## 五、jQuery 对象与 DOM 对象 与 JS 的区别!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

### 5.1 （DOM 对象） 与 （jqurey 对象）的区别

DOM 对象与 jqurey 对象的区别：[网址](https://www.cnblogs.com/yellowapplemylove/archive/2011/04/19/2021583.html)，区分好 DOM 对象 与 jquery 对象是 学好 jquery 的根本，了解了他们的差别，我们在学习 Jquery API 方法的时候才会看得明白。

DOM    对象：即是我们用传统的方法 (JS) 获得的对象，`var domObj = document.getElementById("id");`
jQuery 对象：即是用 jQuery 类库的选择器获得的对象;  `var $obj = $("#id");` 是通过 jQuery 包装 （DOM 对象）后产生的对象，它是 jQuery独有的。

通常 jQuery 对象，我们在变量前面加一歌 $ 表示，我们就可以快速的分辨 对应的变量是 jQuery 对象 还是 DOM 对象

分清 jQuery 对象 和 DOM 对象 之间的区别，之后学习 jQuery 就会轻松很多的。

```JS
// JavaScript 获取 id 为 foo 的元素内的 html 代码。
  document.getElementById("foo").innerHTML;
```

```JS
//jQuery 获取 id 为 foo 的元素内的 html 代码。
$(function(){
  $("#foo").html()
})
```

```JS
//在 jQuery 对象 中无法使用 DOM 对象的任何方法。
$("#id").innerHTML//错误,jQuery 中没有 innerHTML 这个方法，它是 html()
$("#id").html()  // 正确


$("#id").checked //错误,jQuery 中没有 innerHTML 这个方法，它是 html()
$("#id").attr ("checked") // 正确

//当然 DOM 对象 也不能使用 jQuery 方法
```

#### 5.1.1 判断是 DOM 对象 还是 jqurey 对象

```JS
//jqurey 对象 可以获取版本号，检测它是 jqurey
console.log(jQuery.fn.jquery);
console.log($.fn.jquery);
console.log($.prototype.jquery);
//DOM    对象 使用 .nodeType    可以获得节点，检测它是DOM
console.log(object.nodeType);

jqueryObject instanceof jQuery; //true    jqueryObject 是jQuery对象
domObject instanceof jQuery;      //false domObject不是jQuery对象
domObject instanceof HTMLElement; //true  domObject是DOM对象


if (object[0]) {
    console.log("obj is a jquery object");
} else {
    console.log("obj is a dom object");
}


if(obj instanceof jQuery){
alert("这是一个jQuery对象");
}else{
alert("这是一个其它对象")
}
```

#### 5.1.2 jQuery 对象 和 DOM 对象 的互相转换!!!!!!!!!!!!!!!!!!!!!!!! 这里是一个重点。

jquery 对象和 dom 对象是不一样的！比如 jquery 对象不能使用 dom 的方法，dom 对象不能使用 jquery 方法。

那假如我 jquery 没有封装我要的方法，那能怎么办呢？这时我们可以将 jquery 对象 转换成 dom 对象，然后使用 js 去操作 DOM 对象来实现我们的效果。

jquery提供了两种方法将一个 jquery 对象转换成一个 dom 对象，即 [index] 和 get(index)。**因为jquery 对象就是一个数组对象[通过选择器我们可以选择到 1 或者多个 对象。 id ：1 个， class 1个或者多个，元素 1 或者多个.....] 就是数组了!!!!!**

```JS
//jQuery 对象 ，是一个集合，也就是类似数组的东西，可以获取它的长度，*/
console.log($("div").length);//0 或 1 或 更多
```

```js
//jquery对象 转换成  DOM 对象。转换后可以任意使用 DOM 对象中的方法了.
var jqureyObject=$("domobject");  //获取一个 jqurey 对象。下面来转化为 DOM 对象
var domObject=jqureyObject.get(index); //方法1：使用方法 get(index)
var domObject=jqureyObject[index];    //方法2：使用类数组取索引的办法

var $cr=$("#cr"); //jquery 对象 统称用 $ 来表示 jquery 对象 变量!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
var crDom = $cr[0]; //dom 对象 也可写成 var cr=$cr.get(0);
alert(crDom.checked); //检测这个 checkbox 是否给选中 checked 方法是 DOM 对象才有的


//dom 对象 转换成 jquery 对象。转换后可以任意使用 jquery 中的方法了.jquery 对象 提供了一套更加完善的工具用于操作 dom
//对于一个 dom 对象，只需要用 $() 把 dom 对象 包装起来，就可以获得一个 jquery 对象了，方法为 $(dom对象);!!!!!!!!!!!!!!!!!
var crDom = document.getElementById("#cr"); // dom 对象 crDom
var $cr = $(crDom); //转换成 jquery 对象
```

```JS
$(function () {
    var jqureyObject = $("#aa");  // 用 jqurey 来获取 html 元素，           (jqurey对象)
    var domObject = document.getElementById("aa");// document 获取 html 元素(DOM对象)

    console.log(jqureyObject);//jQuery.fn.init [div#div]      (jqurey对象)
    console.log(domObject);// <div id="div">我是小米粥</div>   (DOM 对象)
    // 从这两句的结果可以看到，输出是不一样的。  DOM 对象是 html 中的整个元素以及元素内的内容。
    // 而 jqurey对象 我们是看不到元素内的内容的。

    console.log(jqureyObject.jqurey);   //3.3.1      对 jqurey对象 对象 使用 .jqurey 可以获取到对应引入的 jQurey
    console.log(domObject.nodeType);    // 1         DOM元素的节点类型，
    console.log(jqureyObject.nodeType); //undefined，表示这个对象不是dom对象
    console.log(domObject.jqurey);      //undefined，表示这个对象不是jqurey对象

    console.log($(domObject)); // DOM 对象转 jQuery 对象 ，就是使用 $() 方法传 DOM 对象
    console.log($(jqureyObject.get(0)));//  jQuery 对象 转 DOM 对象， 使用 .get(index) 方法
    console.log($(jqureyObject[0]));   //  jQuery 对象 转 DOM 对象， 使用 [index]      数组索引


    var jqureyObject1 = $(".bb");  //用jqurey来获取html元素，                     (jqurey对象)
    var domObject1 = document.getElementsByClassName("bb");//document获取html元素 (DOM 对象)

    console.log(jqureyObject1);//jQuery.fn.init [prevObject: jQuery.fn.init(1)]   (jqurey对象)  
    console.log(domObject1);// HTMLCollection []    DOM对象                        (DOM 对象)
    /* 题外知识！
      js获取元素的方法中，只有id的是单个DOM元素，可以直接用，
      tagname、classname，的都是数组，都要借助索引才能得到 单个DOM元素 来操作的！！！！
```

### 5.2 （jQuery 与 js 的区别）的区别 也就是 4.2 节

```JS
//jQuery 入口函数:
$(document).ready(function(){
  // 执行代码
});

//或者

$(function(){
    // 执行代码
});
```

```JS
//JavaScript 入口函数:
window.onload = function () {
    // 执行代码
}
// jQuery 的入口函数是在 html 所有标签(DOM)都加载之后，就会去执行。
// JavaScript 的 window.onload 事件是等到所有内容，包括外部图片之类的文件加载完后，才会执行。
```

## 七、jQuery 对象与 的方法操作

方法的网址!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
方法的网址!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
方法的网址!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
方法的网址!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
方法的网址!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
方法的网址!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

网址：[方法的网址](http://jquery.cuishifeng.cn/index.html)，这是一个写的很全的方法网址，jquery 3.3.1 的中文文档，但是太小了吧，看着有点难受。

### 6.1 jQuery 的选择器:获取 jQuery 对象

jQuery 选择器基于元素的 id、类、类型、属性、属性值等"查找"（或选择）HTML 元素。 它基于已经存在的 CSS 选择器。除此之外，它还有一些自定义的选择器

#### 6.1.1 选择器

##### 6.1.1.1 基本选择器：*，element，class，id，this

|选择器|描述|
|:----:|:----:|
|*|所有元素选择器|
|element|element 元素选择器|
|.classname|class='classname' 的 类选择器|
|#idname|id='idname' 的 ID 选择器|
|this|当前对象选择器|

```HTML
<body>
  <div>1111</div>
  <h1>222</h1>
  <div class='title'>1111</div>
  <h1 id='title' class='title'>222</h1>
  <p>如果您点击我，我会消失。</p>
  <p>点击我，我会消失。</p>
  <p>也要点击我哦。</p>
  <script>
    $("*")  //选取所有元素          结果：
    $("div")  //选取 div 元素       结果：
    $(".title")  //选取 class='title' 的元素，就是 div 与 h1 都被选择到
    $("#title")  //选取 id='title' 的元素，就是 h1 被选择到
    $("p").click(function(){
    $(this).hide();
      //$(this) 是在方法 click 内，此处的 $(this) 表示的是当前调用 click 方法的对象 $("p")，
      // 就是表示当前对象，当前调用该方法的对象，
      //其实不就是 js 中的环境的 this 么，函数坏境内就是触发就是触发函数的对象咯
  });
  </script>
<body>
```

##### 6.1.1.2 层级、后代 选择器

|选择器|描述|
|:----:|:----:|
|select1，select2....|匹配任意一个选择器 的元素|
|$("a[target='_blank']")|选取所有 `target` 属性值等于 `"_blank"` 的 `<a>` 元素|
|$("a[target!='_blank']")|选取所有 `target` 属性值不等于 `"_blank"` 的 `<a>` 元素|
|$(":button")|选取所有 `type="button"` 的 `<input>` 元素 和 `<button>` 元素|
|$("tr:even")|选取偶数位置的 `<tr>` 元素|
|$("tr:odd")|选取奇数位置的 `<tr>` 元素|

```HTML
<div>div</div>
<p class="myClass">111</p>
<span>22</span>
<p class="notMyClass"><p class="notMyClass"</p>
<script>
$(document).ready(function(){
  $("div,span,p.myClass")
    //将每一个选择器匹配到的元素合并后一起返回。你可以指定任意多个选择器，并将匹配到的元素合并到一个结果内。
    //结果：[ <div>div</div>, <p class="myClass">111</p>, <span>22</span> ]
});
</script>
```

```HTML
<div>
  <p>11<p>
  <p class='intro'>22<p>
  <p href='#'>33<p>
  <p>
    <span class='intro'>44<span>
  <p>
  <span>555</span>
</div>
<ul>
  <li>q</li>
  <li>w</li>
</ul>
<ul>
  <li>o</li>
  <li>p</li>
</ul>
<script>
$(document).ready(function(){
  $("div p")  //获取 div 下的 所有 p 元素                          结果：<p>11<p> 与<p class='intro'>22<p> 与 <p>33<p>
  $("p.intro")//选取 class 为 intro 的 `<p>` 元素                  结果：<p class='intro'>22<p>
  $("p .intro")//选取 `<p>` 元素下 class 为 intro 的元素           结果： <span class='intro'>44<span>
  $("ul li:first")  //   选取第一个 `<ul>` 元素的第一个 `<li>` 元素 结果: <li>q</li>!!!!!!!!!!!!!!!!!!!!!!!!!!
  $("ul li:first-child") //选取每个 `<ul>` 元素的第一个 `<li>` 元素 结果: <li>q</li> 与 <li>o</li>!!!!!!!!!!!!!!!!
  $("p:first")//选取第一个 `<p>` 元素                              结果: <p>11<p>
  $("[href]") //选取带有 `href` 属性的元素                          结果：<p href='#'>33<p>
  $('div>span') // 选择 div 下的直接子元素 span                     结果：<span>555</span>
});
</script>
```

### 6.2 jQuery 的选择器:创建 jQuery 对象 （注意不是 DOM 对象） 重点！！！！！！！！！！！！！！！！！！！！！！！！

### 5.3 创建 jQuery 对象

```js
//创建  $("<div>内容</div>");
//放到页面中用  对象.appendTo("标签元素") 方法放进去，放到该元素的最后面
        两种办法第一种办法是元素必须是空元素
       ①  $("<a>",{text:"jingdong",href:"url",target:"",title:""});
       ②  $("<a>jingdong</a>").attr({href:"url",target:"",title:""});
       var div = $("<div>hello</div>");//但是这样只是定义在内存中，没有放到页面上，
/*  我们通过选择器是选择不到它 的，需要先放到页面中*/
div.appendTo("body"); //只能是标签么，用"p1"怎么不行，
var link = $("<a>", { text: "jingdong", href: "url", target: "", title: "" });
link.appendTo("body")
```

jQuery()里面提供的4种构建jQuery对象的方式
（1）jQuery(expression,[context])
（2）jQuery(html,[ownerDocument])
（3）jQuery(elements)
（4）jQuery(callback)

$("div>p")               //参数是字符串
$($("div>p"))          //参数可以是jQuery对象或者类数组（ArrayLike）的集合
$(document)          //参数可以是DOM元素
$()                           //$(document)简写
$(function(){})        //$(document).ready()的简写
$([])                        //参数可以是数组
$({})                        //参数可以是对象
$(1)                        //参数可以是数字，即把1存储到jQuery对象的数据集合中

//注意：后面4行代码都可以被解析，但是这些参数数据（非DOM元素的参数）是被存储到ArrayLike（类数组）集合中，而不是被转换为DOM元素。虽然语法不错，解析正常，但是它们无法完成实际应用。


### 7.1 $obj.get(index)  返回指定位置的 DOM 对象

jqurey 是一个集合，也就是类似数组的东西，我们通常是需要对其中的某些元素进行操作，就要提取元素，也就是索引来获取，之后就用方法来操作,也就是获取到对应的 DOM 元素来操作。

就像是在数组中一样，index 可以为负值，从右边开始选择。或者是与数组长度相加。

```JS
$obj.get(index)  //从 Jquery 对象中获取 DOM 对象 数组中某个值
$obj.get()      //从 Jquery 对象中获取 DOM 对象 数组（所有值）
```

### 7.2 $obj[index]    返回指定位置的 DOM  对象

### 7.3 $obj.index（） 返回指定元素相对于其他元素的 index 位置

```html
<body>
  <p>点击列表项可获得其相对于同胞元素的 index 位置：</p>
  <ul>
  <li>Coffee</li>
  <li>Milk</li>
  <li>Soda</li>
  </ul>
</body>
<script>
  $("li").click(function(){
    alert($(this).index()); // 0 或 1，或 2 .....
    // $(this) 也就是当前 HTML 元素。
    //index() 返回指定元素相对于其他指定元素的 index 位置。
  });
</script>
```

```HTML
<body>
  <span>Click a div!</span>
  <div>First div</div>
  <div>Second div</div>
  <div>Third div</div>
  <script>
    $( "div" ).click(function() {
      // 点击某个 div
      // `this` is the DOM element that was clicked
      var index = $( "div" ).index( this );
      $( "span" ).text( "That was div index #" + index );
      // 将 div 的 对应 index 输出在 span 标签内
    });
  </script>
</body>
```

### 7.4 $obj.toArray()  返回 DOM 对象数组

### 7.5 $obj.eq(index)  返回 jqurey 对象

### 7.6 $obj.first()  返回 jqurey 对象

### 7.7 $obj.last()  返回 jqurey 对象

### 7.8 $obj.parent()  返回 jqurey 对象（一级父元素）

### 7.9 $obj.parents()  返回 jqurey 对象（所有父元素）

### 7.10 $obj.parentsUntil()  返回 jqurey 对象（到某个父元素的所有父元素）

### 7.11 $obj.children()  返回 jqurey 对象（一级子元素）

### 7.12 $obj.contents()  返回 jqurey 对象（返回所有一级子元素带文本节点 对象）

### 7.13 $obj.find()  返回 jqurey 对象（后代元素）

### 7.14 $obj.closest()  返回 jqurey 对象（返回它本身或者是逐级向上(父元素)查找到匹配的元素，没有就是空）