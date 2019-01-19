---
title: 静态网页生成器--hexo 的使用
date: '2018/8/13 21:57:25'
categories:
  - 静态网页生成器
  - hexo
abbrlink: 1c27bc84
updated:
tags:
comments:
---

## 一、前言

Welcome to [Hexo](https://hexo.io/)! This is your very first post. Check [documentation](https://hexo.io/docs/) for more info. If you get any problems when using Hexo, you can find the answer in [troubleshooting](https://hexo.io/docs/troubleshooting.html) or you can ask me on [GitHub](https://github.com/hexojs/hexo/issues).

## 二、Quick Start 快速上手

<!--more-->

### 2.1 Create a new post 创建新文章

```bash
# 创建新的文章，当然最简单的方式就是手动的添加一个 md 文件就是新的文章啦
$ hexo new "My New Post"
```

More info: [Writing](https://hexo.io/docs/writing.html)

### 2.2 Run server 本地服务器运行

``` bash
# 在本地服务器运行
$ hexo server
$ hexo s     # 简写
```

More info: [Server](https://hexo.io/docs/server.html)

### 2.3 Generate static files 生成静态文件

``` bash
# 生成静态文件
$ hexo generate
$ hexo g     # 简写
```

More info: [Generating](https://hexo.io/docs/generating.html)

### 2.4 Deploy to remote sites 远程部署

``` bash
# 部署
$ hexo deploy
```

More info: [Deployment](https://hexo.io/docs/deployment.html)

# 五、使用过程中遇到的问题

## 5.1 没有找到 hexo 依赖包

```BASH
liuxm@me ~/work/xiaomiblog (master)
λ hexo g
`ERROR Local hexo not found in ~\work\xiaomiblog`# 没有找到 hexo 包
`ERROR Try running: 'npm install hexo --save'`
```

问题-解决：

- 可能是路径不对                        ->  更新到正确的路径
- 刚克隆/下载下来的项目，没有下载依赖包   ->  `npm install`

## 5.2 cnpm install 安装依赖包出错

```BASH
liuxm@me ~/work/xiaomiblog (master)
`λ cnpm install`
/ [12/15] Installing through@>=2.2.7 <3platform unsupported hexo-abbrlink@2.0.5 › hexo-fs@0.2.3 › chokidar@1.7.0 › fsevents@^1.0.0 Package require os(darwin) not compatible with your platform(win32)
- [12/15] Installing through@>=2.2.7 <3[fsevents@^1.0.0] optional install error: Package require os(darwin) not compatible with your platform(win32)
√ Installed 15 packages
√ Linked 295 latest versions
√ Run 0 scripts
`deprecate hexo-renderer-jade@0.3.0 › jade@^1.11.0 Jade has been renamed to pug, please install the latest version of pug instead of jade`
# 不推荐使用 hexo-renderer-jade@0.3.0> jade@^1.11.0 Jade 已经改名为 pug，请安装最新版本的 pug 代替 jade
`deprecate hexo-renderer-jade@0.3.0 › jade@1.11.0 › transformers@2.1.0 Deprecated, use jstransformer`
# hexo-renderer-jade@0.3.0> jade@1.11.0> transformers@2.1.0 已弃用，请使用 jstransformer
`deprecate hexo-renderer-jade@0.3.0 › jade@1.11.0 › constantinople@~3.0.1 Please update to at least constantinople 3.1.1`
# 弃用 constantinople@~3.0.1 请至少更新 constantinople@3.1.1
`deprecate hexo@3.8.0 › titlecase@^1.1.2 no longer maintained`
# titlecase@^1.1.2 已经不再维护
Recently updated (since 2019-01-12): 3 packages (detail see file C:\Users\liuxm\work\xiaomiblog\node_modules\.recently_updates.txt)
√ All packages installed (375 packages installed from npm registry, used 4s(network 4s), speed 140.33kB/s, json 310(551.22kB), tarball 0B)
```

[github 问题网址](https://github.com/hexojs/hexo-renderer-jade/issues/7)