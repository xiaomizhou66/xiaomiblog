---
title: 'CSS3 深入理解--[transition 过渡]'
date: '2018/8/19 22:57:27'
tags:
  - transition 过渡
categories:
  - ① html-css
  - css
updated:
comments:
---
# 一、前言

- ①gradients 渐变：2 种或者两种背景色的线性/径向(角度) 渐变出来的效果，这个是静态的。
- ②transform 转换：2D 转换与 3D 转换:移动、缩放、转动、拉长或拉伸，是动态的。
- ③transition 过渡： 过渡是元素从一种样式逐渐改变为另一种的效果，也就是两种样式的过渡效果。
    通过过渡 transition，可以让 web 前端开发人员不需要 javascript 就可以实现简单的动画交互效果，它是动态的但还不是动画。
- ④animation 动画：这个是真正的动画。

本节学习的是这几个属性中的 过渡 transition 属性

transition 从效果上看是一种平滑过渡的动画，本质上是在线性时间内将属性从开始值过渡到结束值。例如获得焦点，点击鼠标等动作导致CSS属性值的变化是瞬间完成的，感觉有点生硬。用 transition 可以指定在某时间段内将属性值 **平滑过渡，增强用户体验**。

# 二、transition 过渡

## 2.1 单一属性

[网址](http://www.runoob.com/cssref/css3-pr-transition-property.html)

```BASH
transition:transition-property，transition-duration，transition-timing-function，transition-delay;
#          需要设置过渡的 CSS 属性       过渡效耗时     指定transition效果的转速曲线   延迟时间（指定秒或毫秒数之前要等待切换效果开始


transition-property:width;
# 指定需要过渡的属性。并不是所有属性都能过渡的，只有能数字量化的CSS属性才能过渡。
# ① 颜色系：color，background-color，border-color，outline-color 等等
# ② 数字系：width，height，top，right，bottom，left，zoom，opacity，line-height，background-position，word-spacing，
#           font-weight，vertical-align，outline-outset，z-index 等等
# ③ 01 系：visibility（0表示隐藏，1表示显示）
# ④ all  ： 表示所有的属性都设置过渡
# ⑤ none ：没有属性会获得过渡效果。

transition-duration:5s; # 默认值是 0 意味着不会有效果。取值：（以秒或毫秒计）。
# 也就是从 属性旧值 过渡到 属性新值 花费的时间长度

# 贝赛尔曲线
transition-timing-function:ease;   # 默认值为 ease
# linear        匀速过渡: 规定以相同速度开始至结束的过渡效果            等价于 cubic-bezier(0,0,1,1)
# ease          先快再慢: 规定慢速开始，然后变快，然后慢速结束的过渡效果 等价于 cubic-bezier(0.25,0.1,0.25,1)
# ease-in       加速冲刺: 规定以慢速开始的过渡效果                     等价于 cubic-bezier(0.42,0,1,1)。
# ease-out      减速到停止:   规定以慢速结束的过渡效果                 等价于 cubic-bezier(0,0,0.58,1)）。
# ease-in-out   先加速后减速: 规定以慢速开始和结束的过渡效果            等价于 cubic-bezier(0.42,0,0.58,1)）。
# cubic-bezier(n,n,n,n) 在 cubic-bezier 函数中定义自己的值。可能的值是 0 至 1 之间的数值。

transition-delay: 2s; # 默认值是 0 也即是过渡效果没有延迟就开始过渡了
```

![tu](https://upload-images.jianshu.io/upload_images/1959053-ec85b070d87e5608.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/561/format/webp)

## 2.2 transition 简写属性

```CSS
transition:all 0 ease 0; /* 这个就是默认值，默认值是没有任何效果的，因为过渡时间是 0s */
```

```SCSS
div{
  width:100px;
  height:100px;
  background:red;
  transition:width 2s; /* 简写属性, 过渡的是属性是 宽度值，过渡时间为 2s */
  -webkit-transition:width 2s; /* Safari */
  &:hover{
    width:300px;
  }
}
<div></div>
```

# 三、触发过渡的方式

需要产生过渡了，是有触发方式的，话句话其实就是说在 **过渡方式==什么场合**，就是在什么时候我们可能会使用到过渡这个特性。下面就是我们有可能会使用到这个特性的情况。

- `伪类触发` :hover，:focus，:active，:checked 等。
            `a:link{color:blue;} a:visited {color:blue;} a:hover{color:red;}a:active{color:yellow;}`
- 还有例如 `@media 媒体查询**，根据设备大小，横屏竖屏切换时触发`
- 还有如 click，keydown 等 JS `事件触发`。
- `页面加载`也可能需要。

# 四、transitionend 事件

transition 既然涉及时间，自然就有事件。参照 MDN 有 transitionend 事件，顾名思义就是 **过渡结束时触发该事件。**

```JS
/* 但该事件比较坑。例如过渡 padding 时 */
#tempDiv {
  padding: 1px;
  transition-property: padding; /* 这样会导致事件被执行 4 次 */
  transition-property: all;/* 这样会导致事件被执行 4 次 */
  transition-property: padding-top; /* 修改成这样才是正确的，就只会执行 1 次了
  但是这样就只会过渡 1 条边，也不符合我们的要求呢，其他的边没有得到过渡
  类似这样的属性就不要使用过渡事件了 padding，margin，border 这些有 4 边的都不要使用过渡事件*/
  transition-duration: 1s;
}
#tempDiv:hover {
  padding: 5px;
}
function showMessage() {
  console.log('finished');    //过渡结束时触发打印 log,在这里会被执行 4 次
}
var element = document.getElementById("tempDiv");
element.addEventListener("transitionend", showMessage, false);

/* 过渡属性指定的是 padding，所以在 padding-top，padding-right，padding-bottom，padding-left 过渡结束时均触发了 transitionend 事件。因此 log 被打印了 4 次。 */
```

# 五、（计算属性的）隐式过渡

transition 过渡时有时会出现一些比较模糊的情形，比如设成 `em` 的属性，如你所知 `em` 是根据 `font-size` 来计算的。
类似还有 `rem，vh，vw` 等都是 **根据另一个属性的值来计算得到它的值**。

```CSS
padding:2em;
font-size:12px;
/* 如果 font-size 被改变了，此时 padding 的“书面值”不变，仍旧是 2em，
但“实际值”将会发生变化并触发 transition 过渡。这被称作 “隐式过渡”。多数浏览器会实现隐式过渡，IE 貌似没有，它很特别。 */
```

# 六、开关过渡 和 永久过渡

开关过渡：顾名思义就是触发源的事件结束后会恢复到原始状态。例如当鼠标 hover 事件结束后，图片恢复原始尺寸。
永久过渡：就是过渡后不恢复到原始状态。鼠标 hover 事件结束后，图片仍旧保持放大后的尺寸。

```CSS
/* 开关过渡 */
.transition {
  transition: all 1s ease-in-out;
}
.transition:hover {
  transform: scale(1.5);
}

/* 永久过渡 */
```

# 七、auto 过渡

通常我们属性过渡时，都是定值到定值的过渡，例如 width:100px 过渡到 200px。但要过渡到 width:auto 就不行了。就算你指定 transition: width 1s linear;会发现根本不会有 1 秒的平滑的过渡效果，而是瞬间完成过渡

```SCSS
.div1 {
  background-color: red;
  width: 100px;
  height: 50px;
  transition: width 1s linear; /* 这个过渡 1s 的时间设置了也没有效果，因为 过渡到的是 width: auto; */
  &:hover {
    width: auto;
  }
}
<div id="box1" class="div1">
</div>
```

```JS
// 用 JS 来修改这个 auto 变成具体的值就可以正常的过渡了。
<div id="box2" class="div1">
</div>

window.onload = function(){
    var box = document.getElementById("box2"),
        originWidth = box.clientWidth,
        width2AutoLater = null,
        width2OriginLater = null;

    var width2Auto = function(element, time) {
        if (typeof window.getComputedStyle == "undefined") return;
        var width = window.getComputedStyle(element).width;
        element.style.width = "auto";
        var targetWidth = window.getComputedStyle(element).width;
        element.style.width = width;
        setTimeout(function() {
            element.style.transition = "width "+ time +"ms linear";
            element.style.width = targetWidth;
        }, 10);
    };

    var width2Origin = function(element, time) {
        setTimeout(function() {
            element.style.transition = "width 0s linear";
            element.style.width = originWidth + "px";
        }, 10);
    };

    function callLater(func, paramA, paramB){  
       return function(){  
            func.call(this, paramA, paramB);  
        };  
    }  

    width2AutoLater = callLater(width2Auto, box, 1000);
    width2OriginLater = callLater(width2Origin, box, 1000);

    box.addEventListener("mouseenter", width2AutoLater);
    box.addEventListener("mouseleave", width2OriginLater);
}
// 给 div 注册了mouseenter 和 mouseleave 事件来模拟 hover 效果
// mouseenter 绑定 width2Auto 函数，函数里临时将 div 的 width 设为 auto 后，
// 用 getComputedStyle 得到宽度值，将该宽度值和 transition 设进该 div 的 style 里。
// mouseleave 绑定 width2Origin 函数，函数里将 div 的 width 改回初始值。
// 因为注册事件的函数 addEventListener 的第二个参数是回调函数名，不能给回调函数传参数。
// 因此使用闭包的特性，定义了 callLater 中间函数，函数里通过 call 调用上述两个函数。
```