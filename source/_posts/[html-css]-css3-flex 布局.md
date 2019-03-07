---
title: 'CSS3 深入了解--[弹性盒子模型：display:flex]'
date: '2018/8/17 21:57:27'
tags:
  - flex
categories:
  - ① html-css
  - css
updated:
comments:
---
## 一、前言

网页布局（layout）是 CSS 的一个重点应用。

布局的传统解决方案，基于盒状模型，依赖 display 属性 + position 属性 + float 属性。它对于那些特殊布局非常不方便，比如，垂直居中就不容易实现。

2009年，W3C 提出了一种新的方案：Flex 布局，弹性盒子布局模式。CSS3 弹性盒（ Flexible Box 或 flexbox），是一种当页面需要适应不同的屏幕大小以及设备类型时确保元素拥有恰当的行为的布局方式。引入弹性盒布局模型的目的是提供一种更加有效的方式来对一个容器中的子元素进行排列、对齐和分配空白空间。 Flexible Box 的缩写，意为"弹性布局"，用来为盒状模型提供最大的灵活性。任何一个容器都可以指定为 Flex 布局。

## 二、属性学习

### 2.1 弹性容器 与 弹性子元素

弹性盒子由弹性容器 (Flex container) 和弹性子元素 (Flex item)  组成。
弹性容器通过设置 display 属性的值为 flex 或 inline-flex 将其定义为弹性容器。弹性容器内包含了一个或多个弹性子元素。

注意： 弹性容器外及弹性子元素内是正常渲染的。弹性盒子只定义了弹性子元素如何在弹性容器内布局(简单的说就是没有继承性别)。弹性子元素内的元素渲染可以将弹性子元素用 display 属性的值为 flex 或 inline-flex 将其定义为弹性容器也变成容器，其内部的就可以使用了。

弹性子元素通常在弹性盒子内一行显示。默认情况每个容器只有一行。

|属性|描述|用于|
|:----|:----|:----|
|display|指定 HTML 元素盒子类型。指定元素为容器|容器|
|flex-direction|指定了弹性容器中子元素的排列方式|容器|
|justify-content|设置弹性盒子元素在主轴（横轴）方向上的对齐方式。|容器|
|align-items|设置弹性盒子元素在侧轴（纵轴）方向上的对齐方式。|容器|
|flex-wrap|设置弹性盒子的子元素超出父容器时是否换行。|容器|
|align-content|修改 flex-wrap 属性的行为，类似 align-items, 但不是设置子元素对齐，而是设置行对齐|容器|
|flex-flow|flex-direction 和 flex-wrap 的简写|容器|
|order|设置弹性盒子的子元素排列顺序。|项目/子元素|
|align-self|在弹性子元素上使用。覆盖容器的 align-items 属性。|项目/子元素|
|flex|设置弹性盒子的子元素如何分配空间。|项目/子元素|

### 2.1 几个比较难以区分的属性。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!重点，重点，重点

```TEXT
justify-content:center;  子容器/项目/子元素文本框 在 父容器中的 水平对齐方式（一行）
align-items:    center;  子容器/项目/子元素文本框 在 父容器中的 垂直对齐方式（一行）
align-content:  cecnter; 子容器/项目/子元素文本框 在 父容器中的 垂直对齐方式（多行）
text-align:     center;  文本在文本框中的 水平对齐方式
vertical-align: middle;  文本在文本框中的 垂直对齐方式（但是只能是行内，table-cell等）
```

### 2.2 弹性容器(Flex container)

#### 2.2.1  display  让元素称为弹性容器

在容器这里，我们使用的 display 的值是 flex，或者 inline-flex 使其成为容器。

我们还可以了解一下 display 的其他值。

```bash
# none    隐藏对象。与visibility属性的hidden值不同，其不为被隐藏的对象保留其物理空间
# inline  指定对象为内联元素。
# block   指定对象为块元素。
# inline-block  指定对象为内联块元素。（CSS2）
# list-item     指定对象为列表项目。
# run-in  根据上下文决定对象是内联对象还是块级对象。（CSS3）
# table   指定对象作为块元素级的表格。类同于html标签`<table>`（CSS2）
# inline-table  指定对象作为内联元素级的表格。类同于html标签`<table>`（CSS2）
# table-caption 指定对象作为表格标题。类同于html标签`<caption>`（CSS2）
# table-cell    指定对象作为表格单元格。类同于html标签`<td>`（CSS2）
# table-row     指定对象作为表格行。类同于html标签`<tr>`（CSS2）
# table-row-group 指定对象作为表格行组。类同于html标签`<tbody>`（CSS2）
# table-column    指定对象作为表格列。类同于html标签`<col>`（CSS2）
# table-column-group  指定对象作为表格列组显示。类同于html标签`<colgroup>`（CSS2）
# table-header-group  指定对象作为表格标题组。类同于html标签`<thead>`（CSS2）
# table-footer-group  指定对象作为表格脚注组。类同于html标签`<tfoot>`（CSS2）
# flex          将对象作为弹性伸缩盒显示。（伸缩盒最新版本）（CSS3）
# inline-flex   将对象作为内联块级弹性伸缩盒显示。（伸缩盒最新版本）（CSS3）
```

以下是旧伸缩属性值，已经不使用了。
box：将对象作为弹性伸缩盒显示。（伸缩盒最老版本）（CSS3）
inline-box：将对象作为内联块级弹性伸缩盒显示。（伸缩盒最老版本）（CSS3）
flexbox：将对象作为弹性伸缩盒显示。（伸缩盒过渡版本）（CSS3）
inline-flexbox：将对象作为内联块级弹性伸缩盒显示。（伸缩盒过渡版本）（CSS3）

#### 2.2.2  flex-direction 子容器 在 父容器 排列方式

|值|描述|
|:----|:----|
|flex-direction:row|默认值。灵活的项目将水平显示，正如一个行一样。|
|flex-direction:row-reverse|与 row 相同，但是以相反的顺序。|
|flex-direction:column|灵活的项目将垂直显示，正如一个列一样。|
|flex-direction:column-reverse|与 column 相同，但是以相反的顺序。|
|flex-direction:initial|设置该属性为它的默认值。|
|flex-direction:inherit|从父元素继承该属性。|

```HTML
<div id="main">
  <div style="background-color:coral;">A</div>
  <div style="background-color:lightblue;">B</div>
  <div style="background-color:khaki;">C</div>
  <div style="background-color:pink;">D</div>
  <div style="background-color:lightgrey;">E</div>
  <div style="background-color:lightgreen;">F</div>
</div>
```

各个值效果图展示：
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://p1teq0wgy.bkt.clouddn.com/15555.png)
</div>
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://p1teq0wgy.bkt.clouddn.com/2555.png)
</div>
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://p1teq0wgy.bkt.clouddn.com/3555.png)
</div>
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://p1teq0wgy.bkt.clouddn.com/4555.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>

#### 2.2.3 justify-content  子容器 在 父容器 水平对齐方式

|值|描述|
|:----|:----|
|justify-content:flex-start|默认值。项目位于容器的开头|
|justify-content:flex-end|项目位于容器的结尾。|
|justify-content:center|项目位于容器的中心。|
|justify-content:space-between|项目位于各行之间留有空白的容器内。|
|justify-content:space-around|项目位于各行之前、之间、之后都留有空白的容器内。|

各个值效果图展示：
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://liuxmoo.foryung.com/20180911-1.png)
</div>
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://liuxmoo.foryung.com/20180911-2.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://liuxmoo.foryung.com/20180911-3.png)
</div>
<div style="width:40%; float:left;margin:5px 0;">
![效果图](http://liuxmoo.foryung.com/20180911-4.png)
</div>
<div style="clear:both;height:0;overflow:hidden;"></div>
![效果图](http://liuxmoo.foryung.com/20180911-5.png)

#### 2.2.4 align-items 子容器 在 父容器 垂直对齐方式

|值|描述|
|:----|:----|
|align-items:stretch|默认值。元素被拉伸以适应容器。如果指定侧轴大小的属性值为'auto'，则其值会使项目的边距盒的尺寸尽可能接近所在行的尺寸，但同时会遵照'min/max-width/height'属性的限制。|
|align-items:center|元素位于容器的中心。弹性盒子元素在该行的侧轴（纵轴）上居中放置。（如果该行的尺寸小于弹性盒子元素的尺寸，则会向两个方向溢出相同的长度）。|
|align-items:flex-start|元素位于容器的开头。弹性盒子元素的侧轴（纵轴）起始位置的边界紧靠住该行的侧轴起始边界。|
|align-items:flex-end|元素位于容器的结尾。弹性盒子元素的侧轴（纵轴）起始位置的边界紧靠住该行的侧轴结束边界。|
|align-items:baseline|元素位于容器的基线上。如弹性盒子元素的行内轴与侧轴为同一条，则该值与'flex-start'等效。其它情况下，该值将参与基线对齐。|

各个值效果图展示：
![效果图](http://liuxmoo.foryung.com/%E3%80%8212.png)
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911104539.png)
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911104738.png)

#### 2.2.5 flex-wrap 子容器 在 父容器 超出是否换行

|值|描述|
|:----|:----|
|flex-wrap:nowrap|默认值。规定灵活的项目不拆行或不拆列。|
|flex-wrap:wrap|规定灵活的项目在必要的时候拆行或拆列。|
|flex-wrap:wrap-reverse|规定灵活的项目在必要的时候拆行或拆列，但是以相反的顺序。|
|flex-wrap:initial|设置该属性为它的默认值。请参阅 initial。|

各个值效果图展示：
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911105254.png)
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911105505.png)

#### 2.2.6 flex-flow :flex-direction 和 flex-wrap 的简写

#### 2.2.7 多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用。

修改 flex-wrap 属性的行为，类似 align-items, 但不是设置子元素对齐，而是设置行对齐

|值|描述|
|:----|:----|
|flex-wrap:stretch元素被拉伸以适应容器。各行将会伸展以占用剩余的空间。如果剩余的空间是负数，该值等效于'flex-start'。在其它情况下，剩余空间被所有行平分，以扩大它们的侧轴尺寸。|
|flex-wrap:center|元素位于容器的中心。各行向弹性盒容器的中间位置堆叠。各行两两紧靠住同时在弹性盒容器中居中对齐，保持弹性盒容器的侧轴起始内容边界和第一行之间的距离与该容器的侧轴结束内容边界与第最后一行之间的距离相等。（如果剩下的空间是负数，则各行会向两个方向溢出的相等距离。）|
|flex-wrap:flex-start|元素位于容器的开头。各行向弹性盒容器的起始位置堆叠。弹性盒容器中第一行的侧轴起始边界紧靠住该弹性盒容器的侧轴起始边界，之后的每一行都紧靠住前面一行。
|flex-wrap:flex-end|元素位于容器的结尾。各行向弹性盒容器的结束位置堆叠。弹性盒容器中最后一行的侧轴起结束界紧靠住该弹性盒容器的侧轴结束边界，之后的每一行都紧靠住前面一行。|
|flex-wrap:space-between|元素位于各行之间留有空白的容器内。各行在弹性盒容器中平均分布。如果剩余的空间是负数或弹性盒容器中只有一行，该值等效于'flex-start'。在其它情况下，第一行的侧轴起始边界紧靠住弹性盒容器的侧轴起始内容边界，最后一行的侧轴结束边界紧靠住弹性盒容器的侧轴结束内容边界，剩余的行则按一定方式在弹性盒窗口中排列，以保持两两之间的空间相等。|
|flex-wrap:space-around|元素位于各行之前、之间、之后都留有空白的容器内。各行在弹性盒容器中平均分布，两端保留子元素与子元素之间间距大小的一半。如果剩余的空间是负数或弹性盒容器中只有一行，该值等效于'center'。在其它情况下，各行会按一定方式在弹性盒容器中排列，以保持两两之间的空间相等，同时第一行前面及最后一行后面的空间是其他空间的一半。|
|flex-wrap:initial|设置该属性为它的默认值。请参阅 initial。|

各个值效果图展示：
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911110725.png)
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911110832.png)
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911110842.png)

|order|设置弹性盒子的子元素排列顺序。||
|align-self|在弹性子元素上使用。覆盖容器的 align-items 属性。||
|flex|设置弹性盒子的子元素如何分配空间。||

### 2.2 弹性子元素(Flex item) ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！这个是子元素父元素中的重点 属性

#### 2.2.1  order 子容器 中子元素的排列顺序

order：项目的排列顺序。数值越小，排列越靠前，默认为0。可以为负数，负数值肯定是小的，在最前面。

```css
#main1 {
    width: 400px;
    height: 150px;
    border: 1px solid #c3c3c3;
    display: -webkit-flex; /* Safari */
    display: flex;
}
#main2 {
    width: 400px;
    height: 150px;
    border: 1px solid #c3c3c3;
    display: -webkit-flex; /* Safari */
    display: flex;
  flex-direction:row-reverse;
}
div#myRedDIV   {order: 2;}
div#myBlueDIV  {order: 4;}
div#myGreenDIV {order: 3;}
div#myPinkDIV  {order: 1;}
```

```HTML
<div id="main1">
  <div style="background-color:coral;" id="myRedDIV">order: 2</div>
  <div style="background-color:lightblue;" id="myBlueDIV">order: 4</div>
  <div style="background-color:lightgreen;" id="myGreenDIV">order: 3</div>
  <div style="background-color:pink;" id="myPinkDIV">order: 1</div>
</div>
<div id="main2">
  <div style="background-color:coral;" id="myRedDIV">order: 2</div>
  <div style="background-color:lightblue;" id="myBlueDIV">order: 4</div>
  <div style="background-color:lightgreen;" id="myGreenDIV">order: 3</div>
  <div style="background-color:pink;" id="myPinkDIV">order: 1</div>
</div>
```

各个值效果图展示：
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911113105.png)

#### 2.2.2  align-self 覆盖容器的 align-items 属性，允许单个项目有与其他项目不一样的对齐方式，默认值为auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch。该属性可能取6个值，除了auto，其他都与 align-items 属性完全一致。

各个值效果图展示：
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911113602.png)
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911113928.png)
![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20180911114024.png)

#### 2.2.3  flex 子容器 在 父容器 占据的比例大小 ！！！！！！！！！！！！！！！！！！！！！！！！1！！！！这个是子元素父元素中的重点 属性

[MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS/flex)

```bash
flex-grow  （放大比例）
    # 取  值：number 负值无效。
    # 定  义：规定项目将相对于其他灵活的项目进行扩展的量。其实就是每个子元素在容器中的空间占比。
    #        拉伸因子，定义项目的放大比例  
    # 默认值：默认为 0 ，即如果存在 【剩余空间】，也不放大。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # 举  例：如果所有子项目的 flex-grow 属性都为 1 ，则它们将 【等分剩余】空间（如果有的话）。
    #        如果一个项目的 flex-grow 属性为 2，其他项目都为 1 ，则前者占据的 【剩余空间】将比其他项多一倍。
- flex-shrink （缩小比例）
    # 取  值：number 负值无效。
    # 定  义：规定项目将相对于其他灵活的项目进行收缩的量。空间不足时子元素的缩小选项。
    #         缩小因子
    # 默认值：默认值 1 ,即如果空间不足，该项目将缩小。!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # 举  例：如果所有项目的 flex-shrink 属性都为 1，当空间不足时，都将等比例缩小。
    #         如果一个项目的 flex-shrink 属性为 0，其他项目都为 1，则空间不足时，前者不缩小。
- flex-basis   （基础，初始值）
    # 取  值：合法值："auto"、"inherit" 或一个后跟 "%"、"px"、"em" 或任何其他长度单位的数字。
    # 定  义：柔性项目的初始主长度。定义了在分配多余空间之前，项目占据的主轴空间（main size）。
    #         浏览器根据这个属性，计算主轴是否有多余空间。
    #         它可以设为跟 width 或 height 属性一样的值（比如 350px ），则项目将占据 【固定空间】。
    # 默认值：默认值 auto ,即项目的本来大小。
```

```JS
/* 缩写属性：flex: flex-grow、flex-shrink、flex-basis  默认值 `flex: 0 1 auto;` */
/*  flex 属性可以指定 1 个，2 个或 3 个值。 */

/* 1111 个值 */
flex: auto;  // 等价于 1 1 auto
flex: initial;// 等价于默认值 flex: 0 1 auto;
flex: none;  // 等价于 0 0 auto
flex: 2;// 指的是的拉伸值 flex-grow ，后面两个可选属性还是默认值  相当于 flex: 2 1 0%;
        // 为什么 flex-basis  是 0% 呢，因为当使用一个或两个无单位数时, flex-basis 会从 默认值 auto 变为 0
flex: 1;// 指的是的拉伸值 flex-grow ，后面两个可选属性还是默认值  相当于 flex: 1 1 0%;

flex: 10em;// 指的是的固定尺寸 flex-basis  等价于 1 1 10em ？？？？？？？？？？？？？？？？？？？？？？？
flex: 30px;// 指的是的固定尺寸 flex-basis  等价于 1 1 30px  ？？？？？？？？？？？？？？？？？？？？？？
flex: 50%;//  指的是的固定尺寸 flex-basis  等价于 1 1 50%  ？？？？？？？？？？？？？？？？？？？？、？

flex: inherit;//继承父元素
flex: initial;//初始值，默认值 flex: 0 1 auto;
flex: unset;//  未设置

/* 2222 个值 */
flex: 2 30px;// 指的是 flex-grow | flex-basis  等价于 flex:2 1 30px;
             //就是 拉伸因子 与 固定值【第二个值不能省略单位，否则就变成 flex-shrink 了】
            // 默认的 flex-shrink  会变成 1 ？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
flex: 2 2; // flex-grow | flex-shrink         等价于 flex:2 2 0%;
          // 为什么 flex-basis  是 0% 呢，因为当使用一个或两个无单位数时, flex-basis 会从 默认值 auto 变为 0

/* 3333 个值 */
flex: 2 2 10%;//flex-grow、flex-shrink、flex-basis
```

flex-basis 规定的是子元素的基准值。所以是否溢出的计算与此属性息息相关。flex-basis 规定的范围取决于 box-sizing。这里主要讨论以下 flex-basis 的取值情况：

- auto：首先检索该子元素的主尺寸，如果主尺寸不为 auto，则使用值采取主尺寸之值；如果也是 auto，则使用值为 content。
- content：指根据该子元素的内容自动布局。有的用户代理没有实现取 content 值，等效的替代方案是 flex-basis 和主尺寸都取 auto。
- 百分比：根据其包含块（即伸缩父容器）的主尺寸计算。如果包含块的主尺寸未定义（即父容器的主尺寸取决于子元素），则计算结果和设为 auto 一样。

[segmentfault](https://segmentfault.com/q/1010000004080910/a-1020000004121373)

## 三、兼容问题

### 3.1 块状元素 flex 布局

```CSS
.box{
  display: flex;
}
```

### 3.2 行内元素也可以使用 Flex 布局。

```CSS
.box{
  display: inline-flex;
}
```

Webkit 内核的浏览器，必须加上-webkit前缀。

```CSS
.box{
  display: -webkit-flex; /* Safari */
  display: flex;
}
```

## 四、bug 或者 特别注意

**注意，设为 Flex 布局以后，子元素的 float、clear 和 vertical-align 属性将失效。**


容器默认存在两根轴：水平的主轴（main axis）和垂直的交叉轴（cross axis）。主轴的开始位置（与边框的交叉点）叫做 main start，结束位置叫做 main end；交叉轴的开始位置叫做 cross start，结束位置叫做 cross end。

项目默认沿主轴排列。单个项目占据的主轴空间叫做 main size，占据的交叉轴空间叫做 cross size。

![R](http://liuxmoo.foryung.com/bg2015071004.png)

## 五、使用 felx 以及 calc 计算公式布局。

### 5.1 css 中 felx 与 calc 公式

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
  <style>
    body{
      padding: 0;
      margin: 0;
    }
    .head{
      height: 50px;
      background: firebrick;
    }
    .content{
      display: flex;
      width: 100%;
      background: blue;
      height: calc(100vh - 100px);
    }
    .left{
      width: 240px;
      background: red;
      height: 100%;
    }
    .right{
      width: calc(100vw - 240px);
      background: yellow;
      height: 100%;
      overflow:auto; //这里是auto，是hidden的话就不对的!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111
      .main{
        height:1500px;
        background: red;
      }
    }
    .footer{
      height: 50px;
      background: teal;
    }
  </style>
</head>
<body>
  <div class="head">head</div>
  <div class="content">
    <div class="left">left</div>
    <div class="right">
      <div class="main">
        11
      </div>
    </div>
  </div>
  <div class="footer">footer</div>
</body>
</html>
```

以上代码的效果图如下

![TU](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181001150254.png)

### 5.2 less 中 calc 公式使用

less 中 calc 公式使用：[网址](https://liuxmoo.com/2018/09/30/20.2-less-calc/)