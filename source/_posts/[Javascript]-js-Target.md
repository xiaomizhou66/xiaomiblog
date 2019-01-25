---
title: JS事件：e.target与e.currentTarget区别
date: '2018/8/18 21:57:28'
categories:
  - ② Javascript-ES6-Typescript
  - Javascript
updated:
tags:
comments:
---

## 一、前言

JS 事件：target 与 currentTarget 区别。这里不仅是小程序中的，这个是 js 事件知识点。只是学习到小程序这里的时候需要用到这些绑定事件的传值。dataset 对象。

两者既有区别，也有联系。

## 二、event.target 与 event.currentTarget 的区别深入了解

### 2.1 event.target 与 event.currentTarget 含义区别

- target：一个触发事件的对象的引用,当事件处理程序在事件的冒泡或捕获阶段被调用时。(就是触发事件的元素，事件函数不一定写在它上面，有可能是捕获，冒泡去触发了别的元素上面绑定的事件函数)
- currentTarget：它指的是当事件遍历 DOM 时，标识事件的当前目标。它总是引用事件处理程序附加到的元素，而不是 event.target，它标识事件发生的元素。(也就是事件函数写在哪个元素就是那个元素)

- target 在事件流的 **目标阶段，也就是执行阶段**
- currentTarget 在事件流的 **捕获，目标及冒泡阶段**

- 只有当事件流处在目标阶段的时候，两个的指向才是一样的。也就是说触发事件函数的元素刚好就是绑定事件函数的元素的时候二者是一样的。
- 而当处于捕获和冒泡阶段的时候，
    target 指向被单击的对象
    currentTarget 指向当前事件活动的对象（一般为父级）。


```HTML
<div id="outer" style="background:#099">  
  click outer  
  <p id="inner" style="background:#9C0">click inner</p>  
  <br>  
</div>  

<script type="text/javascript">  
  function G(id){  
    return document.getElementById(id);
  }  
  function addEvent(obj, ev, handler){  
    if(window.attachEvent){  
      obj.attachEvent("on" + ev, handler);  
    }else if(window.addEventListener){
      obj.addEventListener(ev, handler, false);  
    }  
  }  
  function test(e){  
    alert("e.target.tagName : " + e.target.tagName + "\n e.currentTarget.tagName : " + e.currentTarget.tagName);  
  }  
  var outer = G("outer");  
  var inner = G("inner");  
  //addEvent(inner, "click", test);  
  addEvent(outer, "click", test);  
</script>  
```

- 上面的示例中，当在 outer 上点击时，e.target 与 e.currentTarget 是一样的，都是 div；
- 当在 inner 上点击时，e.target 是 p，而 e.currentTarget 则是 div。


深入理解e.target与e.currentTarget
https://juejin.im/post/59f16ffaf265da43085d4108