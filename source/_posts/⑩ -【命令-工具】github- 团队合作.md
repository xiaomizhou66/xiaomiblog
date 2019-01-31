---
title: git 命令行全解-详解
date: '2018/8/19 23:57:28'
categories:
  - ⑩ 打包工具-命令行工具-包管理器-github
  - github
updated:
tags:
comments:
---

# 一、前言

[gitHub 视频教程](https://learngitbranching.js.org/)

# 二、git 原理图解（本地 + 远程）

## 2.1 git 原理图解（本地 + 远程）

![tu](http://liuxmoo.foryung.com/333333333333333333333.png)

本地存在 3 个区域

- 工作区：就是我们的编辑区域       git add 命令可以将我们的工作保存至 缓存区
- 缓存区：我们代码的暂时的保存区域 git commit 命令可以将我们的缓存区内容提交到 本地仓库
- 本地仓库：本地代码管理区域      git push  命令可以将我们本地仓库的 commit 推送到 远程仓库

## 2.2 本地仓库-远程分支 origin/master（本地）

![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114151906.png)

```BASH
$ git checkout o/master
$ git commit
# Git 变成了分离 HEAD 状态，当添加新的提交时 o/master 也不会更新。
# 这是因为 o/master 只有在远程仓库中相应的分支更新了以后才会更新。？？？？所以呢要怎么做？
```

# 二、基础 git 命令（本地 + 远程）

- 1、 git add
- 2、 git reset    与   3、git revert
- 4、 git commit
- 5、 git branch
- 6、 git checkout
- 7、 git log
- 8、 git status
- 9、 git diff
- 10、git clone
- 11、git remote
- 12、git fetch
- 13、git merge
- 14、git rebase
- 15、git pull
- 16、git push
- 17、git cherry-pick
- 18、git tag          与   19、 git describe

## 2.1 git add 添加文件改动（添加到缓存区）

```BASH
$ git add .  # 添加所有的变动到缓存区（多人合作的话，一般不要这样用，先看 用 git status 看遍变动情况）
$ git add xxx.vue # 添加本地的 xxx.vue 文件 到缓存区
$ git add xxx.vue vvv.css # 添加本地的 xxx.vue 与 vvv.css 文件 到缓存区
```

## 2.2 git reset 与 git revert 撤销更改

### 2.2.1 git reset（撤销提交或者是添加）

```BASH
$ git reset HEAD <file> # 如果文件在 本地分支，就把它拿到 缓存区
                        # 如果文件在 缓存区  ，就把它拿到 工作区
$ git reset <file> # 这里是简写


# 注意这个与 git checkout 的区别
# git reset <file>不会改动文件内容（虽然撤销了，但是只是移动了区域，没有去改变我们做的变动）
# git checkout <file> 会改动文件内容（撤销了我们的变动，移动了区域，就是拿本地分支上的 HEAD 来覆盖本地的所有变动
# 在我们不需要我们 该文件的操作的时候，可以这样来覆盖）
```

git reset 重置/回退（这个对于多人合作的话是无效的，不要用，不要用，不要用）

```bash
$ git reset HEAD~1 # 撤销一个 commit
$ git reset HEAD^
```

git reset 通过把分支记录回退几个提交记录来实现撤销改动。你可以将这想象成“改写历史”。git reset 向上移动分支，原来指向的提交记录就跟从来没有提交过一样。

在 reset 后， 被回退的的变更还在，但是处于未加入暂存区状态。

但是。虽然在本地分支中使用 git reset 很方便，但是这种“改写历史”的方法对大家一起使用的远程分支是无效的哦！为了撤销更改并分享给别人，我们需要使用 git revert。

撤销变更 git reset 与 git revert

和提交一样，撤销变更由底层部分（暂存区的独立文件或者片段）和上层部分（变更到底是通过哪种方式被撤销的）组成。

**撤销变更的方法很多**。主要有两种方法用来撤销变更 —— 一是 git reset，还有就是 git revert。我们就学习这 2 种办法就好了。

### 2.2.2 git revert 撤销,还原/延伸（用这个，用这个，用这个，用这个，用这个，用这个，用这个，用这个）

```bash
$ git revert HEAD

# 假如我们需要撤销的是 C2 ,在我们要撤销的提交记录后面居然多了一个新提交！
# 这是因为新提交记录 C2' 引入了更改 —— 这些更改刚好是用来撤销 C2 这个提交的。
# 也就是说 C2' 的状态与 C1 是相同的。
# revert 之后就可以把我们的更改推送到远程仓库与别人分享啦。
```

## 2.4 git commit 提交修改（提交到本地分支）

```BASH
# commit 的相关命令
$ git commit # 提交修改（一次 commit 相当于一个 git 版本，注意这里不是 app 的版本）

# 不建议直接上面的提交操作，要带上适当的注释
$ git commit -m "提交修改的注释" # 提交修改，注意带上注释，不然后期维护起来不明所以!!!!!!!!
```

## 2.5 git branch 创建分支

比如说一个项目很大，通常会按照功能来做各个分支，最后再合并

```BASH
# branch 的相关命令
# 如何查看当前分支（一般带有 * 号的就是当前分支/或者在 gitKargen 上面 √ 号就是当前的分支）
$ git branch  # 列举所有的分支（带有 * 号的就是当前分支）

$ git branch branch-name  # 创建分支，名字为 branch-name，注意分支名称有大小写的区分!！！！！
$ git checkout branch-name # 切换到 branch-name 分支

# 上面两条命令的简写
$ git checkout -b branch-name # 创建并且切换到 branch-name 分支，也就是上 2 个的简写

$ git checkout -m branch-name branch-name1
# 将 branch-name 分支名称更换为 branch-name1
```

## 2.6 git checkout 切换分支/移动 HEAD/撤销修改

```BASH
# 先来学习切换分支
$ git checkout branch-name # 切换到 branch-name 分支
$ git checkout master      # 切换到 master 分支

# 移动 HEAD 到高级操作再学习


# 撤销修改
# 注意这个与 git reset 的区别
# git reset <file>不会改动文件内容（虽然撤销了，但是只是移动了区域，没有去改变我们做的变动）
# git checkout <file> 会改动文件内容（撤销了我们的变动，移动了区域，就是拿本地分支上的 HEAD 来覆盖本地的所有变动
# 在我们不需要我们 该文件的操作的时候，可以这样来覆盖）
```

## 2.7 git log 查看 commit 记录

这里的记录包含了当前分支的所有 commit 记录，自己的 commit 还有团队其他开发者的 commit 记录，都可以查看，commit 记录只会显示出来几条最近的记录，可以通过 enter 键来查看其他的记录。

```BASH
$ git log # 查看当前分支的 commit 记录
$ enter # 查看更多 commit 记录
# commit 257a3c34040e8a666cc93ab168f42d8bfd12be42                       # commit 的 哈希值
# Merge: 3dc859c 433d46a                                                #
# Author: xiaomizhou66 <39998745+xiaomizhou66@users.noreply.github.com> # 操作者
# Date:   Sun Jan 27 17:26:38 2019 +0800                                # 操作时间

#     Merge pull request #12 from xiaomizhou66/xx                       # 操作测试请求
#     修改文件测试 git 使用                                               # commit 的注解
$ q # 退出查看
```

```BASH
# 举例
liuxm@me ~/work/vue/freegit/code/freeui (develop)
λ git log
commit 3a600520cb2974a6e0b859e3ecc67dc9359d7734 (HEAD -> develop, zihua/develop, origin/develop, origin/HEAD)
Merge: 257a3c3 015a860
Author: xiaomizhou66 <39998745+xiaomizhou66@users.noreply.github.com>
Date:   Sun Jan 27 17:27:11 2019 +0800

    Merge pull request #11 from xiaomizhou66/update-readme
    修改 readme 文档

commit 257a3c34040e8a666cc93ab168f42d8bfd12be42
Merge: 3dc859c 433d46a
Author: xiaomizhou66 <39998745+xiaomizhou66@users.noreply.github.com>
Date:   Sun Jan 27 17:26:38 2019 +0800

    Merge pull request #12 from xiaomizhou66/xx
    修改文件测试 git 使用

commit 433d46ad8586b1087ca4b4326dc9b620cbf0b524 (origin/xx, xx)
Author: luixmoo <liuxmoo@gmail.com>
Date:   Sun Jan 27 17:22:36 2019 +0800

    修改文件测试 git 使用

commit 3dc859c3c48e59393d8b8efefe09337bef12a9b1
Author: yzihua <yuanzihua0@gmail.com>
Date:   Sun Jan 27 17:21:31 2019 +0800
:
```

## 2.8 git status 查看本地 3 个工作区域的变动情况

```BASH
$ git status #查看变动情况
# 没有颜色的是 本地分支的变动
# 绿色字体是 缓存区的变动
# 红色字体是 工作区的变动

# 本地分支的变动
# fix conflicts 解决冲突（手动改动文件中去解决冲突，或者 gitKargen 软件中去修改冲突）
```

```BASH
liuxm@me ~/work/vue/freegit/code/freeui (update-readme|REBASE 1/1)
λ git status
rebase in progress; onto 0053607 # 本地分支的变动~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You are currently rebasing branch 'update-readme' on '0053607'.
  (fix conflicts and then run "git rebase --continue") # 解决然后再次合并
  (use "git rebase --skip" to skip this patch) # 忽略合并
  (use "git rebase --abort" to check out the original branch) #

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage) # 将 <file> 文件从 分支 移动到 缓存区

        deleted:    REAME.md  # 缓存区的变动~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # 这里是缓存区的变动，字体会是 绿色 的

Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution) # 将 <file> 文件从 缓存区 移动到 工作区

        both modified:   README.md # 工作区的变动~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # 这里是工作区的变动，字体会是 红色 的
```

## 2.9 git diff 查看文件的具体变动内容（将改动的内容在命令行展示）

```BASH
$ git diff <file> #查看文件的具体变动内容（将改动的内容在命令行展示）
# 它会将 本地分支的 HEAD 中的文件内容 与 工作区的文件内容做比较（增删改查都会展示）

# 缓存区的文件我们没有办法去比较，如果想要比较，只能从 缓存区移动到工作区去比较
```

## 2.10 git clone 克隆线上仓库到本地

```BASH
$ git clone <仓库地址> # 克隆线上的仓库到本地
# 当然如果网络不好的时候我们可使用下载的防方式，不过还是算了吧
# 当你用 git clone 某个仓库时，Git 已经帮你把远程仓库的名称设置为 origin 了
# origin 仓库上的分支也会是 origin/master 也就是  本地的 远程分支
# 由于远程分支的特性导致其拥有一些特殊属性。远程分支反映了远程仓库(在你上次和它通信时)的状态。
# 这会有助于你理解本地的工作与公共工作的差别 —— 这是你与别人分享工作成果前至关重要的一步.
# 远程分支有一个特别的属性，在你检出时自动进入分离 HEAD 状态。Git 这么做是出于不能直接在这些分支上进行操作的原因
# 你必须在别的地方完成你的工作, （更新了远程分支之后）再用远程分享你的工作成果。
```

远程仓库却有一系列强大的特性：
  ① 首先也是最重要的的点, **远程仓库是一个强大的备份**。本地仓库也有恢复文件到指定版本的能力, 但所有的信息都是保存在本地的。**有了远程仓库以后，即使丢失了本地所有数据, 你仍可以通过远程仓库拿回你丢失的数据**。
  ② 还有就是, 远程 **让代码社交化**了! 既然你的项目被托管到别的地方了, 你的朋友可以更容易地为你的项目做贡献(或者拉取最新的变更)

现在用网站来对远程仓库进行可视化操作变得越发流行了(像 Github 或 Phabricator), 但远程仓库永远是这些工具的顶梁柱, 因此理解其概念非常的重要!**git clone 命令在真实的环境下的作用是在本地创建一个远程仓库的拷贝（比如从 github.com）**

## 2.11 git remote 查看远程分支情况

```BASH
$ git remote #列出远程仓库，origin，company 假设远程有两个仓库
# origin
# company
$ git remote show company # 展示 company 仓库的信息
# 远程分支情况
# 本地分支情况
# 本地缓存区情况
# 本地工作区情况
```

```BASH
# 一般的工作是公司有自己的仓库，开发者 folk 公司的仓库（有了自己的 origin 仓库）
$ git clone <folk 的仓库地址> # 克隆自己的仓库到本地 默认就是 origin 仓库
# 克隆了自己的仓库之后，就可以使用 git remote add 添加公司的仓库
$ git remote add company <公司的仓库地址> # 添加公司的仓库 名字是自己取名的，这里就是 company
```

## 2.12 git fetch 从远程仓库获取数据

下图中看到当我们从远程仓库获取数据时, 远程分支也会更新以反映最新的远程仓库。在上一了我们已经提及过这一点了。

![t](http://liuxmoo.foryung.com/111111111111111.png)
![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114153127.png)

```BASH
# 在上面的图片中，我们可以看到，远程仓库中有 C2,C3 两个commit （就是项目合作中其他人的提交）
$ git fetch # 从 默认 origin 远程仓库下载本地仓库中缺失的提交记录 ，更新远程分支 origin/master
$ git fetch company # 从 company 远程仓库下载本地仓库中缺失的提交记录 ，更新远程分支 origin/master
# 之后就可以获取到别人的 commit 了。
# git fetch 实际上将本地仓库中的远程分支更新成了远程仓库相应分支最新的状态。
# 远程分支反映了远程仓库在你最后一次与它通信时的状态，git fetch 就是你与远程仓库通信的方式

# git fetch 并不会改变你本地仓库的状态。它不会更新你的 master 分支，也不会修改你磁盘上（缓存区）的文件。
# 许多开发人员误以为执行了 git fetch 以后，他们本地仓库就与远程仓库同步了。
# 它可能已经将进行这一操作所需的所有数据都下载了下来，但是并没有修改你本地的文件。
# 我们在后面的课程中将会讲解能完成该操作的命令，所以, git fetch 的理解为单纯的下载操作。
# 后面使用 合并 merge 或者是 rebase 是将 本地的 master 分支的 commit 记录（base 根基）替换为  origin/master 的根基
# 这样 远程与 本地的就合并在一起了，得到了线上的，本地的自己的修改也不会被改变
```

```BASH
# 其实我们有很多方法来解决这个问题
# 当远程分支中有新的提交时，你可以像合并本地分支那样来合并远程分支。
$ git cherry-pick origin/master
$ git rebase origin/master
$ git merge origin/master
# 等等.......
```

## 2.13 git merge

在 Git 中合并两个分支时会产生一个特殊的提交记录，它有两个父节点。翻译成自然语言相当于：“我要把这两个父节点本身及它们所有的祖先都包含进来。” 相当于自动生成一个 commit 记录，然后把两个分支指向这里来，这个 commit 不是开发人员 commit 的。而是命令自定形成的。

![1](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190129155718.png)
![2](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190129155952.png)
![3](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190129160341.png)

```BASH
# 假设本地有两个分支 master 分支与 bugFix 分支
liuxm@me ~/work/vue/freegit/code/freeui (master)
$ git merge bugFix # 把 bugFix 分支里的工作合并到 master 分支上。这样 master 分支就拥有了 两个 分支的 commit 记录
$ git checkout bugFix
liuxm@me ~/work/vue/freegit/code/freeui (bugFix)
$ git merge master # 将 bugFix 分支上的 commit 合并到 master 分支，因为 master 继承自 bugFix，Git 什么都不用做，
#                    只是简单地把 bugFix 移动到 master 所指向的那个提交记录。

# rebase 与 merge 的区别就是，merge 会产生一个特殊的 commit 记录，而 rebase 只是将一个分支的 commit 记录复制到另外一个分支上去
```

## 2.14 git rebase (合并提交记录，整理提交记录)

Rebase 实际上就是取出一系列的提交记录，“复制”它们，然后在另外一个地方逐个的放下去。base 是根基的意思，其实就是类似于将一个 仓库的分支 commit 记录，复制出来，替换别人的 commit 记录。Rebase 的优势就是可以创造更线性的提交历史，这听上去有些难以理解。如果只允许使用 Rebase 的话，代码库的提交历史将会变得异常清晰。

![1](http://liuxmoo.foryung.com/2222222rdwefcwfv.png)
![2](http://liuxmoo.foryung.com/21%E7%83%AD%E7%BA%BF%E6%9C%8D%E5%8A%A13%20.png)
![3](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190129162712.png)

```BASH
# 假设本地有两个分支 master 分支与 bugFix 分支
liuxm@me ~/work/vue/freegit/code/freeui (bugFix)
$ git rebase master # 把 bugFix 分支里的工作直接移到 master 分支上。移动以后会使得两个分支的功能看起来像是按顺序开发，但实际上它们是并行开发的
$ git checkout master
liuxm@me ~/work/vue/freegit/code/freeui (master)
$ git rebase bugFix # 将 master 分支上的 commit 提取给 bugFix 分支，master 分支也得到更新了，由于 bugFix 继承自 master，
#                     所以 Git 只是简单的把 master 分支的引用向前移动了一下而已。

# rebase 与 merge 的区别就是，merge 会产生一个特殊的 commit 记录，而 rebase 只是将一个分支的 commit 记录复制到另外一个分支上去
```

### 2.14.1 git fetch 与 git rebase 一般会是这样来操作 √√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√

- git fetch：下载最新的代码
- git rebase：合并（相当于替换了 历史 commit 不会产生 特殊的 commit 记录，一般使用这个合并方法~~~~~~~~~）

rebase：提取 commit 记录，**是创建 额外的一个分支来放置所有复制合并生成的点**
        Rebase 的优势就是可以创造更线性的提交历史，这听上去有些难以理解。如果只允许使用 Rebase 的话，代码库的提交历史将会变得异常清晰。

```BASH
# Rebase 的相关命令，这里写的是本地的操作，一般本地不会使用到合并的，但是也不排除需要的时候

$ git checkout branch-name # 切换到分支 branch-name
$ git rebase master # 分支branch-name 上的提交记录 commit 提取到 master 分支
# master 分支就会有 branch-name 分支的提交记录了
# branch-name 分支就会变成半透明（是重新在一个新的地 复制出来的新的）
$ git checkout branch-name # 切换到分支 master
$ git rebase branch-name   # 将 master 分支的提交记录 cmmit 提取给 branch-name 分支

# 就是要把 branch-name 分支的提交记录给到 master ，也要把 master 的分支也给到 branch-name 分支
```

## 2.15 git pull 获取远程更新 并且 合并到本地分支 master（本地仓库就与远程仓库同步）

Git 远程仓库相当的操作实际可以归纳为两点：
  ① 向远程仓库传输数据 `git push`
  ② 从远程仓库获取数据 `git pull`
既然我们能与远程仓库同步，那么就可以分享任何能被 Git 管理的更新（因此可以分享代码、文件、想法、情书等等）。

但是上面也说了，使用 10.3 办法只是 单纯的类似为 下载的意思，并没有 本地的 master 分支，也不会修改你磁盘上的文件，本地的仓库并没有与远程仓库同步。
实际上，由于 **先抓取更新**再 **合并到本地分支** 这个流程很常用，因此 Git 提供了一个专门的命令来完成这两个操作。它就是我们要讲的 git pull。

```BASH
$ git fetch # 获取远程的 commit 更新  到 本地 master
$ git merge o/master # 合并从 o/master 获取到的 commit 到 master 上，在本例中远程仓库名为 origin

# 上面 2 个命令的简写/缩写
$ git pull # 抓取 commit 更细并且 合并同步到本地
```

### 2.15.1 操作练习 git pull

自造命令 git fakeTeamwork，这个不是学习重点，这里只是为了展示他人远程 commit

“假如”同事、朋友、合作伙伴更新了远程仓库，有可能是某个特定的分支，或是几个提交记录。
我们使用 自造命令 git fakeTeamwork。
**git fakeTeamwork 默认操作就是在【远程仓库的 master 分支】上做一次提交**

```BASH
# 提交 commit 到远程
$ git fakeTeamwork       # 如果没有分支名称   默认是 远程仓库的 master 分支 commit
$ git fakeTeamwork foo 3 # 在远程仓库 的 foo 分支 commit 3 条记录
```

```BASH
# ① 克隆他人项目
$ git clone # 将远程代码克隆到本地

# ② 协同工作每个人修改代码
# 假设远程 master 有别人 commit 的记录，本地自己也有一个 commit 记录 的操作
$ git fakeTeamwork # 在远程提交 commit （项目合作就是他人 commit 了内容），是提交在远程仓库的 master 分支
$ git commit # 在本地自己也提交了 commit                               ，是提交在本地仓库的 master 分支
#              这样本地就会有一个 origin/master 本地远程分支， 一个本地 master 分支，此时的 commit 是提到 master 上的

# ③ 获取远程 commit，并且合并更新本地代码， origin/master 分支，master 分支 合并，并且也含有 远程的 commit
$ git pull
# 这里就不要用 git fetch + git merge..... 慢慢的操作了
```

git pull（git fetch 与 git merge）一般不会直接这样使用的，可能会导致不可预想的问题 xxxx

git pull 是 git fetch 与 git merge 的简写

- git fetch：下载最新的代码
- git merge：合并（会有一个 特殊的 commit 记录，一般不会用这个!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!）

merge：做的是合并分支 **是在两个分支合并生成一个特殊的 commit 记录来交汇**

```BASH
# Merge 的相关命令，这里写的是本地的操作，一般本地不会使用到合并的，但是也不排除需要的时候

# 以下命令假设当前分支为主干/主分支 master
$ git merge branch-name # 将分支 branch-name 合并到 master 主干
# 合并两个分支时会产生一个特殊的提交记录，在 Git 中它有两个父节点。
# 其实就是合并的愿意啊，合并就是为了“我要把这两个父节点本身及它们所有的祖先都包含进来。”
# 此时 master 指向了一个拥有两个父节点的提交记录。这个特殊的提交记录。
# 此时 只有 master 分支拥有所有的 commit

$ git checkout branch-name # 切换到分支 branch-name
$ git merge master # 将主干 master 合并到 branch-name 分支上
# 此时也是会产生一个特殊的记录的......省略不说
# 如果只有这两个分支的话，此时 master 主干，branch-name 分支都拥有了所有的修改
# 当然如果还存在其他的分支的话，他们有自己的提交修改的话，
# master 就没有包含所有的修改了，branch-name 更加不会
```

## 2.16 git push

git push 负责将你的变更上传到指定的远程仓库，并在远程仓库上合并你的新提交记录。一旦 git push 完成, 你的朋友们就可以从这个远程仓库下载你分享的成果了！

你可以将 git push 想象成发布你成果的命令。它有许多应用技巧，稍后我们会了解到，但是咱们还是先从基础的开始吧……

注意 —— git push 不带任何参数时的行为与 Git 的一个名为 push.default 的配置有关。它的默认值取决于你正使用的 Git 的版本，但是在教程中我们使用的是 upstream。 这没什么太大的影响，但是在你的项目中进行推送之前，最好检查一下这个配置。

## 2.17 git cherry-pick (用于整理提交记录)

“整理提交记录” —— 开发人员有时会说“我想要把这个提交放到这里, 那个提交放到刚才那个提交的后面”。移动提交记录：自由修改提交树（整理提交记录）（赋值，没有生成新的交汇点，也没有生成新的额外的分支!!!!!!!!!!!!!!!!!!!!!!!!）

cherry-pick 需要知道哈希值啊，不然就是一大串的相对引用，很麻烦的

如果你想将一些提交复制到 **当前所在的位置（HEAD）** 下面的话， Cherry-pick 是最直接的方式了.因为它特别简单。
注意前面的 rebase 是合并，并不是复制，我们要做的复制其中的一些 commit 而已。`需要注意的是后面的 commit 才能放在 HEAD 的后面，HEAD 前面的 commit 是没有办法 放在 HEAD 后面的`

```BASH
$ git cherry-pick XXX1 XXX3 # 将 XXX 分支 XXX1·XXX3 之间的 commit 复制到当前分支 HEAD 后面
# 需要注意的是这些  XXX1 XXX3 一定是当前 HEAD 后面 commit 提交的
$ git cherry-pick XXX1 BBB3 # 将 XXX 分支的 XXX1 BBB 的 BBB3 中的
#                                commit 复制到当前分支 HEAD 后面
# 当然了， XXX1 XXX3 XXX1 BBB3 是一些哈希值呢，
# 我们需要知道所需要的提交记录（并且还知道这些提交记录的哈希值）时，使用 cherry-pick 才是简单的
# XXX1 BBB3 一定是 HEAD 后面的 commit 的
```

## 2.18 git tag 与 git describe 标签/标记/标识-描述标签

**原因**通过前面 第三、四 章的内容很容易发现：分支很容易被人为移动，并且当有新的提交时，它也会移动。分支很容易被改变，大部分分支还只是临时的，并且还一直在变。
**问题**有没有什么可以永远指向某个提交记录的标识呢，**① 比如软件发布新的大版本**，或者是 **② 修正一些重要的 Bug** 或是 **③ 增加了某些新特性**，有没有比分支更好的可以永远指向这些提交的方法呢？

**解决**Git 的 tag 就是干这个用的，它们可以（在某种程度上， 因为标签可以被删除后重新在另外一个位置创建同名的标签）永久地将某个特定的提交命名为里程碑，然后就可以像分支一样引用了。更难得的是，它们并不会随着新的提交而移动。你也不能检出到某个标签上面进行修改提交，它就像是提交树上的一个锚点，标识了某个特定的位置。

**作用**标签在代码库中起着“锚点”的作用

### 2.18.1 git tag 做标志/标签

```BASH
$ git tag V1.0.0 C1 # 将这个标签命名为 V1.0.0，并且明确地让它指向提交记录 C1，如果你不指定提交记录，Git 会用 HEAD 所指向的位置。
$ git tag V1.0.0    # 如果没有指定 commit  那么将忽视 HEAD 指向的 commit
$ git checkout V1.0.0 # 分离切换到 V1.0.0 这个 commit
```

### 2.19.2 git describe 用来描述离你最近的锚点（也就是标签）

Git Describe 能帮你在提交历史中移动了多次以后找到方向；当你用 git bisect（一个查找产生 Bug 的提交记录的指令）找到某个提交记录时，或者是当你坐在你那刚刚度假回来的同事的电脑前时， 可能会用到这个命令。

```BASH
# 语法
# $ git describe <ref> 语法如此，输出如此 <tag>_<numCommits>_g<hash>
#               <ref> 可以是任何能被 Git 识别成提交记录的引用，如果你没有指定的话，Git 会以你目前所检出的位置（HEAD）。
#               tag 表示的是离 ref 最近的标签，
#               numCommits 是表示这个 ref 与 tag 相差有多少个提交记录，
#               hash 表示的是你所给定的 ref 所表示的提交记录哈希值的前几位。
# 当 ref 提交记录上有某个标签时，则只输出标签名称
```

例如
![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114135841.png)

```BASH
$ git tag v1 C3
$ git describe master # 输出 v1_2_gC2
$ git describe side   # v2_1_gC4
```

# 三、 公司工作的实际操作

看上面的很多操作，没有实际的项目，我们是不知道怎么去使用这些命令的，而且很多时候，由于公司权限的设置，有的操作我们是没有权限去执行的，对应的命令对于我们也就是没有用处了。下面来学一下公司的流程图。

![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190127180244%20%281%29.png)

```BASH
# - 一般公司创建了自己的私有仓库（公司远程仓库）
# - 然后需要开发者去 folk 仓库（自己的远程仓库 默认名为 origin）
#   然后 git clone <自己仓库地址> 下载到本地，本地还是那样的，拥有 3 个区域（一个本地仓库，一个本地缓存区，一个本地工作区）
# - git remote add company <公司仓库地址> （给自己的远程添加一个仓库 命名为 company）

# 上面的操作就完成了基本的工作，可以开始开发了

# 一、每天的第一个工作就是获取线上的最新代码
# 路劲liuxm@me ~/work/vue/freegit/code/freeui (master) # 进入本地仓库，切换到主分支，
# 如果默认名就是 master 的话，如果是其他的比如说是 develop 就换切换 develop
# 这假设是 主分支是 develop 分支
liuxm@me ~/work/vue/freegit (develop)
$ git fetch company # 下载公司远程的最新代码（包含了其他开发者的 commit 记录）（注意要给 git fetch 加上后面的参数，不认就会默认是 origin 的了）
$ git rebase company/develop # 将下载到的代码 与 本地代码合并（base 理解为 根基的意思，其实就是将 company 的 commit 记录[根基]替换给本地的 develop 主分支）
# 这里不要直接使用 git pull（git fetch 与 git merge 的简写），可能会出现冲突代码被覆盖的情况，小心谨慎工作被丢失
#                git pull --rebase（git fetch 与 git rebase 的简写）


# 二、开发 aa 功能，创建分支来开发（通常一个分支是一个功能）
liuxm@me ~/work/vue/freegit/code/freeui (develop)
$ git checkout -b cc # 创建并且切换到 cc 分支（假设我们的分支名称本来是要 aa-ui 的）
liuxm@me ~/work/vue/freegit/code/freeui (cc)
$ git checkout -m cc aa-ui # 修改分支名称
liuxm@me ~/work/vue/freegit/code/freeui (aa-ui)
# 一顿开发操作 dhdjwwnkwai 只会就开始推送自己的代码了
$ git status # 不是必须的，但是这样做可以让自己查看当前的情况（避免一些不必要的错误）
$ git add . # git add 具体的看是添加所有还是单个文件来添加 （添加到 缓存区）
$ git commit -m "工作注解" # 将缓存区的内容添加到本地仓库分支（aa-ui 当前分支）（注解不要少，为了后续的工作，一眼便知道是干了什么）
$ git push origin # 默认的将 本地分支推送给远程 origin 仓库，也就是自己的仓库
# 到 github 上面的去提交 pr，（将自己仓库的代码 提交到 公司 company 仓库去）
# 提交 pr 时候可能会发现代码冲突，无法提交 pr 就需要修改代码解决冲突再重新提交 pr 了


# 三、开发 bb 功能
# 提价的 pr 是需要他人去看代码，然后合并到公司的仓库。（别人有可能会没有来得及做这个工作，但是我们需要开始其他功能更多操作了）

# 假如已经得到合并了
# 重复 一 的工作，下来公司仓库的最新代码，并合并，然后重复 二 的工作（记住新分支），然后又是不断的提交新代码，下拉新代码

# 假如别人还没有合并我们提价提交的 pr
# 如果要开发的 bb 功能与 aa 功能完全没有关系的，不会去使用到里面的东西，那么也是很简单，
#       重复 一 的工作，下来公司仓库的最新代码，并合并，然后重复 二 的工作（记住新分支），然后又是不断的提交新代码，下拉新代码
#       这个时候就不要去动 aa 功能的文件了，不然会导致各种复杂的冲突，
# 如果要开发的 bb 功能是与 aa 功能有关的，我们只能在原来的 aa 分支上去写代码（其实也就是有关系的功能代码就写再一个分支就好了）
#       重复 一 的工作，下来公司仓库的最新代码，并合并（下载别人的新代码还是必须的），
#       然后重复 二 的工作（就不要新的分支了，不然前面的 pr 又没有合并，一定会弄得很乱的），然后又是不断的提交新代码，下拉新代码

# 上面这个复杂的操作，其实就是说赶紧的让别人帮忙看下 pr 帮忙尽快的合并我们的代码就完事了。
```

# 四、 代码冲突解决

偏离的提交历史（就是代码提交重从冲突, 远程代码 与本地代码不匹配!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!）

`fetch、rebase/merge 和 push 组成的工作流很普遍`，就是我们的团队合作的工作，每天不断的下拉新代码，编辑代码，上传推送自己的新代码。

代码的下拉与推送基本操作我们知道了，但是在实际工作中并不是那么简单的，一个项目可能是多人合作的，这样一来，大家下拉推送代码不免就会有冲突，这个冲突才是我们需要去解决的问题。比较专业的意思有就是 **远程库提交历史的偏离。**

- git push 的时候发生了冲突
- 提交 pr 的时候发生了冲突
- git rebase 的时候发生冲突
- git pull 的时候发生冲突

## 5.1 git push 推送代码发生了冲突

假设你周一克隆了一个仓库，然后开始研发某个新功能。到周五时，你新功能开发测试完毕，可以发布了。但是，天啊！**你的同事这周写了一堆代码，还改了许多你的功能中使用的 API，这些变动会导致你新开发的功能变得不可用。但是他们已经将那些提交推送到远程仓库了，因此你的工作就变成了基于项目旧版的代码，与远程仓库最新的代码不匹配了。**（别人有改动了，还改动了我在改的文件）。这种情况下, git push 就不知道该如何操作了。如果你执行 git push，Git 应该让远程仓库回到星期一那天的状态吗？还是直接在新代码的基础上添加你的代码，亦或由于你的提交已经过时而直接忽略你的提交？**git 会拒绝你的 push 请求**，不执行任何的操作，而是提示你代码冲突了，需要先合并代码。
**因为这情况（历史偏离）有许多的不确定性，Git 是不会允许你 push 变更的。实际上它会强制要求我们先合并远程最新的代码，然后才能 推送我们的工作新代码。**

**如何解决**
很简单，你需要做的就是 **使你的工作基于最新的远程分支。**
有许多方法做到这一点呢，**不过最直接的方法就是通过 rebase 调整你的工作**。咱们继续，看看怎么 rebase！

```BASH
# 方法 1
liuxm@me ~/work/vue/freegit/code/freeui (origin/master) # 命令行后面的就是当前所在的分支
$ git fetch  # 下载远程仓库的 commit 记录（最新代码）（用 git fetch 更新了本地仓库中的远程分支 origin/master）
$ git rebase origin/master # 将我们的工作移动到最新的提交记录下（其实就是将远程的 commit 记录（根基）复制替换本地的 commit 记录（根基））

# 简写 git pull 就是 fetch 和 merge 的简写，
# 类似的 git pull --rebase 就是 fetch 和 rebase 的简写！
# 上面的两句可以改写为下面的简写
$ git pull --rebase origin/master # 将我们的工作 rebase 到 远程分支 的最新提交记录


$ git push                 # 将本地 commit 推向远程，向远程仓库推送我们的工作，前面已经 add 过了，也 commit 过了就不要再次重复执行了



# 方法 2
# git merge 不会移动你的工作（它会创建新的合并提交），但是它会告诉 Git 你已经合并了远程仓库的所有变更。
# 这是因为远程分支现在是你本地分支的祖先，也就是说你的提交已经包含了远程分支的所有变化。
$ git fetch  # 用 git fetch 更新了本地仓库中的远程分支 origin/master
$ git merge origin/master  # 合并 origin/master 远程分支上的新变更 到 master 本地分支（为了包含远程仓库的变更）
$ git push                 # 将本地 commit 推向远程
```

## 5.2 提交 pr 的时候发生了冲突

```BASH
liuxm@me ~/work/vue/freegit/code/freeui (bb-ui) # 假设我们现在开发好了 bb-ui 分支
$ git add .
$ git commit -m "开发 bb 功能"
$ git push origin
# 上面的 push 的时候没有发生错误，但是提交 pr 的时候却告诉我们发生了冲突。

# 提交 pr 提示了错误，此时我们的 pr 没有提交成功的~~~~~~~~~~记住修改好冲突之后还要去 提交 pr 的
# 既然提示了代码冲突，肯定我们修改的代码，别人也有更新，并且合并到公司仓库去了
# 那么我们首先需要做的就是去下载别人的新代码
$ git checkout develop # 切换到主分支（下载代码，都要去主分支的）
liuxm@me ~/work/vue/freegit/code/freeui (develop)
$ git fetch company
$ git rebase company/develop # 将 company 仓库的仓库的根基 赋值替换给本地 develop 主分支
$ git checkout bb-ui
liuxm@me ~/work/vue/freegit/code/freeui (bb-ui)
$ git rebase develop  # 将 develop 分支的根基赋值替换给 bb-ui 分支

# $ git am --show-current-patch 提示了错误的地方在哪里了，这个时候我们就要去解决冲突了（其实也就是下面 5.3 的时候时候发生的错误了）
# 手动修改错误
$ git add README.md # 将修改的 README.md 文件移到缓存区
$ git rebase --continue # 继续合并（替换根基）
$ git push origin # 将新修改的文件推送到远程仓库（但是通常这样 push 不成功了的,错误在下面一段说到）
$ git push -f # 将新修改的文件 强行推送到 远程仓库 origin（因位这个 origin 是自己别人也不会用到，使用 -f 没有关系的，别人的项目不要使用这个！！！！！！）
```

## 5.3 git rebase 发生了冲突

```BASH
liuxm@me ~/work/vue/freegit/code/freeui (bb-ui)
λ git rebase develop # rebase 然后就发生了下面的错误
# First, rewinding head to replay your work on top of it...
# Applying: 修改 readme 文档
# Using index info to reconstruct a base tree...
# M       code/freeui/README.md
# Falling back to patching base and 3-way merge...
# Removing code/freeui/REAME.md
# Auto-merging code/freeui/README.md
# CONFLICT (content): Merge conflict in code/freeui/README.md
# ____________________________也就是 code/freeui/ 下的 README.md 文件发生了冲突（本地的与先生的不一致了）
# error: Failed to merge in the changes.
# hint: Use 'git am --show-current-patch' to see the failed patch
# ____________________________可以使用 git am --show-current-patch 命令去查看错误的路径（或者编辑器提示了）
# Patch failed at 0001 修改 readme 文档
# Resolve all conflicts manually, mark them as resolved with
# ____________________________手动的去解决冲突，有冲突的文档会在编辑器提示的（或者上面的命令去找到冲突的地方）
# "git add/rm <conflicted_files>", then run "git rebase --continue".  
# ____________________________可以 git add/rm <conflicted_files> 然后 git rebase --continue 继续合并
# You can instead skip this commit: run "git rebase --skip".
# ____________________________或者  可以 git rebase --skip 合并，并且跳过这个 commit 不要了
# To abort and get back to the state before "git rebase", run "git rebase --abort".
# ____________________________再或者 可以 git rebase --abort 回到 git rebase 之前的状态
# 提示冲突 ONFLICT (content): Merge conflict in code/freeui/README.md
```

```BASH
# 上面的就是 rebase 冲突的一个表现
$ git am --show-current-patch # 找到冲突的文件，位置
# 编辑器其实也会提示冲突的地方的，GitKaren 工具也会提示错误的地方的
# 手动的解决掉这个冲突

# 111111111111111111111111111
# $ git add/rm <conflicted_files> # 这是什么鬼操作？？？    将冲突文件修改好之后，重新提交至缓存区
$ git add README.md # 将修改的 README.md 文件移到缓存区
$ git rebase --continue # 继续合并（替换根基）
$ git push origin # 将新修改的文件推送到远程仓库（但是通常这样 push 不成功了的,错误在下面一段说到）
$ git push -f # 将新修改的文件 强行推送到 远程仓库 origin（因位这个 origin 是自己别人也不会用到，使用 -f 没有关系的，别人的项目不要使用这个！！！！！！）

$ git rebase --skip     # 继续合并，跳过这个 commit 222222222222222222222222222222222222
$ git rebase --abort    # 不合并了，回到 git rebase 之前的状态 3333333333333333333333333
```

```BASH
$ git push origin
 ! [rejected]        bb-ui -> bb-ui (non-fast-forward)
error: failed to push some refs to 'git@github.com:xiaomizhou66/freegit.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

# 五、高级操作（本地）：介绍 Git 的超棒特性（在提交树上移动）

## 5.1 HEAD 是什么？

HEAD 是一个对当前检出记录的 **符号引用** —— 也就是 **指向** 你 **正在**其基础上进行工作的 **commit 提交记录**。
HEAD 总是指向当前分支上最近一次提交记录。大多数修改提交树的 Git 命令都是从改变 HEAD 的指向开始的。

```BASH
$ cat .git/HEAD          # 查看 HEAD 指向
$ git symbolic-ref HEAD  # 如果 HEAD 指向的是一个引用。这样查看它的指向
```

## 5.2 分离 HEAD

分离的目的就是要移动 HEAD，后面我们可以直接使用相当引用来移动 HEAD ，就不需要分离 HEAD 了，太麻烦了。

![1](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_201902323129164542.png)
![2](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190129164805.png)

```BASH
# 分离之前
# HEAD -> master -> C1
# HEAD 指向 master， master 指向 C1

$ git checkout C1
# HEAD -> C1 现在就变成了这样， HEAD 直接指向 commit 记录
```

## 5.3 移动 HEAD

移动 HEAD 的方法有 2 中，

- 一个是通过 commit 记录的哈希值来操作
- 二个就是通多相对引用 ^ ~ 来移动 HEAD

### 5.3.1 哈希值 移动

通过哈希值指定提交记录。每个提交记录的哈希值显示在代表提交记录的圆圈中。
哈希值就是通过哈希函数来计算的唯一值。

通过指定提交记录哈希值的方式在 Git 中移动不太方便。在实际应用时，并没有像本程序中这么漂亮的可视化提交树供你参考，所以你就不得不用 git log 来查查看提交记录的哈希值。
并且哈希值在真实的 Git 世界中也会更长（译者注：基于 SHA-1，共 40 位）。例如前一关的介绍中的提交记录的哈希值可能是 `fed2da64c0efc5293610bdd892f82a58e8cbc5d8`。舌头都快打结了吧...
比较令人欣慰的是，Git 对哈希的处理很智能。你只需要提供能够唯一标识提交记录的前几个字符即可。因此我可以仅输入 `fed2` 而不是上面的一长串字符。

```BASH
$ git log # 查询 commit 记录，获取到目标 commit 的哈希值 `fed2da64c0efc5293610bdd892f82a58e8cbc5d8`
$ git checkout fed2 # 移动到 fed2 这个 commit，并且分离出 HEAD
```

### 5.3.2 相对引用 ^ 与 ~

如果我们使用的是哈希值的话，就要麻烦了，一大串的字符，即使我们可以使用简写，在使用 git log 查询的试试也是一大串的字符串，命令行看起来也都不好看了，因此我们通常使用相对引用来操作。

```BASH
# ^ 用 ~ 两种相对引用
# HEAD^ 表示 HEAD 所在分支 上面 1 个commit
# HEAD~ 表示 HEAD 所在分支 上面 1 个commit
# HEAD~1 表示 HEAD 所在分支 上面 1 个commit
# HEAD~2 表示 HEAD 所在分支 上面 回退 2 个commit

# 其实 ^ 后面也是可以添加 数字，但是与 ~后面的数字一样，~ 后面的数字 指定的是 commit 的回退条数
#                                                   ^ 后面的数字 指定的 第 几个 分支
```

```BASH
# ① 返回几个 commit 记录
$ git checkout ^        # 将 HEAD 向上移动 1 个提交记录
$ git checkout HEAD^    # 将 HEAD 使用 HEAD^ 向上移动 1 个点。

$ git checkout ~   # 将 HEAD向上移动 1 个提交记录
$ git checkout ~1  # 将 HEAD向上移动 1 个提交记录
$ git checkout ~3  # 将 HEAD向上移动 3 个提交记录
$ git checkout HEAD~2   # 将HEAD 使用 HEAD~2 向上移动 2 次。


# ② 返回到分支上的几个 commit 记录
# (^)。把这个符号加在引用名称的后面，表示让 Git 寻找指定提交记录的父提交。
$ git checkout master^  # 将 HEAD 切换到 master 的父节点 中的 第一个父节点 commit 记录
$ git checkout master^^ # 将 HEAD 切换到 master  的父节点 中的 第二个父节点 commit 记录


# ③ 返回那个父分支
# 操作符 ~num 用来指定向上返回几代，也就是返回几个 commit 记录，而这里的 ^num 就不一样了。
# 操作符 ^num 用来指定合并提交记录的某个父提交。如果是 merge 合并提交有两个父提交，所以遇到这样的节点时该选择哪条路径就不是很清晰了。
# Git 默认选择合并提交的 “第一个” [是哪个？？？？？] 父提交，在操作符 ^ 后跟一个数字可以改变这一默认行为。


```

![T](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114144902.png)

```BASH
$ git checkout HEAD~  # 在 当前 所在的分支上  回退 1 个commit
# $ git checkout HEAD^  # 在 第 1 个分支上     回退 1 个commit，
$ git checkout HEAD^2 # 在 第 2 个分支上     回退 1 个commit，
$ git checkout HEAD~2 # 在 当前 所在的分支上 回退  2 个commit

# 这些相对操作其实可以链式操作，上面的 3 个操作 等价如下
$ git checkout HEAD~^2~2
```

## 5.3 移动分支（强制操作 -f）（就是省略掉切换分支的操作）

使用相对引用，强行移动分支。我使用相对引用最多的就是移动分支。可以直接使用 -f 选项让分支指向另一个提交。
更直接的说其实就是强行移动非当前分支，不需要切换分支的意思。不需要再切换分支再去移动 HEAD

![1](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190129185330.png)
![2](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190129185652.png)

```BASH
liuxm@me ~/work/vue/freegit/code/freeui (bugFix) # 当前在 bugFix 分支上，但是我们想要移动 master 分支
$ git branch -f master HEAD~3    # 将 master 分支强制指向 HEAD 的第 3 级父提交。


$ git branch -f branch-name HEAD # 将 branch-name 分支强制指向 HEAD 提交。
```

### 3.1.3 综合操作，综合操作，综合操作!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

```BASH
# ① HEAD
# HEAD 是一个对当前检出记录的符号引用，也就是是说就像是 ￥ 一样，HEAD 只是一个符号表示
# HEAD 通常情况下是指向分支名的（如 master），通常也是最后一个 commit 提交记录的位置

# ② 分离 HEAD
# 上面也说到了，HEAD 通常情况下是指向分支名的（如 master），但是我们需要的不只是这个分支名称
# 我们需要的是将当前位置也就是 HEAD 指向的是 某个/目标 commit 提交，从而才可以进一步操作
# 不是说知道是 master 分支就好了，而是要移动到具体的 commit 提交记录上面。
$ git log # 可以【查询/获取】commit 提交记录的哈希值
# 假设查询到目标提交记录的哈希值为 `fed2da64c0efc5293610bdd892f82a58e8cbc5d8`
$ git checkout fed2da64c0efc5293610bdd892f82a58e8cbc5d8 # 【分离】 HEAD 到目标 提交记录!!!!!!!
$ git checkout fed # 哈希值的简写，因为 git 的作用我们可以这样简写其中的字符就可以知道是对应的提交

# 即使我们可以使用哈希值来分离移动到我们目标的 commit 记录上，但是操作有点麻烦。
# 我们可以使用 相对引用来分离移动，具体查阅 3.1.2
```

## 5.3 综合实际应用（整理移动提交记录）

### 5.3.1 只提取其中 1 条 commit 记录（跳过 debug console.log prinf 语句的 commit）

场景：我正在解决某个特别棘手的 Bug，为了便于调试而在代码中添加了一些 **调试命令 如 console.log** 并向控制台打印了一些信息。
这些调试和打印语句都在它们各自的提交记录里。最后我终于找到了造成这个 Bug 的根本原因，解决掉以后觉得沾沾自喜！
最后就差把 bugFix 分支里的工作合并回 master 分支了。你可以选择通过 fast-forward 快速合并到 master 分支上，但这样的话 master 分支就会包含我这些调试语句了。你肯定不想这样，应该还有更好的方式……**实际我们只要让 Git 复制解决问题的那一个提交记录就可以了**

假设目前的提交树是这样的，![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114105449.png)

```BASH
# 在 bugFix 分支上的 C1 C3 是做为调试使用的，C4 才是我们调试好的 commit 也才是我们需要的
# 现在 HEAD 再 bugFix 分支上
$ git rebase -i HEAD~3
$ git merge master  # 好像 master 没有自己的 commit 的话这句不需要做？
$ git checkout master
$ git merge bugFix

# 这里是用的是 cherry-pick 方法来做
```

### 3.3.2 修改历史 commit （代码内容 或者是 commit 时候的注释）（这个方法可能有问题！！！！！！！！）

之前在 newImage 分支上进行了一次提交，然后又基于它创建了 caption 分支，然后又提交了一次。此时你想对的某个以前的提交记录进行一些小小的调整。比如设计师想修改一下 newImage 中图片的分辨率，尽管那个提交记录并不是最新的了。

假设目前的提交树是这样的，![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114112013.png)

```BASH
# git 使用 amend 选项提供了最后一次 commit 的反悔。但是对于历史提交呢 已经 pushed 的，就必须使用 rebase 了
# 也就是说如果我们只是需要直接 git commit --amend ，但是操作的是之前的操作，那么就要先将 需要修改的变成 最后一个 commit 就好了


$ git rebase -i HEAD~2 # 将 HEAD~2 后面的 commit 提取出来 ,先用 git rebase -i 将提交重新排序，然后把我们想要修改的提交记录挪到最前
$ git commit --amend # 使用 --amend 这个参数可以修改最后一次  commit 的内容，包括提交的 注释内容 都是可以的(进行一些小修改)
$ git rebase -i HEAD~2 # 将 HEAD~2 后面的 commit 提取出来 ,还原顺序
$ git branch -f master HEAD # 将 master 分支强制的合并到 HEAD（把 master 移到修改的最尾部，结合起来）
```

当然完成这个任务的方法不止上面提到的一种（当然用 cherry-pick 也是可以的啦），之后我们会多点关注这些技巧啦，但现在暂时只专注上面这种方法。 最后有必要说明一下目标状态中的那几个 ' ，我们把这个提交移动了两次，每移动一次会产生一个 ' ；而 C2 上多出来的那个是我们在使用了 amend 参数提交时产生的，所以最终结果就是这样了。

### 3.3.3 修改历史 commit （代码内容 或者是 commit 时候的注释）

上面的使用 rebase 排序的方法是可以的，但这样做就唯一的问题就是要进行两次排序，而这有可能造成由 rebase 而导致的冲突。
这个小节我们使用 git cherry-pick 来操作。`cherry-pick 可以将提交树上任何地方的提交记录取过来追加到 HEAD 上（只要不是 HEAD 上游的提交就没问题 ？？？？？什么鬼意思，没有看懂）`

假设目前的提交树是这样的，![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114112013.png)

```BASH
# 此时直接使用 git cherry-pick C2 会出错，就是因为`cherry-pick 可以将提交树上任何地方的提交记录取过来追加到 HEAD 上
#                                              （只要不是 HEAD 上游的提交就没问题） C2 属于 HEAD 上游 是不行的`
# 所以 cherry-pick 只能是复制别人的分支的 commit 么？

$ git checkout master # 切换到 master 分支
$ git cherry-pick C2  # 将 C2 复制到 master 分支上
$ git commit --amend  # 提交一些修改
$ git cherry-pick C3  # 将 C3 复制到 master 分支上
```

## 5.1 合并分支/ 使用 rebase ??????????????? 怎么做呀，好难啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊

![T](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114140833.png)

将所有的分支 commit 全都复制合并到 master 上。

```BASH
# 直接 $ git cherry-pick C3  是错误的，C3 并不是 HEAD 后面出现的。
```

交互式（就是会跳出一个窗口来选择操作 类似 UI）（这个有 UI 界面效果的，好操作多了呀）

如果你不清楚你想要的提交记录的哈希值呢? 我们可以利用交互式的 rebase ，可以从一系列的提交记录中找到想要的记录, 这就是最好的方法。

```BASH
$ git rebase --interactive HEAD~4
$ git rebase -i HEAD~4 # 简写 --interactive
# 最后得到的也是一个复制的 commit 记录

# 指的是从 HEAD~4 后面的 commit 记录都抽取出来操作，注意的是与选择不同，这里的是意思的从 HEAD~4 的后面开始挑选出来进行操作
#    ① 调整提交记录的顺序（通过鼠标拖放来完成）
#    ② 删除你不想要的提交（通过切换 pick 的状态来完成，关闭就意味着你不想要这个提交记录）
#       如果有不需要复制的 commit 点击 omit 取消即可，pick 是选择，就是需要赋值
#    ③ 合并提交。简而言之，它允许你把多个提交记录合并成一个。就是上面 第 2 章学习的 rebase 内容。
# 三种操作，然后就可以得到一个 复制的 指向 HEAD~4 的复制提交树
```

## 5.2 两个父节点 使用相对引用

```BASH
git checkout HEAD^1~2
```

## 5.3 纠缠不清的分支

# 六、高级远程（远程）：关于 origin 和它的周边 —— Git 远程仓库高级操作

## 6.1 推送主分支

在 **大型项目** 中开发人员通常会在 **从 master 上分出来的 特性分支上工作**，**工作完成后只做一次集成**。这跟前面课程的描述很相像（把 side 分支推送到远程仓库），不过本节我们会深入一些.

但是有些开发人员只在 master 上做 push、pull —— 这样的话 master 总是最新的，始终与远程分支 (o/master) 保持一致。

- 将特性分支集成到 master 上
- 推送并更新远程分支

![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114180435.png)

题目：
① 这里共有三个特性分支 —— side1 side2 和 side3。
② 我需要将这三分支按顺序推送到远程仓库
③ 因为远程仓库已经被更新过了，所以我们还要把那些工作合并过来

## 11.2 合并远程仓库

## 11.3 远程追踪

## 11.4 git push 的参数

## 11.5 git fetch 的参数

## 11.5 git pull 的参数

git pull 到头来就是 fetch 后跟 merge 的缩写。你可以理解为用同样的参数执行 git fetch，然后再 merge 你所抓取到的提交记录。

```BASH
$ git pull origin foo
# 相当于：
$ git fetch origin foo
$ git merge o/foo


$ git pull origin bar~1:bugFix
# 相当于
$ git fetch origin bar~1:bugFix
$ git merge bugFix

# git pull 实际上就是 fetch + merge 的缩写,
# git pull 唯一关注的是提交最终合并到哪里（也就是为 git fetch 所提供的 destination 参数）
```

## 11.7 没有 source 的 source