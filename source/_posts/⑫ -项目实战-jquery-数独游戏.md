---
title: 'JQurey 实战项目--[数独游戏]'
date: '2018/8/19 23:57:28'
categories:
  - ⑫ 综合实战项目
  - jQuery
abbrlink: ee9a01e4
updated:
tags:
comments:
---

## 一、前言

本节使用的是 Jquery.js 做一个数独游戏，显示使用 JavaScript 来做，后面使用 TypeScript 来实现。

git 仓库：[网址](https://github.com/xiaomizhou66/shudu)
数独游戏没有后端，纯前端

下面是为了让自己久不用会忘记做的一个项目编辑过程，方便自己后面查阅。

## 二、数独游戏的玩法

数独是源自 18 世纪瑞士的一种数学游戏。是一种运用纸、笔进行演算的逻辑游戏。玩家需要根据9×9盘面上的已知数字，推理出所有剩余空格的数字，并满足每一行、每一列、每一个粗线宫（3*3）内的数字均含 1-9，不重复。

数独盘面是个九宫，每一宫又分为九个小格。在这八十一格中给出一定的已知数字和解题条件，利用逻辑和推理，在其他的空格上填入 1-9 的数字。使 1-9每个数字在每一行、每一列和每一宫中都只出现一次，所以又称“九宫格”。

![tu](http://p1teq0wgy.bkt.clouddn.com/9825bc315c6034a8cb048a23cb134954082376a9.jpg)

## 三、本文运用知识

前端技术：

- HTML5: 页面结构
- less、css: 样式
- JavaScript：前方开发语言
- jQuery：用于 DOM 开大的 js 库
- TypeScript 2.0+ ： JavaScript 开发语言 的超集，提供了可选的 **静态类型**和 **基于接口的OOP**

前端构建技术：

- Node.js 6+: 运行坏境
- NPM、 yarn: 工具安装工具（用来安装下载其他工具） install 安装，init 初始化
- Gulp:    构建工具
- webpack：打包工具
- babel：  转译工具
- TSC (TypeScript Compiler)：编译

## 四、框架搭建结构

### 4.1 结构树

题外话：结构树，命令行输入 `tree` 可以查看结构树,但是 windows 的这个 tree 命令不咋地。[tree 网址](https://wodewone.github.io/2017/02/19/node-tree-user/)

```BASH
├──dist             # 文件夹(生成)：编译生成的文件夹
|  ├──js/           # 文件夹(生成)：编译生成的文件夹，存放编译后的 js 文件
|  ├──css/          # 文件夹(生成)：编译生成的文件夹，存放编译后的 css 文件
|  ├──favicon.ico   # 文件(生成)：  编译移动到这里的文件，网站的图标，如果需要的话
|  └─ index.html    # 文件(生成)：  编译移动到这里的 html 入口文件，
|
├──node_modules    # 文件夹(生成)：使用 yarn 安装工具产生的文件夹（依赖包）
├──src             # 文件夹(创建)：生产文件夹 手动创建 或者 命令行创建的文件夹 （src 可自行命名）
|  ├──js/          # 文件夹(创建)：手动创建 或者 命令行创建的文件夹
|  └─less/         # 文件夹(创建)：手动创建 或者 命令行创建的文件夹
|  
├──.gitignore  # 文件(创建)：上传 git 时忽略的文件/文件夹
├──favicon.ico # 网站的图标(创建)，如果需要的话
├──gulpfile.js # 文件(创建)：手动创建的文件 （用于构建）注意：这个文件的名字一定要是 gulpfile ，不能改名，
|               # 否则运行的 `gulp` 的时候回出现错误 `No gulpfile found` ，在电脑自带命令行运行还莫名的打开了另外一个编辑器
|               # 使用的是 vscode 编辑代码 cmder 运行打开了webstorm ，这都是文件名称不正确导致的。
|               # 当然，如果可以找到并修改gulp的配置文件，理论上可以做到按照我们定的文件名来执行。！！！！但是不麻烦么
├──index.html         # 文件(创建):hmtl 源码文件，页面结构入口文件
├──package.json       # 文件(生成)：使用 yarn add 安装工具产生的文件  （项目配置文件）
├──README.md          # 文件(创建):：手动创建的，项目说明文档
├──webpack.config.js  # 文件(创建):：手动创建 （webpack 配置文件））
└──yarn.lock   # 文件(生成)：使用 yarn 安装工具产生的文件  （用于锁定安装包的精确版本以及所有依赖项）
                # 只要不删除 yarn.lock 文件就可以使用命令 `yarn install` 根据 yarn.lock 文件的内容来还原获取所有的依赖包，
                # 保证所有人用到这个项目的时候安装的依赖包都是一致的。
```

### 4.2 使用 yarn 初始化 src 文件夹

yarn 下载安装：[网址](http://yarnpkg.com)
yarn 文档学习：[网址](https://yarnpkg.com/zh-Hans/docs)，[yarn cli 网址](https://yarnpkg.com/zh-Hans/docs/cli/)

#### 4.2.1 安装 gulp 构建工具

```BASH
$ npm install -g gulp             # 全局安装 gulp 工具
```

```bash
$ yarn init                       #初始化包：创建或更新 package.json 文件。
$ yarn add --dev gulp  gulp-util  #添加开发 （--dev 或 -D）用的 gulp 与 gulp-util 工具，（生产阶段不需要）
$ yarn add --dev gulp-less        #添加开发 （--dev 或 -D）用的，用于构建 less 模块（生产阶段不需要，生产阶段用的是转译后的 css）
$ yarn add -D webpack-stream      #添加开发 （--dev 或 -D）用的，用于打包
$ yarn add --dev babel-core babel-loader babel-preset-es2015
                                  #添加开发 babel-core：babel ，babel-loader：webpack的，babel-preset-es2015：一个预设集
$ yarn add gulp-connect --dev     # 安装 服务器工具 gulp-connect
$ yarn install                    # 在本地 node_modules 目录安装 package.json 里列出的所有依赖。
```

注意: yarn 工具与 npm 的差异， yarn 是 npm 的升级，要比 npm 要快，
yarn 安装 工具 使用 add，只有还原依赖的时候使用 install

#### 4.2.1 生成的 package.json 文件

根据上面的命令行安装下载工具之后，在 src 文件夹下的可以看到如下的文件内容。

```JSON
//package.json 文件下的内容
{
  "name": "shudu",
  "version": "1.0.0",
  "main": "index.js",
  "license": "MIT",
  "devDependencies": {
    "babel-core": "^6.26.3",
    "babel-loader": "^8.0.4",
    "babel-preset-es2015": "^6.24.1",
    "gulp": "^3.9.1",
    "gulp-connect": "^5.6.1",
    "gulp-less": "^4.0.1",
    "gulp-util": "^3.0.8",
    "webpack-stream": "^5.1.1"
  }
}
```

#### 4.2.2 创建的 gulpfile.js 文件

```JS
//gulpfile.js 文件
const gulp = require('gulp')

//定义 webpack 任务：转译 JavaScript
gulp.task('webpack',()=>{
  //
})

//定义 less 任务：转译 less => css
gulp.task('less',()=>{
  //
})

// 定义默认任务，直接依赖与上面定义的 'webpack' 与 'less'  任务
gulp.task('default',['webpack','less'])
```

先创建上面这样一个文件，先运行 `gulp` 若没有发生错误，这个文件就编辑正确了。没有错误，再补充这个文件。
在这种状态就运行非常简单就可以判断这个文件是否有效，如果等编辑的内容多了再来判断，发生错误的话很麻烦去找出错误的原因，编程就是一步步的判断是否执行正确，发生错误的时候自己能很快的找到错误在哪里，提高效率。下面有可能是会发生很多的错误。

```JS
// 完整的 gulpfile.js 文件
const gulp = require('gulp'); //引入 gulp
const connect = require('gulp-connect'); // 引入 gulp-connect

// 定义一个 web-server 任务：/*设置服务器*/
gulp.task('webserver', function () {
  connect.server({
    root: ['dist'], //要运行哪个目录
    livereload: true, //是否热更新。
    port: 8888 //端口号
  }); // gulp 之后生成一个服务器地址 eg：http://localhost:8888
});

//定义 webpack 任务：转译 JavaScript
gulp.task('webpack', () => {
  const webpack = require('webpack-stream') // 引入 webpack-stream
  const config = require('./webpack.config.js') // 引入 webpack 的配置文件
  gulp.src('./src/js/**/*.js') // 源码中的所有 js 文件
    .pipe(webpack(config)) // 转译 过程
    .pipe(gulp.dest('./dist/js')) //转译到 www 文件夹下的 js 文件
    .pipe(connect.reload());
})

//定义 less 任务：转译 less => css
gulp.task('less', () => {
  const less = require('gulp-less')
  gulp.src('./src/less/*.less') // 源码中的所有 less 文件
    // './src/less/*.less'   . 表示当前目录的意思，它 等价于 'src/less/*.less' 
    .pipe(less()) // 转译 过程
    .pipe(gulp.dest('./dist/css')) //转译到 www 文件夹下的 css 文件
    .pipe(connect.reload());
})

// 定义任务 将 html 文件移动到另外一个位置：html 不需要编译
gulp.task('html', () => {
  /*要操作哪些文件 确定源文件地址*/
  gulp.src('index.html')
    .pipe(gulp.dest('./dist'))
    .pipe(connect.reload());
});

gulp.task('ico',()=>{
  gulp.src('favicon.ico')
  .pipe(gulp.dest('./dist'))
})

// 定义默认任务，直接依赖与上面定义的 'webpack' 与 'less'  任务
// 运行 gulp 将会执行这项任务
gulp.task('default', ['webpack', 'less', 'html', 'webserver','ico','watch'])

// 定义 watch 任务，一旦 js /less 有改变，将自动编译，不需要每次都在命令行去 gulp 执行编译。
// 有了这个 watch 任务之后，在命令行执行 `gulp && gulp watch` 命令，然后再编辑过程中就不需要去动用命令行了，
// 会自动的编译，我们就只要关心 html ，src下的 js /less 编辑，以及浏览器 审查就好了。
gulp.task('watch', () => {
  gulp.watch('src/js/**/*.js', ['webpack']) // 一旦 src 下的 所有 js 文件中有改变的就执行 webpack 任务
  gulp.watch('src/less/**/*.less', ['less']) // 一旦 src 下的  less 文件有所改变就执行  less  任务
  gulp.watch('index.html', ['html']) // hmtl 文件有所改变就执行  html  任务
})
```

#### 4.2.3 创建 webpack.config.js 文件

```JS
var webpack = require('webpack');

// 导出对象
module.exports = {
  //入口文件，现在 src/js 文件夹下创建一个 index.js 文件
  mode: 'development',
  entry: {
    index: './src/js/index'
  },
  // 出口文件,输出在 gulpfile 已经指定了，这里就只需要写 文件名就好
  output: {
    filename: '[name].js' // [name].js 这样是什么意思啊？？？？
  },
  //细粒度的配置，source map 格式来增强调试过程。不同的值会明显影响到构建(build)和重新构建(rebuild)的速度。
  devtool: 'source-map',
  resolve: { // 解决的问题
    extensions: ['.js'] // extensions 扩展 ！！！！！！
  },
  module: {
    rules: [{
      test: /\.js$/, // 处理的是 js 文件
      exclude: /node_modules/, //排除依赖包文件夹    
      use: [{
        loader: 'babel-loader', // 使用的是 babel-loader 工具
        // loader:用于对模块的源代码进行转换。loader 可以使你在 import 或"加载"模块时预处理文件。
        //        因此，loader 类似于其他构建工具中“任务(task)”
        options: {
          //当前 loader 需要的特殊配置：webpack 2.5 之前为 query，之后为 options
          // 预置 es2015
          presets: ['es2015'] ////按照最新的 ES6 语法规则去转换
        }
      }]
    }]
  },
  externals: {
    //外部扩展，提供了「不从bundle 中引用依赖」的方式，也就是说，自己的库本身不打包这个lodash，需要用户环境提供。
    // 我们想引用一个库，但是又不想让 webpack 打包 （如果把这个 lodash 打入进去，打包文件就会非常大，影响我们的打包速度）
    // 总得来说，externals 配置就是为了使 import _ from 'lodash' 这句代码，在本身不引入 lodash 的情况下，能够在各个环境都能解释执行。
    "jquery": "jQuery"
  },
  plugins: [ // ProvidePlugin 允许代码中直接使用定义的属性，而不需要 require()
    // 比如下面的定义可以直接使用 $，而不再需要 const $ = require("jquery");
    // 这里使用到 webpack 需要在文件开头引入 var webpack = require('webpack');
    // 否则会报错  ReferenceError: webpack is not defined
    new webpack.ProvidePlugin({
      $: "jquery"
    })
  ]
}
```

#### 4.2.4  webpack.config.js  与 gulpfile.js 编辑过程的错误

关于 module 模块的学习，可以查看这该网址：[地址](https://webpack.docschina.org/configuration/module/)

① **extensions: ['.js']** 注意单词拼写！！！
② **webpack 版本的问题**
    **webpack.config.js 文件中 query 与  options**webpack2.5 之前为 query，之后为 options。 新版本的 webpack 不要忘记更新。
    该问题可以查看：[Stack Overflow](https://stackoverflow.com/questions/45273988/webpack3-jshint-loader-does-not-work/45274620#45274620)

```BASH
λ gulp
[18:21:13] Using gulpfile F:\qianduan_dir\00program\JQuery\shudu\src\gulpfile.js
[18:21:13] Starting 'webpack'...
[18:21:17] 'webpack' errored after 3.99 s
[18:21:17] WebpackOptionsValidationError: Invalid configuration object. Webpack has been initialised using a configuration object that does not match the API schema.
 - configuration.module has an unknown property 'loader'. These properties are valid:
   object { defaultRules?, exprContextCritical?, exprContextRecursive?, exprContextRegExp?, exprContextRequest?, noParse?, rules?, strictExportPresence?, strictThisContextOnImports?, unknownContextCritical?, unknownContextRecursive?, unknownContextRegExp?, unknownContextRequest?, unsafeCache?, wrappedContextCritical?, wrappedContextRecursive?, wrappedContextRegExp? }
   -> Options affecting the normal modules (`NormalModuleFactory`).
 - configuration.resolve has an unknown property 'extentions'. These properties are valid:
   object { alias?, aliasFields?, cachePredicate?, cacheWithContext?, concord?, descriptionFiles?, enforceExtension?, enforceModuleExtension?, extensions?, fileSystem?, mainFields?, mainFiles?, moduleExtensions?, modules?, plugins?, resolver?, symlinks?, unsafeCache?, useSyncFileSystemCalls? }
   -> Options for the resolver
```

③ **webpack**loader: 'babel-loader' 不要漏写说明东西！！！
    该问题可以查看：[Stack Overflow](https://stackoverflow.com/questions/42520932/gulp-unhandled-stream-error-in-pipe)

```BASH
λ gulp
internal/streams/legacy.js:59
      throw er; // Unhandled stream error in pipe.
      ^
Error: Entry module not found: Error: Can't resolve 'babel' in 'F:\qianduan_dir\00program\JQuery\shudu\src'(这里有说明错误)
BREAKING CHANGE: It's no longer allowed to omit the '-loader' suffix when using loaders.
                 You need to specify 'babel-loader' instead of 'babel',
                 see https://webpack.js.org/migrate/3/#automatic-loader-module-name-extension-removed
resolve 'babel' in 'F:\qianduan_dir\00program\JQuery\shudu\src'
  Parsed request is a module
  using description file: F:\qianduan_dir\00program\JQuery\shudu\src\package.json (relative path: .)
    resolve as module
      F:\qianduan_dir\00program\JQuery\shudu\node_modules doesn't exist or is not a directory
      F:\qianduan_dir\00program\JQuery\node_modules doesn't exist or is not a directory
      F:\qianduan_dir\00program\node_modules doesn't exist or is not a directory
      F:\node_modules doesn't exist or is not a directory
      looking for modules in F:\qianduan_dir\node_modules
        No description file found
      looking for modules in F:\qianduan_dir\00program\JQuery\shudu\src\node_modules
        using description file: F:\qianduan_dir\00program\JQuery\shudu\src\package.json (relative path: ./node_modules)
          using description file: F:\qianduan_dir\00program\JQuery\shudu\src\package.json (relative path: ./node_modules/babel)
            no extension
              F:\qianduan_dir\00program\JQuery\shudu\src\node_modules\babel doesn't exist
        No description file found
            .js
              F:\qianduan_dir\00program\JQuery\shudu\src\node_modules\babel.js doesn't exist
        no extension
          F:\qianduan_dir\node_modules\babel doesn't exist
            .json
              F:\qianduan_dir\00program\JQuery\shudu\src\node_modules\babel.json doesn't exist
        .js
          F:\qianduan_dir\node_modules\babel.js doesn't exist
            as directory
              F:\qianduan_dir\00program\JQuery\shudu\src\node_modules\babel doesn't exist
        .json
          F:\qianduan_dir\node_modules\babel.json doesn't exist
        as directory
          F:\qianduan_dir\node_modules\babel doesn't exist
```

④ **webpack 与 babel 版本**

```BASH
Unhandled rejection Error in plugin "webpack-stream"
Message:
    ./js/index.js
Module build failed (from ./node_modules/babel-loader/lib/index.js):
Error: Cannot find module '@babel/core'
 babel-loader@8 requires Babel 7.x (the package '@babel/core'). If you'd like to use Babel 6.x ('babel-core'), you should install 'babel-loader@7'
```

这个问题在安装 babel-loader 的时候有提示下面的提示。（题外话：`install` has been replaced with `add` to add new dependencies. Run "yarn add babel-loader" instead.）

```BASH
λ yarn add --dev babel-loader
yarn add v1.9.4
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
warning " > webpack-cli@3.1.2" has unmet peer dependency "webpack@^4.x.x".
warning " > babel-loader@8.0.4" has unmet peer dependency "@babel/core@^7.0.0".
warning " > babel-loader@8.0.4" has unmet peer dependency "webpack@>=2".
[4/4] Building fresh packages...
success Saved 1 new dependency.
info Direct dependencies
└─ babel-loader@8.0.4
info All dependencies
└─ babel-loader@8.0.4
Done in 12.13s.
```

上面三个警告解决
[3/4] Linking dependencies...
warning " > webpack-cli@3.1.2" has unmet peer dependency "webpack@^4.x.x".
warning " > babel-loader@8.0.4" has unmet peer dependency "@babel/core@^7.0.0".
warning " > babel-loader@8.0.4" has unmet peer dependency "webpack@>=2".

 链接依赖项，需要将后者下载下来。

⑤ **mode**

```BASH
λ gulp
[00:13:30] Using gulpfile F:\qianduan_dir\00program\JQuery\shudu\src\gulpfile.js
[00:13:30] Starting 'webpack'...
[00:13:36] Finished 'webpack' after 6.13 s
[00:13:36] Starting 'less'...
[00:13:38] Finished 'less' after 1.99 s
[00:13:38] Starting 'default'...
[00:13:38] Finished 'default' after 99 μs
[00:13:46] Version: webpack 4.23.1
Built at: 2018-11-03 00:13:46
   Asset       Size  Chunks             Chunk Names
index.js  944 bytes       0  [emitted]  index
Entrypoint index = index.js

WARNING in configuration
The 'mode' option has not been set, webpack will fallback to 'production' for this value. Set 'mode' option to 'development' or 'production' to enable defaults for each environment.
You can also set it to 'none' to disable any default behavior. Learn more: https://webpack.js.org/concepts/mode/
```

错误警告：没有设定是开发模式还是生产模式,要求指定.解决：[网址](https://webpack.js.org/concepts/mode/#usage),这里用的的是 `mode: 'development'`，是开发阶段使用的。

⑥ **weback is not undefined**

```JS
// 在 wepack.config.js 中加入这段代码之后出错
  externals: {
    "jquery": "jQuery"
  },
  plugins: [
    // ProvidePlugin 允许代码中直接使用定义的属性，而不需要 require()
    // 比如下面的定义可以直接使用 $，而不再需要 const $ = require("jquery");
    // 这里使用到 webpack 需要在文件开头引入 var webpack = require('webpack');
    // 否则会报错  ReferenceError: webpack is not defined
    new webpack.ProvidePlugin({
      $: "jquery"
    })
  ]
```

```BASH
λ gulp
[15:34:38] Working directory changed to F:\qianduan_dir\00program\JQuery\shudu\src
[15:34:38] Using gulpfile F:\qianduan_dir\00program\JQuery\shudu\src\gulpfile.js
[15:34:38] Starting 'webpack'..
[15:34:39] 'webpack' errored after 201 ms
[15:34:39] ReferenceError: webpack is not defined
 ```

 解决问题：编译器已经告诉我们是因为 webpack 没有定义了，需要使用到这个变量，我们需要在 wepack.config.js 文件开头就将这个 webpack 引进来。[问题](https://segmentfault.com/a/1190000008367991)

 ```JS
 var webpack = require('webpack'); // 开头引进来，后面才能使用 webpack 这个变量
 ```

⑦ 浏览器运行问题

```BASH
WebSocket connection to 'ws://localhost:35729/livereload' failed: Error in connection establishment: net::ERR_CONNECTION_REFUSED
```

这是命令行关闭了，没有在运行，所以浏览器找不到服务器了。

### 4.3 使用 npm 初始化 src 文件夹

## 五、 页面实现，数据结构设计，数据处理

页面视觉设计一般是视觉设计师做的活。页面实现、数据结构设计是前端工程师的活。

![TU1](http://p1teq0wgy.bkt.clouddn.com/------1.jpg)
![TU2](http://p1teq0wgy.bkt.clouddn.com/-----2.jpg)
![TU3](http://p1teq0wgy.bkt.clouddn.com/----3.png)

在这里，我们做的是数组游戏，使用的是 数组结构（二维数组/矩阵数组），二维数组 A[m][n]，这是一个 m 行，n 列的二维数组。 m 就是第 m 行， n 是每行的第 n 列。每行是一个 一维数组（内层数组）,整个九宫格是一个二维数组（外层数组）

二维数组/矩阵数组 matix
每行数据（一维数组）：aRow = matix[i]
每个格子数据（数字）：aCell = aRow[j]
格子中的数据是 1-9 ，空时为 0 ，在 js 中它对应的布尔值为 false ，对应布尔值的值有 null，undefined，'' ，0 ，这里使用 0 ，为了数据类型的统一。

### 5.1 数据结构-二维数组

```JS
// 创建 一维数组
function makeRowArray(v) {
  // 传一个默认值为 0 的变量 v
  const arr = new Array(9) // 创建一个长度为 9 的数组 ，赋值给常量 arr
  arr.fill(v) // 用变量 v 填充整个数组 arr
  return arr
}

// 创建二维数组
function makeMatix(v) {
  const arr = new Array(9)
  // 调用 Array.from() 创建数组，使用第二个参数对 类数组中的元素进行处理
  return Array.from({
    length: 9
  }, () => makeRowArray(v))
  //return Array.from({length:9}).map(()=>makeRowArray()) 这里是传一个参数，得到数组使用 map() 方法
}

var a = makeMatix(0) // 这里怎么使用 const ？？？、不懂
a[2][2] = 2
console.log(a)
/*λ node .
[ [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 2, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
  [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]
*/
// 得到上面这样的代码就可以正确的创建了一个九宫格二维数组了
```

### 5.2 洗牌算法-随机生成二维数组数据

[洗牌算法](https://gaohaoyang.github.io/2016/10/16/shuffle-algorithm/)，简单来说 Fisher–Yates shuffle 算法是一个用来将一个有限集合生成一个随机排列的算法（数组随机排序）。这个算法生成的随机排列是等概率的。同时这个算法非常高效。Fisher–Yates shuffle 算法是一个非常高效又公平的随机排序算法，如果有随机排序数组的需求，就用这个算法，非常的高效。

[洗牌算法](https://blog.csdn.net/pngynghay/article/details/23529421)

[方法动画](https://codepen.io/haoyang/pen/jrvrQq)

```JS
// 给 Array 类 添加 shuffle 方法，并且是从后面开始交换
Array.prototype.shuffle = function () {
  let n = this.length - 1
  for (var i = n; i >= 0; i--) {
    var j = Math.floor(Math.random() * (i + 1));
    [this[j], this[i]] = [this[i], this[j]]
  }
  return this; //this 表示的是 Array 类
}

// 编写一个 shuffle1 方法，并且是从前面开始交换
function shuffle1(arr) {
  let n = arr.length
  // 交换 n-1 次就ok 了
  for (let i = 0; i < n - 1; i++) {
    let j = i + Math.floor(Math.random() * (n - i));
    // （i 位置）与 （ i 到最后元素中的一个，包含 i） 做交换
    [arr[i], arr[j]] = [arr[j], arr[i]]
  }
  return arr
}
```

### 5.3 洗牌算法-检查算法：检查洗牌算法填入的数字是否符合 数独游戏的要求（每行，每列，每宫 由1-9组成，每个数字出现一次）

### 5.4 工具包 toolkit

大规模的设计，需要将一个大程序拆分成互相依赖的小文件，再用简单的方法拼装起来。而不是在一个入口执行文件写大段的代码，这样不利于编程。

在 ES6 之前， JS  是没有自己的模块的，它使用的是 commonJS ，也就是 `module.export->require` 形式.其他语言都有这项功能，比如 Ruby 的require、Python 的import，甚至就连 CSS 都有 @import，但是 JavaScript 任何这方面的支持都没有，这对开发大型的、复杂的项目形成了巨大障碍。

ES6 之后拥有了这个 module ，我们可以将大程序拆分成互相依赖的小文件，再用简单的方法拼装起来。很多 js 代码我们可以编辑在工具包内，不应该都写在入口执行文件内。

JavaScript 的 [module](http://es6.ruanyifeng.com/#docs/module)

ES5 commonJS: `module.export->require`
ES6 module : `export->import`

关于这两个使用模块的方法，可以查看这边文章：[搞明白require和import](http://imweb.io/topic/582293894067ce9726778be9)

本文中我们也是使用 ES5 commonJS 来做这个工具包模块的导出导入应用。将 5.1 、5.2 节的代码编写成模块。

```JS
// Toolkit.js 文件
 const martixToolkit = {
   makeRowArray(v = 0) {
     const arr = new Array(9)
     arr.fill(v)
     return arr
   },
   makeMatix() {
     return Array.from({
       length: 9
     }, () => this.makeRowArray()) // 在 ES6 的模块中不能使用this
   },
   shuffle(arr) {
     let n = arr.length - 1
     for (var i = n; i >= 0; i--) {
       var j = Math.floor(Math.random() * (i + 1));
       [arr[j], arr[i]] = [arr[i], arr[j]]
     }
     return arr;
   }
 }

 module.exports = martixToolkit;
```

```JS
//index.js 入口文件
const toolkit=require('./toolkit') // commonJS 模块导入方法

const matix=toolkit.makeMatix() // 调用 toolkit 的 makeMatix() 方法创建一个 matix 二维数组/矩阵
console.log(matix)
console.log(toolkit.shuffle([1,2,3,4,5,6,7,8,9]))
```

### 5.5 HTML 页面制作

#### 5.5.1 gulp 构建

编辑好 html 文件，使用 gulp 构建 less->css,module.js->js.
src 中保存在的是编译之前的文件，以及下载安装的依赖包，
www 中保存的是编译之后生成的文件，以及编辑的 html 文件。

```BASH
$ gulp               # 代码编辑之后构建
$ gulp && gulp watch # 在 webpack.config.js  写上 watch 任务，监听变化构建
```

#### 5.5.2 html 代码

- 写代码之前先写分行写注释：便于识别代码区域，后期也好维护
- 用 less 编辑的
- 复杂的代码，就像是表格这种是用 js 生成的，（用时长），不要忘记要在 js 中保证文本加载完全再做操作

```HTML
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" type="text/css" href="css/main.css">
  <script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
  <!--  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->
  <script src="js/index.js"></script>
  <!-- 引入jquery库，以及 www.js 下编译生成的 js -->
  <title>数独游戏</title>
</head>

<body>
  <div class="main">
    <!-- 标题，难易度星星 -->
    <div class="shudu-title">
      <div class="title">数独游戏</div>
      <div class="level">关卡 9</div>
      </h1>
    </div>
    <!-- 用时，帮助 -->
    <div class="time-help">
      <div class="time">用时</div>
      <div>帮助</div>
    </div>
    <!-- 九宫格 -->
    <div id="container" class="container gird">
    </div>
    <!--  操作按钮组,数字选择框 -->
    <div class="number-board">
      <div>1</div>
      <div>2</div>
      <div>3</div>
      <div>4</div>
      <div>5</div>
      <div>6</div>
      <div>7</div>
      <div>8</div>
      <div>9</div>
    </div>
    <!--  操作按钮组 -->
    <div class="operation-board">
      <div>返回</div>
      <div>前进</div>
      <div>重置</div>
      <div>暂停</div>
      <div>提交</div>
    </div>
  </div>
</body>

</html>
```

```LESS
@shadowBottom: 0 0.2rem 0.3rem rgba(48, 48, 48, 192);
@shadowTop: 0 -0.1rem 0.2rem rgba(48, 48, 48, 192);
html {
  font-size: 14px;
  body {
    margin: 0;
    padding: 0;
    font-family: "Consolas", "微软雅黑";
    background: #fff;
    user-select: none;
    /* 禁止选择复制内容，如果允许选择，碰到选择了会用户体验不好 */
    max-width: 450px;
    > * {
      max-width: 450px;
    }
    .main {
      padding: 0.5rem;
      .shudu-title {
        // rem  是 css3 中新增的尺寸单位：相对的 HTML根 元素的大小，后期值需要更新 html 根元素的尺寸即可。
        margin-bottom: 1.5rem;
        padding: 1rem;
        font-size: 1.5rem;
        display: flex;
        justify-content: space-between;
        color: #fff;
        background: rgb(54, 148, 192);
        box-shadow: @shadowBottom;
        .title {
          flex: 2;
        }
        .level {
          flex: 1;
        }
      }

      .time-help {
        padding: 0.5rem;
        display: flex;
        justify-content: flex-end;
        .help {
          margin: 0.5rem;
          border-radius: 1rem;
        }
      }

      #container {
        margin: 1rem 0;
        padding: 0 5%;
        .row {
          display: flex;
          justify-content: center;
          > span {
            // > span 是什么？
            display: inline-block;
            cursor: pointer;
            text-align: center;
            width: 10%;
            //height: 24px;
            //line-height: 24px;
            border: 1px solid #cccccc;
            border-right-width: 0;
            border-bottom-width: 0;
            background: white;
            & :first-child {
              border-left-width: 2px;
            }
            & :last-child {
              border-right-width: 2px;
            }
            // 这里为什么需要 & ？？？
            &.col_g_right {
              border-right-width: 2px;
            }
          }
          & :first-child {
            > span {
              border-top-width: 2px;
            }
          }
          & :last-child {
            > span {
              border-bottom-width: 2px;
            }
          }
          // 这里为什么需要 & ？？？
          &.row_g_bottom {
            > span {
              border-bottom-width: 2px;
            }
          }
        }
      }
      .number-board,
      .operation-board {
        margin: 0.1rem 0;
        padding: 0.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      .number-board {
        div {
          padding: 0.5rem 0.8rem;
          background: rgb(223, 152, 46);
          //height: 2rem;
          font-size: 1.3rem;
          //width: 2rem;
          border-radius: 1rem;
        }
      }
      .operation-board {
        div {
          padding: 0.5rem 1rem;
          background: rgb(54, 148, 192);
          //height: 3rem;
          font-size: 1.3rem;
          //width: 3rem;
          border-radius: 1rem;
        }
      }
    }
  }
}
```

#### 5.5.3 用 js 代码生成九宫格

```JS
// index.js
const toolkit = require('./toolkit') // commonJS 模块导入方法

//const matix = toolkit.makeMatix()

class Gird {
  // 这个类 需要传入一个 $('') 选择器
  constructor(container) {
    this._$container = container // ？？？
  }
  /*     map() 方法返回一个新数组，数组中的元素为原始数组元素调用函数处理后的值。
    map() 方法按照原始数组元素顺序依次处理元素。注意： map() 不会对空数组进行检测。map() 不会改变原始数组。 */
  build() {
    const martix = toolkit.makeMatix(); // 调用矩阵，创建一个元素都是 0 的二维数组
    const rowGroupClasses = ['row_g_top', 'row_g_middle', 'row_g_bottom'] // 定义行样式，使用解构赋值，需要操作的是 row_g_bottom
    const colGroupClasses = ['col_g_left', 'col_g_middle', 'col_g_right'] // 定义列样式，使用解构赋值，需要操作的是 col_g_right
    //martix.map(RowArray => $div); // 二维数组的 元素 也就是 一维数组/每行数据 映射为 div
    //RowArray.map(cellValue =>)     // 一维数组/每行数据 映射为 <span>cellValue</span>
    const $cells = martix.map(rowValues => rowValues.map((cellValue, colIndex) => {
      return $("<span>") // 2 个 map 遍历，可以执行九宫格中所有的数组
        .addClass(colGroupClasses[colIndex % 3]) //addClass() - 向被选元素添加一个或多个类 (每宫右边的外框加粗线)
        .text(cellValue); //<span>cellValue</span> //设置 text(str) 或返回 text() 所选元素的文本内容
    }));
    const $divArray = $cells.map(($spanArray, rowIndex) => {
      // 1 个 map 遍历，每次处理 1 行
      return $("<div>")
        .addClass('row')
        .addClass(rowGroupClasses[rowIndex % 3]) //(每宫底边的外框加粗线)
        .append($spanArray);
      // append() 在被选元素的结尾插入内容  
      // http://www.runoob.com/jquery/jquery-dom-add.html
    })
    this._$container.append($divArray);
  }
  // 给 Gird 类添加一个布局方法
  layout() {
    const width = $('span:first', this._$container).width() // $ 里面传 2 个参数？？？
    $('span', this._$container)
      .height(width) // 是的高度等于宽度
      .css({
        'line-height': `${width}px`, // ES6 字符串模本语法
        'font-size': width < 32 ? `${width/2}px` : ''
      })
  }
}

// 要在文档加载完全之后执行 window.onload =函数
/* $(document).ready(function () {
  const gird=new Gird($("#container"))
  gird.build();
  gird.layout();
}); */
$(function () {
  var gird = new Gird($("#container"))
  gird.build();
  gird.layout();
})
```

## 六、 完整的代码实现过程

### 6.1 重构代码：就是框架，代码，模块的划分

#### 6.1.1 脚本目录结构：src/js 下的 JavaScript 目录结构

这里是前面章节的 整体结构树

```BASH
└─src                   # 文件夹：源码文件夹 手动创建 或者 命令行创建的文件夹 （src 为约定俗成命名）
  ├──js
  | └───index.js                # 文件夹：手动创建 或者 命令行创建的文件夹
  ├──less               # 文件夹：手动创建 或者 命令行创建的文件夹
  ├──node_modules       # 文件夹：使用 yarn 安装工具产生的文件夹（依赖包）
  ├──package.json       # 文件：使用 yarn 安装工具产生的文件  （项目配置文件）
  ├──webpack.config.js  # 文件：手动创建 （webpack 配置文件）
  ├──yarn.lock          # 文件：使用 yarn 安装工具产生的文件  （用于锁定安装包的精确版本以及所有依赖项）
  |                     # 只要不删除 yarn.lock 文件就可以使用命令 `yarn install` 根据 yarn.lock 文件的内容来还原获取所有的依赖包，
  |                     # 保证所有人用到这个项目的时候安装的依赖包都是一致的。
  ├──gulpfile.js       # 文件：手动创建的文件 （用于构建）注意：这个文件的名字一定要是 gulpfile ，不能改名，
  |                     # 否则运行的 `gulp` 的时候回出现错误 `No gulpfile found` ，在电脑自带命令行运行还莫名的打开了另外一个编辑器
  |                     # 使用的是 vscode 编辑代码 cmder 运行打开了webstorm ，这都是文件名称不正确导致的。
  |                     # 当然，如果可以找到并修改gulp的配置文件，理论上可以做到按照我们定的文件名来执行。！！！！但是不麻烦么
└─www                   # 文件夹：生产文件夹 手动创建 或者 命令行创建的文件夹 （www 可自行命名）
  |                     # 文件夹：手动创建 或者 命令行创建的文件夹
  ├──css               # gulp 编译生成的文件夹，以及内部文件
  ├──js                # gulp 编译生成的文件夹，以及内部文件
  └─ index.html        # 手动创建编辑的 html 页面结构入口文件。
```

src/js 目录更新为

```BASH
~src/js
  ├──index.js            # 页面入口以及事件绑定
  ├──core/                 # 算法以及数据结构相关的脚本
  |   ├──toolkit.js      # 工具方法集
  |   ├──generator.js    # 生成数独解决方案：洗牌算法
  |   ├──checker.js      # 检查数独解决方案：检查洗牌算法
  |   ├──shudu.js        # 生成数独游戏
  |
  └─ ui/                   # 界面相关的脚本
     ├──gird.js          # 生成九宫格
     └──number-board.js  # 处理弹出的操作面板？？？我做的不需要吧
```

```BASH
λ .\node_modules\.bin\gulp && .\node_modules\.bin\gulp watch # 项目内运行
λ gulp && gulp watch   # 全局运行
```

①问题：要在 src 目录项运行

下面这里没有在 src 而是在 js 下面运行，没有 index.js 入口文件，运行时会报错的，这里就报错了， `throw er; // Unhandled stream error in pipe.`，如果不知道的话，还以为是 webpack 文件出错，但是在 src 运行又正确了，。

```BASH
λ gulp && gulp watch
[22:24:57] Working directory changed to F:\qianduan_dir\00program\JQuery\shudu\src
[22:24:59] Using gulpfile F:\qianduan_dir\00program\JQuery\shudu\src\gulpfile.js
[22:24:59] Starting 'webpack'...
[22:25:07] Finished 'webpack' after 7.62 s
[22:25:07] Starting 'less'...
[22:25:08] Finished 'less' after 1.35 s
[22:25:08] Starting 'default'...
[22:25:08] Finished 'default' after 101 μs

internal/streams/legacy.js:59
      throw er; // Unhandled stream error in pipe.
      ^
Error: ./js/ui/gird.js
Module not found: Error: Can't resolve './core/toolkit' in 'F:\qianduan_dir\00program\JQuery\shudu\src\js\ui'
resolve './core/toolkit' in 'F:\qianduan_dir\00program\JQuery\shudu\src\js\ui'
  using description file: F:\qianduan_dir\00program\JQuery\shudu\src\package.json (relative path: ./js/ui)
    Field 'browser' doesn't contain a valid alias configuration
    using description file: F:\qianduan_dir\00program\JQuery\shudu\src\package.json (relative path: ./js/ui/core/toolkit)
      no extension
        Field 'browser' doesn't contain a valid alias configuration
        F:\qianduan_dir\00program\JQuery\shudu\src\js\ui\core\toolkit doesn't exist
      .js
        Field 'browser' doesn't contain a valid alias configuration
        F:\qianduan_dir\00program\JQuery\shudu\src\js\ui\core\toolkit.js doesn't exist
      as directory
        F:\qianduan_dir\00program\JQuery\shudu\src\js\ui\core\toolkit doesn't exist
[F:\qianduan_dir\00program\JQuery\shudu\src\js\ui\core\toolkit]
[F:\qianduan_dir\00program\JQuery\shudu\src\js\ui\core\toolkit.js]
 @ ./js/ui/gird.js 8:14-39
 @ ./js/index.js


F:\qianduan_dir\00program\JQuery\shudu\src  (shudu@1.0.0)
λ .\node_modules\.bin\gulp && .\node_modules\.bin\gulp watch
[22:30:39] Using gulpfile F:\qianduan_dir\00program\JQuery\shudu\src\gulpfile.js
[22:30:39] Starting 'webpack'...
[22:30:42] Finished 'webpack' after 2.89 s
[22:30:42] Starting 'less'...
[22:30:43] Finished 'less' after 786 ms
[22:30:43] Starting 'default'...
[22:30:43] Finished 'default' after 122 μs
[22:30:46] Version: webpack 4.23.1
Built at: 2018-11-06 22:30:46
       Asset      Size  Chunks             Chunk Names
    index.js   9.6 KiB   index  [emitted]  index
index.js.map  9.38 KiB   index  [emitted]  index
Entrypoint index = index.js index.js.map
[22:30:49] Using gulpfile F:\qianduan_dir\00program\JQuery\shudu\src\gulpfile.js
[22:30:49] Starting 'watch'...
[22:30:49] Finished 'watch' after 54 ms
```

②

问题解决：[网址](https://github.com/aurelia/cli/issues/852)

```BASH
[22:30:49] Starting 'watch'...
[22:30:49] Finished 'watch' after 54 ms
[22:36:35] Starting 'webpack'...
[22:36:38] Finished 'webpack' after 2.74 s
[22:36:38] Starting 'webpack'...
[22:36:38] 'webpack' errored after 7.04 ms
[22:36:38] ConcurrentCompilationError in plugin "webpack-stream"
Message:
    You ran Webpack twice. Each instance only supports a single concurrent compilation at a time.
    # 你运行Webpack两次。 每个实例一次只支持一个并发编译。
Details:
    details: undefined
    missing: undefined
    origin: undefined
    dependencies: undefined
    module: undefined

[22:36:40] Version: webpack 4.23.1
Built at: 2018-11-06 22:36:40
       Asset      Size  Chunks             Chunk Names
    index.js  9.62 KiB   index  [emitted]  index
index.js.map  9.45 KiB   index  [emitted]  index
Entrypoint index = index.js index.js.map
```

运行非 index.js 文件，不是用 gulp 构建，还是使用 node 来直接运行。

```BASH
F:\qianduan_dir\00program\JQuery\shudu\src\js\core
λ node generator.js
```

```Refused to apply style from 'http://localhost:8888/pages/css/home.css' because its MIME type ('text/html') is not a supported stylesheet MIME type, and strict MIME checking is enabled.
2home.html:10 GET http://localhost:8888/pages/js/home.js net::ERR_ABORTED 404 (Not Found)
```
因为 是 home.css 的文件路径不对，编辑时， index.html 与 home.html 放置的位置是不同的
因为 是 home.js 的文件路径不对，编辑时， index.js 与 home.js 放置的位置是不同的