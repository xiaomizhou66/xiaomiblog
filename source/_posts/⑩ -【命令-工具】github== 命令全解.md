---
title: git 命令行全解-详解
date: '2018/8/19 23:57:28'
categories:
  - ⑩ 打包工具-命令行工具-包管理器-github
  - github
abbrlink: ada474d1
updated:
tags:
comments:
---

# 一、前言

[gitHub 视频教程](https://learngitbranching.js.org/)

# 二、基础操作：循序渐进地介绍 Git 主要命令

## 2.1 git commit 提交修改

```BASH
# commit 的相关命令
$ git commit # 提交修改
```

## 2.2 git checkout 切换分支/移动 HEAD

```BASH
# 先来学习切换分支
$ git checkout branch-name # 切换到 branch-name 分支
$ git checkout master      # 切换到 master 分支

# 移动 HEAD 到高级操作再学习
```

## 2.3 git branch 创建分支

比如说一个项目很大，通常会按照功能来做各个分支，最后再合并

```BASH
# branch 的相关命令
# 如果查看当前分支（带有 * 号的就是当前分支）
$ git branch branch-name  # 创建分支，名字为 branch-name，注意分支名称有大小写的区分!
$ git checkout branch-name # 切换到 branch-name 分支
$ git checkout -b branch-name # 创建并且切换到 branch-name 分支，也就是上 2 个的简写
$ git commit # 在 branch-name 分支上 提交修改
```

## 2.4 git merge / git rebase 合并分支

合并分支的命令有 2 种，1 种是 merge ，另外一种是 rebase。
merge：做的是合并分支 **是在两个分支合并生成一个特殊的 commit 记录来交汇**
rebase：提取 commit 记录，**是创建 额外的一个分支来放置所有复制合并生成的点**
        Rebase 的优势就是可以创造更线性的提交历史，这听上去有些难以理解。如果只允许使用 Rebase 的话，代码库的提交历史将会变得异常清晰。

```BASH
# Merge 的相关命令

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

```BASH
# Rebase 的相关命令

$ git checkout branch-name # 切换到分支 branch-name
$ git rebase master # 分支branch-name 上的提交记录 commit 提取到 master 分支
# master 分支就会有 branch-name 分支的提交记录了
# branch-name 分支就会变成半透明（是重新在一个新的地 复制出来的新的）
$ git checkout branch-name # 切换到分支 master
$ git rebase branch-name   # 将 master 分支的提交记录 cmmit 提取给 branch-name 分支

# 就是要把 branch-name 分支的提交记录给到 master ，也要把 master 的分支也给到 branch-name 分支
```

# 三、高级操作：介绍 Git 的超棒特性（在提交树上移动）

## 3.1 分离-移动 HEAD

- 分离 HEAD：如果我们使用哈希值来移动 HEAD 的话需要先分离 HEAD
- 相对引用 ^ 与 ~ 直接使用相对引用的话就不需要分离出来了

我们需要知道当前的 HEAD 处在哪里哦。

### 3.1.1 哈希值（题外学习）

通过哈希值指定提交记录。每个提交记录的哈希值显示在代表提交记录的圆圈中。
哈希值就是通过哈希函数来计算的唯一值。

通过指定提交记录哈希值的方式在 Git 中移动不太方便。在实际应用时，并没有像本程序中这么漂亮的可视化提交树供你参考，所以你就不得不用 git log 来查查看提交记录的哈希值。
并且哈希值在真实的 Git 世界中也会更长（译者注：基于 SHA-1，共 40 位）。例如前一关的介绍中的提交记录的哈希值可能是 `fed2da64c0efc5293610bdd892f82a58e8cbc5d8`。舌头都快打结了吧...
比较令人欣慰的是，Git 对哈希的处理很智能。你只需要提供能够唯一标识提交记录的前几个字符即可。因此我可以仅输入 `fed2` 而不是上面的一长串字符。

### 3.1.2 相对引用 ^ 与 ~

如果我们使用的是哈希值的话，就要麻烦了，一大串的字符，即使我们可以使用简写，在使用 git log 查询的试试也是一大串的字符串，命令行看起来也都不好看了，因此我们通常使用相对引用来操作。

```BASH
$ git checkout ^   # 将HEAD 向上移动 1 个提交记录
$ git checkout ~1  # 将HEAD向上移动 1 个提交记录
$ git checkout ~3  # 将HEAD向上移动 3 个提交记录
# (^)。把这个符号加在引用名称的后面，表示让 Git 寻找指定提交记录的父提交。
$ git checkout master^  # 将HEAD 切换到 master 的父节点 commit 记录
$ git checkout master^^ # 将HEAD 切换到 master 的第二个父节点 commit 记录
$ git checkout HEAD^    # 将HEAD 使用 HEAD^ 向上移动 1 个点。
$ git checkout HEAD~2   # 将HEAD 使用 HEAD~2 向上移动 2 次。
```

操作符 ^ 与 ~ 符一样，后面也可以跟一个数字。但是该操作符后面的数字与 ~ 后面的不同，并不是用来指定向上返回几代，而是指定合并提交记录的某个父提交。还记得前面提到过的一个合并提交有两个父提交吧，所以遇到这样的节点时该选择哪条路径就不是很清晰了。
Git 默认选择合并提交的 “第一个” [是哪个？？？？？] 父提交，在操作符 ^ 后跟一个数字可以改变这一默认行为。

```BASH
# ^ 用 ~ 两种相对引用
# HEAD^ 表示 HEAD 所在分支 上面 1 个commit
# HEAD~ 表示 HEAD 所在分支 上面 1 个commit
# HEAD~1 表示 HEAD 所在分支 上面 1 个commit
# HEAD~2 表示 HEAD 所在分支 上面 回退 2 个commit

# 其实 ^ 后面也是可以添加 数字，但是与 ~后面的数字一样，~ 后面的数字 指定的是 commit 的回退条数
#                                                   ^ 后面的数字 指定的 第 几个 分支
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

### 3.1.3 强制操作 -f（目的是移动分支）

我使用相对引用最多的就是移动分支。可以直接使用 -f 选项让分支指向另一个提交。

```BASH
$ git branch -f master HEAD~3 #将 master 分支强制指向 HEAD 的第 3 级父提交。
$ git branch -f branch-name HEAD #将 branch-name 分支强制指向 HEAD 提交。
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

### 3.1.4 HEAD 的其他操作

```BASH
$ cat .git/HEAD         # 看 HEAD 指向
$ git symbolic-ref HEAD # 如果 HEAD 指向的是一个引用。这样查看指向
```

## 3.2 撤销变更 git reset 与 git revert

和提交一样，撤销变更由底层部分（暂存区的独立文件或者片段）和上层部分（变更到底是通过哪种方式被撤销的）组成。

**撤销变更的方法很多**。主要有两种方法用来撤销变更 —— 一是 git reset，还有就是 git revert。我们就学习这 2 种办法就好了。

### 3.2.1 git reset 重置/回退（这个对于多人合作的话是无效的，不要用，不要用，不要用）

```bash
$ git reset HEAD~1 # 撤销一个 commit
$ git reset HEAD^
```

git reset 通过把分支记录回退几个提交记录来实现撤销改动。你可以将这想象成“改写历史”。git reset 向上移动分支，原来指向的提交记录就跟从来没有提交过一样。

在 reset 后， 被回退的的变更还在，但是处于未加入暂存区状态。

但是。虽然在本地分支中使用 git reset 很方便，但是这种“改写历史”的方法对大家一起使用的远程分支是无效的哦！为了撤销更改并分享给别人，我们需要使用 git revert。

### 3.2.2 git revert 还原/延伸（用这个，用这个，用这个，用这个，用这个，用这个，用这个，用这个）

```bash
$ git revert HEAD
```

假如我们需要撤销的是 C2 ,在我们要撤销的提交记录后面居然多了一个新提交！这是因为新提交记录 C2' 引入了更改 —— 这些更改刚好是用来撤销 C2 这个提交的。也就是说 C2' 的状态与 C1 是相同的。
revert 之后就可以把你的更改推送到远程仓库与别人分享啦。

# 四、移动提交记录：自由修改提交树（整理提交记录）（赋值，没有生成新的交汇点，也没有生成新的额外的分支!!!!!!!!!!!!!!!!!!!!!!!!）

前面的 二、三章 的学习，提交、分支以及在提交树上移动。 这些概念涵盖了 Git 90% 的功能，同样也足够满足开发者的日常需求。
剩余的 10% 在处理复杂的工作流时(或者当你陷入困惑时）可能就显示尤为重要了。接下来要讨论的这个话题是“整理提交记录” —— 开发人员有时会说“我想要把这个提交放到这里, 那个提交放到刚才那个提交的后面”。
就需要在这章来学习了。

## 4.1 git cherry-pick （当然这个也是需要知道哈希值啊，不然就是一大串的相对引用，很麻烦的）

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

## 4.2 git rebase 交互式（就是会跳出一个窗口来选择操作 类似 UI）（这个有 UI 界面效果的，好操作多了呀）

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

## 4.3 综合实际应用

### 4.3.1 只提取其中 1 条 commit 记录（跳过 debug console.log prinf 语句的 commit）

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

### 4.3.2 修改历史 commit （代码内容 或者是 commit 时候的注释）（这个方法可能有问题！！！！！！！！）

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

### 4.3.3 修改历史 commit （代码内容 或者是 commit 时候的注释）

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

# 五、标签/标记/标识-描述标签

**原因**通过前面 第三、四 章的内容很容易发现：分支很容易被人为移动，并且当有新的提交时，它也会移动。分支很容易被改变，大部分分支还只是临时的，并且还一直在变。
**问题**有没有什么可以永远指向某个提交记录的标识呢，**① 比如软件发布新的大版本**，或者是 **② 修正一些重要的 Bug** 或是 **③ 增加了某些新特性**，有没有比分支更好的可以永远指向这些提交的方法呢？

**解决**Git 的 tag 就是干这个用的，它们可以（在某种程度上， 因为标签可以被删除后重新在另外一个位置创建同名的标签）永久地将某个特定的提交命名为里程碑，然后就可以像分支一样引用了。更难得的是，它们并不会随着新的提交而移动。你也不能检出到某个标签上面进行修改提交，它就像是提交树上的一个锚点，标识了某个特定的位置。

**作用**标签在代码库中起着“锚点”的作用

## 5.1 git tag 做标志/标签

```BASH
$ git tag V1.0.0 C1 # 将这个标签命名为 V1.0.0，并且明确地让它指向提交记录 C1，如果你不指定提交记录，Git 会用 HEAD 所指向的位置。
$ git tag V1.0.0    # 如果没有指定 commit  那么将忽视 HEAD 指向的 commit
$ git checkout V1.0.0 # 分离切换到 V1.0.0 这个 commit
```

## 5.2 git describe 用来描述离你最近的锚点（也就是标签）

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

# 六、操作练习/高级---多分支的处理

## 6.1 合并分支/ 使用 rebase ??????????????? 怎么做呀，好难啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊

![T](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114140833.png)

将所有的分支 commit 全都复制合并到 master 上。

```BASH
# 直接 $ git cherry-pick C3  是错误的，C3 并不是 HEAD 后面出现的。
```

## 6.2 两个父节点 使用相对引用

```BASH
git checkout HEAD^1~2
```

## 6.3 纠缠不清的分支

# 十、基础远程：Push & Pull —— Git 远程仓库！

前面我们说的代码都是本地的 提交树的操作，但是我们都是多人合作，即使不是多人合作一般我们也是需要在网上分享的，这个就需要使用到远程了而不是仅仅在我们的本地来操作那么简单了。

## 10.1 git clone 远程克隆

远程仓库并不复杂, 在如今的云计算盛行的世界很容易把远程仓库想象成一个富有魔力的东西, 但实际上它们只是你的仓库在另个一台计算机上的拷贝。你可以通过因特网与这台计算机通信：也就是增加或是获取提交记录。

话虽如此, 远程仓库却有一系列强大的特性：
  ① 首先也是最重要的的点, **远程仓库是一个强大的备份**。本地仓库也有恢复文件到指定版本的能力, 但所有的信息都是保存在本地的。**有了远程仓库以后，即使丢失了本地所有数据, 你仍可以通过远程仓库拿回你丢失的数据**。
  ② 还有就是, 远程 **让代码社交化**了! 既然你的项目被托管到别的地方了, 你的朋友可以更容易地为你的项目做贡献(或者拉取最新的变更)

现在用网站来对远程仓库进行可视化操作变得越发流行了(像 Github 或 Phabricator), 但远程仓库永远是这些工具的顶梁柱, 因此理解其概念非常的重要!

**git clone 命令在真实的环境下的作用是在本地创建一个远程仓库的拷贝（比如从 github.com）**。 但在我们的教程中使用这个命令会有一些不同 ，它会在远程创建一个你本地仓库的副本（因为我们没有实际的在我们的电脑本地区克隆项目，就当我们的电脑在我们看不见的地方好了）。显然这和真实命令的意思刚好相反，但是它帮咱们把本地仓库和远程仓库关联到了一起，在教程中就凑合着用吧。

```BASH
$ git colone xxxxxx  # 这里 xxxxx 是从 gitHub 项目获取到的链接
```

你可能注意到的第一个事就是在我们的 **本地仓库多了一个名为 o/master 的分支, 这种类型的分支就叫远程分支。**由于远程分支的特性导致其拥有一些特殊属性。远程分支反映了远程仓库(在你上次和它通信时)的状态。这会有助于你理解本地的工作与公共工作的差别 —— 这是你与别人分享工作成果前至关重要的一步.远程分支有一个特别的属性，**在你检出时自动进入分离 HEAD 状态。Git 这么做是出于不能直接在这些分支上进行操作的原因,**
**你必须在别的地方完成你的工作, （更新了远程分支之后）再用远程分享你的工作成果。**

o/master 的分支，那么这个分支就叫 master，远程仓库的名称就是 o
o/ 远程分支一个命名规范 `<remote name>/<branch name>`

大多数的开发人员会 **将它们主要的远程仓库命名为 origin**，并不是 o。这是因为当你用 git clone 某个仓库时，Git 已经帮你把远程仓库的名称设置为 origin 了。不过 origin 对于我们的 UI 来说太长了，因此不得不使用简写 o 但是要记住, 当你使用真正的 Git 时, 你的 **远程仓库默认为 origin**

## 10.4 远程分支 origin/master

![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114151906.png)

```BASH
$ git checkout o/master
$ git commit
# Git 变成了分离 HEAD 状态，当添加新的提交时 o/master 也不会更新。
# 这是因为 o/master 只有在远程仓库中相应的分支更新了以后才会更新。？？？？所以呢要怎么做？
```

## 10.3 git fetch  从远程仓库获取数据（但是这个不能一步到位，我们通常应该使用 git pull）

Git 远程仓库相当的操作实际可以归纳为两点：
  ① 向远程仓库传输数据 `git push`
  ② 从远程仓库获取数据 `git pull`
既然我们能与远程仓库同步，那么就可以分享任何能被 Git 管理的更新（因此可以分享代码、文件、想法、情书等等）。

你会看到当我们从远程仓库获取数据时, 远程分支也会更新以反映最新的远程仓库。在上一了我们已经提及过这一点了。

![t](http://liuxmoo.foryung.com/111111111111111.png)
![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190114153127.png)

```BASH
# 在上面的图片中，我们可以看到，远程仓库中有 C2,C3 两个commit （就是项目合作中其他人的提交），我们使用 
$ git fetch
# ① 从远程仓库下载本地仓库中缺失的提交记录
# ② 更新远程分支指针(如 o/master)
#  之后就可以获取到别人的 commit 了。
# git fetch 实际上将本地仓库中的远程分支更新成了远程仓库相应分支最新的状态。
# 远程分支反映了远程仓库在你最后一次与它通信时的状态，git fetch 就是你与远程仓库通信的方式
```

**git fetch 不会做的事**
git fetch 并不会改变你本地仓库的状态。它不会更新你的 master 分支，也不会修改你磁盘上的文件。
理解这一点很重要，**因为许多开发人员误以为执行了 git fetch 以后，他们本地仓库就与远程仓库同步了**。它可能已经将进行这一操作所需的所有数据都下载了下来，但是并没有修改你本地的文件。我们在后面的课程中将会讲解能完成该操作的命令，**所以, 你可以将 git fetch 的理解为单纯的下载操作。**

```BASH
# 其实我们有很多方法来解决这个问题
# 当远程分支中有新的提交时，你可以像合并本地分支那样来合并远程分支。
$ git cherry-pick o/master
$ git rebase o/master
$ git merge o/master
# 等等.......
```

## 10.4 git pull 获取远程更新 并且 合并到本地分支 master（本地仓库就与远程仓库同步）

但是上面也说了，使用 10.3 办法只是 单纯的类似为 下载的意思，并没有 本地的 master 分支，也不会修改你磁盘上的文件，本地的仓库并没有与远程仓库同步。
实际上，由于 **先抓取更新**再 **合并到本地分支** 这个流程很常用，因此 Git 提供了一个专门的命令来完成这两个操作。它就是我们要讲的 git pull。

```BASH
$ git fetch # 获取远程的 commit 更新  到 本地 master
$ git merge o/master # 合并从 o/master 获取到的 commit 到 master 上，在本例中远程仓库名为 origin

# 上面 2 个命令的简写/缩写
$ git pull # 抓取 commit 更细并且 合并同步到本地
```

## 10.5 模拟团队合作----操作练习 git pull

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

## 10.6 git push

git push 负责将你的变更上传到指定的远程仓库，并在远程仓库上合并你的新提交记录。一旦 git push 完成, 你的朋友们就可以从这个远程仓库下载你分享的成果了！

你可以将 git push 想象成发布你成果的命令。它有许多应用技巧，稍后我们会了解到，但是咱们还是先从基础的开始吧……

注意 —— git push 不带任何参数时的行为与 Git 的一个名为 push.default 的配置有关。它的默认值取决于你正使用的 Git 的版本，但是在教程中我们使用的是 upstream。 这没什么太大的影响，但是在你的项目中进行推送之前，最好检查一下这个配置。

## 10.7 偏离的提交历史（就是代码提交重从冲突, 远程代码 与本地代码不匹配!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!）

`fetch、rebase/merge 和 push 组成的工作流很普遍`

现在我们已经知道了如何从其它地方 pull 提交记录，以及如何 push 我们自己的变更。看起来似乎没什么难度，但是为何还会让人们如此困惑呢？
困难来自于远程库提交历史的偏离。

假设你周一克隆了一个仓库，然后开始研发某个新功能。到周五时，你新功能开发测试完毕，可以发布了。但是，天啊！**你的同事这周写了一堆代码，还改了许多你的功能中使用的 API，这些变动会导致你新开发的功能变得不可用。但是他们已经将那些提交推送到远程仓库了，因此你的工作就变成了基于项目旧版的代码，与远程仓库最新的代码不匹配了。**

这种情况下, git push 就不知道该如何操作了。如果你执行 git push，Git 应该让远程仓库回到星期一那天的状态吗？还是直接在新代码的基础上添加你的代码，异或由于你的提交已经过时而直接忽略你的提交？**实际上 git 会拒绝你的 push 请求**，不执行任何的操作，而是提示你代码冲突了，需要先合并代码。
**因为这情况（历史偏离）有许多的不确定性，Git 是不会允许你 push 变更的。实际上它会强制你先合并远程最新的代码，然后才能分享你的工作。**

**如何解决**
很简单，你需要做的就是 **使你的工作基于最新的远程分支。**
有许多方法做到这一点呢，**不过最直接的方法就是通过 rebase 调整你的工作**。咱们继续，看看怎么 rebase！

```BASH
# 方法 1
$ git fetch  # 下载远程仓库的 commit（用 git fetch 更新了本地仓库中的远程分支 origin/master）
$ git rebase origin/master # 将我们的工作移动到最新的提交记录下？？？？确定可以？API 都改了确定可以？？？？？？
$ git push                 # 将本地 commit 推向远程
# 简写 git pull 就是 fetch 和 merge 的简写，
# 类似的 git pull --rebase 就是 fetch 和 rebase 的简写！
# 也就是说方法 1 可以改成
$ git pull --rebase origin/master # 将我们的工作 rebase 到 远程分支 的最新提交记录
$ git push # 向远程仓库推送我们的工作



# 方法 2
# git merge 不会移动你的工作（它会创建新的合并提交），但是它会告诉 Git 你已经合并了远程仓库的所有变更。
# 这是因为远程分支现在是你本地分支的祖先，也就是说你的提交已经包含了远程分支的所有变化。
$ git fetch  # 用 git fetch 更新了本地仓库中的远程分支 origin/master
$ git merge origin/master  # 合并 origin/master 远程分支上的新变更 到 master 本地分支（为了包含远程仓库的变更）
$ git push                 # 将本地 commit 推向远程
```

# 十一、高级远程：关于 origin 和它的周边 —— Git 远程仓库高级操作

## 11.1 推送主分支

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
