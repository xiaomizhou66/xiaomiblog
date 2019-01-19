---
title: 'CSS3 深入理解--[animation 动画]'
date: '2018/8/19 22:57:27'
tags:
  - animation 动画
categories:
  - 一、html-css
  - css3
abbrlink: e603d324
updated:
comments:
---
# 一、前言

- ①gradients 渐变：2 种或者两种背景色的线性/径向(角度) 渐变出来的效果，这个是静态的。
- ②transform 转换：2D 转换与 3D 转换:移动、缩放、转动、拉长或拉伸，是动态的。
- ③transition 过渡： 过渡是元素从一种样式逐渐改变为另一种的效果，也就是两种样式的过渡效果。通过过渡transition，可以让 web 前端开发人员不需要 javascript 就可以实现简单的动画交互效果，它是动态的但还不是动画。
- ④animation 动画：这个是真正的动画。

这几个特性中最炫的当然还是这个真正的做成动画的特性 animation，本章就是来学习这个特性的。
使用这个CSS3特性，我们可以创建动画，它可以取代许多网页动画图像，Flash 动画，和 JavaScripts。
**animation 属性和传统的动画制作一样，能控制帧的每一步，制作出更强大的动画效果。**

[MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation)

# 二、animation 动画

## 2.1 @keyframes 关键帧

Keyframes 被称为关键帧，其类似于 Flash 中的关键帧。在 CSS3 中其主要以 “@keyframes” 开头，后面紧跟着是动画名称加上一对花括号“{…}”，括号中就是一些不同时间段样式规则。

```CSS
@keyframes changecolor{
  0%{
   background: red;
  }
  /* 这个中间可以有多个百分比,设置多组状态*/
  100%{
    background: green;
  }
}

/* 也可以使用 from....to....关键字来写 */
@keyframes changecolor{
  from{
   background: red;
  }
  to{
    background: green;
  }
}
```

```CSS
<div>鼠标放到我身上</div>
@keyframes wobble {
  0% {
    margin-left: 100px;
    background:green;
  }
  40% {
    margin-left:150px;
    background:orange;
  }
  60% {
    margin-left: 75px;
    background: blue;
  }
  100% {
    margin-left: 100px;
    background: red;
  }
}
div {
  width: 100px;
  height: 100px;
  background:red;
  color: #fff;
}
div:hover{
  animation: wobble 5s ease .1s;
}
```

## 2.1 from...to 关键字

```CSS
@keyframes xxxxx {
  0% {
    margin-left: 100px;
    background:green;
  }
  50% {
    margin-left: 75px;
    background: blue;
  }
  100% {
    margin-left: 100px;
    background: red;
  }
}

/* 等价于 */
@keyframes xxxxx {
  from {
    margin-left: 100px;
    background:green;
  }
  50% {
    margin-left: 75px;
    background: blue;
  }
  to {
    margin-left: 100px;
    background: red;
  }
}
```

## 2.2 animation-play-state 动画的状态 (不在 animation 属性里面!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1)

```CSS
/* 指定动画是否正在运行或已暂停，这个不在 animation 属性里面。 */
animation-play-state:running; /* 默认值 ,表示正在播放动画*/
animation-play-state:paused; /* 表示暂停动画 */

/* 通常在 JS 端使用该属性 object.style.animationPlayState="paused" 来暂停动画。 */
```

```CSS
@keyframes move {
/*   0%{
    transform: translateY(90px);
  }
  关键字 from 对应的是 0%*/
  from{
    transform: translateY(90px);
  }
  15%{
    transform: translate(90px,90px);
  }
  30%{
    transform: translate(180px,90px);
  }
  45%{
    transform: translate(90px,90px);
  }
  60%{
    transform: translate(90px,0);
  }
  75%{
    transform: translate(90px,90px);
  }
  90%{
    transform: translate(90px,180px);
  }
 /*  100%{ 关键字 to 对应的是 100%，
 在 from.....to 中间可以插入其他的百分比 */
  to{
    transform: translate(90px,90px);
  }
}

div {
  width: 200px;
  height: 200px;
  border: 1px solid red;
  margin: 20px auto;
}
span {
  display: inline-block;
  width: 20px;
  height: 20px;
  background: orange;
  transform: translateY(90px);
  /* animation-name: move;
  animation-duration: 10s;
  animation-timing-function: ease-in;
  animation-delay: .2s;
  animation-iteration-count:infinite;
  animation-direction:alternate; */
  animation:move 10s ease-in .2s infinite alternate;
  animation-play-state:paused; /* 这个属性不在 animation 简写里面 */
}
div:hover span {
  animation-play-state:running;
}
<div>
  <span></span>
</div>
```

## 2.3 animation 简写属性

```BASH
animation:name/duration timing-function animation-delay iteration-count direction   play-state  fill-mode;
# ① 动画名字 ②动画耗时  ③ 动画曲线     ④ 延迟执行时间 ⑤ 动画执行次数  ⑥ 单程还是往返 ⑦          ⑧ 动画结束的样式

① animation-name      # 指定要绑定到选择器的关键帧的名称
#    指定 @keyframes 关键帧的名称 。CSS 加载时会应用该名字的 @keyframes 规则来实现动画
#     注意名称是区分大小写！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

② animation-duration  # 动画指定需要多少秒或毫秒完成       默认值：0s，表示无动画，单位可以设s秒或ms毫秒
③ animation-timing-function  #  动画播放方式 默认值：ease
#    linear        匀速过渡: 动画从头到尾的速度是相同的            等价于 cubic-bezier(0,0,1,1)
#    ease          先快再慢: 默认。动画以低速开始，然后加快，在结束前变慢。 等价于 cubic-bezier(0.25,0.1,0.25,1)
#    ease-in       加速冲刺: 动画以低速开始。                    等价于 cubic-bezier(0.42,0,1,1)
#    ease-out    减速到停止: 动画以低速结束。                    等价于 cubic-bezier(0,0,0.58,1)
#    ease-in-out 先加速后减速:    动画以低速开始和结束。          等价于 cubic-bezier(0.42,0,0.58,1)
#    cubic-bezier(n,n,n,n)   在 cubic-bezier 函数中自己的值。可能的值是从 0 到 1 的数值。

#    step-start;   一步到位                                     等价于 steps(1, start)
#    step-end;     延迟到位                                     等价于 steps(1, end)
#       对于只有0%,100%或from, to两个关键时间帧的动画，step-start和step-end是 没有任何 需要使用的理由的。
#       如果是非等分，无法过渡的阶梯动画，则有使用价值
#    steps(4, end); 逐步运动，断续的动画
#    frames(10);  这个属性值，目前的浏览器都没有实现
#    ease, step-start, cubic-bezier(0.1, 0.7, 1.0, 0.1); 多值
④ animation-delay     # 延迟开始动画的时间。              默认值：0s，表示不延迟，立即播放动画。
⑤ animation-iteration-count  #  定义动画的播放次数。      默认值：1次
#     默认值 1 次，即 放完一遍后不循环播放。
#     n        =>  播放n次
#     infinite =>  表示无限循环播放。
⑥ animation-direction # 指定是否应该轮流反向播放动画。动画播放的方向     默认值：normal
#     normal             默认值。正向播放。
#     reverse            动画   反向播放。
#     alternate          动画在奇数次（1、3、5...）正向播放，在偶数次（2、4、6...）反向播放。 可以平滑的动画
#     alternate-reverse  动画在奇数次（1、3、5...）反向播放，在偶数次（2、4、6...）正向播放。 可以平滑的动画
⑦ animation-fill-mode # 规定当动画不播放时（当动画完成时，或当动画有一个延迟未开始播放时），要应用到元素的样式。 默认值：none
#    none      默认值。动画 在动画 执行之前 和 之后 不会应用任何样式到目标元素。
#              动画播完后，元素恢复到初始状态。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#    forwards  翻译为，向前，最后
#              在动画结束后（由 animation-iteration-count 决定），动画将应用该属性值!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#              保持 @keyframes 里最后一帧的属性。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#    backwards 翻译为，后退，最前，第一
#              在 animation-delay 的时间里 元素的样式使用的是 动画的第一次迭代的关键帧中定义的属性值。
#              这些都是 from 关键帧中的值（当 animation-direction 为 "normal" 或 "alternate" 时）
#              或 to 关键帧中的值（当 animation-direction 为 "reverse" 或 "alternate-reverse" 时
#              应用 @keyframes 里第一帧的属性!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#              动画结束之后，元素不会使用 动画中的样式，会回到元素本身的样式
#    both  动画遵循 forwards 和 backwards 的规则。也就是说，动画会在两个方向上扩展动画属性。
#             动画结束后，第一帧、最后一帧 都应用到元素上!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

###### 简单来说就是 forwards  就是动画结束后，元素的样式变成 动画最后一帧的样式
###### 简单来说就是 backwards 动画延迟执行的时间内，元素的样式变成 动画第一帧的样式，动画结束之后，会回到元素本身的样式
###### 简单来说就是 both      延迟的时候就用第一帧的样式了，并且动画结束后，元素的样式变成 动画最后一帧的样式




!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!简写属性！！！！！！！！！！！！！！！！！！！！！！！！！！
animation: moveten 1s step(10,end) infinite alternate 3s backwards;
#         动画名称 耗时 动画方式     动画次数  往返方式  延迟 最后样式
#         简写属性没有顺序的要求，也没有要求全部设置，但是如果只有一个值的话，默认的是 耗时，也即是说延迟没有设置，没有延迟。
#         因为有 animation-duration 和 animation-delay 都是时间，浏览器会根据先后顺序，
#         将第一个时间认作为 animation-duration，第二个时间认作为 animation-delay。
animation: moveten1 1s ease .5s, moveten2 2s ease 1s forwards; #多动画!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#          动画名称 耗时 方式 延迟,动画名称2 耗时 方式 耗时 样式
```

### 2.3.1 搞懂 step() 断续（不连续）

[网址](https://www.zhangxinxu.com/wordpress/2018/06/css3-animation-steps-step-start-end/)

类似的 steps(number, position) 可以分解为 step-start和step-end 这两种关键字
number：表示我们把动画分成几段/几部分
position：
    start 表示直接开始。也就是时间才开始，就已经执行了一个距离段。
          起始点被忽略，因为时间一开始直接就到了第二个点，
          分段结束的时候，时间才开始走。于是，动画执行的5个分段点是后5个点
    end 表示戛然而止。是默认值。也就是时间一结束，当前距离位移就停止。
          结束点被忽略，因为等要执行结束点的时候已经没时间了，
          分段开始的时候，时间跟着一起走。于是，动画执行的5个分段点是前5个点

记住position参数的含义: 牢记这么一句话：一切都是反的！start不是开始，而是结束；end不是结束，而是开始。
![tu](https://image.zhangxinxu.com/image/blog/201806/2018-06-11_223135.png)
![tu](https://image.zhangxinxu.com/image/blog/201806/2018-06-11_223630.png)

### 2.3.2 搞懂 animation-fill-mode 的属性值 forwards 与 backwards

```CSS
.myDiv2 {
    width: 75px;
    height: 75px;
    background-color: red;
    position:relative;
    animation:mymove 5s 1 2s;
}
@keyframes mymove {
    from {left:0px; background-color:green;}
    to {left:200px; background-color: blue;}
}
.forwards { animation-fill-mode:forwards; }
.bkforwards { animation-fill-mode:backwards; }
.both { animation-fill-mode:both; }

<div class="myDiv2"></div> /* 最终是红色 */
<div class="myDiv2 forwards"></div> /* 最终是 蓝色 */
<div class="myDiv2 bkforwards"></div> /* 最终是红色 */
<div class="myDiv2 both"></div> /* 最终是 蓝色 */
```

## 2.4 transition 与 animation 的区别

如何区别：@keyframes 动画帧就是区别 animation 和 transition 的关键。
在 transition 中是无法更细致地控制时间段内执行的动作的，而在 animation 中用 @keyframes 可以细致地指定第一帧要干什么，第二帧要干什么。

## 2.5 区别 @keyframes 与 animation

@keyframes 只是定义了一个动画效果，但要使动画生效，必须用 animation 属性将动画绑定到具体某 DOM 元素上才行。

# 三、动画应用实例

## 3.1 简单动画

```CSS
div{
  width:100px;
  height:100px;
  background:red;
  animation:myfirst 5s;
  /* 用 animation 将 myfirst 样式绑定到这个div上面,
  把 "myfirst" 动画捆绑到 div 元素，时长：5 秒： */
  -webkit-animation:myfirst 5s; /* Safari and Chrome */
}

@keyframes myfirst
{
  from {background:red;}
  to {background:yellow;}
}

@-webkit-keyframes myfirst /* Safari and Chrome */
{
  from {background:red;}
  to {background:yellow;}
}
```

## 3.2 多个状态动画

任意多的样式任意多的次数。请用百分比来规定变化发生的时间，或用关键词 "from" 和 "to"，等同于 0% 和 100%。0% 是动画的开始，100% 是动画的完成。

```CSS
```