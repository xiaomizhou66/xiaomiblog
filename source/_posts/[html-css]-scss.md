---
title: scss 入门
date: '2018/8/18 21:57:28'
categories:
  - ① html-css
  - scss
updated:
tags:
comments:
---

## 一、前言

CSS预处理器：
  定义了一种新的专门的编程语言，编译后成正常的CSS文件。为CSS增加一些编程的特性，无需考虑浏览器的兼容问题，让CSS更加简洁，适应性更强，可读性更佳，更易于代码的维护等诸多好处。

有less，scss（sass） 等。

[scss 中文网](https://www.sasscss.com/docs/)

## 二、sass 基本了解

通常说 sass 的时候，是包括 scss 的。scss 是 sass 的其一。

### 2.1 sass 定义

Sass 是一个 CSS 的扩展，它在 CSS 语法的基础上，允许您使用变量 (variables), 嵌套规则 (nested rules), 混合 (mixins), 导入 (inline imports) 等功能，令 CSS 更加强大与优雅。使用 Sass 以及 Compass 样式库 有助于更好地组织管理样式文件，以及更高效地开发项目。

### 2.2 特色 (Features)

- 完全兼容 CSS3
- 在 CSS 语言的基础上增加变量(variables)、嵌套 (nesting)、混合 (mixins) 等功能
- 通过函数进行颜色值与属性值的运算
- 提供 控制指令等高级功能
- 自定义输出格式

### 2.3 sass 语法（现在用的的 scss 就对了）

#### 2.3.1 scss 写法（Sass 有两种语法格式 sass 与 scss）

首先是 SCSS (Sassy CSS) ,也是本参考资料示例所使用的格式 , 这种格式仅在 CSS3 语法的基础上进行扩展，这意味着每个CSS样式表是一个同等的SCSS文件。此外，SCSS 也支持大多数 CSS hacks 写法 以及浏览器专属前缀语法 (vendor-specific syntax)，例如，IE 古老的 filter 语法。 这种语法的样式表文件需要以 .scss 作为拓展名。

#### 2.3.2 sass 写法（Sass 有两种语法格式 sass 与 scss）

最早的语法，被称为缩进语法 (Indented Sass)，或者通常说的 "Sass"，它提供了一种更加简介的方式来书写CSS。它使用缩进而不是花括号来表示选择器的嵌套，用换行而不是分号来分隔属性，一些人认为这样做比 SCSS 更容易阅读，书写也更快速。 缩排语法具有 Sass 的所有特色功能， 虽然有些语法上稍有差异； 具体差异在缩进语法参考中都有描述。 使用此种语法的样式表文件需要以 .sass 作为扩展名。

#### 2.3.3 Sass 和 SCSS 的区别

- 文件扩展名不同：“.sass” 和 “.scss”；
- Sass 是以严格缩进式语法规则来书写的，不带大括号和分号；
  而 SCSS 的语法和 CSS 书写语法类似。**scss 更符合我们的习惯**

#### 2.3.4 两种格式的文件可以互相导入引用

任何一种语法的文件可以直接 import(导入) 到另一种语法的文件中使用，只要使用 sass-convert 命令行工具，就可以将一种语法转换为另一种语法：

```BASH
#Convert Sass to SCSS
$ sass-convert style.sass style.scss
```

```BASH
# Convert SCSS to Sass
$ sass-convert style.scss style.ss # ????这个就是 .ss ？？？错了吧？？？
```

但是请注意，此命令 不会 生成CSS文件。要想生成CSS文件，请使用其他地方描述的 sass 命令。

## 三、sass 的安装引用

### 3.1 在 vue.js 项目使用 scss

```BASH
# 在 vue 项目中使用 scss
$ npm install sass-loader node-sass --save-dev
$ yarn add sass-loader node-sass # yarn 的好处
```

不需要配置了，可以直接使用 vue-loader 已经帮忙配置好了的。

```HTML
<style scoped lang="sass">
      xxxx
      xxxx
</style>
```

### 3.2 在 react.js 项目使用 scss

这个链接的方法不知道是否正确，没有试过[Y](https://segmentfault.com/a/1190000014910538)

```BASH
# 在 react.js 项目中使用 scss
$ npm install sass-loader node-sass --save-dev # 安装 scss ？？？？？不对
$ yarn add sass-loader node-sass # yarn 的好处，怎么群里有人说 node-sass 需要翻墙，不要使用 yarn 不靠谱？？？？好晕
# 配置？？？好像又不需要了呀？？？？？
# 运行
$ npm run eject   # 会生成一个 config 文件夹，其实相当于 复制 node_module 中的文件夹，不直接修改 node_module 文件夹避免错误
$ yarn eject  # 用 yarn 来运行
# config 文件夹中的文件配置
```

#### 3.2.1 eject 注意的问题

create-react-app 默认是没有暴露 webpack 配置的，所以需要 eject 一下。

**注意如果项目在 git 仓库环境下，先提交代码到 git 仓库，否则会报错** 不过什么是 git 仓库环境？？？？？？

```BASH
λ npm run eject
> hello-world@0.1.0 eject F:\qianduan_dir\00program\react.js\hello-world
> react-scripts eject
? Are you sure you want to eject? This action is permanent. No
Close one! Eject aborted.
F:\qianduan_dir\00program\react.js\hello-world (master -> origin)
λ npm run eject
> hello-world@0.1.0 eject F:\qianduan_dir\00program\react.js\hello-world
> react-scripts eject
? Are you sure you want to eject? This action is permanent. Yes
This git repository has untracked files or uncommitted changes:
src/App.js
M yarn.lock
Remove untracked files, stash or commit any changes, and try again.
npm ERR! code ELIFECYCLE
npm ERR! errno 1
npm ERR! hello-world@0.1.0 eject: `react-scripts eject`
npm ERR! Exit status 1
npm ERR!
npm ERR! Failed at the hello-world@0.1.0 eject script.
npm ERR! This is probably not a problem with npm. There is likely additional logging output above.
npm ERR! A complete log of this run can be found in:
npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-12-24T03_53_46_605Z-debug.log
```

#### 3.2.2 config 文件配置

官方 create-react-app 脚手架，原生并不支持 sass，所以需要额外配置。[可以参看链接](https://juejin.im/post/5b5d5c5bf265da0f8e19f99b)

**webpack.config.dev.js**: 开发环境 yarn start / npm start 使用

**webpack.config.prod.js**:开发环境 npm run build / yarn build 使用

## 四、CSS 拓展

### 4.1 选择器 嵌套

Sass 允许将一个 CSS 样式嵌套进另一个样式中，内层样式仅适用于外层样式的选择器范围内,这有助于避免父选择器重复，相对于复杂的CSS布局中多层嵌套的选择器 要简单得多。

#### 4.1.1 后代选择器的嵌套

```SCSS
/* scss 语法 */
#main p {
  color: #00ff00;
  width: 97%;

  .redbox {
    background-color: #ff0000;
    color: #000000;
  }
}

/* 编译后对应的 css */
#main p {
  color: #00ff00;
  width: 97%;
}
#main p .redbox {
  background-color: #ff0000;
  color: #000000;
}
```

```CSS
/* scss 语法 */
#main {
  width: 97%;
  p, div {
    font-size: 2em;
    a { font-weight: bold; }
  }
  pre { font-size: 3em; }
}

/* 编译后对应的 css */
#main {
  width: 97%;
}
#main p, #main div {
  font-size: 2em;
}
#main p a, #main div a {
  font-weight: bold;
}
#main pre {
  font-size: 3em;
}
```

#### 4.1.2 嵌套引用 父选择器 &  以及伪类嵌套

有些时候需要直接使用嵌套外层的父选择器，这个就很有用了，例如，你可能喜欢给选择器指定 hover 样式，或者当 body 元素具有某个样式时，在这些情况下，你可以 & 字符来明确地表示插入指定父选择器。 例如：

```CSS
/* scss 语法 */
a {
  font-weight: bold;
  text-decoration: none;
  &:hover { text-decoration: underline; }
  body.firefox & { font-weight: normal; }
}

/* 编译后对应的 css */
a {
  font-weight: bold;
  text-decoration: none;
}
a:hover {
  text-decoration: underline;
}
body.firefox a {
  font-weight: normal;
}
```

```CSS
/* & 将替换为呈现在 CSS 文件中的父选择器。
这意味着，如果你有一个多层嵌套的规则，父选择器将在被 & 替换之前完全分解。 例如： */

/* scss 语法 */
#main {
  color: black;
  a {
    font-weight: bold;
    &:hover { color: red; }
  }
}

/* 编译后对应的 css */
#main {
  color: black;
}
#main a {
  font-weight: bold;
}
#main a:hover {
  color: red;
}
```

```CSS
/* & 必须出现在的选择器的开头位置（也就是作为选择器的第一个字符），父选择器 & 被作为一个后缀的时候，Sass 将抛出一个错误。
但可以跟随后缀，将被添加到父选择的后面。 */
/* scss 语法 */
#main {
  color: black;
  &-sidebar { border: 1px solid; }
}

/* 编译后对应的 css */
#main {
  color: black;
}
#main-sidebar {
  border: 1px solid;
}
```

### 4.2 属性 嵌套(有相同的属性前缀)

CSS 中有一些属性遵循相同的 “命名空间”；比如，font-family, font-size, 和 font-weight 都在 font 命名空间中。

在 CSS 中，如果你想在同一个命名空间中设置一串属性，你必须每次都输出来。Sass 为此提供了一个快捷方式：只需要输入一次命名空间，然后在其内部嵌套子属性。例如：

```CSS
/* scss 语法 */
.funky {
  font: {
    family: fantasy;
    size: 30em;
    weight: bold;
  }
}

/* 编译后对应的 css */
.funky {
  font-family: fantasy;
  font-size: 30em;
  font-weight: bold;
}
```

```CSS
/* 命名空间也可以有自己的属性值。 */
/* scss 语法 */
.funky {
  font: 20px/24px fantasy {
    weight: bold;
  }
}

/* 编译后对应的 css */
.funky {
  font: 20px/24px fantasy;
    font-weight: bold;
}
```

### 4.3 伪类 嵌套

```CSS
/* scss: */
.clearfix{
  &:before,
  &:after {
      content:"";
      display: table;
    }
  &:after {
    clear:both;
    overflow: hidden;
  }
}

/* css: */
clearfix:before, .clearfix:after {
  content: "";
  display: table;
}
.clearfix:after {
  clear: both;
  overflow: hidden;
}
```

### 4.4 scss 继承

在 sass 中的继承，可以继承类样式块中所有样式代码，而且编译出来的 css 会将选择器合并在一起，形成组合选择器。

```CSS
.btn {
  border: 1px solid #ccc;
  padding: 6px 10px;
  font-size: 14px;
}
.btn-primary {
  background-color: #f36;
  color: #fff;
  @extend .btn;
}

/* CSS */
.btn, .btn-primary {
  border: 1px solid #ccc;
  padding: 6px 10px;
  font-size: 14px;
 }
.btn-primary {
  background-color: #f36;
  color: #fff;
}
```

### 4.5 占位符选择器 % (需要调用 `@extend` 达到编译)

Sass 支持一种特殊类型的选择器 `%` ,叫做"占位符选择器" (placeholder selector)。
用占位符声明的代码，如果不被 `@extend` 调用就不会被编译。

通过 @extend 调用的占位符，编译出来的代码会将相同的代码合并在一起，代码变得十分简洁。

```CSS
%mt5 {
  margin-top: 5px;
}
%pt5{
  padding-top: 5px;
}
.btn {
  color:red;
}

/* CSS */
.btn {
    color:red;
}/* % 占位符声明的代码没有被编译产生 css 代码 */
```

```CSS
%mt5 {
  margin-top: 5px;
}
%pt5{
  padding-top: 5px;
}
.btn {
  @extend %mt5;/* 使用@extend调用占位符代码 */
  @extend %pt5;
}
.block {
  @extend %mt5;
  span {
    @extend %pt5;
  }
}

/* CSS */
.btn, .block {
  margin-top: 5px;
}
.btn, .block span {
  padding-top: 5px;
}
```

## 五、 注释: /* */ 和 //

Sass 支持标准的CSS多行注释以 /* */ 以及单行注释 //。
在尽可能的情况下，多行注释会被保留在输出的 CSS 中，而单行注释会被删除。

- `/*注释内容*/`:会在编译出来的 css 文件中显示
- `//注释内容`  :不会在编译出来的 css 文件中显示

```CSS
//定义一个占位符
%mt5 {
  margin-top: 5px;
}
/*调用一个占位符*/
.box {
  @extend %mt5;
}
```

编译出来的css：

```CSS
.box {
  margin-top: 5px;
}
/*调用一个占位符*/
```

可以看到上面的例子中，单行注释的文本在 编译得到的 css 文件中不存在了。而多行注释存在。

```CSS
/* This comment is
 * several lines long.
 * since it uses the CSS comment syntax,
 * it will appear in the CSS output. */
body { color: black; }

// These comments are only one line long each.
// They won't appear in the CSS output,
// since they use the single-line comment syntax.
a { color: green; }


/* 编译为： */
/* This comment is
 * several lines long.
 * since it uses the CSS comment syntax,
 * it will appear in the CSS output. */
body {
  color: black;
}
a {
  color: green;
}
```

如果多行注释的第一个字母是 !，那么注释总是会被保留到输出的 CSS 中，即使在压缩输出模式下。这可用于在你生成的 CSS 中添加版权声明。

使用插值语句 (interpolation) ，可以将变量值输出到多行注释中，例如：

```CSS
$version: "1.2.3";
    /* This CSS is generated by My Snazzy Framework version #{$version}. */

/* 编译为： */
/* This CSS is generated by My Snazzy Framework version 1.2.3. */
```

## 六、变量

### 6.1 变量声明

语法：$+变量名+：+变量值；

```CSS
$width:200px;
```

使用 SassScript 最直截了当的方法是使用变量。变量以美元符号开始，赋值像设置 CSS 属性那样：

```SCSS
/* scss */
$width: 5em;
#main {
  width: $width;
}
```

### 6.2 普通变量 与 默认变量

- 普通变量声明后可以在全局范围内使用；
- 默认变量仅需在值后面加上!default 即可；
- 默认变量一般是用来设置默认值，然后根据需求来覆盖的，覆盖的方式是在默认变量之前重新声明下变量即可。
  默认变量的价值在进行组件化开发的时候会非常有用。

```CSS
/* SCSS */
$baseLineHeight: 2;
$baseLineHeight: 1.5 !default;
body {
       line-height: $baseLineHeight;
}

/* 编译后的CSS代码： */
body {
  line-height:2;
}
```

变量默认 !default （Variable Defaults: !default）

如果分配给变量的值后面添加了 `!default` 标志 ，这意味着该变量如果已经赋值，那么它不会被重新赋值，但是，如果它尚未赋值，那么它会被赋予新的给定值。

例如:

```CSS
$content: "First content";
    $content: "Second content?" !default;
$new_content: "First time reference" !default;

#main {
  content: $content;
      new-content: $new_content;
}
/* 编译为 CSS*/

#main {
  content: "First content";
  new-content: "First time reference";
}
```

```CSS
/* 通过!default赋值的时候，如果变量是 null 值时，将视为未赋值（愚人码头注：所以下面的$content值为 "Non-null content"）： */
$content: null;
    $content: "Non-null content" !default;
#main {
  content: $content;
}

/* 编译为： CSS*/
#main {
  content: "Non-null content";
}
```

### 6.3 局部变量 与 全局变量

- 局部变量：在元素里面声明的变量；
- 全局变量：在元素外面定义的变量；
- 全局变量的影子：和全局变量名字相同的局部变量叫做全局变量的影子。

```CSS
$color:green;/* 全局变量 */
$width:200px;/* 全局变量 */
$height:200px;/* 全局变量 */
body {
    background-color:$color;/* 调用全局变量 */
}
div {
  $color:yellow;/*定义局部变量，全局变量 $color 的影子 */
  .div {
  background-color:$color;/* 调用局部变量 */
  width:$width;/* 调用全局变量 */
  height:$height;/* 调用全局变量 */
  }
}
```

变量仅在它定义的选择器嵌套层级的范围内可用（可以理解为块级作用域）。

不在任何嵌套选择器内定义的变量则在可任何地方使用（可以理解为全局变量）。
定义变量的时候可以后面带上 `!global` 标志，在这种情况下，变量在任何地方可见（可以理解为全局变量，也可以叫做所用于的提升吧)

```SCSS
/* scss */
#main {
  $width: 5em !global;// 在 #main 中定义的变量，在 #sidebar 希望使用的话就 使用 !global 标志。
    width: $width;
}
#sidebar {
  width: $width;
}

/* css */
#main {
  width: 5em;
}
#sidebar {
  width: 5em;
}
```

```CSS
/* 使用scss代码： */
$font-stack: Helvetica, sans-serif;
  $primary-color: #333;
  body {
    font: 100% $font-stack;
    color: $primary-color;
}

/* css代码： */
body {
  font: 100% Helvetica, sans-serif;
  color: #333;
}
```

### 6.4 变量中 连字符 与 下划线 没有区分

由于历史原因，变量名（以及其他所有 `Sass` 标识符）可以互换连字符 `-` 和下划线 `_` ,例如，如果你定义了一个名为 `$main-width`，您可以使用 `$main_width` 访问它，反之亦然。简单来说就是说，**sass 中定义的变量 连字符 与 下划线 没有区分**

```CSS
$main-width:20px;/* 等价于 */
$main_width:20px;
```

## 七、数据类型 与 对应的运算

### 7.1 数据类型 分类

SassScript 支持 7 种主要的数据类型：

- 数字 (例如： 1.2, 13, 10px)
- 文本字符串，带引号字符串和不带引号字符串(例如："foo", 'bar', baz)
- 颜色 (例如：blue, #04a3f9, rgba(255, 0, 0, 0.5))
- 布尔值 (例如： true, false)
- 空值 (例如： null)
- 值列表 (list)，用空格或逗号分隔 (例如： 1.5em 1em 0 2em, Helvetica, Arial, sans-serif)
- maps ，从一个值映射到另一个 (例如： (key1: value1, key2: value2))

SassScript 也支持其他所有类型的 CSS 属性值，比如 Unicode 字符集，或 !important 声明。然而，不会对这些类型的属性值做特殊处理，一律视为不带引号的字符串。

**所有数据类型的支持相等运算 (== 和 !=)。此外，每种类型都有其自己特殊的运算方式。**

### 7.2 数字/数值 运算

1.2, 13, 10px 等成为数字/数值

- ① 加法 +
- ② 减法 -
- ③ 乘法 *
- ④ 除法 /
- ⑤ 取模 %
- ⑥ 关系运算符(<, >, <=, >=)
- ⑦ 相等运算符(==, !=)

#### 7.2.1 数值做 加减法（数值之间的单位需要一致，否则报错）

Sass 数学函数在算术运算期间会保留单位。**意味着不同单位的数值之间是不能相互运算的**，会报错。

注意 + - 运算符的前后都要加上空格符。

```CSS
.box {
  width: 20px + 8in;  /* in 是什么鬼单位，为什么这个又不报错 */
  height:20px - 5px;
  width: ((220px + 720px) - 11 * 20 ) / 12 ; /* 下面混合计算中，这个为什么没错，只有一个有单位的话不错？？？ */
}

/* 编译出来的css： */
.box {
  width: 788px;
  height:25px;
}
```

```CSS
.box {
  width: 20px + 1em;/* 不同类型单位不能做加法,文件报错 */
}
```

```CSS
$content-width: 720px;
$sidebar-width: 220px;
$gutter: 20px;
.container {
  width: $content-width + $sidebar-width + $gutter;
}
/* 编译出来的css： */
.container {
  width: 960px;
}
```

#### 7.2.2 数值做 乘法 （只能有一个数值有单位，两个都有单位就会做平方 报错）

两个单位相同的数字相乘将产生单位平方，`px * px` 是无效的 CSS 单位，Sass 会抛出一个错误，因为你试图在 CSS 中使用无效的单位。

```CSS
.box {
  width: 10px * 2;
}

/* 编译出来的css： */
.box {
  width: 20px;
}
```

```CSS
.box {
  width:10px * 2px;  /* 报错,只能有一个有单位 */
}
.box {
  width:10px * 2em;  /* 报错，只能有一个有单位，并且两个数值的单位不一致都不能运算的 */
}
```

#### 7.2.3 数值做 除法（注意的问题点很多）

如果除式中 **没有变量** 或者 **不是在一个数学表达式**中（有 加法减法 等），就要将除式运算用 **小括号括起来**，**否则 “/”不会被当做除号运算。**

```CSS
p {
  font: 10px/8px;               /* 原生 CSS，不是除法运算 */
  $width: 1000px;
  width: $width/2;              /* 使用了变量，是除法运算 */
  width: round(1.5)/2;          /* 使用了函数, 作为除法 */
  height: (500px/2);            /* 使用了括号, 作为除法 */
  margin-left: 5px + 8px/2px;   /* 使用了 +, 作为除法 */
  font: (italic bold 10px/8px); /* 在一个列表（list）中，括号可以被忽略。 */
}
/* 编译为： */
p {
  font: 10px/8px; /* 这种是无意义的css */
  width: 500px;
  height: 250px;
  margin-left: 9px;
}
```

```CSS
/* 除法中相同单位相除不会报错，会产生一个无单位的值： */
.box {
  width: (1000px / 100px);
}
/* 编译为： */
.box {
  width: 10;
}
```

#### 7.2.8 加减乘除混合运算

```CSS
.box {
  width: ((220px + 720px) - 11 * 20 ) / 12 ;  
}

/* CSS */
.box {
  width: 60px;
}
```

#### 7.2.9 数值变量 插值运算： #{} 运算

纯 CSS 的/ 和变量一起使用（即/不作为除法使用），你可以使用 #{} 插入他们。

```CSS
p {
  $font-size: 12px;
  $line-height: 30px;
  font: #{$font-size}/#{$line-height};
}
/* 编译为： */

p {
  font: 12px/30px; /* 但是这个不是没有意义的 css ？？？做来干什么 */
}
```

### 7.3 字符串 运算

- 不带引号的字符串 `sans-serif` 或者 `bold`
- 带引号（单双引号）的字符串 `"Lucida Grande"` 或者 `'http://sass-lang.com'`

#### 7.3.1 不带引号的 字符串  + 连字符运算

```CSS
/* + 运算可用于连接字符串: */
/* SCSS */
p {
  cursor: e + -resize;
}

/* 编译为：CSS */
p {
  cursor: e-resize;
}
```

#### 7.3.2 带引号的 字符串  + 连字符运算

```CSS
$content: "Hello" + "" + "Sass!";
.box:before {
  content: " #{$content} ";
}
/* 编译出来的css： */
.box:before {
  content: " Hello Sass! ";
}
```

#### 7.3.3 一个不带/一个带 引号的 字符串  + 连字符运算

以连字符 + 左边的字符串为准，若带则带，不带则不带

```CSS
/* SCSS */
p:before {
  content: "Foo " + Bar;        /* "Foo " 有引号，结果为有引号 */
  font-family: sans- + "serif"; /* sans- 无引号，则结果无引号 */
}

/* 编译为：CSS */
p:before {
  content: "Foo Bar";
  font-family: sans-serif;
}
```

#### 7.3.3 字符串与 非字符串 运算

```CSS
/* 默认情况下，运算表达式与其他值连用时，用空格做连接符： */
/* SCSS */
p {
  margin: 3px + 4px auto;
}

/* 编译为：CSS */
p {
  margin: 7px auto;
}
```

#### 7.3.4 字符串 插值 运算

在文本字符串中，#{}式插值可以用来在字符串中放置动态值：

```CSS
/* 在字符串插值时，Null值被视为空字符串： */
/* SCSS */
$value: null;
    p:before {
      content: "I ate #{$value} pies!";
}

/* 编译为：CSS */
p:before {
  content: "I ate  pies!";
}
```

```CSS
p:before {
  content: "I ate #{5 + 10} pies!";
}
/* CSS */
p:before {
  content: "I ate 15 pies!";
}
```

上面的计算中，在编译输出的 CSS 文件中不会改变 Sass 文档中使用的字符串类型。

有一个例外，当使用 `#{} interpolation` 时，带引号的字符串将被编译为不带引号的字符串，
这样主要是为了便于使用，比如 mixins 中的选择器名称。例如：

```CSS
@mixin firefox-message($selector) {
      body.firefox #{$selector}:before {
    content: "Hi, Firefox users!";
  }
}
@include firefox-message(".header");

/* 编译为： */
body.firefox .header:before {
  content: "Hi, Firefox users!";
}
```

### 7.4 颜色运算

所有算术运算都支持的颜色值，颜色值的运算是分段进行计算的，也就是，依次计算红（red），绿（green），以及蓝（blue）的成分值。例如：

```CSS
p {
  color: #010203 + #040506;
}
/* 计算 01 + 04 = 05, 02 + 05 = 07, 和 03 + 06 = 09 */
/* 编译为： */
p {
  color: #050709;
}
```

```CSS
/* 通常 color functions(颜色函数)比尝试使用颜色运算更加有用，以达到同样的效果。数字和颜色值之间的算术运算也是分段。例如： */
p {
  color: #010203 * 2;
}
/* 计算 01 * 2 = 02, 02 * 2 = 04, 和 03 * 2 = 06，并且编译为： */

p {
  color: #020406;
}
```

```CSS
/* 需要注意的是，包含 alpha 通道（那些由 rgba 或 hsla 函数创建的）的颜色必须具有相同的 alpha 值，才能进行颜色运算。
这样算术不会影响alpha值 */
p {
  color: rgba(255, 0, 0, 0.75) + rgba(0, 255, 0, 0.75);
}
/* <!-- 编译为： --> */

p {
  color: rgba(255, 255, 0, 0.75);
}
```

```CSS
/* 颜色的alpha通道可以使用opacify和transparentize函数进行调整。例如： */
$translucent-red: rgba(255, 0, 0, 0.5);
    p {
      color: opacify($translucent-red, 0.3);
      background-color: transparentize($translucent-red, 0.25);
}
/* 编译为： */
p {
  color: rgba(255, 0, 0, 0.8);
  background-color: rgba(255, 0, 0, 0.25);
}
```
  
```CSS
/* IE浏览器的滤镜（filters）要求所有的颜色包括 alpha 层，而且格式必须是固定的 #AABBCCDD ，使用 ie_hex_str 函数可以轻松的将颜色转化为 IE 滤镜所要求的格式。例如： */
$translucent-red: rgba(255, 0, 0, 0.5);
    $green: #00ff00;
div {
  filter: progid:DXImageTransform.Microsoft.gradient(enabled='false', startColorstr='#{ie-hex-str($green)}', endColorstr='#{ie-hex-str($translucent-red)}');
}

/* 编译为：CSS */
div {
  filter: progid:DXImageTransform.Microsoft.gradient(enabled='false', startColorstr=#FF00FF00, endColorstr=#80FF0000);
}
```

### 7.5 #### 5.2.4 布尔运算

SassScript 支持布尔值的 and, or, 和 not 运算。

```HTML
<h3>Example using Boolean Operations</h3>
<p class="bool">SASS stands for Syntactically Awesome Stylesheet..</p>
```

```CSS
/* SCSS */
$age:20;
.bool {
  @if ($age > 10 and $age < 25) {
    color: green;
  }
}
```

### 7.6 空值 运算

### 7.7  列表 运算

#### 7.7.1 scss 中的列表定义

```CSS
/* 列表 是指 Sass 如何表示在CSS声明的 */，
margin: 10px 15px 0 0;
font-face: Helvetica, Arial, sans-serif;
/* 列表只是一串其他值，无论是用空格还是用逗号隔开。 */

font-size:12px;
/* 事实上，独立的值也被视为列表：只包含一个值的列表。 */
```

#### 7.7.2 列表计算方法

[list 函数](http://sass-lang.com/documentation/Sass/Script/Functions.html#list-functions),以下列举其中几个方法。

```CSS
/* 列表本身没有太多的功能，但 Sass list functions 赋予了数组更多新功能： */

/* nth 函数可以直接访问数组中的某一项 */
nth($list,$n) /* 返回列表中的特定项。 */

/* join 函数可以将多个数组连接在一起 */
join($list1,$list2,[$separator,$bracketed]) /* 将两个列表合并为一个。 */

/* append 函数可以在数组中添加新值 */
append($list1,$val,[$separator])/* 将单个值追加到列表的末尾。 */

/* @each 指令能够遍历数组中的每一项。 */
```

### 7.8 Maps 运算

#### 7.8.1 scss 中 map 定义

```CSS
/* Maps 代表一个键和值对集合，其中键用于查找值。他们可以很容易地将值收集到命名组中，并且可以动态地访问这些组。
在 CSS 中你找不到和他们类似的值，虽然他们的语法类似于媒体查询表达式： */
$map: (key1: value1, key2: value2, key3: value3);
```

和列表（Lists）不同，Maps 必须始终使用括号括起来，并且必须用逗号分隔。Maps 中的键和值可以是任意的 SassScript 对象。一个 Maps 可能只有一个值与给定的键关联（尽管该值可以是一个列表）。一个给定的值可能与许多键关联。

#### 7.8.2 map 的计函数方法

[MAP](http://sass-lang.com/documentation/Sass/Script/Functions.html#map-functions),下面只是列举几个。

```CSS
map-get($map,$key)/* 返回与给定键关联的映射中的值。 */
map-merge($map1,$map2)/* 将两个地图合并为一个新地图。 */
```

Maps不能转换为纯CSS。作为变量的值或参数传递给CSS函数将会导致错误。使用inspect($value) 函数以产生输出字符串，这对于调试 maps 非常有用。

#### 5.2.6 圆括号 改变 优先级

```CSS
/* 圆括号可以用来影响运算的顺序(优先级)： */
p {
  width: 1em + (2em * 3);
}

/* 编译为：CSS */
p {
  width: 7em;
}
```

### 5.4 函数

SassScript定义了一些有用的函数， 这些函数可以像普通 CSS 函数语法一样调用：

```CSS
p {
  color: hsl(0, 100%, 50%);
}
编译为：

p {
  color: #ff0000; }
```

  可用函数的完整列表，请参阅[这张页面](http://sass-lang.com/documentation/Sass/Script/Functions.html)。

### 5.5 关键词参数 (Keyword Arguments)

Sass 函数允许指定明确的关键词参数 (keyword arguments) 进行调用。 上面的例子也可以改写成：

p {
  color: hsl($hue: 0, $saturation: 100%, $lightness: 50%);
}
虽然不够简明，但可以让Sass代码阅读起来更加方便。 关键词参数让函数具有更灵活的接口， 即便参数众多，也不会让使用变得困难。

命名参数（named arguments）可以以任意顺序传入，并且，具有默认值的参数可以省略掉。 由于命名参数也是变量名称，因此，下划线、短横线可以互换使用。

完整的 Sass 函数列表和它们的参数名称，以及在 Ruby 里如何定义你自己的函数的步骤，请见 Sass::Script::Functions。

### 5.6 插值：#{}（Interpolation: #{}）

您还可以通过 #{} 插值语法在选择器和属性名中使用 SassScript 变量：

```CSS
$name: foo;
    $attr: border;
p.#{$name} {
      #{$attr}-color: blue;
}
/* 编译为： */

p.foo {
  border-color: blue; }
```

它也可以使用#{}插值语句把 SassScript 插入到属性值中。在大多数情况下，这种做可能还不如使用直接变量来的方便，但使用 #{}意味着靠近它的运算符都将被视为纯CSS（愚人码头注：可以避免各种运算）。 例如：

```CSS
p {
  $font-size: 12px;
      $line-height: 30px;
  font: #{$font-size}/#{$line-height};
}
/* 编译为： */

p {
  font: 12px/30px; }
```

### 5.7 SassScript中的&（& in SassScript）

就像当它在选择器中使用一样，SassScript中的&指向当前父选择器。下面是一个逗号分隔的列表（list）中包含一个空格的分隔列表（list）。例如：

```CSS
.foo.bar .baz.bang, .bip.qux {
  $selector: &;
}
```

$selector 的值是现在 ((".foo.bar" ".baz.bang"), ".bip.qux")。这个混合选择器在这里加了引号，以表明他们是字符串，但在现实中，他们将不带引号的。即使选择器不包含逗号或空格，&总会有两个嵌套层次，因此它可以保证访问一致性。

如果没有父选择器，& 的值将是空。这意味着你可以在一个 mixin 中使用它来检测父选择是否存在：

```CSS
@mixin does-parent-exist {
  @if & {
    &:hover {
      color: red;
    }
  } @else {
    a {
      color: red;
    }
  }
}
```

## 八、ass 插值

```CSS
$properties: (margin, padding);
@mixin set-value($side, $value) {
    @each $prop in $properties {//对每个在$properties中的$prop,即$properties中的margin、padding
        #{$prop}-#{$side}: $value;//$prop连接参数$side，值为参数$value
    }
}
.login-box {
    @include set-value(top, 14px);//调用混合宏
}

/* 编译出来的css： */
.login-box {
  margin-top: 14px;
  padding-top: 14px;
}
```

```CSS
/* 可以在使用@extend时使用插值： */
%updated-status {
    margin-top: 20px;
    background: #F00;
}
.selected-status {
    font-weight: bold;
}
$flag: "status";
.navigation {
    @extend %updated-#{$flag};
    @extend .selected-#{$flag};
}
```

以下的用法是不对的

```CSS
/* 下面这样是错误的 */
$margin-big: 40px;
$margin-medium: 20px;
$margin-small: 12px;
@mixin set-value($size) {
    margin-top: $margin-#{$size};
}
.login-box {
    @include set-value(big);
}

/* 这样也是错误的 */
@mixin updated-status {
  margin-top: 20px;
  background: #F00;
}
$flag: "status";
.navigation {
  @include updated-#{$flag};
}
```

## 八、if 语句：控制指令和表达式

## 九、混入指令:sass 混合宏（需要学习）

混入 (mixin) 允许您定义可以在整个样式表中重复使用的样式，而避免了使用无语意的类（class），比如  .float-left。混入 (mixin) 还可以包含所有的 CSS 规则，以及任何其他在 Sass 文档中被允许使用的东西。他们甚至可以带 arguments，引入变量，只需少量的混入 (mixin) 代码就能输出多样化的样式。

### 9.1 声明混合宏 @mixin xxx{}  与 调用 @include xxx

```CSS
/* @mixin :声明混合宏的关键词；
border-radius:混合宏的名称；
大括号内：复用的样式代码； */

@mixin border-radius{
    -webkit-border-radius: 3px;
    border-radius: 3px;
}/* 声明混合宏border-radius */
button {
  @include border-radius; /* 调用混合宏border-radius */
}

/* 编译为CSS： */
button {
  -webkit-border-radius: 3px;
  border-radius: 3px;
}
```

```CSS
/* 混入 (mixin) 通过 @mixin 指令定义。在它后面跟混入的名称和任选的 arguments（参数），以及混入的内容块。 */
@mixin large-text {
  font: {
    family: Arial;
    size: 20px;
    weight: bold;
  }
  color: #ff0000;
}
.page-title {
  @include large-text;
  padding: 4px;
  margin-top: 10px;
}

/* css */
.page-title {
  font-family: Arial;
  font-size: 20px;
  font-weight: bold;
  color: #ff0000;
  padding: 4px;
  margin-top: 10px;
}
```

```CSS
/* 混入也可以包含选择器和属性的混合体，选择器中甚至可以包含parent references（父选择器）。 例如： */
@mixin clearfix {
  display: inline-block;
  &:after {
    content: ".";
    display: block;
    height: 0;
    clear: both;
    visibility: hidden;
  }
  * html & { height: 1px }
}
```

```CSS
/* 混入（mixin）也可以包含在任何规则的外（即，在文档的根）,只要它们不直接定义的任何属性或使用任何父选择器引用 */
@mixin silly-links {
  a {
    color: blue;
    background-color: red;
  }
}
@include silly-links;

/* CSS */
a {
  color: blue;
  background-color: red;
}
```

```CSS
/* 混入（mixin）定义也可以包含其他的混入
混入可以包含自己。这行为不同于 Sass 3.3 之前的版本，以前混入递归是被禁止的。
只定义后代选择器的混入可以安全地混入到文件的最顶层。*/
@mixin compound {
  @include highlighted-background;
  @include header-text;
}

@mixin highlighted-background { background-color: #fc0; }
@mixin header-text { font-size: 20px; }
```

注意：**混入的名称没有 连字符 与下划线之分**
混入（mixin）的名字（和所有其他 Sass 标识符）可以互换连字符和下划线。例如，如果你定义了一个名为add-column的混入，你可以把它作为add_column，反之亦然。

### 9.3 混合宏的参数

混入（mixin）可以用 SassScript 值作为参数，给定的参数被包括在混入（mixin）中并且作为为变量提供给混入（mixin）。

#### 9.3.1 不带任何值的参数

```CSS
@mixin border-radius($radius){
  -webkit-border-radius: $radius;
  border-radius: $radius;
}/* 声明一个带有参数$radius的混合宏 */
.box {
  @include border-radius(3px);/*调用混合宏并给混合宏传参数“3px” */
}
```

#### 9.3.2 传一个带值参数（传入一个默认值）

```CSS
@mixin border-radius($radius:3px){
  -webkit-border-radius: $radius;
  border-radius: $radius;
}/*声明一个传入了默认参数值的混合宏 */
.btn {
  @include border-radius;/*使用默认参数值的混合宏 */
}
.box {
  @include border-radius(50%);/*可以自己传入参数值 */
}

/* CSS */
.btn {
  -webkit-border-radius: 3px;
  border-radius: 3px;
}
.box {
  -webkit-border-radius: 50%;
  border-radius: 50%;
}
```

```CSS
@mixin sexy-border($color, $width: 1in) {
  border: {
    color: $color;
        width: $width;
    style: dashed;
  }
}
p { @include sexy-border(blue); }
h1 { @include sexy-border(blue, 2in); }

/* CSS */
p {
  border-color: blue;
  border-width: 1in;
  border-style: dashed; }

h1 {
  border-color: blue;
  border-width: 2in;
  border-style: dashed; }
```

#### 9.3.3 传多个参数值

```CSS
@mixin size($width,$height){
  width: $width;
  height: $height;
}
.box-center {
  @include size(500px,300px);
}

/* 编译出来的css： */
.box-center {
  width: 500px;
  height: 300px;
}
```

```CSS
@mixin sexy-border($color, $width: 1in) {
  border: {
    color: $color;
        width: $width;
    style: dashed;
  }
}
p { @include sexy-border(blue); }
h1 { @include sexy-border(blue, 2in); }

/* CSS */
p {
  border-color: blue;
  border-width: 1in;
  border-style: dashed; }

h1 {
  border-color: blue;
  border-width: 2in;
  border-style: dashed; }
```

#### 9.3.4 关键字参数

混入（mixin）在引入（@include指令）的时候也可以使用明确的关键字参数。例如，上面的例子可以写成：

```CSS
p { @include sexy-border($color: blue); }
    h1 { @include sexy-border($color: blue, $width: 2in); }
```

虽然这是不够简明，但是它可以使样式表更容易阅读。它给函数呈现了更加灵活的接口，它使多参数的混入更加容易调用。
命名的参数可以按任何顺序进行传递，有默认值的参数可以省略。由于命名参数是变量名，下划线和连字符可以互换使用。

#### 9.3.5 可变参数

有时，不能确定一个混入（mixin）或者一个函数（function）使用多少个参数。例如，用于创建盒子阴影（box-shadow）的一个混入（mixin）可以采取任何数量的box-shadow作为参数。对于这些情况，Sass支持"可变参数",参数在声明混入（mixin）或函数（function）结束的地方，所有剩余的参数打包成一个列表（list）。参数看起来就像普通参数一样，但后面跟随着...。例如：

```CSS
@mixin box-shadow($shadows...) {
      -moz-box-shadow: $shadows;
      -webkit-box-shadow: $shadows;
      box-shadow: $shadows;
}

.shadows {
  @include box-shadow(0px 4px 5px #666, 2px 6px 10px #999);
}

/* 编译为： */
.shadows {
  -moz-box-shadow: 0px 4px 5px #666, 2px 6px 10px #999;
  -webkit-box-shadow: 0px 4px 5px #666, 2px 6px 10px #999;
  box-shadow: 0px 4px 5px #666, 2px 6px 10px #999;
}
```

可变参数可以包含任何关键字参数传递给混入（mixin）或者函数（function）。这些可以使用keywords($args)函数 来访问，返回一个map，参数名称字符串（无$）和值的键值对。

可变参数，也可以在调用（@include指令）一个混入（mixin）时使用。使用相同的语法，你可以扩展值的列表（list），以便每个值作为单独的参数传入，或扩展值的map，以使每个键值对作为一个关键字参数处理。例如：

```CSS
@mixin colors($text, $background, $border) {
      color: $text;
      background-color: $background;
      border-color: $border;
}

$values: #ff0000, #00ff00, #0000ff;
    .primary {
      @include colors($values...);
}

$value-map: (text: #00ff00, background: #0000ff, border: #ff0000);
    .secondary {
      @include colors($value-map...);
}

/* 编译为： */
.primary {
  color: #ff0000;
  background-color: #00ff00;
  border-color: #0000ff;
}

.secondary {
  color: #00ff00;
  background-color: #0000ff;
  border-color: #ff0000;
}
```

你可以同时传递一个列表（list）和一个map参数，只要列表（list）在map上之前，比如@include colors($values..., $map...)。

您可以使用可变参数来包装一个混入（mixin）并且添加额外的样式，而不改变混入（mixin）的参数签名。如果你这样做，关键字参数将通过包装的混入（mixin）直接传递。例如：

```CSS
@mixin wrapped-stylish-mixin($args...) {
      font-weight: bold;
      @include stylish-mixin($args...);
}

.stylish {
  // The $width argument will get passed on to "stylish-mixin" as a keyword
      @include wrapped-stylish-mixin(#00ff00, $width: 100px);
}
```

### 9.4 传递内容块到混入

样式内容块可以传递到混入（mixin）包含样式的位置。样式内容块将出现在混入内的任何 @content 指令的位置。这使得可以定义抽象 关联到选择器和指令的解析。

例如：

```CSS
@mixin apply-to-ie6-only {
  * html {
    @content;
  }
}
@include apply-to-ie6-only {
  #logo {
    background-image: url(/logo.gif);
  }
}
/* 生成: */

* html #logo {
  background-image: url(/logo.gif);
}
```

同样的混入（mixin）可以在.sass 简写语法（@mixin 可以用 = 表示，而 @include 可以用 + 表示）来完成：

```CSS
=apply-to-ie6-only
  * html
    @content

+apply-to-ie6-only
  #logo
    background-image: url(/logo.gif)
```

注意： 当@content指令指定多次或在一个循环中指定的时候，样式块将在每次调用中被复制并引用。

### 9.5 变量的作用域和内容块

传递给混入（mixin）的内容块在其被定义的作用域中进行运算，而不是混入（mixin）的作用域。这意味着混入（mixin）的局部变量不能传递给样式块使用，并且变量将解析为全局值：

```CSS
$color: white;
    @mixin colors($color: blue) {
  background-color: $color;
      @content;
      border-color: $color;
}
.colors {
  @include colors { color: $color; }
}

/* CSS */
.colors {
  background-color: blue;
  color: white;
  border-color: blue;
}
```

另外，这清楚地表明，变量和传递到块中使用的混入，指向块定义的周围其他样式。例如：

```CSS
#sidebar {
  $sidebar-width: 300px;
      width: $sidebar-width;
  @include smartphone {
    width: $sidebar-width / 3;
  }
}
```

## 十、函数指令

## 十一、输出格式

## 十二、扩展 Sass

## 十三 导入：@规则 和 指令 (@-Rules and Directives)