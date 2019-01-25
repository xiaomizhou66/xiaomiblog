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
|-- .eslintrc.js      # 这个文件在 cli3 中也是没有的 ，webpack 被封装了，eslint设置也在 package.json 文件夹里面了
|                     # 其他的信息还是像 cli1 版本那样可以设置的选项都在。
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

## 5.6 eslint 的问题

在 cli3 中没有单独的 .eslint.js 文件了，它直接在 package.json 文件中去配置，具体的配置项目可以在 eslint 的文章去具体查看，[eslint 文章](https://liuxmoo.com/2018/08/19/%E2%91%A9%20-%20%E3%80%90%E5%91%BD%E4%BB%A4-%E5%B7%A5%E5%85%B7%E3%80%91%E7%BC%96%E8%BE%91%E5%99%A8==ESlint-vscode%E3%89%96/)

[网站教程](https://www.jianshu.com/p/bfc7e7329cff)

```BASH
# package.json 文件 eslint 部分代码 ，
"eslintConfig": {
    "root": true,
    "env": {
      "node": true
    },
    "extends": [
      "plugin:vue/essential",
      "eslint:recommended"
    ],
    "rules": {},
    "parserOptions": {
      "parser": "babel-eslint"
    }
  },
```

### 5.6.1 不使用 eslint 

如果不需要 eslint 的话，就直接注释删除掉这段代码，注意 json 文件也不能带注释的呢！！！！！否则会发生错误，而且如果错误没有提示原因的话，这个错误就很难发现了。

如果以后还会有机会想到使用 eslint 就不想删掉这个代码，那么就在 vue.config.js 中将以下三项设置为 false

```BASH
devServer: {
        overlay: {
            warnings: false,
            errors: false
        },
        lintOnSave: false
    }
 ```
 
 ### 5.6.2 使用 eslint
 
 ```BASH
  "rules": {},
  # 在这修改自己ID规则即可
  
  rules: {
      "规则名": [规则值, 规则配置]
  }
  
  规则值
  "off"或者0    //关闭规则关闭                             0 无规则
  "warn"或者1    //在打开的规则作为警告（不影响退出代码）    1 不，不需要这样，可以这样也可以不这样
  "error"或者2    //把规则作为一个错误（退出代码触发时为1）  2 是的，就是这样，就是不允许这样
  
  其中的一些常见的配置
  "no-alert": 0,//禁止使用alert confirm prompt
  "no-array-constructor": 2,//禁止使用数组构造器
  "no-bitwise": 0,//禁止使用按位运算符
  "no-caller": 1,//禁止使用arguments.caller或arguments.callee
  "no-catch-shadow": 2,//禁止catch子句参数与外部作用域变量同名
  "no-class-assign": 2,//禁止给类赋值
  "no-cond-assign": 2,//禁止在条件表达式中使用赋值语句
  "no-console": 2,//禁止使用console
  "no-const-assign": 2,//禁止修改const声明的变量
  "no-constant-condition": 2,//禁止在条件中使用常量表达式 if(true) if(1)
  "no-continue": 0,//禁止使用continue
  "no-control-regex": 2,//禁止在正则表达式中使用控制字符
  "no-debugger": 2,//禁止使用debugger
  "no-delete-var": 2,//不能对var声明的变量使用delete操作符
  "no-div-regex": 1,//不能使用看起来像除法的正则表达式/=foo/
  "no-dupe-keys": 2,//在创建对象字面量时不允许键重复 {a:1,a:1}
  "no-dupe-args": 2,//函数参数不能重复
  "no-duplicate-case": 2,//switch中的case标签不能重复
  "no-else-return": 2,//如果if语句里面有return,后面不能跟else语句
  "no-empty": 2,//块语句中的内容不能为空
  "no-empty-character-class": 2,//正则表达式中的[]内容不能为空
  "no-empty-label": 2,//禁止使用空label
  "no-eq-null": 2,//禁止对null使用==或!=运算符
  "no-eval": 1,//禁止使用eval
  "no-ex-assign": 2,//禁止给catch语句中的异常参数赋值
  "no-extend-native": 2,//禁止扩展native对象
  "no-extra-bind": 2,//禁止不必要的函数绑定
  "no-extra-boolean-cast": 2,//禁止不必要的bool转换
  "no-extra-parens": 2,//禁止非必要的括号
  "no-extra-semi": 2,//禁止多余的冒号
  "no-fallthrough": 1,//禁止switch穿透
  "no-floating-decimal": 2,//禁止省略浮点数中的0 .5 3.
  "no-func-assign": 2,//禁止重复的函数声明
  "no-implicit-coercion": 1,//禁止隐式转换
  "no-implied-eval": 2,//禁止使用隐式eval
  "no-inline-comments": 0,//禁止行内备注
  "no-inner-declarations": [2, "functions"],//禁止在块语句中使用声明（变量或函数）
  "no-invalid-regexp": 2,//禁止无效的正则表达式
  "no-invalid-this": 2,//禁止无效的this，只能用在构造器，类，对象字面量
  "no-irregular-whitespace": 2,//不能有不规则的空格
  "no-iterator": 2,//禁止使用__iterator__ 属性
  "no-label-var": 2,//label名不能与var声明的变量名相同
  "no-labels": 2,//禁止标签声明
  "no-lone-blocks": 2,//禁止不必要的嵌套块
  "no-lonely-if": 2,//禁止else语句内只有if语句
  "no-loop-func": 1,//禁止在循环中使用函数（如果没有引用外部变量不形成闭包就可以）
  "no-mixed-requires": [0, false],//声明时不能混用声明类型
  "no-mixed-spaces-and-tabs": [2, false],//禁止混用tab和空格
  "linebreak-style": [0, "windows"],//换行风格
  "no-multi-spaces": 1,//不能用多余的空格
  "no-multi-str": 2,//字符串不能用\换行
  "no-multiple-empty-lines": [1, {"max": 2}],//空行最多不能超过2行
  "no-native-reassign": 2,//不能重写native对象
  "no-negated-in-lhs": 2,//in 操作符的左边不能有!
  "no-nested-ternary": 0,//禁止使用嵌套的三目运算
  "no-new": 1,//禁止在使用new构造一个实例后不赋值
  "no-new-func": 1,//禁止使用new Function
  "no-new-object": 2,//禁止使用new Object()
  "no-new-require": 2,//禁止使用new require
  "no-new-wrappers": 2,//禁止使用new创建包装实例，new String new Boolean new Number
  "no-obj-calls": 2,//不能调用内置的全局对象，比如Math() JSON()
  "no-octal": 2,//禁止使用八进制数字
  "no-octal-escape": 2,//禁止使用八进制转义序列
  "no-param-reassign": 2,//禁止给参数重新赋值
  "no-path-concat": 0,//node中不能使用__dirname或__filename做路径拼接
  "no-plusplus": 0,//禁止使用++，--
  "no-process-env": 0,//禁止使用process.env
  "no-process-exit": 0,//禁止使用process.exit()
  "no-proto": 2,//禁止使用__proto__属性
  "no-redeclare": 2,//禁止重复声明变量
  "no-regex-spaces": 2,//禁止在正则表达式字面量中使用多个空格 /foo bar/
  "no-restricted-modules": 0,//如果禁用了指定模块，使用就会报错
  "no-return-assign": 1,//return 语句中不能有赋值表达式
  "no-script-url": 0,//禁止使用javascript:void(0)
  "no-self-compare": 2,//不能比较自身
  "no-sequences": 0,//禁止使用逗号运算符
  "no-shadow": 2,//外部作用域中的变量不能与它所包含的作用域中的变量或参数同名
  "no-shadow-restricted-names": 2,//严格模式中规定的限制标识符不能作为声明时的变量名使用
  "no-spaced-func": 2,//函数调用时 函数名与()之间不能有空格
  "no-sparse-arrays": 2,//禁止稀疏数组， [1,,2]
  "no-sync": 0,//nodejs 禁止同步方法
  "no-ternary": 0,//禁止使用三目运算符
  "no-trailing-spaces": 1,//一行结束后面不要有空格
  "no-this-before-super": 0,//在调用super()之前不能使用this或super
  "no-throw-literal": 2,//禁止抛出字面量错误 throw "error";
  "no-undef": 1,//不能有未定义的变量
  "no-undef-init": 2,//变量初始化时不能直接给它赋值为undefined
  "no-undefined": 2,//不能使用undefined
  "no-unexpected-multiline": 2,//避免多行表达式
  "no-underscore-dangle": 1,//标识符不能以_开头或结尾
  "no-unneeded-ternary": 2,//禁止不必要的嵌套 var isYes = answer === 1 ? true : false;
  "no-unreachable": 2,//不能有无法执行的代码
  "no-unused-expressions": 2,//禁止无用的表达式
  "no-unused-vars": [2, {"vars": "all", "args": "after-used"}],//不能有声明后未被使用的变量或参数
  "no-use-before-define": 2,//未定义前不能使用
  "no-useless-call": 2,//禁止不必要的call和apply
  "no-void": 2,//禁用void操作符
  "no-var": 0,//禁用var，用let和const代替
  "no-warning-comments": [1, { "terms": ["todo", "fixme", "xxx"], "location": "start" }],//不能有警告备注
  "no-with": 2,//禁用with
  
  "array-bracket-spacing": [2, "never"],//是否允许非空数组里面有多余的空格
  "arrow-parens": 0,//箭头函数用小括号括起来
  "arrow-spacing": 0,//=>的前/后括号
  "accessor-pairs": 0,//在对象中使用getter/setter
  "block-scoped-var": 0,//块语句中使用var
  "brace-style": [1, "1tbs"],//大括号风格
  "callback-return": 1,//避免多次调用回调什么的
  "camelcase": 2,//强制驼峰法命名
  "comma-dangle": [2, "never"],//对象字面量项尾不能有逗号
  "comma-spacing": 0,//逗号前后的空格
  "comma-style": [2, "last"],//逗号风格，换行时在行首还是行尾
  "complexity": [0, 11],//循环复杂度
  "computed-property-spacing": [0, "never"],//是否允许计算后的键名什么的
  "consistent-return": 0,//return 后面是否允许省略
  "consistent-this": [2, "that"],//this别名
  "constructor-super": 0,//非派生类不能调用super，派生类必须调用super
  "curly": [2, "all"],//必须使用 if(){} 中的{}
  "default-case": 2,//switch语句最后必须有default
  "dot-location": 0,//对象访问符的位置，换行的时候在行首还是行尾
  "dot-notation": [0, { "allowKeywords": true }],//避免不必要的方括号
  "eol-last": 0,//文件以单一的换行符结束
  "eqeqeq": 2,//必须使用全等
  "func-names": 0,//函数表达式必须有名字
  "func-style": [0, "declaration"],//函数风格，规定只能使用函数声明/函数表达式
  "generator-star-spacing": 0,//生成器函数*的前后空格
  "guard-for-in": 0,//for in循环要用if语句过滤
  "handle-callback-err": 0,//nodejs 处理错误
  "id-length": 0,//变量名长度
  "indent": [2, 4],//缩进风格
  "init-declarations": 0,//声明时必须赋初值
  "key-spacing": [0, { "beforeColon": false, "afterColon": true }],//对象字面量中冒号的前后空格
  "lines-around-comment": 0,//行前/行后备注
  "max-depth": [0, 4],//嵌套块深度
  "max-len": [0, 80, 4],//字符串最大长度
  "max-nested-callbacks": [0, 2],//回调嵌套深度
  "max-params": [0, 3],//函数最多只能有3个参数
  "max-statements": [0, 10],//函数内最多有几个声明
  "new-cap": 2,//函数名首行大写必须使用new方式调用，首行小写必须用不带new方式调用
  "new-parens": 2,//new时必须加小括号
  "newline-after-var": 2,//变量声明后是否需要空一行
  "object-curly-spacing": [0, "never"],//大括号内是否允许不必要的空格
  "object-shorthand": 0,//强制对象字面量缩写语法
  "one-var": 1,//连续声明
  "operator-assignment": [0, "always"],//赋值运算符 += -=什么的
  "operator-linebreak": [2, "after"],//换行时运算符在行尾还是行首
  "padded-blocks": 0,//块语句内行首行尾是否要空行
  "prefer-const": 0,//首选const
  "prefer-spread": 0,//首选展开运算
  "prefer-reflect": 0,//首选Reflect的方法
  "quotes": [1, "single"],//引号类型 `` "" ''
  "quote-props":[2, "always"],//对象字面量中的属性名是否强制双引号
  "radix": 2,//parseInt必须指定第二个参数
  "id-match": 0,//命名检测
  "require-yield": 0,//生成器函数必须有yield
  "semi": [2, "always"],//语句强制分号结尾
  "semi-spacing": [0, {"before": false, "after": true}],//分号前后空格
  "sort-vars": 0,//变量声明时排序
  "space-after-keywords": [0, "always"],//关键字后面是否要空一格
  "space-before-blocks": [0, "always"],//不以新行开始的块{前面要不要有空格
  "space-before-function-paren": [0, "always"],//函数定义时括号前面要不要有空格
  "space-in-parens": [0, "never"],//小括号里面要不要有空格
  "space-infix-ops": 0,//中缀操作符周围要不要有空格
  "space-return-throw-case": 2,//return throw case后面要不要加空格
  "space-unary-ops": [0, { "words": true, "nonwords": false }],//一元运算符的前/后要不要加空格
  "spaced-comment": 0,//注释风格要不要有空格什么的
  "strict": 2,//使用严格模式
  "use-isnan": 2,//禁止比较时使用NaN，只能用isNaN()
  "valid-jsdoc": 0,//jsdoc规则
  "valid-typeof": 2,//必须使用合法的typeof的值
  "vars-on-top": 2,//var必须放在作用域顶部
  "wrap-iife": [2, "inside"],//立即执行函数表达式的小括号风格
  "wrap-regex": 0,//正则表达式字面量用小括号包起来
  "yoda": [2, "never"]//禁止尤达条件
 ```
 

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