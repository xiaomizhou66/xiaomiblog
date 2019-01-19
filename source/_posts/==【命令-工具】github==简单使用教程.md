---
title: git 使用教程-常用的操作
date: '2018/8/19 23:57:28'
categories:
  - 打包工具-命令行工具-包管理器-github上传下载工具
  - github
abbrlink: 94add265
updated:
tags:
comments:
---

## 一、前言

[gitHub 视频教程](https://learngitbranching.js.org/)

## 二、本地新项目上传 gitHub

本地创建的项目，要放在仓库的步骤。

### 2.1 本地与 gitHub 建立联系

```BASH
# gitHub 上面创建仓库， 获取仓库地址
# 命令行进入本地仓库目录
$ git init      #初始化一个本地仓库
$ git remote add origin <远程仓库地址> # 添加一个远程仓库地址给本地仓库
                      # origin 为默认远程仓库
$ git remote show     # 查看远程仓库 （查看是否添加成功）
$ git remote show origin # 查看 origin 远程仓库详情（查看是否添加成功）
```

### 2.2 本地的文件更新再上传 gitHub

```BASH
$ git add  .         # 添加当前目录下的所有文件以及文件夹(把文件添加到本地仓库)
$ git commit -m "xx" # 确认添加到本地(把文件添加到本地仓库)
$ git push           # 把确认好的文件添加到远程 默认的 master 分支
# $ git push origin master 上面一条是这里的简写 origin master 为默认分支
```

```BASH
$ git push --set-upstream origin master  #本次仓库首次提交
# $ git push 第一次提交直接推可能是不成功的，要先建立联系。
# --set-upstream 的意思是 设置上游为 origin 的 master 分支
$ git push --set-upstream origin master --force #强推
# 注意：这个强推，会将线上的东西覆盖，不能随意使用。
# 特别是合作的项目，不能把别人 push 的东西默认的覆盖！！！
# 强推之后就没有 readme.md 了，要自己添加上去。（本地添加好操作）
```

## 四、获取线上项目 下拉更新本地代码 并且重新上传

### 4.1 获取新代码

获取线上的项目，我们不需要像上传本地新项目到 git 上面了，不需要初始化项目了。

```BASH
# 进入到本地的文件夹（希望把即将下载的项目放置在哪里）
$ git clone <远程仓库地址> # 这样本地就会有一个与 git 上面的仓库了
```

```BASH
# 每天项目第一步就是先 pull 下载到最新的版本
$ git pull # 更新别的开发者上传的部分
# 用户名输入
# 密码输入（输入不可见）
$ code .  # 使用 vscode 打开项目（当然也可以用编辑器的方法去打开）
```

### 4.2 上传自己更新的代码

```BASH
$ git add  .         # 添加当前目录下的所有文件以及文件夹(把文件添加到本地仓库)
$ git commit -m "xx" # 确认添加到本地(把文件添加到本地仓库)
$ git push           # 把确认好的文件添加到远程 默认的 master 分支
# $ git push origin master 上面一条是这里的简写 origin master 为默认分支

# 如果线上有新的版本，git push 是不成功的，需要先 git pull 拉新的下来再git push，不然就会把别人写的代码覆盖了
```

更加合理的流程应该是这样的，不要直接 git add . 这样是上传这个项目，

```BASH
$ git status # 查看目前的修改情况，结果如下
#On branch master
#Your branch is up to date with 'origin/master'.
#Changes not staged for commit:
#  (use "git add <file>..." to update what will be committed) # 添加改动
#  (use "git checkout -- <file>..." to discard changes in working directory) # 撤销改动
#        modified:   src/pages/formulaManagement/formulaManagement.vue
$ git add src/pages/formulaManagement/formulaManagement.vue # 添加自己id修改文件
$ git commit -m "xx" # 确认添加到本地(把文件添加到本地仓库)
$ git pull           # 选拉下别人的修改，注意这里，否则会把别人的工作给干没了的
$ git push           # 把确认好的文件添加到远程 默认的 master 分支
```

### 4.4 撤销改动

```BASH
$ git status
# 没有 commit 但是忘记自己修改的部分，需要回退
$ git checkout src/group/admin.vue # 没有 commit 需要回退的话就用 可以用 checkout 回退
```

```bash
# 已经 commit 掉，需要回退到之前的 commit的状态
$ git log # 查找 commit 记录，获取自己 commit 后面的字符串
# commit 260f0661eae5b4a1c4f56223700db1b0ab18e1e1
$ q  # 退出 git log 查找，不行就 ctrl + c，或者是 esc
$ git reset 260f0661eae5b4a1c4f56223700db1b0ab18e1e1 # 后退到之前的 commit 状态
```

### 4.4 查看自己改动文件内容对比

```BASH
$  git status # 查看自己修改了哪些文件
# modified:   src/pages/analysis/analysis.vue
# modified:   src/pages/formManagement/formManagement.vue
$ git diff src/pages/formManagement/formManagement.vue # 查看该文件改动部分
# 一直回车回车 到 end 就是所有的改动部分
$ q # 退出查看
```

### 4.3 拉取线上版本覆盖本地版本

```BASH
# 拉取线上的版本，完全覆盖本地版本
$ git fetch --all
$ git reset --hard origin/master # origin/master 是当前master分支 可根据需要的分支修改该值
```

## 十、git 上面 issue回复：markdown 使用

issue 兼容了 markdown ，完全可以使用 markdown 的语法。

### 10.1 代码块模板

例如，我们需要放置一段 js 代码，如下，我们就是使用这样的格式将 js 代码包起来就好了，其他的格式代码都是一样的道理。

```JS
// js 代码
```

### 10.2 单选框，多选框

```js
// 如下使用这个模板做到复选框功能，注意 [] 内需要空格符
- [ ] Be awesome
- [ ] Prepare dinner
  - [ ] Research recipe
  - [ ] Buy ingredients
  - [ ] Cook recipe
- [ ] Sleep
```

![效果图](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181114221925.png)

在 issue 生成的回复中就可以勾选了，并且勾选之后对应的 markdown 代码也会被改变。

## 十一、文章编辑技巧

### 11.1 锚点

```TEXT
这是第 4 章中写的标签
<p id="id4"></p>
```

```TEXT
在需要锚点的地方写的代码
具体学习见第四章:<a href="#id4" target="_self">HTTP 报文首部</a>
```

## 十五、 本章问 git 上 README.md 文件的使用说明书写样例

下面的 bash 的格式没有写完整（为了本文的格式）

```TEXT
# hete_web

> A Vue.js project

## Before Build

``bash
# install pnpm（本项目使用pnpm作为包管理工具）
sudo npm install -g pnpm
``

## Build Setup

`` bash
# install dependencies
pnpm install

# serve with hot reload at localhost:8080
pnpm run dev

# build for production with minification
pnpm run build

# build for production and view the bundle analyzer report
pnpm run build --report
``

## 协作须知

``bash
# 使用UI库：iView
https://www.iviewui.com/

# 项目结构
group 目录下分 visitor 和 admin
assets 存放公共资源，如公共 css、js 库
components 存放公用组件
pages 存放页面，下分 visitor 和 admin
store 使用 vuex

# 路由结构
"/" 下为用户界面，对应 group/visitor
"/admin/" 下为管理员界面，对应 group/admin
``

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).
```