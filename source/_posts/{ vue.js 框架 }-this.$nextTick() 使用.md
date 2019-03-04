---
title: 'this.$nextTick() 使用'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

# 一、前言

this.$nextTick() 使用得到，可以很好。

# 二、什么时候用 this.$nextTick()

```JS
created() {
  //在 created 和 mounted 阶段，如果需要操作渲染后的试图，也要使用 nextTick 方法。
  this.$nextTick(() => {
    console.log(this.$refs.message.innerHTML, "this.$refs.message.innerHTML");
    console.log(
      this.$refs.message_value.value,
      "this.$refs.message_value.value"
    );
  });
}
```

在其他的函数里面，遇到需要渲染后再执行的代码块，就要是到到的。

## 2.1 将一个 A元素下的内容 copy 给另外一个 B元素

这个情况，我们必须是要让 A 渲染完成才会获取到它的 innerHTML 的。没有渲染完成，那么 DOM 中就没有我们需要获取的内容。

```HTML
<!-- 注意到我们使用了 ref  这个特殊的特性
在 vue 中我们一般是用来在父组件标记子组件标签的，
但是也可以用在原生的 html 标签中，以便我们的使用，下面就是它的一个使用情景 -->
<p ref="message">1111111</p>
<div ref="tt"></div>

<script>
  created() {
    //在 created 和 mounted 阶段，如果需要操作渲染后的试图，也要使用 nextTick 方法。
    this.$nextTick(() => {
      this.$refs.tt.innerHTML = this.$refs.message.innerHTML
      // 注意到这个是 this.$refs.xxx    是 refs ，要加上 s ，html 中设置的时候是 ref  ！！！！！！！！！！！！！！！！！！！
    });
  }
</script>
```

## 三、ref

>ref 可以有下划线，但是不能有中线。
>并且注意， ref 是在 mounted 才会存在，才可以读取到的

```HTML
<input v-model.lazy="message"  v-model.trim="message" placeholder="edit me"  ref="message_value">
<p ref="message">{{ message }}</p>

<script>
console.log(this.$refs.message.innerHTML);//获取标签内的内容
console.log(this.$refs.message_value.value);//获取输入框的值
</script>
```

### 3.1 JS 原生的获取元素

#### 3.1.1 document.getElementByXXX

```JS
document.getElementById(id)        //方法：通过 id   取得 HTML元素。 //可返回对拥有指定 ID 的第一个对象的引用。
document.getElementById(id).innerHTML                              // 返回该 html 下的 html 代码

document.getElementsByName()     //方法：通过 name 取得元素，是一个数组。
//因为一个文档中的 name 属性可能不唯一（如 HTML 表单中的单选按钮通常具有相同的 name 属性），
//所有 getElementsByName() 方法返回的是元素的数组，而不是一个元素。
// 获得 form 中第一个 name 为 “inputText” 的元素值
// var myParagragh = document.getElementsByName("inputText")[0].value;

document.getElementsByTagName()  //方法：通过 HTML 标签取得元素，是一个数组。
// var myParagragh = document.getElementsByTagName("p")[1].value; 获得文档中的第二个段落的值：


document.getElementsByClassName(classname)
document.getElementsByClassName("example color")[0].innerHTML


//获取元素的值
document.getElementById("id").value;
```

```HTML
<div class="example">
  <p>P 元素在在第一个样式为 class="example" 的 Div 元素中。Div 的索引值为 0。</p>
</div>
<div class="example color">
  <p>P 元素在在第一个样式为 class="example color" 的 Div 元素中。Div 的索引值为 0。</p>
</div>
<div class="example color">
  <p>P 元素在在第一个样式为 class="example color" 的 Div 元素中。Div 的索引值为 0。</p>
</div>
<p>点击按钮修改第一个类为 "example" 的 div 元素的背景颜色。</p>

<script>
  function myFunction() {
    var x = document.getElementsByClassName("example color");
    x[0].style.backgroundColor = "red";
  }
</script>
```

```JS
<form id="form1" action="#">
  <a href="http://www.baidu.com/" >百度</a></br>
  <a href="http://www.google.cn/" >谷歌</a></br>
  <a href="http://www.gougou.com/" >狗狗</a></br>
</form>

<script>
  <!--getElementsByTags-->
  debugger;
  var hrefs = document.getElementsByTagName("A");
  for (var i=0; i < hrefs.length; i++) {
    var aHref = hrefs[i];  // var aHref = hrefs.item(i);
    if (aHref.innerHTML == "百度") {
      alert(aHref.href);
      break;
    }
  }
</script>
```

#### 3.1.2 document.querySelector(CSS selectors)

匹配指定 CSS 选择器的第一个元素。如果没有找到，返回 null。如果指定了非法选择器则 抛出 SYNTAX_ERR 异常。

```JS
//querySelector() 方法仅仅返回匹配指定选择器的第一个元素。如果你需要返回所有的元素，请使用 querySelectorAll() 方法替代。
document.querySelector("#demo");//指定一个或多个匹配元素的 CSS 选择器。 可以使用它们的 id, 类, 类型, 属性, 属性值等来选取元素。


document.querySelector("p");//获取文档中第一个 <p> 元素：
document.querySelectorAll("p");//获取文档中所有的 <p> 元素：
document.querySelector(".example");//获取文档中 class="example" 的第一个元素:
document.querySelector("p.example");//获取文档中 class="example" 的第一个 <p> 元素:

<h3> h3 元素</h3>
<h2> h2 元素</h2>
document.querySelector("h2, h3").style.backgroundColor = "red";//只会将 h3 那段代码渲染为红色背景
// 因为它是获取第一个 h2 或者是 h3, 先遇到 h3 那么就是它了，不会再找别人了

<h2> h2 元素</h2>
<h3> h3 元素</h3>
document.querySelector("h2, h3").style.backgroundColor = "red";//只会将 h2 那段代码渲染为红色背景
// 因为它是获取第一个 h2 或者是 h3，先遇到 h2 那么就是它了，不会再找别人了

document.querySelector("div span") // 找到第一个 div 下的 span ！！！！！！！！！！！！！！！！！！！！！！！！！
document.querySelector('.ivu-menu-item .ivu-menu-item-active ivu-menu-item-selected')

var matches = document.querySelectorAll("div.note, div.alert");
//下面的例子返回一个文档中所有的 class 为 "note" 或者 "alert" 的 div 元素.
// 会把所有符合要求的都找上
```