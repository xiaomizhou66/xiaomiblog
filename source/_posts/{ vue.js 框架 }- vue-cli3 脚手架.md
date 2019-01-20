---
title: 'vue-cli3--[小白入门篇、速学篇]'
date: '2018/8/19 23:57:28'
categories:
  - ④  vue.js
  - vue-cli 脚手架
abbrlink: f5907a18
updated:
tags:
comments:
---
# 一、前言

前面都是使用 vue-cli1 来搭建的项目，其实现在已经是 vue-cli3 了，而且现在使用的也比较广泛了。

[vue-cli3 官网](https://cli.vuejs.org/zh/guide/creating-a-project.html#%E4%BD%BF%E7%94%A8%E5%9B%BE%E5%BD%A2%E5%8C%96%E7%95%8C%E9%9D%A2)

# 二、安装 vue-cli3

```BASH
# -g  是 --global 的简写
# -v  是 --version 的简写
# -S  是 --save 的简写
# -D  是 --dev 的简写



$ npm install -g @vue/cli
# OR
$ cnpm install -g @vue/cli
# OR
$ yarn global add @vue/cli # 当然这个需要先安装 yarn

# 安装之后，就可以在命令行中访问 vue 命令。
$ vue --version # 查看 vue-cli 的版本
```

# 三、使用 vue-cli3 搭建项目

[可以参考网上的教程来做](https://www.cnblogs.com/wisewrong/p/9740173.html)

- 命令行搭建
- ui 交互式搭建

## 3.1 命令行搭建项目

```BASH
# 需要需要的是 ts 版的项目，那么首先要确保电脑安装有 ts
$ npm install -g typescript # 首先需要安装有 ts,需要电脑已经存在 ts 就需要再安装了
$ tsc -v 查看ts的版本号

$ vue create my-app # my-app 是项目名称
# 运行上面的命令之后出现下面的选择，
# Vue CLI v3.2.1
# ? Please pick a preset: (Use arrow keys) 请使用 【向下键】 来选择一个预置方式
# > default (babel, eslint)  默认的预置方式 (babel, eslint) 也就是说只有这 2 个插件，直接回车 enter 的话就默认为这个选项
#   Manually select features 手动选择功能（这里就可以选择为 ts 版本）
# 使用 【向下键】 来选择一个预置方式,三角箭头指向那个就是那个

# 手动选择：按住 空格键来选择，按住 a 键 代表选择全部， i 键表示反选
# ? Check the features needed for your project: (Press <space> to select, <a> to toggle all, <i> to invert selection)
#  (*) Babel        编译器 ES6-ES5
# >( ) TypeScript   拓展 TS
#  ( ) Progressive Web App (PWA) Support  [渐进式网页应用](https://juejin.im/post/5a6c86e451882573505174e7)
#  ( ) Router       路由
#  ( ) Vuex         状态管理器
#  ( ) CSS Pre-processors                 CSS 预处理器，例如 scss，less，Stylus 等等
#  (*) Linter / Formatter
#  ( ) Unit Testing 测试单元
#  ( ) E2E Testing  测试单元


# 可以看出上面已经可以选择安装很多东西了， Router 路由， Vuex 状态管理器，scss 等，这些都可以不需要额外的安装了。如果之前没有选择安装的话也可以现在安装这些个插件 ，使用的是 `yarn add` 命令，当然也可以使用 ui 界面来搜索添加组件
$ yarn add router # 创建项目的时候已经安装了其实，如果没有安装，后面需要用到就这样安装
$ yarn add vuex   # 创建项目的时候已经 选择安装了其实，如果没有安装，后面需要用到就这样安装
$ vue add router  # 官网还这样来添加，是什么骚操作
$ vue add vuex    # 官网还这样来添加，是什么骚操作

$ yarn add element-ui # 下载饿了么 ui 框架，这个框架是 PC 端的
$ yarn add iview # 下载 iview 这个 ui 框架，框架都是选择的，选择其一即可。

$ cnpm install axios        # 下载前后端数据交互应用
$ yarn add axios            # 使用 yarn

$ npm install normalize.css # 浏览器兼容 css 文件
$ npm i v-charts echarts -S # 图表 ui 组件库
$ npm install --save dayjs  # 日期时间处理，dayjs 库

$  yarn serve # 开启服务，运行
$  yarn build # 打包
$  yarn lint  # 执行lint
$  yarn test:unit # 执行单元测试
```

### 3.1.1 CSS 预处理器

```BASH
#vue-cli3 本身就支持 PostCSS、CSS Modules 和包含 Sass、Less、Stylus 在内的预处理器。在搭建项目的时候就可以选择是否需要安装了。
# 如果之前没有安装，现在安装就好了
npm install -D sass-loader node-sass # Sass
npm install -D less-loader less # Less
npm install -D stylus-loader stylus # Stylus
```

```SCSS
<style lang="scss">
$color: red;
</style>
```

### 3.1.2 可以执行的命令

```BASH
$ vue create --help # 用这个帮助查看可执行的命令
Usage: create [options] <app-name>
create a new project powered by vue-cli-service
Options:
  -p, --preset <presetName>       Skip prompts and use saved or remote preset
  -d, --default                   Skip prompts and use default preset
  -i, --inlinePreset <json>       Skip prompts and use inline JSON string as preset
  -m, --packageManager <command>  Use specified npm client when installing dependencies
  -r, --registry <url>            Use specified npm registry when installing dependencies (only for npm)
  -g, --git [message]             Force git initialization with initial commit message
  -n, --no-git                    Skip git initialization
  -f, --force                     Overwrite target directory if it exists
  -c, --clone                     Use git clone when fetching remote preset
  -x, --proxy                     Use specified proxy when creating project
  -b, --bare                      Scaffold project without beginner instructions
  -h, --help                      output usage information
```

## 3.2 ui 交互式界面搭建项目

```BASH
$ vue-ui # 在浏览器打开一个页面
# 在打开的界面鼠标操作来搭建项目
```

# 四、项目结构

## 4.1 JS 的项目结构

```bash
.
|-- node_modules    # 依赖包
|
|-- public          # 存放静态文件
|   |-- favicon.ico # 网站图标
|   |-- index.html  # 入口文件，是一个会被 html-webpack-plugin 处理的模板。在构建过程中，资源链接会被自动注入。
|
|-- src              # 源码目录，存放 vue 项目工程文件
|   |-- assets/      # 静态源码文件
|   |-- components/  # 公共组件
|   |-- views/       # 页面组件
|   |-- App.vue           # 页面入口文件
|   |-- main.js           # 程序入口文件，加载各种公共组件
|   |-- router.js         # 路由文件
|   |-- store.js          # vuex 的状态管理
|   |-- interceptor.js    # 自己创建的拦截器
|
|-- .browserslistrc  # 指定了项目的目标浏览器的范围，
|                     # 这个值会被 @babel/preset-env 和 Autoprefixer 用来确定
|                     # 需要转译的 JavaScript 特性 和  需要添加的 CSS 浏览器前缀。
|-- .eslintrc.js
|-- .gitignore        # git 上传需要忽略的文件格式
|-- babel.config.js   # ES6 语法编译配置
|-- package.json      # 项目基本信息
|-- postcss.config.js # css 预处理器配置
|-- README.md         # 项目说明
|-- vue.config.js     # webpack 配置文件（手动创建的：https://segmentfault.com/a/1190000016101954）
|-- yarn.lock         # 版本限制
```

## 4.2 TS 的项目结构

```bash
.
|-- node_modules    # 依赖包
|
|-- public          # 存放静态文件
|   |-- favicon.ico # 网站图标
|   |-- index.html  # 入口文件，这个文件夹下的文件不会纳入webpack的打包中
|
|-- src              # 源码目录，存放 vue 项目工程文件
|   |-- assets/      # 静态源码文件
|   |-- components/  # 公共组件
|   |-- views/       # 页面组件
|   |-- App.vue           # 页面入口文件
|   |-- main.ts           # 程序入口文件，加载各种公共组件
|   |-- router.ts         # 路由文件
|   |-- shims-tsx.d.ts
|   |-- shims-vue.d.ts
|   |-- store.ts          # vuex 的状态管理
|   |-- interceptor.ts    # 自己创建的拦截器
|
|-- .browserslistrc
|-- .gitignore        # git 上传需要忽略的文件格式
|-- package.json      # 项目基本信息
|-- postcss.config.js # css 预处理器配置
|-- README.md         # 项目说明
|-- tsconfig.json     # 语法编译配置
|-- tslint.json       # eslint 的限制
|-- vue.config.js     # webpack 配置文件（手动创建的：https://segmentfault.com/a/1190000016101954）
|-- yarn.lock         # 版本限制
```

## 4.3 public ----HTML 和静态资源

public/index.html 文件是一个会被 html-webpack-plugin 处理的模板。在构建过程中，资源链接会被自动注入。另外，Vue CLI 也会自动注入 resource hint (preload/prefetch、manifest 和图标链接 (当用到 PWA 插件时) 以及构建过程中处理的 JavaScript 和 CSS 文件的资源链接。

### 4.3.1 public/index.html

```HTML
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="icon" href="<%= BASE_URL %>favicon.ico"> 
    <!-- 插值：https://cli.vuejs.org/zh/guide/html-and-static-assets.html#prefetch -->
    <title>todo-</title>
  </head>
  <body>
    <noscript>
      <strong>We're sorry but todo- doesn't work properly without JavaScript enabled. Please enable it to continue.</strong>
    </noscript>
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>
```

## 4.4 src/router.js

## 4.6 babel.config.js

```JS
//babel.config.js
module.exports = {
  presets: [
    // 这里一定要给自己看仔细了，是好多对括号！漏了就没法编译，没法编译，yarn serve 肯定就会错啦！！！！！！！！！！！！！！！！
    ['@vue/app', {
      polyfills: [
        'es6.promise',
        'es6.symbol'
      ]
    }]
  ]
}
```

## 4.7 vue.config.js 手动创建的配置文件

由于 vue-cli 3 也学习了 rollup 的零配置思路，所以项目初始化后，没有了以前熟悉的 build 目录，也就没有了 webpack.base.config.js、webpack.dev.config.js 、webpack.prod.config.js 等配置文件。

其实这一切都是因为 vue-cli3 的项目初始化，帮开发者已经解决了 80% ，甚至绝大部分情形下的 webpack 配置。在实际开发过程中，肯定还有需要自己去修改配置的地方，就需要在项目根目录下手动新建一个 vue.config.js

[官网设置参考](https://cli.vuejs.org/zh/config/#%E5%85%A8%E5%B1%80-cli-%E9%85%8D%E7%BD%AE)
[掘金配置采坑总结](https://juejin.im/post/5bd02f98e51d457a944b634f)

```JS
// vue.config.js
module.exports = {
  //① 设置 baseUrl 选项
  baseUrl: process.env.NODE_ENV === 'production'
    ? '/production-sub-path/'      //开发服务器架设在根路径
    : '/',
  outputDir: 'dist',               // 默认值 dist 设置 打包生成的目录
  assetsDir: 'static',            //放置生成的静态资源 (js、css、img、fonts) 的 (相对于 outputDir 的) 目录。
  indexPath: 'index.html',
  filenameHashing: true,          //hash 以便更好的控制缓存
  pages: {
    index: {
      entry: 'src/index/main.js',// page 的入口
      template: 'public/index.html',// 模板来源
      filename: 'index.html',// 在 dist/index.html 的输出
      // 当使用 title 选项时，
      title: 'Index Page',// template 中的 title 标签需要是 <title><%= htmlWebpackPlugin.options.title %></title>
      chunks: ['chunk-vendors', 'chunk-common', 'index']// 在这个页面中包含的块，默认情况下会包含
      // 提取出来的通用 chunk 和 vendor chunk。
    },
    // 当使用只有入口的字符串格式时，
    // 模板会被推导为 `public/subpage.html`
    // 并且如果找不到的话，就回退到 `public/index.html`。
    // 输出文件名会被推导为 `subpage.html`。
    subpage: 'src/subpage/main.js'
  },
  lintOnSave: true, // 默认值为 true，// eslint-loader 是否在保存的时候检查
  //lintOnSave: process.env.NODE_ENV !== 'production' 在生产构建时禁用 eslint-loader
  runtimeCompiler: false,// 默认值 false, 是否使用包含运行时编译器的 Vue 核心的构建
  transpileDependencies: [],//默认值 [], 默认情况下 babel-loader 忽略其中的所有文件 node_modules
  productionSourceMap: true,//默认值为 true，细粒话构建
  crossorigin: undefined,//默认值为 undefined
  integrity: false,
  //Type: Object | Function
  configureWebpack: (config) => {
  // 简单/基础配置，比如引入一个新插件
  },
  //Type: Object | Function
  chainWebpack: config => {
    config.plugins.delete('prefetch')// 移除 prefetch 插件
    // 或者
    // 修改它的选项：
    config.plugin('prefetch').tap(options => {
      options[0].fileBlacklist = options[0].fileBlacklist || []
      options[0].fileBlacklist.push(/myasyncRoute(.)+?\.js$/)
      return options
    })
    //调整内联文件的大小限制。例如，下列代码会将其限制设置为 10kb：
    config.module
      .rule('images')
        .use('url-loader')
          .loader('url-loader')
          .tap(options => Object.assign(options, { limit: 10240 }))
  },
  // 对组件中 css 的配置
  css: {
    modules: true,//默认值 false
    extract: false,//默认生产环境下是 true，开发环境下是 false
    sourceMap: false,
    loaderOptions: {
      css: {
        // 这里的选项会传递给 css-loader
      },
      postcss: {
        // 这里的选项会传递给 postcss-loader
      },
      scss: {
        // @/ 是 src/ 的别名
        // 所以这里假设你有 `src/variables.scss` 这个文件,可以这样向所有 Sass 样式传入共享的全局变量
        data: `@import "@/variables.scss";`
      },
      less: {
        //
      },
      stylus: {
        //
      }
    }
  },
  devServer: { // 对开发服务的设置 Various Dev Server settings
    proxy: 'http://localhost:4000',//指向开发环境 API 服务器的字符串
    //proxy: {
    //  '/api': {
    //    target: '<url>',
    //    ws: true,
    //    changeOrigin: true
    //  },
    //  '/foo': {
    //    target: '<other_url>'
    //  }
    //}
    host: '0.0.0.0', process.env.HOST
    port: 8080, // can be overwritten by process.env.PORT, if port is in use, a free one will be determined
    open: true, // 自动调用默认浏览器打开
    https: false // 是否使用https, https使用node的一个内部默认的ca证书
  },
  parallel: require('os').cpus().length > 1,
  pwa: {
    //
  },
  pluginOptions: {
    foo: {
      // 插件可以作为 `options.pluginOptions.foo` 访问这些选项。
    }
  }
}
```

# 五、安装过程遇到的问题

## 5.1 ERROR  command failed: yarn --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist

创建了一个 ts 版的没有问题，但是再创建一个 js 版的项目就出现了这个问题。所以是什么鬼问题，具体？？？？

[这个问题 gitHub](https://github.com/vuejs/vue-cli/issues/889)

```BASH
# ts 版
λ vue create hello-world-ts-

Vue CLI v3.2.1
? Please pick a preset: Manually select features
? Check the features needed for your project: Babel, TS, Router, Vuex, CSS Pre-processors, Linter
? Use class-style component syntax? Yes
? Use Babel alongside TypeScript for auto-detected polyfills? No
? Use history mode for router? (Requires proper server setup for index fallback in production) Yes
? Pick a CSS pre-processor (PostCSS, Autoprefixer and CSS Modules are supported by default): Sass/SCSS
? Pick a linter / formatter config: TSLint
? Pick additional lint features: (Press <space> to select, <a> to toggle all, <i> to invert selection)Lint on save
? Where do you prefer placing config for Babel, PostCSS, ESLint, etc.? In dedicated config files
? Save this as a preset for future projects? No


Vue CLI v3.2.1
✨  Creating project in F:\qianduan_dir\00program\web-vue-cli3\hello-world-ts-.
�  Initializing git repository...
⚙  Installing CLI plugins. This might take a while...

yarn install v1.12.3
info No lockfile found.
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
Done in 33.88s.
�  Invoking generators...
�  Installing additional dependencies...

yarn install v1.12.3
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
Done in 47.62s.
⚓  Running completion hooks...

�  Generating README.md...

�  Successfully created project hello-world-ts-.
�  Get started with the following commands:

 $ cd hello-world-ts-
 $ yarn serve
 ```

```BASH
# js 版
λ vue create hello-world-js


Vue CLI v3.2.1
? Please pick a preset: Manually select features
? Check the features needed for your project: Babel, Router, Vuex, CSS Pre-processors, Linter
? Use history mode for router? (Requires proper server setup for index fallback in production) Yes
? Pick a CSS pre-processor (PostCSS, Autoprefixer and CSS Modules are supported by default): Sass/SCSS
? Pick a linter / formatter config: Basic
? Pick additional lint features: (Press <space> to select, <a> to toggle all, <i> to invert selection)Lint on save
? Where do you prefer placing config for Babel, PostCSS, ESLint, etc.? In dedicated config files
? Save this as a preset for future projects? No


Vue CLI v3.2.1
✨  Creating project in F:\qianduan_dir\00program\web-vue-cli3\hello-world-js.
�  Initializing git repository...
⚙  Installing CLI plugins. This might take a while...

yarn install v1.12.3
info No lockfile found.
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4][###########################################################################################################################################################] 1020/1020 Linking dependencies...
[4/4] Building fresh packages...
success Saved lockfile.
Done in 44.86s.
�  Invoking generators...
�  Installing additional dependencies...

yarn install v1.12.3
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
[4/4] Building fresh packages...
infoerror Visit  F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\node-sass: Command failed.
# 这句就爆红了，不知道是什么错误，为什么 ts 版本的就没有这个错误
Exit code: 1
Command: node scripts/build.js
https://yarnpkg.com/en/docs/cli/installArguments:
Directory: F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\node-sass
Output:
Building: C:\Program Files\nodejs\node.exe F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\node-gyp\bin\node-gyp.js rebuild --verbose --libsass_ext=  for documentation about this command.
--libsass_cflags= --libsass_ldflags= --libsass_library=
gyp info it worked if it ends with ok
gyp verb cli [ 'C:\\Program Files\\nodejs\\node.exe',
gyp verb cli   'F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\node-gyp\\bin\\node-gyp.js',
gyp verb cli   'rebuild',
gyp verb cli   '--verbose',
gyp verb cli   '--libsass_ext=',
gyp verb cli   '--libsass_cflags=',
gyp verb cli   '--libsass_ldflags=',
gyp verb cli   '--libsass_library=' ]
gyp info using node-gyp@3.8.0
gyp info using node@8.11.3 | win32 | x64
gyp verb command rebuild []
gyp verb command clean []
gyp verb clean removing "build" directory
gyp verb command configure []
gyp verb check python checking for Python executable "python2" in the PATH
gyp verb `which` failed Error: not found: python2
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\index.js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\windows.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed  python2 { Error: not found: python2
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\index.js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\windows.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed   stack: 'Error: not found: python2\n    at getNotFoundError (F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:13:12)\n    at F (F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:68:19)\n    at E (F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:80:29)\n    at F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:89:16\n
at F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\isexe\\index.js:42:5\n    at F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\isexe\\windows.js:36:5\n    at FSReqWrap.oncomplete (fs.js:152:21)',
gyp verb `which` failed   code: 'ENOENT' }
gyp verb check python checking for Python executable "python" in the PATH
gyp verb `which` failed Error: not found: python
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\index.js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\windows.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed  python { Error: not found: python
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\which\which.js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\index.js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\isexe\windows.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed   stack: 'Error: not found: python\n    at getNotFoundError (F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:13:12)\n    at F (F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:68:19)\n    at E (F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:80:29)\n    at F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\which\\which.js:89:16\n    at F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\isexe\\index.js:42:5\n    at F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\isexe\\windows.js:36:5\n    at FSReqWrap.oncomplete (fs.js:152:21)',
gyp verb `which` failed   code: 'ENOENT' }
gyp verb could not find "python". checking python launcher
gyp verb could not find "python". guessing location
gyp verb ensuring that file exists: C:\Python27\python.exe
gyp ERR! configure error
gyp ERR! stack Error: Can't find Python executable "python", you can set the PYTHON env variable.
gyp ERR! stack     at PythonFinder.failNoPython (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\node-gyp\lib\configure.js:484:19)
gyp ERR! stack     at PythonFinder.<anonymous> (F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\node-gyp\lib\configure.js:509:16)
gyp ERR! stack     at F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\graceful-fs\polyfills.js:282:31
gyp ERR! stack     at FSReqWrap.oncomplete (fs.js:152:21)
gyp ERR! System Windows_NT 6.1.7601
gyp ERR! command "C:\\Program Files\\nodejs\\node.exe" "F:\\qianduan_dir\\00program\\web-vue-cli3\\hello-world-js\\node_modules\\node-gyp\\bin\\node-gyp.js" "rebuild" "--verbose" "--libsass_ext=" "--libsass_cflags=" "--libsass_ldflags=" "--libsass_library="
gyp ERR! cwd F:\qianduan_dir\00program\web-vue-cli3\hello-world-js\node_modules\node-sass
gyp ERR! node -v v8.11.3
gyp ERR! node-gyp -v v3.8.0
gyp ERR! not ok
Build failed with error code: 1
ERROR  command failed: yarn --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist
 ```

```BASH
# 修改设置：setting the ~/.vuerc from "useTaobaoRegistry": true, to false.
# 用户的根目录（home 目录：就是命令行打开的时候 C:\Users\Administrator 文件夹：window 系统）中出现了一个.vuerc 文件
# {
#   "useTaobaoRegistry": false,// 将原来的 true 修改为 false
#   "packageManager": "yarn"
# }
# 或者重装 vue
$ sudo npm uninstall -g vue
$ sudo npm uninstall -g vue-cli
$ sudo npm uninstall -g @vue/cli
$ sudo npm cache clean --force
$ sudo npm install -g vue
$ sudo npm install -g @vue/cli
```

## 5.2  npm install -g @vue/cli 的错误

```BASH
λ npm install -g @vue/cli
npm WARN deprecated hoek@5.0.4: This version is no longer maintained. Please upgrade to the latest version.
# $ npm install hoek@5.0.4 -g
npm WARN deprecated cross-spawn-async@2.2.5: cross-spawn no longer requires a build toolchain, use it instead
# 不推荐使用 cross-spawn-async@2.2.5 模块，cross-spawn 而不再需要构建工具链。 应该使用它 cross-spawn 才是
# $ npm install cross-spawn -g
C:\Users\Administrator\AppData\Roaming\npm\vue -> C:\Users\Administrator\AppData\Roaming\npm\node_modules\@vue\cli\bin\vue.js
> protobufjs@6.8.8 postinstall C:\Users\Administrator\AppData\Roaming\npm\node_modules\@vue\cli\node_modules\protobufjs
> node scripts/postinstall
> nodemon@1.18.9 postinstall C:\Users\Administrator\AppData\Roaming\npm\node_modules\@vue\cli\node_modules\nodemon
> node bin/postinstall || exit 0
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@1.2.4 (node_modules\@vue\cli\node_modules\fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@1.2.4: wanted {"os":"darwin","arch":"any"} (current: {"os":"win32","arch":"x64"})
#  fsevents@1.2.4 是苹果电脑使用的，而不表示在 win 系统使用的，但是则呢删除呀？？？？每次都出现这个!!!!!!
+ @vue/cli@3.2.1
added 672 packages from 503 contributors in 201.079s
```

```BASH
# 产生的别的问题
λ npm install hoek # 直接这样找不到 package.json 文件的
npm WARN saveError ENOENT: no such file or directory, open 'F:\qianduan_dir\package.json'
npm WARN enoent ENOENT: no such file or directory, open 'F:\qianduan_dir\package.json'
npm WARN webpack-cli@3.1.2 requires a peer of webpack@^4.x.x but none is installed. You must install peer dependencies yourself.
npm WARN qianduan_dir No description
npm WARN qianduan_dir No repository field.
npm WARN qianduan_dir No README data
npm WARN qianduan_dir No license field.

# $ npm install hoek -g        改成这样全局
# $ npm install cross-spawn -g
```

## 5.3 vue create app,~/.vuerc  may be outdated. Please delete it and re-run vue-cli in manual mode.

```BASH
 ERROR  ~/.vuerc  may be outdated. Please delete it and re-run vue-cli in manual mode.
 # ~/.vuerc 文件失效，需要删除然后再 使用 vue-cli3 手动模式搭建项目。

 # 为啥会出现错误呢？？？就是在 home 目录修改之后就出错了，官方不是说可以自己修改么？？？？
 # 其实错在自己 vuerc 文件编辑错误，不是写法错误就是注释错误，总之就是错了，然后找不到文件。
 # 正确的配置参考 6.2.1 章节!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 $ cat ~/.vuerc # 此命令可以查阅自己的 .vuerc 文件内容
 ```

## 5.4 λ yarn serve：Unknown option: .polyfills.

```BASH
yarn run v1.12.3
$ vue-cli-service serve
 INFO  Starting development server...
 94% after seal
 ERROR  Failed to compile with 1 errors  14:56:33
 `error`  in ./src/main.js
Module build failed (from ./node_modules/babel-loader/lib/index.js):
`ReferenceError`: [BABEL] F:\qianduan_dir\00program\web-vue-cli3\todo-\src\main.js: Unknown option: .polyfills. Check out https://babeljs.io/docs/en/babel-core/#options for more information about options. # 这里已经说明了是 不明选项错误 
    at throwUnknownError (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\validation\options.js:123:11)
    at Object.keys.forEach.key (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\validation\options.js:107:5)
    at Array.forEach (<anonymous>)
    at validateNested (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\validation\options.js:83:21)
    at validate (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\validation\options.js:74:10)
    at instantiatePreset (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\full.js:244:36)
    at cachedFunction (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\caching.js:33:19)
    at loadPresetDescriptor (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\full.js:235:45)
    at config.presets.reduce (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\full.js:77:21)
    at Array.reduce (<anonymous>)
    at recurseDescriptors (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\full.js:74:38)
    at loadFullConfig (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\config\full.js:108:6)
    at process.nextTick (F:\qianduan_dir\00program\web-vue-cli3\todo-\node_modules\@babel\core\lib\transform.js:28:33)
    at _combinedTickCallback (internal/process/next_tick.js:131:7)
    at process._tickCallback (internal/process/next_tick.js:180:9)
 @ multi (webpack)-dev-server/client?http://192.168.2.103:8080/sockjs-node (webpack)/hot/dev-server.js ./src/main.js
 ```

 [github](https://github.com/vuejs/vue-cli/issues/2938#issuecomment-437896185),上面也有有遇到了一样的问题，都是粗心的人啊，还查了半天才知道是哪里错误了！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

 ```JS
 //bable.config.js 文件
 //这个文件写法不正确，难怪搞成了不正确的！！！！！！！！！！！！！！！！！！！！！！!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 //不细心啊，还有就是命令行报错其实已经提示错误在哪里了!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 // 还有就是 `ReferenceError` 这个会告诉我们错误的地方，不要总是看 `error` 的提示!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 module.exports = {
  presets: [
    '@vue/app'/* ,
    {
      polyfills: [
        'es6.promise',
        'es6.symbol'
      ]
    } */
  ]
}


//正确的写法
module.exports = {
  presets: [
    ['@vue/app', {
      polyfills: [
        'es6.promise',
        'es6.symbol'
      ]
    }]
  ]
}
 ```

## 5.5 webpack 的问题

```BASH
liuxm@me ~/work/vue/freegit/code/freeui (import-iview-ui)
λ yarn add iview
yarn add v1.13.0
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.7: The platform "win32" is incompatible with this module.
info "fsevents@1.2.7" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
`warning "@vue/cli-plugin-babel > babel-loader@8.0.5" has unmet peer dependency "webpack@>=2".`
`warning "@vue/cli-plugin-eslint > eslint-loader@2.1.1" has unmet peer dependency "webpack@>=2.0.0 <5.0.0".`
`warning " > sass-loader@7.1.0" has unmet peer dependency "webpack@^3.0.0 || ^4.0.0".`
```

问题：
  cli3 中 对 webpack 进行了封装，[CLI 服务](https://cli.vuejs.org/zh/guide/cli-service.html#%E4%BD%BF%E7%94%A8%E5%91%BD%E4%BB%A4),上面的只是警告，不用理会，react 的 create-react-app 2.0 中好像也是这样的问题。

# 六、插件 和 Preset

## 6.1 插件

**插件**一些重要的插件可以在 vue create my-app 的时候就手动选择安装了，有的后续安装 vue add xxxx，或者是 vue ui 界面去安装。

## 6.2 preset 预设置

**Preset**vue create 的时候回有很多 yes/no 的选择就是 Preset，其实它还在 home 目录生成了一个 .vuerc 文件，通过直接编辑这个文件来调整、添加、删除保存好的 preset。下次创建项目就会默认按照这个配置来了。

### 6.2.1 预设置 文件

Preset 的数据会被插件生成器用来生成相应的项目文件

```JSON
// 对于官方插件来说 下面的配置 不是必须的——当被忽略时，CLI 会自动使用 registry 中最新的版本。
// 不过我们推荐为 preset 列出的所有第三方插件提供显式的版本范围。
{
  "useTaobaoRegistry": false,//默认是为 true 的，因为 vue create 出错所以这里改为 false
  "packageManager": "yarn",//默认是 yarn 的，可以改成其他的，但是算了吧，这个是默认配置啊!!!!
  "presets": {
    "vue-cli3-preset": {
      "useConfigFiles": true,//被合并到 package.json 或相应的配置文件中
      "configs": {
        "vue": {},
        "postcss": {},
        "eslintConfig": {},
        "jest": {}
      },
      "plugins": {
        "@vue/cli-plugin-babel": {},
        "@vue/cli-plugin-eslint": {
          "version": "^3.0.0",// 插件的版本管理
          "config": "airbnb",
          "lintOn": ["save", "commit"],
        }
      },
      "router": true,
      "routerHistoryMode": true,
      "vuex": true,
      "cssPreprocessor": "sass"// css 预处理器 scss 比 less 还是其他都好，就默认这个好了
    }
  }
}
```