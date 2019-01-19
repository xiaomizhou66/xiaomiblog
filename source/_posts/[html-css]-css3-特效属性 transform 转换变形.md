---
title: 'CSS3 深入理解--[transform 转换/变形]'
date: '2018/8/19 22:57:27'
tags:
  - transform 转换/变形
categories:
  - 一、html-css
  - css3
abbrlink: 7db68520
updated:
comments:
---
## 一、前言

- ①gradients 渐变：2 种或者两种背景色的线性/径向(角度) 渐变出来的效果，这个是静态的。
- ②transform 转换：2D 转换与 3D 转换:移动、缩放、转动、拉长或拉伸，是动态的。
- ③transition 过渡： 过渡是元素从一种样式逐渐改变为另一种的效果，也就是两种样式的过渡效果。通过过渡transition，可以让 web 前端开发人员不需要 javascript 就可以实现简单的动画交互效果，它是动态的但还不是动画。
- ④animation 动画：这个是真正的动画。

本章学习 transform 转换/变形

## 二、前置属性

### 2.1 transform-origin 更改转换元素的位置。（在子元素上面使用）

```BASH
# 定义视图被置于 X Y Z 轴的何处（XYZ轴的正向分别是往右，往下，靠近用户眼睛。反之为反向）
transform-origin: 50% 50% 0;  # 默认值，元素的正中心。值都表示一个偏移量！！！！！！！！！！！！！！！
# 第一个参数, 是二维的取值可以是 left center right length % 这 5 种写法
#     left center right ：相对应的变形中心偏移
#     length %          ：定义变形中心距离盒模型的 左侧 的 <length> 或 <percentage> 偏移值
#         left   =>  0%
#         center =>  50%
#         right  => 100%
# 第二个参数, 是二维的取值可以是 top center bottom length % 这 5 种写法
#     top center bottom ：相对应的变形中心偏移
#     length %          ：定义变形中心距离盒模型的 顶部 的 <length> 或 <percentage> 偏移值
#         top    =>  0%
#         center =>  50%
#         bottom => 100%
# 第三个参数，表示的是三维的，取值只能是长度值 length，也就是 30px; 0; 这样的
#     length            ：定义变形中心距离 用户视线（z=0处）就是屏幕的地方咯 的 <length>（不能是 <percentage>）偏移值。


# 这个属性的可以有 1 个，2个，3个值都可以。

# 1 个值，没有设置的值就是原始默认值
transform-origin: 2px;
transform-origin: center;
transform-origin: left;
transform-origin: bottom;
transform-origin: inherit;  # 继承父元素
transform-origin: initial;  # 原始值
transform-origin: unset;    # 不设置

# 2 个值，就是 前面两个值
transform-origin: 3cm 2px;
transform-origin: left 2px;
transform-origin: right top;
transform-origin: top right;

transform-origin: 2px 30% 10px;
transform-origin: left 5px -3px;
transform-origin: right bottom 2cm;
transform-origin: bottom right 2cm;
```

```CSS
#div1{
  /* 父元素 */
  position: relative;
  height: 200px;
  width: 200px;
  margin: 100px;
  padding:10px;
  border: 1px solid black;
}

#div2{
  /* 子元素 */
  padding:50px;
  position: absolute;
  border: 1px solid black;
  background-color: red;
  transform: rotate(45deg); /* 子元素需要旋转，不需要在父元素做什么操作 */
  -ms-transform: rotate(45deg); /* IE 9 */
  -webkit-transform: rotate(45deg); /* Safari and Chrome */

  transform-origin:20% 40%;/* 子元素希望改变自己的圆心的位置，
  其实就是在父元素中移动位置，将中心位置移到父元素中别的位置，完全可以使用 transform:translate()来替代的 */
  -ms-transform-origin:20% 40%; /* IE 9 */
  -webkit-transform-origin:20% 40%; /* Safari and Chrome */
}

<div id="div1">
  <div id="div2">HELLO</div>
</div>
```

![tu](https://upload-images.jianshu.io/upload_images/1959053-e4ab3a6f6eb071ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/351/format/webp)

**注意**

>transform-origin 指定变形中心点对 translate 位移没有影响，translate 位移始终相对于 **元素正中心** 进行位移

```CSS
/* 其实transform-origin只是一个语法糖而已，你总是可以用 translate 来代替它。
每个transform-origin都可以被两个 translate 模拟出来（by CSS变形规范的编辑Aryeh Gregor）。
例如： */
transform: rotate(30deg);
transform-origin: 200px 300px;

/* 等价于 */
transform: translate(200px, 300px)
           rotate(30deg)
           translate(-200px, -300px);
transform-origin: 0 0;
```

### 2.2 transform-style 确定元素的子元素 是否位于3D空间中。使用在【父元素】上。

还是在该元素所在的平面内被扁平化，如果被扁平化，则子元素不会独立的存在于三维空间。因为该属性不会被（自动）继承，所以必须为元素所有非叶子后代节点设置该属性。

```CSS
transform-style: preserve-3d; /* 让子元素处于 三维空间  3D */
transform-style: flat;     /* 子元素位于此元素所在平面内 2D 。这个是默认值!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
transform-style: inherit;  /* 继承父元素 */
```

![tu](https://upload-images.jianshu.io/upload_images/1959053-2c4077a76ffd8524.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/150/format/webp)

左图的父 div 没有设 transform-style 默认是 flat，因此元素不会在Z轴展开（translateZ(16px) 失效），只能呈现 2D 效果。
右图的父 div 上设了 transform-style: preserve-3d;，因此呈现了 3d 效果。

```CSS
.div1 {
    float: left;
    background-color: red;
    transform: perspective(200px) rotateY(45deg);
}
.div1 img{
    transform: translateZ(16px);
}
.p3d {
    transform-style: preserve-3d;
}

<div class="div1"><img src="head75.png" /></div>
<div class="div1 p3d"><img src="head75.png" /></div>
```

```css
#div1{
  /* 父元素 */
  position: relative;
  height: 200px;
  width: 200px;
  margin: 100px;
  padding:10px;
  border: 1px solid black;
}

#div2{
 /*  子元素 */
  padding:50px;
  position: absolute;
  border: 1px solid black;
  background-color: red;
  transform: rotateY(60deg); /* 子元素需要围绕着 Y 轴旋转 3D 旋转 ，不需要在它的父元素做什么操作就可以做到*/
  -webkit-transform: rotateY(60deg); /* Safari and Chrome */

  transform-style: preserve-3d; /* 希望它的子元素（也就是孙子元素）处理 3D 空间,在这里设置 */
  -webkit-transform-style: preserve-3d; /* Safari and Chrome */
}

#div3{
  /* 孙子元素 */
  /* 希望自己不处理父元素（也就是上面的 div2）的平面，那么需要在其父元素设置 transform-style */
  padding:40px;
  position: absolute;
  border: 1px solid black;
  background-color: yellow;
  transform: rotateY(-60deg); /* 孙子元素希望围绕着 Y 轴旋转，这个不需要在其父元素做什么操作 */
  -webkit-transform: rotateY(-60deg); /* Safari and Chrome */

}
<div id="div1">
  <div id="div2">HELLO
    <div id="div3">YELLOW</div>
  </div>
</div>
```

查看上面的[效果](http://www.runoob.com/try/try.php?filename=trycss3_transform-style)

**注意**!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

>如果同时设了 `transform-style: preserve-3d;` 和 `overflow: hidden;`，3D 效果将失效，等价于 `transform-style: flat;`。如果你发现 3D 效果没有像预想地那样出现，可以检查一下（包括祖先元素）是否有 `overflow: hidden;`，该属性将 flatten everything…

### 2.3 perspective 指定 3D 的视距。表示的是 3D 效果离眼睛的距离。使用在【父元素】上。也可以在子元素调用变形函数来使用。

perspective 属性指定了观察者与 z=0 平面的距离(电脑设备屏幕))，使具有三维位置变换的元素产生透视效果。**z>0 的三维元素比正常大，而 z<0 时则比正常小，大小程度由该属性的值决定。**

```CSS
/* length ,指定观察者距离 z=0 平面的距离，为元素及其内容应用透视变换。当值为 0 或 负值 时，无透视变换。*/
perspective: none; /* 默认值 ,表示无 3D 效果，即 2D 扁平化。*/
perspective: 20px;  
perspective: 3.5em;
perspective: inherit;
perspective: initial;
perspective: unset;
```

![tu](https://upload-images.jianshu.io/upload_images/1959053-8a2f99e7daa03d53.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/450/format/webp)

```CSS
/* 图中 d 就是 perspective 视距(其实就是人的观察者离屏幕的距离？？)，Z就是translateZ轴的位移。
Z 轴正向位移时，3D 舞台将放大。反之，Z 轴负向位移时，3D 舞台将缩小。
上图 Z 是 d 的一半，因此 3D 舞台上的元素将是原来的 2 倍。下图 Z 同样是 d 的一半，但由于是 负值，所以 3D 舞台上的元素将缩小 三分之一。 */
.x {
    transform: perspective(200px) rotateX(60deg);
}
.y {
    transform: perspective(200px) rotateY(60deg);
}
.z {
    transform: perspective(200px) rotateZ(60deg);
}
<img class="x" src="head75.png" />
<img class="y" src="head75.png" />
<img class="z" src="head75.png" />
```

![tu](https://upload-images.jianshu.io/upload_images/1959053-0a1968974bc9cf07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/426/format/webp)

```CSS
.divsp {
  display: inline-block;
  border: 1px blue dashed;
  margin-left: 30px;
  perspective: 100px;  /* 父元素设置 视距 为 100px, 表示 3D 舞台距离你的眼睛 100px。 */
}
.z1 {
  transform: translateZ(-75px);
  /* 原始图片为 75px，缩小到 42.85px， */
}
.z2 {
  transform: translateZ(0px);
  /* Z 轴没有位移，因此仍旧是原始大小 */
}
.z3 {
  transform: translateZ(25px);
    /* 原始图片为 75px，放大后的图片为 100px。 */
}
.z4 {
  transform: translateZ(101px);
  /* 图片消失了，因为 3D 舞台距离你眼睛 100px，而图片从舞台往Z轴正向位移 101px，图片到了你脑袋后面自然什么都看不见。
  如果是 100px 相当于图片紧贴着你的眼睛，所以全屏都是图片。 */
}
<div class="divsp">
  <img class="z1" src="head75.png" />
</div>
<div class="divsp">
  <img class="z2" src="head75.png" /></div>
<div class="divsp">
  <img class="z3" src="head75.png" /></div>
<div class="divsp">
  <img class="z4" src="head75.png" />
</div>
```

**注意**

这个属性我们是这样写的 `perspective: 100px;`，但是也会看到这样写的 `transform: perspective(200px) rotateX(60deg);`
两种方法都是可以的，可以这样来理解
`perspective: 100px;`  是属性写法，指定用于 3D 舞台，即 3D 舞台的视距，里面的 **子元素 共享这个视距**
`transform: perspective(200px) rotateX(60deg);` 调用函数的写法，perspective() 函数指定只针对当前变形元素，
    需要和 transform 其他函数一起使用，仅表示当前变形元素的视距。

### 3.4 perspective-origin 设置视距的基点。使用在【父元素】上。

属性指定了观察者的位置，在属性 perspective 中被用作消失点。

```bash
perspective-origin:50% 50%;    # 默认值,也可以简写为 center。表示视距基点在中心点不进行任何位移。
#  第一个参数 <percentage> 百分比，相对于元素宽度，可为负值。
#            <length> 长度值，可为负值。
#            left  => 0
#            center=> 50%
#            right => 100%
#  第二个参数 <percentage> 百分比，相对于元素高度，可为负值。
#            <length> 长度值，可为负值。
#            top  => 0
#            center=> 50%
#            bottom => 100%
```

```CSS
#div1
{
  /* 这里是父元素 */
  position: relative;
  height: 150px;
  width: 150px;
  margin: 50px;
  padding:10px;
  border: 1px solid black;

  perspective:150; /* 这个透视属性用在父元素上，当然也直接的在子元素上调用函数的方式使用 */
  perspective-origin: 10% 10%;/* 这个透视属性用在父元素上*/
  -webkit-perspective:150; /* Safari and Chrome */
  -webkit-perspective-origin: 10% 10%; /* Safari and Chrome */
}

#div2
{
  /* 这里是子元素 */
  padding:50px;
  position: absolute;
  border: 1px solid black;
  background-color: red;
  transform: rotateX(45deg);/* transform  这个变形函数属性直接使用在需要转换变形的 元素/子元素上 */
  -webkit-transform: rotateX(45deg); /* Safari and Chrome */
}

<div id="div1">
  <div id="div2">HELLO</div>
</div>
```

![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190110154534.png)

### 2.5 backface-visibility 当元素背面朝向观察者时是否可见（使用在子元素-不需要父元素设置）

属性指定当元素背面朝向观察者时是否可见。元素的背面总是透明的，当其朝向观察者时，显示正面的镜像。在某些情况下，我们不希望元素内容在背面可见，比如实现翻牌效果。

```BASH
backface-visibility: visible; # 默认值，表示背面可见，允许显示正面的镜像。
backface-visibility: hidden;  # 表示背面不可见。
```

```CSS
div{
  position:relative;
  height:60px;
  width:60px;
  background-color:red;
  transform:rotateY(180deg);
  -webkit-transform:rotateY(180deg); /* Chrome and Safari */
  -moz-transform:rotateY(180deg); /* Firefox */
}
#div1{
  -webkit-backface-visibility:hidden;
  -moz-backface-visibility:hidden;
  -ms-backface-visibility:hidden;
  }
#div2{
  -webkit-backface-visibility:visible;
  -moz-backface-visibility:visible;
  -ms-backface-visibility:visible;
}

<div id="div1">DIV 1</div>
<div id="div2">DIV 2</div>
```

## 三、transform 属性【使用在子元素】

CSS 里 transform 变形这个属性有点学习难度，尤其在 CSS3 里加上了 3D 效果之后，2 维变 3 维学习成本更是成倍提高。

transform 本质上是 **一系列变形函数 `<transform-function>`**，分别是
① perspective 透视
② translate 位移
③ scale 缩放
④ rotate 旋转
⑤ skew 扭曲
⑥ matrix 矩阵

**注意**
这个 transform 属性对 块级元素 有效，如果是行内元素需要使用到 `display:inline-block;` 使得它保留了原有 行内元素属性，也有了块级元素的属性。

```TEXT
transform-origin:50%;  =>  transform: translateX(50%);？？？？？？ 这个是不是也是这样对应的呀
perspective:200px;     =>  transform: perspective(200px);
```

可以是 1 个值，可以是多个值，这个属性写法就像是调用其他属性的函数 `<transform-function>`值 变换函数 一样的写法 。就是上面的 6 中值中的任意组合。**变换函数按从 左到右 的顺序相乘，这意味着复合变换按从 右到左 ？？？？ 的顺序有效地应用。**

### 3.1 transform: none;      默认值 不进行转换

### 3.2 transform: matrix();  transform: matrix3d();  矩阵转换 [基本上就不会使用这个属性]

矩阵转换变形是 **所有**变形的 **本质**，所有的变形效果都可以用矩阵来实现。但是这个需要使用到数学的矩阵来计算，这个太难了，可以使用其他 5 种属性值来达到的效果，就不要使用这个来慢慢的计算了吧，给自己搞什么麻烦。[www](https://www.jianshu.com/p/52e0018e6ce2)

```BASH
# 值为 number
# 2D 转换，使用 6 个值的矩阵。就是基于水平方向（X轴）和垂直方向（Y轴）重新定位元素,此属性值使用涉及到数学中的矩阵。
transform: matrix(1.0, 2.0, 3.0, 4.0, 5.0, 6.0);
matrix(1,0,0,1,50,100);  # 等价于 translate(50px, 100px); 也就是说最后的 5,6 两个值是 位移值
matrix(0.5,0,0,1.5,0,0); # 等价于 scale(0.5, 1.5);        也就是说 第 1,4 两个值是 缩放系数，默认值为 1 不做缩放
matrix(1, 0, 1, 1, 0, 0);# 等价于 skew(45deg);            也就是说 第 2,3 个值是倾斜值

# 3D 转换，使用 16 个值的 4x4 矩阵。
transform: matrix3d(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0);
transform: matrix(1.06,1.84,0.54,2.8,466px,482px);
# 等价于transform: rotate(15deg) translate(230) scale(1.5,2.6) skew(220deg,-150deg) translate(230px);

# 看这里的结论就是这个太难了，矩阵数学什么的就不要用了，谁有时间为了写一个属性慢慢的在这里做什么计算的。
```

### 3.2 transform: translate();  位移转换

注意不要用 position 来替代这个属性哦，position 做不到这个属性的要求

```BASH
transform: translate(12px, 50%); # 2D 转换
# X,Y轴位移： 第 1,2 个参数 length，%  
# 如果只是设置了一个参数，那么表示 X,Y 方向按照同样的参数位移。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

transform: translate3d(12px, 50%, 3em); #  3D 转换
# X,Y轴位移：第 1,2 个参数 length，%  如果只是设置了 2 个参数，那么就是 Z 方向没有发生位移，等同于 2D 转换的效果。!!!!!!!!!!!!!!
# Z 轴位移： 第 3 个参数 length ，只能是长度值,Z 轴的值越大表示离眼睛越近，元素就越大，但当值大于 perspective 视距时元素将消失，
#           因为眼睛无法看见眼睛背后的东西，
transform: translateX(x);      #  转换，只是用 X 轴的值。transform: translateX(2em);
transform: translateY(y);      #  转换，只是用 Y 轴的值。transform: translateY(3in);
transform: translateZ(z);      #  转换，只是用 Z 轴的值。transform: translateZ(2px);
```

### 3.3 transform: scale();  缩放 转换变形

```BASH
# 根据中心原点对对象进行缩放。默认值为 1，小于1 为 缩小，大于 1 为放大，负值就是垂直方向反转之后缩放

#  2D 缩放转换。
transform: scale(2, 0.5);
transform: scale(.5); #  缩小一倍，如果只有一个参数，那么 x,y 轴上缩放的系数是一样的!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
transform: scale(2);  #  放大一倍
transform: scale(-.5, -1.5); # 设负数，负数会先将元素 垂直方向反转再缩放，当然可以用 rotate 实现反转更好

#  3D 缩放转换。
transform: scale3d(2.5, 1.2, 0.3);
transform: scaleX(x);          #  通过设置 X 轴的值来定义缩放转换。    transform: scaleX(2);
transform: scaleY(y);          #  通过设置 Y 轴的值来定义缩放转换。    transform: scaleY(0.5);
transform: scaleZ(z);          #  通过设置 Z 轴的值来定义 3D 缩放转换。transform: scaleZ(0.3);
```

### 3.4 transform: rotate(); 旋转 转换变形

#### 3.4.1 先来了解一下角度单位

![角度图](http://liuxmoo.foryung.com/4393631-ea6585a41b1bf230.png)

- deg
    deg =>  °  一共是 360°，也就是 360deg，
    围绕 X 轴，【上内】旋转是 正值
    围绕 Y 轴，【右内】旋转是 正值
    围绕 Z 轴，【顺时针】  是 正值
    `90deg = 100grad = 0.25turn ≈ 1.570796326794897rad`
- grad
    梯度（Gradians）。一个圆共400梯度
- rad
    弧度（Radians）。一个圆共 2π 弧度
- turn
    转、圈（Turns）。一个圆共1圈

#### 3.4.2 旋转属性简单使用

```BASH
#  2D 旋转
transform: rotate(0.5turn); # 顺时针半圈  
#  如果这个值为 【正值】，元素相对 【原点中心】【顺时针】旋转；
#  如果这个值为 【负值】，元素相对 【原点中心】【逆时针】旋转；
transform: rotate(30deg); # 顺时针 30°

#  3D 旋转
transform: rotate3d(x,y,z,angle);
# x y z 的取值为 0～1 为各轴的 旋转矢量值。angle 为 3D舞台上旋转的角度，正角度表示顺时针旋转，负角度表示逆时针旋转角度。
# 但是这个 0～1 的值也太难计算了吧？？？？？？？一般人会使用这个来做为  css 样式来打代码么？？？？？？？？？？？？？
transform: rotate3d(1, 2.0, 3.0, 10deg);

transform: rotateX(angle);         #  3D 旋转。沿着 X 轴的 3D 旋转。
transform: rotateX(10deg); # 沿着 X 轴 向上内转 10 deg
# 就是围绕着 通过元素原点中线的【水平线】旋转 angle 角度，转角为 90° 的话视图就看不见了

transform: rotateY(angle);         #  3D 旋转。沿着 Y 轴的 3D 旋转。
transform: rotateY(10deg); # 沿着 Y 轴向右内转 10 deg
# 就是围绕着 通过元素原点中线的【垂直线】旋转 angle 角度，转角为 90° 的话视图就看不见了

transform: rotateZ(angle);         #  3D 旋转。沿着 Z 轴的 3D 旋转。
transform: rotateZ(10deg); # 沿着 Z 轴顺时针 10deg
# 这个效果就是类似于 2D 旋转了，是围绕着 Z 轴来旋转的
```

![TU](https://upload-images.jianshu.io/upload_images/1959053-6fe9c379076f0baa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/338/format/webp)

```CSS
.x {
    transform: perspective(200px) rotateX(60deg);
}
.y {
    transform: perspective(200px) rotateY(60deg);
}
.z {
    transform: perspective(200px) rotateZ(60deg);
}
<img class="x" src="head75.png" />
<img class="y" src="head75.png" />
<img class="z" src="head75.png" />
```

### 3.5 transform: skew(); 倾斜 转换变形

```BASH
#   2D 倾斜。
transform: skew(30deg, 20deg);  #  2D 倾斜。沿着 X 和 Y 轴的 2D 倾斜转换。
#  相对于元素原点中心倾斜，如果只提供第一个参数，那么第二个参数就是 0 值。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#  第 1 个参数：上边和下边 与水平线 X 轴的夹角（顺时针方向的夹角）!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#  第 2 个参数：左边和右边 与垂直线 Y 轴的夹角（逆时针方向的夹角）!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
transform: skewX(angle);           #  2D 倾斜。沿着 X 轴的 2D 倾斜转换。水平方向倾斜。transform: skewX(30deg);
transform: skewY(angle);           #  2D 倾斜。沿着 Y 轴的 2D 倾斜转换。垂直方向倾斜。transform: skewY(1.07rad);
```

### 3.6 transform: perspective(length); 透视 转换变形

```BASH
# 3D 透视
transform: perspective(length);         #  3D 透视。
# 为 3D 转换元素定义透视视图。transform: perspective(17px);
```

### 3.7 transform 属性多个 变形函数

```BASH
transform: translateX(10px) rotate(10deg) translateY(5px);
#  变换函数按从 左到右 的顺序相乘，这意味着复合变换按从 右到左 ？？？？ 的顺序有效地应用。
```

## 四、使用的例子

### 4.1 简单的鼠标滑过缩放

```CSS
.wrapper {
  width: 200px;
  height: 200px;
  border:2px dashed red;
  margin: 100px auto;
}

.wrapper div {
  width: 200px;
  height: 200px;
  line-height: 200px;
  background: orange;
  text-align: center;
  color: #fff;
}

.wrapper div:hover {
  opacity: .5;
  -webkit-transform:scale(.8);
  -moz-transform:scale(.8);
  transform: scale(.8);
}

<div class="wrapper">
  <div>我将缩小0.8</div>
</div>

/* 鼠标滑过时 让容器状态缩小0.8。 */
```

### 4.2 简单旋转

```CSS
.wrapper {
  margin: 100px auto;
  width: 300px;
  height: 200px;
  border: 2px dotted blue;

  div{
    width: 300px;
    height: 200px;
    line-height: 200px;
    text-align: center;
    background: green;
    color: #fff;
    -webkit-transform: rotate(-20deg);
    -moz-transform: rotate(-20deg);
    transform:rotate(-20deg);

    span {
      display:block;
      -webkit-transform: rotate(20deg);
      -moz-transform: rotate(20deg);
      transform:rotate(20deg);
    }
  }
}
<div class="wrapper">
 <div><span>我不想旋转(^_^)</span></div>
</div>

/* 上面做的就是 div 逆时针旋转 20°，然后文本不旋转 */
```

### 4.3 简单的倾斜

```CSS
.wrapper {
  width: 300px;
  height: 100px;
  border: 2px dotted red;
  margin: 30px auto;
}

.wrapper div {
  width: 300px;
  height: 100px;
  line-height: 100px;
  text-align: center;
  color: #fff;
  background: orange;
  -webkit-transform:skew(45deg);/* 只有一个参数的话就是 X轴方向倾斜， Y 轴方向的值为 0 就是不发生倾斜 */
  -moz-transform:skew(45deg);
  transform:skew(45deg);
}

.wrapper span {
  display:block;
  -webkit-transform:skew(-45deg);
  -moz-transform:skew(-45deg);
  transform:skew(-45deg);
}

<div class="wrapper">
  <div><span>我不想被扭曲\倾斜(^_^)</span></div>
</div>

/* 图形扭曲，而文字不扭曲。使得一个 长方形 倾斜为 平行四边形 */
```