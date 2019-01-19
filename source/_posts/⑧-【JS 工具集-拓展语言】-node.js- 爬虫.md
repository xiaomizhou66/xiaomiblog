---
title: node.js--爬虫
date: '2018/9/06 01:00:01'
categories:
  - ⑧ JS 工具集/ JS拓展语言
  - node.js 语言
abbrlink: '689222'
updated:
tags:
comments:
---

# 一、爬虫

## 2.1 什么是爬虫

网络爬虫（又被称为网页蜘蛛，网络机器人，在 FOAF 社区中间，更经常的称为网页追逐者），是一种按照一定的规则，自动地抓取万维网信息的程序或者脚本。另外一些不常使用的名字还有蚂蚁、自动索引、模拟程序或者蠕虫。

## 2.2 爬虫工具

python  VS node.js

说到爬虫，大家想到的比较多的还是 python，确实 python 有 Scrapy 等成熟的框架，可以实现很强大的爬取功能。但是 node 也有自身的优点，凭借强大的异步特性，可以很轻松的实现高效的异步并发请求，节省 cpu 的开销。node.js 直接是在浏览器运行的，这个也是它的优点。

# 二、爬虫流程

```bash
结构分析  # 分析清楚页面结构，要爬哪些页面，页面的结构是怎样的，需不需要登录；有没有ajax接口，返回什么样的数据等。
数据抓取  # 如今的网页的数据，大体分为同步页面和ajax接口。
         # 同步页面数据的抓取就需要我们先分析网页的结构，
         # python 抓取数据一般是通过 正则表达式匹配 来获取需要的数据；
         # node有一个 cheerio 的工具，可以将获取的页面内容转换成 jquery 对象，
         # 然后就可以用 jquery 强大的 dom API 来获取节点相关数据， 其实大家看源码，这些 API 本质也就是正则匹配。
         # ajax 接口数据一般都是 json 格式的，处理起来还是比较简单的。
数据存储  # 抓取的数据后，会做简单的筛选，然后将需要的数据先保存起来，以便后续的分析处理。
         # 当然我们可以用 MySQL 和 Mongodb 等数据库存储数据。为了方便，没有问题的话也可以直接采用文件存储。
数据分析  # 因为我们最终是要展示数据的，所以我们要将原始的数据按照一定维度去处理分析，然后返回给客户端。
         # 这个过程可以在存储的时候去处理，也可以在展示的时候，前端发送请求，后台取出存储的数据再处理。
结果展示  # 这个是前端工程师的工作啦。
```

# 三、爬虫常用库

## 3.1 Superagent：http 方面的库

[Superagent](http://visionmedia.github.io/superagent/)
[Superagent 中文网站](https://cnodejs.org/topic/5378720ed6e2d16149fa16bd)
Superagent 是个轻量的的 http 方面的库，是 nodejs 里一个非常方便的客户端请求代理模块，进行 get、post、head 等网络请求。

## 3.2 Cheerio ：Node.js 版 jquery

[Cheerio](https://github.com/cheeriojs/cheerio)
[Cheerio 中文](https://cnodejs.org/topic/5203a71844e76d216a727d2e)
[Cheerio 中文简书](https://www.jianshu.com/p/629a81b4e013)
（用来从网页中以 css selector 取数据，使用方式跟 jquery 一模一样）可以将获取的页面内容转换成 jquery 对象。
然后就可以用 jquery 强大的 dom API 来获取节点相关数据， 其实大家看源码，这些 API 本质也就是正则匹配。

## 3.3 Async：流程控制工具包

[Async](https://github.com/caolan/async)
[Async 中文](https://cnodejs.org/topic/56f6588387688ffc6e356e87)
[Async 中文简书](https://www.jianshu.com/p/498813629a03)
Async 是一个流程控制工具包，提供了直接而强大的异步功能 `mapLimit(arr, limit, iterator, callback)`，我们主要用到这个方法，大家可以去看看官网的 API。

## 3.4 当然还有其他的工具恶意使用，

比如：删除数组元素方法的工具，数组排序方法的工具

# 五、实际应用（爬虫完整）

```JS
//结构分析，如要登录。所以我们要先拿到登录的 cookie 才行，有的时候是 token，看自己要爬的网页来分析
//获取登录cookie
function getCookie() {
  superagent.post('https://www.example.com')
  .type('form')
  .send({
      phone: phone,
      password: password,
      productCode: "LMLC",
      origin: "PC"
  })
  .end(function(err, res) {
      if (err) {
          handleErr(err.message);
          return;
      }
      cookie = res.header['set-cookie']; //从response中得到cookie
      emitter.emit("setCookeie");
  })
}
```