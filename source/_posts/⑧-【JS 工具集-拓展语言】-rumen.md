---
title: 'node.js--[小白入门版]'
date: '2018/8/19 23:57:28'
categories:
  - ⑧ JS 工具集/ JS拓展语言
  - node.js 语言
abbrlink: ff03de2a
updated:
tags:
comments:
---

## 一、什么是 node.js

JavaScript 是脚本语言，脚本语言都需要一个解析器才能运行。对于写在 HTML 页面里的 JS，浏览器充当了解析器的角色。而对于需要独立运行的 JS，NodeJS 就是一个解析器。简单的说 Node.js 就是运行在服务端的 JavaScript。

每一种解析器都是一个运行环境，不但允许 JS 定义各种数据结构，进行各种计算，还允许 JS 使用运行环境提供的内置对象和方法做一些事情。例如运行在浏览器中的 JS 的用途是操作 DOM，浏览器就提供了 document 之类的内置对象。而运行在 NodeJS 中的 JS 的用途是操作磁盘文件或搭建 HTTP 服务器，NodeJS 就相应提供了fs、http 等等内置对象（API接口）。

[官方中文网](http://nodejs.cn/api/)，
[官网英文网](https://nodejs.org/en/)

Node.js 是一个基于 Chrome JavaScript 运行时建立的一个平台。Node.js是一个事件驱动 I/O 服务端 JavaScript 环境，基于 Google 的 V8 引擎，V8 引擎执行 Javascript 的速度非常快，性能非常好。

node.js

- 可以解析 JS 代码（没有浏览器安全级的限制）
- 提供系统级别的 API：文件的读写，进程的管理，网络通信等等

学习 node.js 可以使用的几个网站：

- node.js 官网：[官方中文网](http://nodejs.cn/api/)，[官网英文网](https://nodejs.org/en/)
- [github官网源码托管](https://github.com/dashboard)
- [npm论坛](www.npmjs.com)
- [stackoverflow技术问答社区](stackoverflow.com)

## 二、node.js的安装

不同版本的 API 接口可能不同，使用的规范也会不同。一定要注意自己使用的 node.js 版本。

### node.js官网

[官网网址：](https://nodejs.org/en/download/)
[旧版本node.js](Node.js 历史版本下载地址：https://nodejs.org/dist/)

官网中偶数位为稳定的版本，奇数为不稳定的版本，选择偶数版本来使用。

## 三、node.js 创建一个 web 服务器

 Node.js 应用是由哪几部分组成的：

- 引入 required 模块：我们可以使用 require 指令来载入 Node.js 模块。
- 创建服务器：服务器可以监听客户端的请求，类似于 Apache 、Nginx 等 HTTP 服务器。
- 接收请求与响应请求 服务器很容易创建，客户端可以使用浏览器或终端发送 HTTP 请求，服务器接收请求后返回响应数据。

项目的根目录下创建一个叫 server.js 的文件，并写入以下代码：http.createServer() 方法创建服务器，并使用 listen 方法绑定 8888 端口。 函数通过 request, response 参数来接收和响应数据。

```JS
//我们使用 require 指令来载入 http 模块，并将实例化的 HTTP 赋值给变量 http
var http = require('http'); //这里是 Commonjs 规范
http.createServer(function (request, response) {
    // 发送 HTTP 头部
    // HTTP 状态值: 200 : OK
    // 内容类型: text/plain
    response.writeHead(200, {'Content-Type': 'text/plain'});

    // 发送响应数据 "Hello World"
    response.end('Hello World\n');
}).listen(8888); //这里使用的是链式语法

// 终端打印如下信息
console.log('Server running at http://127.0.0.1:8888/');
```

在 8888 这个端口监听到一个请求之后，就会去调用匿名回调函数 function (request, response){}

**用命令行运行代码：**

- cd 到相应的项目目录，
- node server.js

server.js代码解析：

- 第一行请求（require）Node.js 自带的 http 模块，并且把它赋值给 http 变量。接下来我们调用 http 模块提供的函数： createServer 。这个函数会返回 一个对象，这个对象有一个叫做 listen 的方法，这个方法有一个数值参数， 指定这个 HTTP 服务器监听的端口号。分析Node.js 的 HTTP 服务器：
- 第一行请求（require）Node.js 自带的 http 模块，并且把它赋值给 http 变量。接下来我们调用 http 模块提供的函数： createServer 。这个函数会返回 一个对象，这个对象有一个叫做 listen 的方法，这个方法有一个数值参数， 指定这个 HTTP 服务器监听的端口号。

## 四、NPM

### 4.1 什么是NPM

NPM 是随同 NodeJS 一起安装的包管理工具，能解决 NodeJS 代码部署上的很多问题，常见的使用场景有以下几种：

- 允许用户从 NPM  服务器下载别人编写的第三方包到本地使用。
- 允许用户从 NPM 服务器下载并安装别人编写的命令行程序到本地使用。
- 允许用户将自己编写的包或命令行程序上传到 NPM 服务器供别人使用。

### 4.2 NPM的安装

新版的 nodejs 已经集成了 npm，安装了新版的 node.js，npm 也就一同安装上了。不需要再次安装。

- 查看版本：可以用命令行 `npm -v`查看安装的版本。
- 升级版本:Window 系统：`npm install npm -g`

### 4.3 NPM的功能

- 安装模块
- 卸载模块
- 搜索模块
- 更新模块
- 创建模块

**模块分类：**
npm 的包安装分为本地安装（local）、全局安装（global）两种，从敲的命令行来看，差别只是有没有-g 而已。

- 全局安装：
    指的是将模块安装在计算机系统，此后在任何一个磁盘，创建的任何一个项目都可以直接使用这个模块，不需要再次安装。通俗的说就是公有的。大家用使用。
    1. 将安装包放在 ./node_modules 下（运行 npm 命令时所在的目录），如果没有 node_modules 目录，会在当前执行 npm 命令的目录下生成 node_modules 目录。
    2. 可以通过 require() 来引入本地安装的包。
- 本地安装：
    指的是将模块安装在相应的项目目录下，仅仅是这个项目可以使用，后期在其他盘，或者文件下创建项目，需要使用到这个模块的话，需要再次安装的。通俗的说就是各管各的。我有的是私有的。
    1. 将安装包放在 /usr/local 下或者你 node 的安装目录。
    2. 可以直接在命令行里使用。

下面将以 express 模块全局安装来解析 NPM 功能，也可以以之间的 vue.js 系列来学习本节。

**①安装express模块**

```BASH
npm install express -g
//也可以使用 cnpm 淘宝镜像，还可以使用 pnpm
//安装淘宝镜像：npm install -g cnpm --registry=https://registry.npm.taobao.org
```

>`npm list 模块名` 可以用来查看某个模块的版本号，也可以使用`模块名 -v/-V` 来查看模块小单版本号
`npm list -g` 可以用来查看全局安装的所有模块，也可以在 package.json 文件中查看安装的模块信息。

**②卸载模块**

```bash
npm uninstall express
//卸载后，你可以到 /node_modules/ 目录下查看包是否还存在，或者使用命令 `npm ls` 查看
```

**③更新模块**

```bash
npm update express
//或者使用命令 `express -v`查看更新后的版本
```

**④搜索模块**

```bash
npm search express
```

**⑤创建模块**

```bash
//以下命令创建模块提供他人使用
npm init       生成 package.json 文件
npm adduser    在 npm 资源库中注册用户（使用邮箱注册）
npm publish    发布模块
//后续可以使用 npm 装这个模块，跟其他他人创建好的模块一样的方法下载安装使用
```

**package.json解析**
package.json 位于模块的目录下，用于定义包的属性。

```JSON
//下面是 express 包的 package.json 文件，位于 node_modules/express/package.json 内容
{
  "name": "express",
  "description": "Fast, unopinionated, minimalist web framework",
  "version": "4.13.3",
  "author": {
    "name": "TJ Holowaychuk",
    "email": "tj@vision-media.ca"
  },
  "contributors": [
    {
      "name": "Aaron Heckmann",
      "email": "aaron.heckmann+github@gmail.com"
    },
    {
      "name": "Ciaran Jessup",
      "email": "ciaranj@gmail.com"
    },
    {
      "name": "Douglas Christopher Wilson",
      "email": "doug@somethingdoug.com"
    },
    {
      "name": "Guillermo Rauch",
      "email": "rauchg@gmail.com"
    },
    {
      "name": "Jonathan Ong",
      "email": "me@jongleberry.com"
    },
    {
      "name": "Roman Shtylman",
      "email": "shtylman+expressjs@gmail.com"
    },
    {
      "name": "Young Jae Sim",
      "email": "hanul@hanul.me"
    }
  ],
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "git+https://github.com/strongloop/express.git"
  },
  "homepage": "http://expressjs.com/",
  "keywords": [
    "express",
    "framework",
    "sinatra",
    "web",
    "rest",
    "restful",
    "router",
    "app",
    "api"
  ],
  "dependencies": {
    "accepts": "~1.2.12",
    "array-flatten": "1.1.1",
    "content-disposition": "0.5.0",
    "content-type": "~1.0.1",
    "cookie": "0.1.3",
    "cookie-signature": "1.0.6",
    "debug": "~2.2.0",
    "depd": "~1.0.1",
    "escape-html": "1.0.2",
    "etag": "~1.7.0",
    "finalhandler": "0.4.0",
    "fresh": "0.3.0",
    "merge-descriptors": "1.0.0",
    "methods": "~1.1.1",
    "on-finished": "~2.3.0",
    "parseurl": "~1.3.0",
    "path-to-regexp": "0.1.7",
    "proxy-addr": "~1.0.8",
    "qs": "4.0.0",
    "range-parser": "~1.0.2",
    "send": "0.13.0",
    "serve-static": "~1.10.0",
    "type-is": "~1.6.6",
    "utils-merge": "1.0.0",
    "vary": "~1.0.1"
  },
  "devDependencies": {
    "after": "0.8.1",
    "ejs": "2.3.3",
    "istanbul": "0.3.17",
    "marked": "0.3.5",
    "mocha": "2.2.5",
    "should": "7.0.2",
    "supertest": "1.0.1",
    "body-parser": "~1.13.3",
    "connect-redis": "~2.4.1",
    "cookie-parser": "~1.3.5",
    "cookie-session": "~1.2.0",
    "express-session": "~1.11.3",
    "jade": "~1.11.0",
    "method-override": "~2.3.5",
    "morgan": "~1.6.1",
    "multiparty": "~4.1.2",
    "vhost": "~3.0.1"
  },
  "engines": {
    "node": ">= 0.10.0"
  },
  "files": [
    "LICENSE",
    "History.md",
    "Readme.md",
    "index.js",
    "lib/"
  ],
  "scripts": {
    "test": "mocha --require test/support/env --reporter spec --bail --check-leaks test/ test/acceptance/",
    "test-ci": "istanbul cover node_modules/mocha/bin/_mocha --report lcovonly -- --require test/support/env --reporter spec --check-leaks test/ test/acceptance/",
    "test-cov": "istanbul cover node_modules/mocha/bin/_mocha -- --require test/support/env --reporter dot --check-leaks test/ test/acceptance/",
    "test-tap": "mocha --require test/support/env --reporter tap --check-leaks test/ test/acceptance/"
  },
  "gitHead": "ef7ad681b245fba023843ce94f6bcb8e275bbb8e",
  "bugs": {
    "url": "https://github.com/strongloop/express/issues"
  },
  "_id": "express@4.13.3",
  "_shasum": "ddb2f1fb4502bf33598d2b032b037960ca6c80a3",
  "_from": "express@*",
  "_npmVersion": "1.4.28",
  "_npmUser": {
    "name": "dougwilson",
    "email": "doug@somethingdoug.com"
  },
  "maintainers": [
    {
      "name": "tjholowaychuk",
      "email": "tj@vision-media.ca"
    },
    {
      "name": "jongleberry",
      "email": "jonathanrichardong@gmail.com"
    },
    {
      "name": "dougwilson",
      "email": "doug@somethingdoug.com"
    },
    {
      "name": "rfeng",
      "email": "enjoyjava@gmail.com"
    },
    {
      "name": "aredridel",
      "email": "aredridel@dinhe.net"
    },
    {
      "name": "strongloop",
      "email": "callback@strongloop.com"
    },
    {
      "name": "defunctzombie",
      "email": "shtylman@gmail.com"
    }
  ],
  "dist": {
    "shasum": "ddb2f1fb4502bf33598d2b032b037960ca6c80a3",
    "tarball": "http://registry.npmjs.org/express/-/express-4.13.3.tgz"
  },
  "directories": {},
  "_resolved": "https://registry.npmjs.org/express/-/express-4.13.3.tgz",
  "readme": "ERROR: No README data found!"
}
```

- Package.json 属性说明
- name - 包名。
- version - 包的版本号。
- description - 包的描述。
- homepage - 包的官网 url 。
- author - 包的作者姓名。
- contributors - 包的其他贡献者姓名。
- dependencies - 依赖包列表。如果依赖包没有安装，npm 会自动将依赖包安装在 node_module 目录下。
- repository - 包代码存放的地方的类型，可以是 git 或 svn，git 可在 Github 上。
- main - main 字段指定了程序的主入口文件，require('moduleName') 就会加载这个文件。这个字段的默认值是模块根目录下面的 index.js。
- keywords - 关键字

### 4.4 NPM常用命令

NPM 常用命令：除了本章介绍的部分外，NPM还提供了很多功能，package.json 里也有很多其它有用的字段。也可以去查看：[NPM官方文档](npmjs.org/doc/)

>使用npm help <command>可查看某条命令的详细帮助，例如 npm help install。
在package.json所在目录下使用 npm install . -g 可先在本地安装当前命令行程序，可用于发布前的本地测试。
使用npm update <package>可以把当前目录下 node_modules 子目录里边的对应模块更新至最新版本。
使用npm update <package> -g 可以把全局安装的对应命令行程序更新至最新版。
使用npm cache clear可以清空NPM本地缓存，用于对付使用相同版本号发布新版本代码的人。
使用npm unpublish <package>@<version>可以撤销发布自己发布过的某个版本代码。

## 五、REPL(交互式解释器)

### 5.1 什么是REPL？

REPL(Read Eval Print Loop:交互式解释器) 表示一个电脑的环境，类似 Window 系统的终端或 Unix/Linux shell，我们可以在终端中输入命令，并接收系统的响应。

Node 自带了交互式解释器 .REPL 可以执行以下任务,可以很好的调试 Javascript 代码。

- 读取 - 读取用户输入，解析输入了Javascript 数据结构并存储在内存中。
- 执行 - 执行输入的数据结构
- 打印 - 输出结果
- 循环 - 循环操作以上步骤直到用户两次按下 ctrl-c 按钮退出。

REPL

```BASH
node //启动 Node 的终端,命令行变成了三角符号
> 1 + ( 2 * 3 ) - 4 //简单表示式输入计算
3
>x = 10  //变量声明：没有使用关键字 var ,然后值会被直接打印出来
10
> var y = 10//变量声明：有使用关键字 var ,值不会被打印出来，而是打印了 undefined
undefined
> x + y
20
> console.log("Hello World") //可以打印
Hello World
>var c = 0  
undefined
> do {  //多行表达式...这个符号是 node 自己判断为多行语句后自己添加的，回车即可
... c++;
... console.log("c: " + c);
... } while ( c < 5 );
c: 1
c: 2
c: 3
c: 4
c: 5
undefined
```

```BASH
> var x = 10
undefined
> var y = 20
undefined
> x + y
30
> var sum = _ //使用下划线(_)获取上一个表达式的运算结果：
undefined
> console.log(sum)
30
undefined
```

REPL 命令
- ctrl + c - 退出当前终端。
- ctrl + c 按下两次 - 退出 Node REPL。
- ctrl + d - 退出 Node REPL.
- 向上/向下 键 - 查看输入的历史命令
- tab 键 - 列出当前命令
- .help - 列出使用命令
- .break - 退出多行表达式
- .clear - 退出多行表达式
- .save filename - 保存当前的 Node REPL 会话到指定文件
- .load filename - 载入当前 Node REPL 会话的文件内容。

## 六、回调函数

Node.js 是单进程单线程应用程序，但是因为 V8 引擎提供的异步执行回调接口 (Node.js 几乎每一个 API 都是支持回调函数的)，通过这些接口可以处理大量的并发，所以性能非常高。

- Node.js 异步编程的直接体现就是回调。异步编程依托于回调来实现，但不能说使用了回调后程序就异步化了。
- 回调函数在完成任务后就会被调用，Node 使用了大量的回调函数，Node 所有 API 都支持回调函数。
    例如，我们可以一边读取文件，一边执行其他命令，在文件读取完成后，我们将文件内容作为回调函数的参数返回。这样在执行代码时就没有阻塞或等待文件 I/O 操作。这就大大提高了 Node.js 的性能，可以处理大量的并发请求。

回调函数一般作为参数的最后一个参数出现：
function func1(name, age, callback) { }
function func2(value, callback1, callback2) { }

**单线程阻塞代码** 与 **单线程阻异步编程**

创建一个文件 input.txt

```TEXT
名字：liuxmoo
```

```JS
//单线程阻塞代码：顺序执行
var fs = require("fs");
var data = fs.readFileSync('input.txt');
console.log(data.toString()); 
console.log("ok"); //这句会等待上面一句执行完毕后才开始执行

//代码执行结果
//名字：liuxmoo
//ok
```

```JS
//单线程阻异步编程：不需要按顺序执行
var fs = require("fs");
fs.readFile('input.txt', function (err, data) {
    if (err) return console.error(err);
    console.log(data.toString());
});
console.log("ok"); //上面那个函数没有执行完全，这个语句就执行完毕了

//代码执行结果
//ok
//名字：liuxmoo
```

第一个实例在文件读取完后才执行完程序。 第二个实例我们不需要等待文件读取完，这样就可以在读取文件时同时执行接下来的代码，大大提高了程序的性能。如果需要处理回调函数的参数，写在回调函数内。