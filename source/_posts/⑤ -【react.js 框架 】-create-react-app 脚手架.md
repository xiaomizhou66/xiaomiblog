---
title: 'react.js--[create-react-app 脚手架]'
date: '2018/8/19 23:57:28'
categories:
  - ⑤ react.js
  - create-react-app 脚手架
updated:
tags:
comments:
---

# 一、前言

使用脚手架快速搭建项目结构。官网叫做 React App，其实就是 create-react-app，这样过比较好理解。

[gitHub 网址](https://github.com/facebook/create-react-app)，上面有视频教程。

脚手架搭建的项目也是 **单页应用**。

# 二、环境准备：应用的安装

以下应用如果没有在电脑安装过，那么就要先安装才能在电脑上使用 create-react-app 脚手架创建项目。

## 2.1全局安装 node.js

```BASH
# 安装 node.js，命令行输入 node -v 查看版本来测试是否成功安装
① 中文地址：http://nodejs.cn/download/
② 英文地址：https://nodejs.org/en/download/
③ 历史版本下载地址：https://nodejs.org/dist/
④ 全面的详解安装方法：http://www.runoob.com/nodejs/nodejs-install-setup.html
```

## 2.2全局安装 npm

```BASH
# 新版本的 node.js 中已经含有 NPM，如果是新版本不需要再安装 NPM，
# 安装NPM， 命令行输入 `npm -v` 查看版本来测试是否成功安装
# 全面的详解安装方法：http://www.runoob.com/nodejs/nodejs-npm.html
```

## 2.3全局安装 cnpm

```BASH
$ npm install -g cnpm --registry=https://registry.npm.taobao.org # 安装 cnpm
# 安装 CNPM，可以使用 `cnpm-v` 查看版本来测试是否成功安装
```

## 2.4 全局安装 pnpm

```BASH
# install pnpm
$ npm install -g pnpm # pnpm 是先使用缓存，要比 npm 要好一点
```

## 2.5 升级NPM版本

```BASH
# 升级 npm 版本，命令行输入
$ npm install npm -g ，或者是淘宝镜像
$ cnpm install npm -g
```

## 2.6 react 安装 （不需要额外安装）

官网也没有安装 react ，因为 create-react-app 就包含了 react ，使用脚手架创建项目的时候会自动的安装 react 与 react-dom。

但是下面还是写一下方法

### 2.6.1 npm 安装方法 npm init [name]

```bash
# npm 安装方法
$ npm init #这一句需要么？？？
$ npm install --save react react-dom # 一般是不是不推荐全局安装 react ？
```

### 2.6.2 yarn 安装方法 yarn add

```BASH
# Yarn 安装方法
yarn init # 这个需要么？？
yarn add react react-dom
```

### 2.6.3 pnpm/cnpm 安装法

### 2.6.5 cdn 安装方法

```HTML
<!--  CDN 引入 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UT
F-8" />
<title>Hello React!</title>
<script src="https://cdn.staticfile.org/react/16.4.0/umd/react.development.js"></script>
<script src="https://cdn.staticfile.org/react-dom/16.4.0/umd/react-dom.development.js"></script>
<script src="https://cdn.staticfile.org/babel-standalone/6.26.0/babel.min.js"></script>
</head>
<body>
<!--
react.min.js ======= React 的核心库
react-dom.min.js === 提供与 DOM 相关的功能
babel.min.js ======= Babel 可以将 ES6 代码转为 ES5 代码，这样我们就能在目前不支持 ES6 浏览器上执行 React 代码。Babel 内嵌了对 JSX 的支持。通过将 Babel 和 babel-sublime 包（package）一同使用可以让源码的语法渲染上升到一个全新的水平。
注意: 在浏览器中使用 Babel 来编译 JSX 效率是非常低的。一般还是不用这种办法了，还要去找 链接 -->
```

## 2.7 create-react-app（包括 react 与 react-dom）

```BASH
$ npm install -g create-react-app
# 全局安装 create-react-app 脚手架
```

## 2.8 安装  调试工具 debugging

React Developer Tools : an extension available for Chrome , Firefox , and as a standalone app that allows you to inspect the React component hierarchy in the Chrome Developer Tools

[React Developer Tools 调试工具](https://github.com/facebook/react-devtools)

# 三、初始化项目：react 项目构建完整构建过程

## 3.1 react 框架项目创建!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

```BASH
# 完整构建过程
# ① 创建应用 应用名称 my-app 最好使用正确的路径 my-app 为自定义名称
$ create-react-app my-app         # 使用 npm 初始化项目，用这个好了，不要搞其他什么特殊
$ yarn create react-app my-app    # 使用 yarn 初始化项目
$ npx create-react-app my-app     # 使用 npx 初始化项目

# ② 进入项目!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!这个很重要，很重要，很重要，很很重要!!!!!!!!!!
$ cd my-app

# ③ 开启/运行项目，start 之后浏览器就会打开一个窗口，不打开就自己复制链接去打开一个窗口
$ npm start    # 开始使用，当然 cnpm start，pnpm start，yarn start 都行的
$ yarn start   # 这里还是使用 yarn 吧，命令行都是使用 yarn 安装的，很快，并且也提示 yarn start

# 先 start 之后再来安装下面的东西吧，要保证自己每步写的代码都没有问题，写了很多，才发现一堆的错误，会很头疼的。

# ④ 路由
# $ npm install --save react-router 这个已经过时
$ npm install --save react-router-dom
$ yarn add react-router-dom # yarn 安装法
# ⑤ 动画（看自己是否需要八）
$ yarn add react-transition-group # 网址 https://reactcommunity.org/react-transition-group/
$ npm install react-transition-group --save #安装动画插件 yarn 的好处就是不需要 --save 了
$ yarn add react-motion
$ npm install --save react-motion # 安装动画插件 使用 https://github.com/chenglou/react-motion

# ⑥ 请求，拦截器
$ yarn add axios            # 使用 yarn 安装 axios

# ⑦ ui 组件库 蚂蚁金服 antd design
$ npm install antd --save
$ yarn add antd


# 实践之后发现使用 npm 好多错误，还是用 yarn 好了!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1


# 直接用 scss 文件之后， yarn start 会提示安装的。
# $ npm install sass-loader node-sass --save-dev # 安装 scss ？？？？？不对
# $ yarn add sass-loader node-sass # yarn 的好处，
# create-react-app 2.0 已经默认的是支持 css 预处理器了，但是还是要安装 node-sass，只是不需要配置了。
$ yarn add node-sass # 只需要安装 node-sass 不需要 sass-loader ，否则会报出下面的错误
# warning Pattern ["sass-loader@^7.1.0"] is trying to unpack in the same destination

# eject !!!!!!这个会移除我的 webpack 不要轻易使用！！！！！！！！!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# 如果 create-react-app 中的 webpack 配置满足不了需求，可以运行这个命令将所有 webpack 配置以及服务移到项目目录中，
# 这样修改起来就很灵活了，但是这个命令是不可回退的。
$ npm run eject   # 会生成一个 config 文件夹，其实相当于 复制 node_module 中的文件夹，不直接修改 node_module 文件夹避免错误
$ yarn eject  # 用 yarn 来运行，其实 2.0 版本的脚手架不需要这个操作了已经！！！！！！！！！！！！！！！！！！！！！！！！！！
# 不要忘记配置 config 文件夹


# 打包应用，开发完之后，打包 disc 文件夹部署上线
$ pnpm run build
$ yarn build
```

**还可以引人其他的工具库:**

- [阿里图标：](http://www.iconfont.cn/home/index?spm=a313x.7781069.1998910419.2)内含千万字符实体图标选择使用
- [Lodash工具库：](http://liuxmoo.gofoer.com/2018/08/12/12-lodash1/)一套工具库，内部封装了很多字符串、数组、对象等常见数据类型的处理函数，方便我们处理js的各种类型数据

## 3.2 查看版本 以及其他 命令操作

```BASH
-V   # --version 的缩写
-h   # --help  的缩写

$ create-react-app -V   (or --version)# 打印版本信息
$ create-react-app --info             # 打印当前系统跟react相关的开发环境参数，也就是操作系统、Node版本 et
$ create-react-app -h   (or --help)   # 打印帮助信息
$ create-react-app my-app --verbose   # 打印本地日志，其实他是 npm 和 yarn 安装外部依赖包可以加的选项，可以打印安装有错时的信息。
$ create-react-app my-app --scripts-version   # 由于它本身把创建目录初始化步骤和控制命令分离了，用来控制react项目的开发、打包和测试都放在了 react-scripts 里面，所以这里可以单独来配置控制的选项信息。
$ create-react-app my-app --use-npm  # create-react-app 默认使用 yarn 来安装，运行，
# 如果没有使用 yarn，需要指定配置为使用 npm
```

create-react-app 对于开发者还是很友好的，可以自己去定义很多东西，如果你不想这么去折腾，它也提供了标准的 react-scripts 供开发者使用

## 3.3 搭建完成的项目包含的功能

```BASH
- React, JSX, ES6, TypeScript and Flow syntax support.
  # 因此就是上面的，不需要下载 react.js 了的。
- Language extras beyond ES6 like the object spread operator.
  # 对象扩展运算符
- Autoprefixed CSS, so you don’t need -webkit- or other prefixes.
  # 自动修复 CSS，不需要 -webkit- 或 其他前缀
- A fast interactive unit test runner with built-in support for coverage reporting.
  # 一个快速交互式单元测试运行器，内置支持覆盖率报告。
- A live development server that warns about common mistakes.
  # 一个实时开发服务器，用于警告常见错误。
- A build script to bundle JS, CSS, and images for production, with hashes and sourcemaps.
  # 用于生成JS，CSS和图像的构建脚本，包含哈希和源图
- An offline-first service worker and a web app manifest, meeting all the Progressive Web App criteria.
  (Note: Using the - service worker is opt-in as of react-scripts@2.0.0 and higher)
  #
- Hassle-free updates for the above tools with a single dependency.
  # 使用单个依赖项对上述工具进行无忧更新
```

# 四、搭建框架中间遇到的问题

## 4.1 npm WARN deprecated circular-json@0.3.3: CircularJSON is in maintenance only, flatted is its successor.

```BASH
npm WARN deprecated circular-json@0.3.3: CircularJSON is in maintenance only, flatted is its successor.
这个 CircularJSON 它其实是 ESlint 的问题，
```

ESlint 的问题 [网址](https://github.com/eslint/eslint/issues/11052)，出来十几天的问题，2018-12-21 没有解决曾问题，

## 4.2 npm install 出错

```BASH
λ yarn install
yarn install v1.9.4
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
error An unexpected error occurred: "EPERM: operation not permitted, scandir 'F:\\qianduan_dir\\00program\\react.js\\hello
-world\\node_modules\\@types'". # 安装依赖的时候错误
info If you think this is a bug, please open a bug report with the information provided in "F:\\qianduan_dir\\00program\\r
eact.js\\hello-world\\yarn-error.log".
info Visit https://yarnpkg.com/en/docs/cli/install for documentation about this command.
```

```BASH
λ npm install
npm WARN deprecated circular-json@0.3.3: CircularJSON is in maintenance only, flatted is its successor.
npm WARN deprecated kleur@2.0.2: Please upgrade to kleur@3 or migrate to 'ansi-colors' if you prefer the old syntax. Visit
 <https://github.com/lukeed/kleur/releases/tag/v3.0.0\> for migration path(s).
npm WARN rollback Rolling back @types/q@1.5.1 failed (this is probably harmless): EPERM: operation not permitted, lstat 'F
:\qianduan_dir\00program\react.js\hello-world\node_modules\@types\q'
npm ERR! path F:\qianduan_dir\00program\react.js\hello-world\node_modules\@types
npm ERR! code EPERM
npm ERR! errno -4048
npm ERR! syscall mkdir
npm ERR! Error: EPERM: operation not permitted, mkdir 'F:\qianduan_dir\00program\react.js\hello-world\node_modules\@types'

npm ERR!  { Error: EPERM: operation not permitted, mkdir 'F:\qianduan_dir\00program\react.js\hello-world\node_modules\@typ
es'
npm ERR!   cause:
npm ERR!    { Error: EPERM: operation not permitted, mkdir 'F:\qianduan_dir\00program\react.js\hello-world\node_modules\@t
ypes'
npm ERR!      errno: -4048,
npm ERR!      code: 'EPERM',
npm ERR!      syscall: 'mkdir',
npm ERR!      path: 'F:\\qianduan_dir\\00program\\react.js\\hello-world\\node_modules\\@types' },
npm ERR!   stack: 'Error: EPERM: operation not permitted, mkdir \'F:\\qianduan_dir\\00program\\react.js\\hello-world\\node
_modules\\@types\'',
npm ERR!   errno: -4048,
npm ERR!   code: 'EPERM',
npm ERR!   syscall: 'mkdir',
npm ERR!   path: 'F:\\qianduan_dir\\00program\\react.js\\hello-world\\node_modules\\@types',
npm ERR!   parent: 'hello-world' }
npm ERR!
npm ERR! The operation was rejected by your operating system.
npm ERR! It's possible that the file was already in use (by a text editor or antivirus),
npm ERR! or that you lack permissions to access it.
npm ERR!
npm ERR! If you believe this might be a permissions issue, please double-check the
npm ERR! permissions of the file and its containing directories, or try running
npm ERR! the command again as root/Administrator (though this is not recommended).

npm ERR! A complete log of this run can be found in:
npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-12-21T11_11_52_804Z-debug.log
```

**解决：**

其实就是 node_modules 下载出错了。
大概是安装到一半的话不要停止，即使 ctrl+c 停止，但是node_modules 文件夹已经存在了，再停止重新安装会出错的可能性很大，装了就不要停止，否则就需要先删掉，node_modules ,删除缓存，然后再重新的安装。

[网址](https://github.com/npm/npm/issues/17747)

```BASH
# node_modules 删除这个文件夹
$ npm cache verify # 清除缓存
$ yarn install     # 重新下载依赖
```

## 4.3 安装 scss 出错/webpack

```BASH
λ yarn add sass-loader node-sass
yarn add v1.12.3
[1/4] Resolving packages...
[2/4] Fetching packages...
warning Pattern ["sass-loader@^7.1.0"] is trying to unpack in the same destination "C:\\Users\\Administrator\\AppData\\Local\\Yarn\\Cache\
\v4\\npm-sass-loader-7.1.0-16fd5138cb8b424bf8a759528a1972d72aad069d\\node_modules\\sass-loader" as pattern ["sass-loader@7.1.0"]. This could result in non-deterministic behavior, skipping. # sass-loader@^7.1.0 试图在同一个地址解压
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
`warning " > sass-loader@7.1.0" has unmet peer dependency "webpack@^3.0.0 || ^4.0.0".` # 没有找到必须的 webpack 依赖包
[4/4] Building fresh packages...
```

解决：因为之前用过了 `yarn eject`，不要轻易使用吧！！！！！还是不知道怎么在 react 中使用 scss!!!!!!!!!!!!!!!!!!!!!!!!!!!1
`yarn eject` 会把 webpack 这个打包工具去掉。出现上面的警告，去看创建好的项目中 package.json 文件内容少了好多！！！！！！！

```BASH
# 版本是自己选择的，不用版本就会下载不指定版本的 webpack
$ npm install webpack -g # 不需要安装
$ yarn add webpack@4.19.1 -g # 不需要安装
# 但是之后没有使用  yarn eject 也出现了这个问题，是因为 vie-cli3 没有包含 webpack 打包器么
# vue-cli3 脚手架也会出现这个问题，只是一个警告，因为新的脚手架是对 webpack 进行了封装，一个警告不是错误 error 我们不需要理会的。
```

问题：
  cli3 中 对 webpack 进行了封装，[CLI 服务](https://cli.vuejs.org/zh/guide/cli-service.html#%E4%BD%BF%E7%94%A8%E5%91%BD%E4%BB%A4),上面的只是警告，不用理会，react 的 create-react-app 2.0 中好像也是这样的问题。

## 4.4 使用 yarn 安装时候出现的问题

```BASH
λ yarn add axios
yarn add v1.12.3
warning package-lock.json found. # 发现了 package-lock.json 文件
Your project contains lock files generated by tools other than Yarn. # 您的项目包含由 Yarn 以外的工具生成的锁定文件。
It is ion inconsistencies caused by unsynchronized lock files. #它是由不同步的 lock 文件引起的不一致
To clear this warning, remove package-lock.json. # 要清除此警告，请删除package-lock.json。
```

其实就是因为之前有使用 npm 然后一会又使用 yarn 导致的问题，就把这个 package-lock.json 删掉就好了，留下一个 yarn.lock 来锁定版本就好。

## 4.5 yarn eject

```BASH
λ yarn eject
yarn run v1.12.3
$ react-scripts eject
NOTE: Create React App 2 supports TypeScript, Sass, CSS Modules and more without ejecting: https://reactjs.org/blog/2018/10/01/create-react-app-v2.html
? Are you sure you want to eject? This action is permanent. Yes
This git repository has untracked files or uncommitted changes:
# 提示还有没有提交的修改，就是 git 相关的项目， eject 之前需要上传到 git
package.json
M yarn.lock
Remove untracked files, stash or commit any changes, and try again.
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
```

```BASH
# commit 一下就好了，或者之前就是将它按照正产 git 项目来 commit
git add .
git commit -am "Save before ejecting"
```

## 4.1 Can't resolve './assets/logo.svg'

```BASH
λ yarn start
yarn run v1.12.3
$ node scripts/start.js
Failed to compile.

./src/app/App.js
`Module not found: Can't resolve './assets/logo.svg' in 'F:\qianduan_dir\00program\react.js\todo\src\app'`
```

这里就是路径错误了，路径一定要修改正确。是 `../assets/logo.svg`，
一个点表示当前目录下的 assets 目录，肯定是不存在的了！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
两个点表示返回到文件夹 assets，这样才是正确的。！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

## 4.1 没有 cd 进入文件夹!!!!!!!!!!!!!!!!!!!!!!!!!!!!!每次都犯这个错误

```BASH
F:\qianduan_dir\00program\react.js
λ yarn add react-router-dom
yarn add v1.12.3
info No lockfile found.
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
warning "react-router-dom > react-router@4.3.1" has unmet peer dependency "react@>=15".
# 这里这样提示，但是却不是它的错误，仔细看下 F:\qianduan_dir\00program\react.js 这个目录都不对。
warning " > react-router-dom@4.3.1" has unmet peer dependency "react@>=15".
[4/4] Building fresh packages...
 ```

根本不是其他插件的问题，就是因为在这里文件夹不是项目文件夹啊，都没有 package.json 怎么去安装插件!!!!!!!!!!!!!!!!!


## 4.8 yarn add node-sass

```BASH
F:\qianduan_dir\00program\react.js\ordering-system (master -> origin)
λ yarn add node-sass
yarn add v1.12.3
[1/4] Resolving packages...
[2/4] Fetching packages...
info fsevents@1.2.4: The platform "win32" is incompatible with this module.
info "fsevents@1.2.4" is an optional dependency and failed compatibility check. Excluding it from installat
ion.
[3/4] Linking dependencies...
[4/4] Building fresh packages...
`error F:\qianduan_dir\00program\react.js\ordering-system\node_modules\node-sass: Command failed.`
# 什么鬼错误？不是支持 scss 的么，怎么还错误了？？？？
Exit code: 1
`Command: node scripts/build.js`#
Arguments:
Directory: F:\qianduan_dir\00program\react.js\ordering-system\node_modules\node-sass
Output:
Building: C:\Program Files\nodejs\node.exe F:\qianduan_dir\00program\react.js\ordering-system\node_modules\
node-gyp\bin\node-gyp.js rebuild --verbose --libsass_ext= --libsass_cflags= --libsass_ldflags= --libsass_li
brary=
gyp info it worked if it ends with ok
gyp verb cli [ 'C:\\Program Files\\nodejs\\node.exe',
gyp verb cli   'F:\\qianduan_dir\\00program\\react.js\\ordering-system\\node_modules\\node-gyp\\bin\\node-g
yp.js',
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
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\react.js\ordering-system\node_mo
dules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\which.
js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\index.
js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\window
s.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed  python2 { Error: not found: python2
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\react.js\ordering-system\node_mo
dules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\which.
js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\index.
js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\window
s.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed   stack: 'Error: not found: python2\n    at getNotFoundError (F:\\qianduan_dir\\00p
rogram\\react.js\\ordering-system\\node_modules\\which\\which.js:13:12)\n    at F (F:\\qianduan_dir\\00prog
ram\\react.js\\ordering-system\\node_modules\\which\\which.js:68:19)\n    at E (F:\\qianduan_dir\\00program
\\react.js\\ordering-system\\node_modules\\which\\which.js:80:29)\n    at F:\\qianduan_dir\\00program\\reac
t.js\\ordering-system\\node_modules\\which\\which.js:89:16\n    at F:\\qianduan_dir\\00program\\react.js\\o
rdering-system\\node_modules\\isexe\\index.js:42:5\n    at F:\\qianduan_dir\\00program\\react.js\\ordering-
system\\node_modules\\isexe\\windows.js:36:5\n    at FSReqWrap.oncomplete (fs.js:152:21)',
gyp verb `which` failed   code: 'ENOENT' }
gyp verb check python checking for Python executable "python" in the PATH
gyp verb `which` failed Error: not found: python
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\react.js\ordering-system\node_mo
dules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\which.
js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\index.
js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\window
s.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed  python { Error: not found: python
gyp verb `which` failed     at getNotFoundError (F:\qianduan_dir\00program\react.js\ordering-system\node_mo
dules\which\which.js:13:12)
gyp verb `which` failed     at F (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:68:19)
gyp verb `which` failed     at E (F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\whi
ch.js:80:29)
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\which\which.
js:89:16
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\index.
js:42:5
gyp verb `which` failed     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\isexe\window
s.js:36:5
gyp verb `which` failed     at FSReqWrap.oncomplete (fs.js:152:21)
gyp verb `which` failed   stack: 'Error: not found: python\n    at getNotFoundError (F:\\qianduan_dir\\00pr
ogram\\react.js\\ordering-system\\node_modules\\which\\which.js:13:12)\n    at F (F:\\qianduan_dir\\00progr
am\\react.js\\ordering-system\\node_modules\\which\\which.js:68:19)\n    at E (F:\\qianduan_dir\\00program\
\react.js\\ordering-system\\node_modules\\which\\which.js:80:29)\n    at F:\\qianduan_dir\\00program\\react
.js\\ordering-system\\node_modules\\which\\which.js:89:16\n    at F:\\qianduan_dir\\00program\\react.js\\or
dering-system\\node_modules\\isexe\\index.js:42:5\n    at F:\\qianduan_dir\\00program\\react.js\\ordering-s
ystem\\node_modules\\isexe\\windows.js:36:5\n    at FSReqWrap.oncomplete (fs.js:152:21)',
gyp verb `which` failed   code: 'ENOENT' }
gyp verb could not find "python". checking python launcher
gyp verb could not find "python". guessing location
gyp verb ensuring that file exists: C:\Python27\python.exe
gyp ERR! configure error
gyp ERR! stack Error: Can't find Python executable "python", you can set the PYTHON env variable.
gyp ERR! stack     at PythonFinder.failNoPython (F:\qianduan_dir\00program\react.js\ordering-system\node_mo
dules\node-gyp\lib\configure.js:484:19)
gyp ERR! stack     at PythonFinder.<anonymous> (F:\qianduan_dir\00program\react.js\ordering-system\node_mod
ules\node-gyp\lib\configure.js:509:16)
gyp ERR! stack     at F:\qianduan_dir\00program\react.js\ordering-system\node_modules\graceful-fs\polyfills
.js:284:29
gyp ERR! stack     at FSReqWrap.oncomplete (fs.js:152:21)
gyp ERR! System Windows_NT 6.1.7601
gyp ERR! command "C:\\Program Files\\nodejs\\node.exe" "F:\\qianduan_dir\\00program\\react.js\\ordering-sys
tem\\node_modules\\node-gyp\\bin\\node-gyp.js" "rebuild" "--verbose" "--libsass_ext=" "--libsass_cflags=" "
--libsass_ldflags=" "--libsass_library="
gyp ERR! cwd F:\qianduan_dir\00program\react.js\ordering-system\node_modules\node-sass
gyp ERR! node -v v8.11.3
gyp ERR! node-gyp -v v3.8.0
gyp ERR! not ok
Build failed with error code: 1
info Visit https://yarnpkg.com/en/docs/cli/add for documentation about this command.
```

# 五、框架结构详解

## 5.1 没有 eject 的项目结构

```bash
|-- node_modules/ # 依赖包
|
|-- public
|   |-- favicon.ico      # 网站图片标识
|   |-- index.html       # 页面模板：一切的开始都从这里开始，所以这个是代码执行的源头
|   |-- manifest.json    # 指定了开始页面为 index.html。
|
|-- src/                # src 目录下的文件才会被 webpack 打包，所以要把 js、css 文件放在 src 目录下
|   |-- App.css
|   |-- App.js
|   |-- App.test.js
|   |-- index.css
|   |-- index.js    # 入口文件
|   |-- logo.svg
|   |-- serviceWorker.js
|
|-- .gitignore       # git 上传需要忽略的文件格式
|-- package.json     # 项目基本信息
|-- README.md        # 项目说明
|-- yarn.lock        # 明确 安装包的具体版本
```

## 5.2 eject 之后的项目结构

[项目结构可以学习这篇文章](https://www.jianshu.com/p/7f81913d1298)

```bash
|-- build/   #存放项目被webpack处理后生成的文件；
|
|-- config/  # webpack 配置文件，存放的是项目的配置文件；
|   |-- jest/
|   |   |-- cssTransform.js
|   |   |-- fileTransform.js
|   |
|   |-- env.js
|   |-- paths.js
|   |-- webpack.config.js
|   |-- webpackDevServer.config.js
|
|-- node_modules/ # 依赖包，存放 npm 安装的工具包 或 模块
|
|-- public   # 静态资源，该目录下的文件不会被webpack处理，它们会被拷贝到 build/ 文件夹下
|   |-- favicon.ico      # 网站图片标识
|   |-- index.html       # 页面模板：一切的开始都从这里开始，所以这个是代码执行的源头
|   |-- manifest.json    # 指定了开始页面为 index.html。
|
|-- scripts           # 运行配置，与项目的构建、打包 或 服务 相关的脚本
|   |-- build.js      #
|   |-- start.js      #
|   |-- test.js       #
|
# |-- src/              # src 目录下的文件才会被 webpack 打包，所以要把 js、css 文件放在 src 目录下，项目的源代码及资源
# |   |-- App.css
# |   |-- App.js
# |   |-- App.test.js
# |   |-- index.css
# |   |-- index.js    # 入口文件
# |   |-- logo.svg
# |   |-- serviceWorker.js
# 实际代码中会去修改这个文件夹下的结构，
|
|-- .gitignore       # git 上传需要忽略的文件格式
|-- package.json     # 项目基本信息
|-- README.md        # 项目说明
|-- yarn.lock        # 明确 安装包的具体版本
```

## 5.3 public/

public 虽然目录可以添加任何资源，如：图片、代码 等等，但是 不建议 把这些资源添加到 public 目录中；public 适合存放 **与 webpack 不兼容的库**

要引用 public/ 目录下的资源，需要使用一个特殊的变量 PUBLIC_URL 来表示 public 目录；在执行 npm run build 时，PUBLIC_URL 变量会被替换成正确的绝对路径；

```HTML
<!-- 
在 HTML中用 %PUBLIC_URL% 引用 PUBLIC_URL 变量，
在 JavaScript 中用 process.env.PUBLIC_URL 引用 PUBLIC_URL 变量；
示例：在文件 public/index.html 可以这样引用 public/favicon.ico: -->
<link rel="shortcut icon" href="%PUBLIC_URL%/favicon.ico" />
```

### 4.1 public/manifest.json 配置文件

```JSON
{
  "short_name": "React App",
  "name": "Create React App Sample",
  "icons": [
    {
      "src": "favicon.ico",
      "sizes": "64x64 32x32 24x24 16x16",
      "type": "image/x-icon"
    }
  ],
  "start_url": ".",
  "display": "standalone",
  "theme_color": "#000000",
  "background_color": "#ffffff"
}
```

### 4.2 public/index.html 入口文件

```HTML
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="%PUBLIC_URL%/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="theme-color" content="#000000">
    <!--
      manifest.json provides metadata used when your web app is added to the
      homescreen on Android. See https://developers.google.com/web/fundamentals/web-app-manifest/
      当你使用 Android 屏幕的时候，这个 manifest.json 文件可以提供元数据，具体参阅上面的网址
    -->
    <link rel="manifest" href="%PUBLIC_URL%/manifest.json">
    <!--
      Notice the use of %PUBLIC_URL% in the tags above.
      It will be replaced with the URL of the `public` folder during the build.
      Only files inside the `public` folder can be referenced from the HTML.

      Unlike "/favicon.ico" or "favicon.ico", "%PUBLIC_URL%/favicon.ico" will
      work correctly both with client-side routing and a non-root public URL.
      Learn how to configure a non-root public URL by running `npm run build`.
      请注意在上面的标记中使用％PUBLIC_URL％。它将在构建期间替换为 `public` 文件夹的 URL。
      只能从 HTML 中引用 `public` 文件夹中的文件。
      与 “/favicon.ico” 或 “favicon.ico” 不同，“％PUBLIC_URL％/ favicon.ico” 将 与客户端路由和非 root 公共 URL 一起正常工作。
      通过运行 `npm run build` 了解如何配置非 root 公共 URL。
    -->
    <title>React App</title>
  </head>
  <body>
    <noscript>
      You need to enable JavaScript to run this app.
    </noscript>
    <div id="root"></div>
    <!--
      This HTML file is a template. 这个是 html 模板文件
      If you open it directly in the browser, you will see an empty page. 如果直接用浏览器打开这个文件看到的是空白页面
      You can add webfonts, meta tags, or analytics to this file.   可以添加 webfonts, meta tags, or analytics 到这个文件
      The build step will place the bundled scripts into the <body> tag. 构建好的内容将会导入 <div id="root"></div> 这里面

      To begin the development, run `npm start` or `yarn start`. 可以运行 `npm start` or `yarn start` 来运行,pnpm start 也行
      To create a production bundle, use `npm run build` or `yarn build`. 使用 `npm run build` or `yarn build` 打包
    -->
  </body>
</html>
```

## 5.4 src/

上面这个里是创建时产生的结构，但是我们的 项目页面肯定是不少的，文件多了，都放在一个页面是很难看的。根据自己项目的结构需要调整。
webpack 只能编译 src/ 目录下的代码，如果在 src/ 下导入了 src/ 目录之外的文件（除了npm 包），则 webpack 会报错；
这样做的目的是为了减少由于路径书写错导而导致的错误；如果一定要导入 src/ 外的 非 npm 包 文件，
则可以在 /config/paths.js 文件中的 allowedFilesOutOfSrc 属性 中添加需要包含的 src 外部非 npm 包文件 的路径；

**项目结构的核心思想**
因为代码的相关性主要与业务功能有关，而与文件类型的关系不大，所以，为了便于 编写、查阅、理解 代码，项目结构遵循以下核心宗指（宗指属于思想）：

- 以业务功能为单位组织项目结构；
- 以低耦合度为目标划分模块职责和逻辑；

优点：

- 业务功能模块的相关代码都集中在一块，方便移动和删除；
- 实现了关注点分离，方便开发、调试、维护、编写、查阅、理解代码；

**src目录结构**

搭建的项目中 src 的目录结构修改如下。src的目录结构将以业务功能划分

```BASH
src/
├── app/    # 存放项目业务代码
│   ├── App.css
│   ├── App.js      # 根组件，路由也在这里写
│   └── App.test.js
│
├──assets/  # 存放项目共用的代码以外的资源，如：图片、图标、视频 等；
│   ├── logo.svg
│   ├── constant.less    # 存放 Less 的常量；如果是 scss 就是 scss 常量
│   └── constant.js      # 存放 js 的常量；
│
├── component/   # 组件
│   ├──
│   └──
│
├── views/       # 页面
│   ├──
│   └──
│
├── index.css            # 全局 css 样式
├── index.js             # webpack 的入口文件；
└── serviceWorker.js
```

### 4.3 src/index.js 插入 `<div id="root"></div>` 中的 JSX 拓展语言代码组件

```JS
import React from 'react';// 导入 react.js
import ReactDOM from 'react-dom';// 导入 react-dom
import './index.css';//导入 index 对应的 css 文件
import App from './App';// 导入 app 组件                路径需要响应的修改！！！！！！！！！！！！！！！！！！
import * as serviceWorker from './serviceWorker';//导入服务器

ReactDOM.render(<App />, document.getElementById('root'));// 将 app 组件渲染到 html 中

// If you want your app to work offline and load faster, you can change如果您希望您的应用脱机工作并加载更快，您可以更改
// unregister() to register() below. Note this comes with some pitfalls.取消注册（）以注册（）如下。 请注意，这带来了一些陷阱。
// Learn more about service workers: http://bit.ly/CRA-PWA了解有关服务工作者的更多信息：http：//bit.ly/CRA-PWA
serviceWorker.unregister();// 脱机工作
```

### 4.4 src/index.css 全局样式 body，一些页面初始化的样式可以在这里写

```CSS
body {
  margin: 0;
  padding: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen",
    "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, "Courier New",
    monospace;
}
```

### 4.5 src/App.js  App.css  组件 app 与 其对应的 css 样式

```js
import React, { Component } from 'react';// 为什么导入的是 { Component }
import logo from './logo.svg';// 导入 图片                      路径需要响应的修改！！！！！！！！！！！！！！！！！！
import './App.css';//导入 css 文件

class App extends Component { // 这里创建组件，怎么又变成 Component 了，不是 React.Component 的么，因为 ES6 的解构赋值
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <a
            className="App-link"
            href="https://reactjs.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            Learn React
          </a>
        </header>
      </div>
    );
  }
}

export default App;
```

```CSS
.App {
  text-align: center;
}

.App-logo {
  animation: App-logo-spin infinite 20s linear; /* 动画 */
  height: 40vmin;
}

.App-header {
  background-color: #282c34;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: calc(10px + 2vmin);
  color: white;
}

.App-link {
  color: #61dafb;
}

@keyframes App-logo-spin {/*animation 的关键帧   */
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}
```

### 4.6 src/serviceWorker.js  服务器配置文件，网络代理服务器

```JS
// This optional code is used to register a service worker.
// register() is not called by default.

// This lets the app load faster on subsequent visits in production, and gives
// it offline capabilities. However, it also means that developers (and users)
// will only see deployed updates on subsequent visits to a page, after all the
// existing tabs open on the page have been closed, since previously cached
// resources are updated in the background.

// To learn more about the benefits of this model and instructions on how to
// opt-in, read http://bit.ly/CRA-PWA

const isLocalhost = Boolean(
  window.location.hostname === 'localhost' ||
    // [::1] is the IPv6 localhost address.
    window.location.hostname === '[::1]' ||
    // 127.0.0.1/8 is considered localhost for IPv4.
    window.location.hostname.match(
      /^127(?:\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$/
    )
);

export function register(config) {
  if (process.env.NODE_ENV === 'production' && 'serviceWorker' in navigator) {
    // The URL constructor is available in all browsers that support SW.
    const publicUrl = new URL(process.env.PUBLIC_URL, window.location.href);
    if (publicUrl.origin !== window.location.origin) {
      // Our service worker won't work if PUBLIC_URL is on a different origin
      // from what our page is served on. This might happen if a CDN is used to
      // serve assets; see https://github.com/facebook/create-react-app/issues/2374
      return;
    }

    window.addEventListener('load', () => {
      const swUrl = `${process.env.PUBLIC_URL}/service-worker.js`;

      if (isLocalhost) {
        // This is running on localhost. Let's check if a service worker still exists or not.
        checkValidServiceWorker(swUrl, config);

        // Add some additional logging to localhost, pointing developers to the
        // service worker/PWA documentation.
        navigator.serviceWorker.ready.then(() => {
          console.log(
            'This web app is being served cache-first by a service ' +
              'worker. To learn more, visit http://bit.ly/CRA-PWA'
          );
        });
      } else {
        // Is not localhost. Just register service worker
        registerValidSW(swUrl, config);
      }
    });
  }
}

function registerValidSW(swUrl, config) {
  navigator.serviceWorker
    .register(swUrl)
    .then(registration => {
      registration.onupdatefound = () => {
        const installingWorker = registration.installing;
        if (installingWorker == null) {
          return;
        }
        installingWorker.onstatechange = () => {
          if (installingWorker.state === 'installed') {
            if (navigator.serviceWorker.controller) {
              // At this point, the updated precached content has been fetched,
              // but the previous service worker will still serve the older
              // content until all client tabs are closed.
              console.log(
                'New content is available and will be used when all ' +
                  'tabs for this page are closed. See http://bit.ly/CRA-PWA.'
              );

              // Execute callback
              if (config && config.onUpdate) {
                config.onUpdate(registration);
              }
            } else {
              // At this point, everything has been precached.
              // It's the perfect time to display a
              // "Content is cached for offline use." message.
              console.log('Content is cached for offline use.');

              // Execute callback
              if (config && config.onSuccess) {
                config.onSuccess(registration);
              }
            }
          }
        };
      };
    })
    .catch(error => {
      console.error('Error during service worker registration:', error);
    });
}

function checkValidServiceWorker(swUrl, config) {
  // Check if the service worker can be found. If it can't reload the page.
  fetch(swUrl)
    .then(response => {
      // Ensure service worker exists, and that we really are getting a JS file.
      const contentType = response.headers.get('content-type');
      if (
        response.status === 404 ||
        (contentType != null && contentType.indexOf('javascript') === -1)
      ) {
        // No service worker found. Probably a different app. Reload the page.
        navigator.serviceWorker.ready.then(registration => {
          registration.unregister().then(() => {
            window.location.reload();
          });
        });
      } else {
        // Service worker found. Proceed as normal.
        registerValidSW(swUrl, config);
      }
    })
    .catch(() => {
      console.log(
        'No internet connection found. App is running in offline mode.'
      );
    });
}

export function unregister() {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.ready.then(registration => {
      registration.unregister();
    });
  }
}
```

### 4.6.1 service worker 介绍

可以实现消息推动、地理围栏、离线应用等功能，相当于在浏览器端建立了一个代理服务，实现一些现在看来逆天的功能。

这个是用来做离线缓存的新的 api 实现。
其工作原理是 **缓存同源路径下的请求**，相当于是在前端与后端数据中加了一个缓存层，**使得在离线状态下也能够正常访问部分页面**。

![t](https://segmentfault.com/img/bVWgUS?w=884&h=67)，访问中之所以报错，可能是你以本地 (localhost) 等方式打开，并非是在打包中制定的域名下。

目前原生 App 跟 HTML5 相比具有如下优势:富离线体验、消息推送、定时默认更行等功能，这些优势决定了 HTML5 无法取代 native。
service worker(后面简称 sw )，就是在这样的背景下提出来的。

sw 是一段运行在浏览器 **后端的脚本**，独立于页面，是一个 worker，也可以理解为一个 **网络代理服务器**。因此 sw 是无法与 DOM 进行交互的，但是可以与 js 主线程进行通信。

### 4.6.2  service worker 实现的功能

目前 sw 还是一个草案(现在应该不是了吧，脚手架都用了，)，各个浏览器支持程度还不是很高，除了 chrome 40、firefox 以外，其他浏览器均不支持该功能，但是 sw 提供的逆天功能还是非常值得期待:

- 后台数据的同步
- 从其他域获取资源请求
- 接受计算密集型数据的更新，多页面共享该数据
- 客户端编译与依赖管理
- 后端服务的 hook 机制
- 根据 URL 模式，自定义模板
- 性能优化
- 消息推送
- 定时默认更新
- 地理围栏

其中最期待的还是通过 HTTP 请求的拦截，进而实现离线应用，提升页面的性能体验。

### 4.6.3 简单使用

```JS
//a. 首先在页面注册一个service worker

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('./index.js').then((reg) => {
    console.log('register a service worker: ', reg)
  }).catch((err) => {
    console.log('err: ', err);
  });
}


//b. 接着就可以在Service worker中尽情畅想
//以页面的离线应用为出发点，说明sw如实做到离线应用的。

const cacheUrl = [
  '/base.css',
  '/france.html'
];
const cacheName = 'my-site-cache';

// install阶段
self.addEventListener('install', (event) => {
  console.log('sw event: install');
  event.waitUntil(
    caches.open(cacheName).then((cache) => {
      console.log('open cache');
      return cache.addAll(cacheUrl);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(caches.match(event.request).then(res => {
    if (res) {
      console.log('match');
      return res;
    }
    return fetch(event.request);
  }));
});
```

### 4.6.4 生命周期

sw（ service worker ） 的说明周期主要包括三个阶段: install、active、working。
下面这张图说明各个阶段完成的工作:
![Y](http://zhenhua-lee.github.io/img/service-work/sw-lifecycle.png)

### 4.6.5 事件机制

sw （ service worker ）本质上也是一个 worker，所以 sw 开发也是建立在事件的基础上，通过事件机制完成相关业务逻辑的处理。
其中 sw （ service worker ）里面的事件在原始事件对象 EVENT,进行了拓展，例如 fetch event 里面拥有 respondWith、waitUtil 方法。

### 4.6.6 补充介绍: Cache API

cache api 就是对 http 的 request/response 进行缓存管理，是在 service worker 的规范中定义的，往往跟 service worker 一起操作使用，是实现 web app 离线应用的关键一环。但是 cache api 又不依赖于 service worker，可以单独在 window 下使用，。

在 window 对象下，cache api 的操作封装在 caches 对象下面，里面的操作分为两类: 对 cache 的操作、对 cache 里面 http 的操作。下面简单说明下 cache storage 的相关操作:

```JS
// 下面是对cache的相关操作
// open: 创建或打开一个cache
caches.open('test').then(cache => {
  return cache.add('/base.css')
}).then((val) => {
  console.log('create a cache and add "base.css" to it');
});
// 在cache storage查找缓存的资源
caches.match('/base.css').then(res => {
  if (!res) return 'can not find this http in caches storage';
  return res.text()
}).then((result) => {
  console.log(result)
});
// 得到所有的cache
caches.keys().then(name => {
  console.log('names: ', name)
});
// 得到某个cache
caches.delete('test').then(val => {
  console.log('delete success?: ', val)
});

// 对cache里面http进行操作
caches.open('test').then(cache => {
  // 添加缓存资源
  return cache.add('/base.css')
}).then((val) => {
  console.log('create a cache and add "base.css" to it');
});

caches.open('test').then(cache => {
  // 资源匹配
  return cache.match('/base.css')
}).then(res => {
  return res.text()
}).then(str => {
  console.log(str)
});
```

## 4.7 src/App.test.js  测试文件

关于测试可以学习[T](http://joescott.coding.me/blog/2017/04/27/create-react-app-tests/),
当运行 npm run test, Jest 会以 watch 模式启动。每次你保存一个文件，它都会重新运行测试，就像 npm start 重新编译代码一样。

```JS
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

it('renders without crashing', () => {// 渲染没有崩溃
  const div = document.createElement('div');
  ReactDOM.render(<App />, div);//？？？？？？？？？？？？？
  ReactDOM.unmountComponentAtNode(div);// 、？？？？？？？？？？？？？？？？？？？
});

```

## 4.8 package.json

```JSON
{
  "name": "todo",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "react": "^16.7.0",
    "react-dom": "^16.7.0",
    "react-scripts": "2.1.2"
  },
  "scripts": {
    "start": "react-scripts start", // 开发环境运行,默认监听 3000 端口
    "build": "react-scripts build",// 生产环境运行，进行项目打包，默认打包到 build 目录
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  },
  "eslintConfig": {
    "extends": "react-app"
  },
  "browserslist": [
    ">0.2%",
    "not dead",
    "not ie <= 11",
    "not op_mini all"
  ]
}
```

# 六、自己添加的框架思想!!!!!!!!!!!!!!!!!!!!!!!!!!

[官网网址](https://react.docschina.org/docs/faq-structure.html)

```JS
//按照文件类型来分组,类似这样
api/
  APIUtils.js
  APIUtils.test.js
  ProfileAPI.js
  UserAPI.js
components/
  Avatar.js
  Avatar.css
  Feed.js
  Feed.css
  FeedStory.js
  FeedStory.test.js
  Profile.js
  ProfileHeader.js
  ProfileHeader.css
```

- 避免太多嵌套，不要分太细！文件夹太多，总是 import 不好！
- 不要过度思考这个问题，重要的是代码做出东西来！

例如下面是完整的框架

```BASH
|-- build/   #存放项目被webpack处理后生成的文件；
|
|-- config/  # webpack 配置文件，存放的是项目的配置文件；
|   |-- jest/
|   |   |-- cssTransform.js
|   |   |-- fileTransform.js
|   |
|   |-- env.js
|   |-- paths.js
|   |-- webpack.config.js
|   |-- webpackDevServer.config.js
|
|-- node_modules/ # 依赖包，存放 npm 安装的工具包 或 模块
|
|-- public   # 静态资源，该目录下的文件不会被webpack处理，它们会被拷贝到 build/ 文件夹下
|   |-- favicon.ico      # 网站图片标识
|   |-- index.html       # 页面模板：一切的开始都从这里开始，所以这个是代码执行的源头
|   |-- manifest.json    # 指定了开始页面为 index.html。
|
|-- scripts           # 运行配置，与项目的构建、打包 或 服务 相关的脚本
|   |-- build.js      #
|   |-- start.js      #
|   |-- test.js       #
|
# |-- src/              # src 目录下的文件才会被 webpack 打包，所以要把 js、css 文件放在 src 目录下，项目的源代码及资源
# |   |-- App.css
# |   |-- App.js
# |   |-- App.test.js
# |   |-- index.css
# |   |-- index.js    # 入口文件
# |   |-- logo.svg
# |   |-- serviceWorker.js
# 实际代码中会去修改这个文件夹下的结构，
├── src/
│   ├──app/    # 存放项目业务代码
│   │   ├── App.css
│   │   ├── App.js    # 根组件，路由也在这里写，或者是在外面写，在这里导入
│   │   └── App.test.js
│   │
│   ├──assets/  # 存放项目共用的代码以外的资源，如：图片、图标、视频 等；
│   │   ├── logo.svg
│   │   ├── constant.less    # 存放 Less 的常量；如果是 scss 就是 scss 常量
│   │   ├── index.css        # 全局 css 样式
│   │   └── constant.js      # 存放 js 的常量；
│   │
│   ├── component/   # 组件
│   │   ├──
│   │   └──
│   │
│   ├── views/       # 页面
│   │   ├──pagesA/
│   │   └──pagesB/
│   │
│   ├── index.js             # webpack 的入口文件；
│   └── serviceWorker.js
|
|-- .gitignore       # git 上传需要忽略的文件格式
|-- package.json     # 项目基本信息
|-- README.md        # 项目说明
|-- yarn.lock        # 明确 安装包的具体版本
```

注意修改了项目结构目录之后，不要忘记修改其中文件的路径!!!!!!!!!!!!!!!!!否则会运行错误哦！！！！！！！！！！！！！！！！