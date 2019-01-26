---
title: CSS3 深入了解--[background 属性的全面使用]
date: 2018/8/18 21:57:28
categories:
  - ① html-css
  - css
updated:
tags:
comments:
---

## 一、前言

CSS3中包含几个新的背景属性，提供更大背景元素控制。

## 二、background

background是一个简写属性，可以在一个声明中设置所有的背景属性，可设置的属性如下：
[效果图参考网址](https://www.jianshu.com/p/7102ab9ae08c)

```BASH
background-color    #指定要使用的背景颜色|1|（填充：内边距区域 padding 和边框区域 border，border 也可以自己再设置颜色）
    transparent # 透明，默认值!!!!!!!!!!!
    named_color #颜色名称，如 red；
    hex_number  #十六进制颜色，如 #fff000；
    rgb()       #rgb代码颜色，如 rgb(0,255,255)；
    rgba()      # 同 hex_number，可是设置透明度，取值0-1，如rgba(0,255,255,.5)；
    hsl()       # 设置色调（0-360）、饱和度（0.0-100.0%）和亮度（0.0-100.0%）；
    hsla()      # 同 rgba() ，可以设置透明值，取值0-1；
    inherit     # 规定应该从父元素继承 background-color 属性的设置。
    currentColor # 规定为 color 属性的颜色值
background-image #指定要使用的一个或多个背景图像|1|
    url('URL') # 图像的 URL #这个加不上上引号呢，是个问题，不加上引号也正确，但是有的浏览器比如说老ie不会兼容,所以还是加吧，不要偷懒。
    none      # 无图像背景会显示。这是默认
    inherit   # 指定背景图像应该从父元素继承
background-position #指定背景图像的位置|1|
    left   top    #只写前面一个值，那么第二个值默认为 "center"
    left   center #只写前面一个值，那么第二个值默认为 "center"
    left   bottom #只写前面一个值，那么第二个值默认为 "center"
    right  top    #只写前面一个值，那么第二个值默认为 "center"
    right  center #只写前面一个值，那么第二个值默认为 "center"
    right  bottom #只写前面一个值，那么第二个值默认为 "center"
    center top    #只写前面一个值，那么第二个值默认为 "center"
    center center #只写前面一个值，那么第二个值默认为 "center"
    center bottom #只写前面一个值，那么第二个值默认为 "center"
    x%    y%  # 第一个值是水平位置，第二个值是垂直。左上角是0％0％ 右下角是100％100％ 中间 50% 50%，
              #如果仅指定了一个值，其他值将是50％。 。默认值为：0％0％
    xpos ypos #第一个值是水平位置，第二个值是垂直。左上角是0。单位可以是像素（0px0px）或任何其他 CSS单位。
              # 如果仅指定了一个值，其他值将是50％。你可以混合使用％和positions
    inherit  # 指定 background-position 属性设置应该从父元素继承
    # CSS3 之后，这个属性的值有 4 个值。
    right 50px bottom 50px # 第二 第四个为相对 偏移量
background-size     #指定背景图片的大小|3|
    px  px # 设置背景图片高度和宽度。第一个值设置宽度，第二个值设置的高度。如果只给出一个值，第二个是设置为 auto(自动)
    %   %  # 将计算相对于背景定位区域的百分比。第一个值设置宽度，第二个值设置的高度。如果只给出一个值，第二个是设置为"auto(自动)"
           # 50% 50% 占据整个容器的 1/4
    cover  # 此时会保持图像的纵横比 并 将图像缩放成将完全覆盖背景定位区域的最小大小。（所有的区域都被覆盖了，背景图像有可能超出容器）
    contain #此时会保持图像的纵横比并将图像缩放成将适合背景定位区域的最大大小。（有的区域可能会没有覆到，背景图像始终被包含在容器内。）
background-repeat   #指定如何重复背景图像|1|
    repeat    # 背景图像将向垂直和水平方向重复。这是默认值!!!!!!!!!!!!!!
    repeat-x  # 只有水平位置会重复背景图像
    repeat-y  # 只有垂直位置会重复背景图像
    no-repeat # background-image不会重复
    inherit   # 指定background-repea属性设置应该从父元素继承
    round     # 背景图像自动缩放直到适应且填充满整个容器。（CSS3）
    space    # 背景图像以相同的间距平铺且填充满整个容器或某个方向。（CSS3）
              # round和space两个属性值在浏览器的支持和表现情况不太一样，不做探讨。
background-origin   #指定背景图像的定位区域|3|
    padding-box # 背景图像填充框的相对位置 (从 padding 区域[含 padding]开始显示背景图像) 默认值？？？？？？
    border-box  # 背景图像边界框的相对位置 (从 border 区域[含 border]开始显示背景图像)
    content-box # 背景图像的相对位置的内容框(从 content 区域开始显示背景图像)
                # js 写法 object.style.backgroundOrigin="content-box""
background-clip     #指定背景图像的绘画区域|3|
    border-box  # 从border区域（不含border）开始向外裁剪背景。默认值!!!!!!!!!!!!!!!!!!!!!!!
    padding-box # 从padding区域（不含padding）开始向外裁剪背景。
    content-box # 从content区域开始向外裁剪背景。
    text        # 从前景内容的形状（比如文字）作为裁剪区域向外裁剪，如此即可实现使用背景作为填充色之类的遮罩效果。
background-attachment #设置背景图像是否固定或者随着页面的其余部分滚动。|1|
    scroll     # 背景图片随页面的其余部分滚动。这是默认值!!!!!!!!!!!!!!!!!!!!!!!!
               # 背景图像相对于元素固定，也就是说当元素内容滚动时背景图像不会跟着滚动，因为背景图像总是要跟着元素本身。但会随元素的祖先元素或窗体一起滚动
    fixed      # 背景图像相对于窗体固定
    local      # 背景图像相对于元素内容固定，也就是说当元素随元素滚动时背景图像也会跟着滚动，因为背景图像总是要跟着内容。（CSS3）
    inherit    # 指定background-attachment的设置应该从父元素继承
```

语法:background:bg-color bg-image position/bg-size bg-repeat bg-origin bg-clip bg-attachment initial|inherit;

注意点：

- 以上的属性顺序是没有要求的。
- position/bg-size 同时设置的话，要这样写一个斜杠，如果单位相同，如果只设置一个值，表示的是 position 设置，没有 size
- bg-origin bg-clip 同时设置，这个不需要斜杠     ，他们的值一样的，如果设置一个值，表示的是 origin 设置，没有 clip
- 但是大致习惯上说应该有个顺序。就是上面的语法的顺序，因为大家普遍是这样的，要方便大家的习惯。
    **background: red url('#') left 10px top 10px/cover no-repeat border-box border-box fixed;**!!!!!!!!!!!!!!!!!!!!!!!!!!!
- 以上属性是可选的，不必要全写
    **background:#FF0000 URL('smiley.gif');** 是允许的。

### 背景属性可以设置多组值

```CSS
background: url("image.png") 0% 0%/60px 60px no-repeat padding-box,
            url("image.png") 40px 10px/110px 110px no-repeat content-box,
            #58a url("image.png") 140px 40px/200px 100px no-repeat content-box;
```

```CSS
/* 可以设置多个背景，然后固定模式也是一一对应的 */
background-image: url("https://mdn.mozillademos.org/files/12057/starsolid.gif"),url("https://mdn.mozillademos.org/files/12059/startransparent.gif");
background-attachment: fixed, scroll;
```

注意点：

- 有背景颜色的组 只有有一个，并且只能放在最后。
- 如设置的多组属性背景图像之间存在重叠, 则前面的背景图像会覆盖在后面的背景图像上。

![tu](https://camo.githubusercontent.com/67d9adf8311881e921e2dbe40e4fbfeea05f9193/687474703a2f2f696d672e6d756b6577616e672e636f6d2f3538393938316361303030313331316630353037303231312e706e67)

## 三 background-blend-mode 属性定义了背景层的混合模式（图片与颜色）。[这个属性不在简写属性background里面]

|值|描述|
|:----|:----|
|normal|默认值。设置正常的混合模式。|
|multiply|正片叠底模式。|
|screen|滤色模式。|
|overlay|叠加模式。|
|darken|变暗模式。|
|lighten|变亮模式。|
|color-dodge|颜色减淡模式。|
|saturation|饱和度模式。|
|color|颜色模式。|
|luminosity|亮度模式。|
