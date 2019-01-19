---
title: '[编写高质量 JS 代码 ]'
date: '2018/8/19 23:57:28'
tags:
  - 递归函数
categories:
  - ② Javascript-ES6-Typescript
  - Javascript
abbrlink: ba7adbb8
updated:
comments:
---
## 一、前言

[网址：](https://m.baidu.com/from=1000539d/bd_page_type=1/ssid=0/uid=0/pu=usm%402%2Csz%401320_2001%2Cta%40iphone_1_10.2_3_602/baiduid=F698D753713440C62CEDBE2E71B1D6E4/w=0_10_/t=iphone/l=3/tc?ref=www_iphone&lid=8001055715519983826&order=1&fm=alop&isAtom=1&is_baidu=0&tj=www_normal_1_0_10_title&vit=osres&m=8&srd=1&cltj=cloud_title&asres=1&title=%E5%BB%BA%E8%AE%AE65%3A%E6%AF%94%E8%BE%83%E5%87%BD%E6%95%B0%E7%9A%84%E6%83%B0%E6%80%A7%E6%B1%82%E5%80%BC%E4%B8%8E%E9%9D%9E%E6%83%B0%E6%80%A7%E6%B1%82%E5%80%BC_%E7%BC%96%E5%86%99%E9%AB%98%E8%B4%A8%E9%87%8F...&dict=32&wd=&eqid=6f0975c827ad7000100000025bdacb02&w_qd=IlPT2AEptyoA_ykwsP9bu4CuH5JVg9Anxka&tcplug=1&sec=33873&di=52cc3dc7a1d2a082&bdenc=1&tch=124.0.128.175.0.0&nsrc=IlPT2AEptyoA_yixCFOxCGZb8c3JV3T5ABSOKiMKQDmaoo39h47aUbAsEm_hASbTUS3kdz0XvsVJbSi&clk_type=1&l=1&baiduid=F698D753713440C62CEDBE2E71B1D6E4&w=0_10_%E9%9D%9E%E6%83%B0%E6%80%A7%E6%B1%82%E5%80%BC&t=iphone&from=1000539d&ssid=0&uid=0&bd_page_type=1&pu=usm%402%2Csz%401320_2001%2Cta%40iphone_1_10.2_3_602&clk_info=%7B%22srcid%22%3A1599%2C%22tplname%22%3A%22www_normal%22%2C%22t%22%3A1541065478544%2C%22xpath%22%3A%22div-article-header-div-a-h3-span%22%7D&sfOpen=1)

代码的实现有很多种方法，但是他们的事件复杂度，空间复杂度，后期维护，等等都有所不同，都是需要考虑的问题。这篇文章是为了写出高质量代码 JavaScript 代码的合集。

内容全部由编写高质量的 JavaScript 代码的最佳实践组成，**从基本语法、应用架构、工具框架、编码风格、编程思想等5大方面对 Web 前端解读**

## 惰性求值与非惰性求值

### 非惰性求值：不需要的干

不管表达式是否被利用，只要在执行代码行中都会被计算。

```JS
var a = 2;
function f(x){
return x;
}
alert(f(a,a=a*a)); //2  调用函数时，传入了 2 个参数，本次调用只会使用第 1 个参数，
                       //但是第二个参数 也就是表达式参数，它是表达式也会被计算，最红得到 a=a*a=4， 下次使用这个值的话就会被改变了
alert(f(a)); //4    这里再调用函数 参入的 a 就是上一次调用被计算之后的 a=4 ，结果就是 4 了
```

函数作为运算符参与运算，具有非惰性求值特性，非惰性求值行为自然会对整个程序产生一定的负面影响。不管我们是否需要，它都执行了。如果在一个函数参数中无意添加了几个表达式，虽然这样不会对函数的运算结果产生影响，但是由于表达式被执行，就会对整个程序产生潜在的负面影响。例如会占用系统资源。

```JS
function f() {}
f(function () {
  while (true);
}())

//虽然函数 f 没有参数，但是在调用时将会执行传递给它的参数表达式，该表达式是一个死循环结构的函数值，最终将导致系统崩溃。？？？
```

### 惰性求值：你要的时候它才干

惰性函数模式是一种将对函数或请求的处理延迟到真正需要结果时进行的通用概念，很多应用程序都采用了这种概念。从惰性编程的角度来思考问题，可以帮助消除代码中不必要的计算。

例如，在 Scheme 语言中，delay 特殊表单接收一个代码块，它不会立即执行这个代码块，而是将代码和参数作为一个 promise（promise：承诺，约定，誓言） 存储起来。如果需要 promise 产生一个值，就会运行这段代码。promise 随后会保存结果，这样将来再请求这个值时，该值就可以立即返回，而不用再次执行代码。

这种设计模式在 JavaScript  中大有用处，尤其是在编写跨浏览器的、高效运行的库时非常有用。

```JS
var t;
function f(){
  t = t ? t : new Date();
  return t;
}
console.log(f());
/* Thu Nov 01 2018 18:14:17 GMT+0800
Thu Nov 01 2018 18:14:19 GMT+0800
Thu Nov 01 2018 18:14:22 GMT+0800 */
// 看上面，同一段代码，不同时间执行，的结果时间是不一样的，它就是做到了惰性求值，在需要它的时候它才求值。
```

上面的示例使用全局变量 t 来存储时间对象，这样在每次调用函数时都必须进行重新求值，代码的效率没有得到优化，同时全局变量 t 很容易被所有代码访问和操作，存在安全隐患。

问题？？？、所以是怎么做到惰性求值的？？？

```JS
//使用闭包隐藏全局变量t，只允许在函数f内访问。但是这仍然没有提高调用时的效率，因为每次调用f依然需要求值：
var f = (function () {
  var t;
  return function () {
    t = t ? t : new Date();
    return t;
  }
})();
f();
```

```JS
var f = function () {
  var t = new Date();
  f = function () {
    return t;
  }
  return f();
};
f();
//函数 f 的首次调用将实例化一个新的 Date 对象并重置 f 到一个新的函数上，f 在其闭包内包含 Date 对象。在首次调用结束之前，
//f 的新函数值也已被调用并提供返回值。
/* 函数 f 的调用都只会简单地返回 t 保留在其闭包内的值，这样执行起来非常高效。弄清这种模式的另一种途径是，外部函数 f 的首次调用是一个保证（promise），它保证了首次调用会重定义 f 为一个非常有用的函数，保证来自于 Scheme 的惰性求值机制。？？？？？？？？？？？？？？？ */
```