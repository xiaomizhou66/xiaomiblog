---
title: Chrome 开发者工具的使用详解
date: '2018/8/19 23:57:28'
categories:
  - ⑧ JS 工具集/ JS拓展语言
  - Chrome 开发者工具
updated:
tags:
comments:
---

# 一、Chrome 开发者工具

在编写代码时，少不了需要调试代码，调试样式，检查 bug 等等,肯定要把开发者工具学会。

[谷歌开发者工具中文文档](https://www.css88.com/doc/chrome-devtools/)
[PHP网站中文开发者文档](https://www.html.cn/doc/chrome-devtools/inspect-styles/edit-styles/),这个php 网站的说得非常的好，还是看这个好了，非常的全，不仅说了浏览器的调试问题，还有其他的问题的调试。

# 二、面板基础了解

- Elements(元素面板)：
    使用“元素”面板可以通过自由操纵 DOM 和 CSS 来重演您网站的布局和设计。
- Console(控制台面板)：
    在开发期间，可以使用控制台面板记录诊断信息。或者使用它作为 shell,在页面上与 JavaScript 交互。
- Sources(源代码面板)：**断点调试 JS（就是 debugger 调试）**
    在“源代码”面板中，可以断点调试 JavaScript 。或者通过 Workspaces（工作区）连接本地文件，使用开发者工具实时编辑。
- Network(网络面板)
    使用“网络”面板了解请求和下载的资源文件，并优化您的网页加载性能。
- Performace【原 Timeline (时间轴面板)】
    使用时间轴面板，可以通过记录录像提高页面的运行时性能。并探索网站生命周期内发生的各种事件。
- Memory【 Profiles(分析面板)】
    如果你需要比时间轴面板提供的更多信息，请使用“配置”面板，例如以跟踪内存泄漏。
- Application(资源面板)
    使用“资源”面板检查加载的所有资源，包括 IndexedDB 与 Web SQL 数据库，本地和会话存储，cookie，应用程序缓存，图像，字体和样式表。
- Security(安全面板)
    使用安全面板调试混入内容问题，您的证书的安全隐患及更多。
- Audits
    对当前网页进行网络利用情况、网页性能方面的诊断，并给出一些优化建议。比如列出所有没有用到的 CSS 文件等。
- Vue：vue-develop 开发插件

# 三、打开开发者工具

- 在 Chrome 菜单中选择 更多工具 > 开发者工具。
- 在页面元素上右键点击，选择 “检查”。
- 使用快捷键 Ctrl+Shift+I (Windows) 或者 Cmd+Opt+I (Mac)。

# 四、Elements(元素面板)

[php 网站文档与视频](https://www.css88.com/doc/chrome-devtools/inspect-styles)

![T](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190201203213.png)

一些使用技巧：

- 在 DOM 树中，按住 alt 键去点击一个节点，可以将它的所有子节点全都展开。选择DOM元素和在带有剪头的地点按住Alt +点击鼠标左键，可以展开所有子节点
- 在 dom 中，我们可以选中一行dom元素，然后在右键，选择 break on ，可以看到，到这里就会有断点发生。DOM BreakPoints
- 点击右键之后，这里有很多选项都是之前很少用但是非常有用的，比如编辑、copy、hide（这样就不用自己设置 display：none 了）
    还有测试 force state (active、hover、focus、visited)的情况，这样就不用我们每次亲自去测试了。另外， 包括断点中的内部节点发生变化、属性发生变化、断点要移除之后都会出现断点的情况。可以多多利用之。
- 查找不生效的样式：
    在样式中，如果我们看到某个样式是划横线，并且前面有个换色三角形的标志，说明这个属性是不存在的，其实就是我们在编辑 css 文件的时候写错了，然后这个属性不能生效，比如说在尺寸属性的时候写 px 成了 xp 就不会生效了。
- 增加一个 class 样式：
    在 style 的模块中，有一个 + 号，点击这里可以增加样式。然后编辑样式属性与值
    还可以直接在 DOM 中选中元素，然后右键 `edit as html` 就可以像是在编辑器中那样去编辑了
- 颜色的选择：
    如果 ui 不是 ui 设计师设计，而是我们自己做的，希望选择自己喜欢的颜色的时候，在编辑器去调颜色是很麻烦的，直接在 浏览器中去点击色块就可以调颜色。
- 选中 DOM 之后右键copy
    可以去复制浏览器中的 html 代码，复制到我们的 编辑器中去使用
- 某些交互动画的 DOM 查找
    有的是 hover 啊，或是交互才会显示出来的元素，我们通过箭头去是找不到对应的 DOM 的，太难了。这个时候我们应该在显示页面中去右键-> 审查，这样就会跳转到对应的 DOM 节点元素上了。（这个时候鼠标不要再移动到显示页面了，否则又会恢复到原来的样子，我们需要调试的 DOM 节点就又找不到了）

## 4.1 style 模块（查看属性继承至哪里）

从上往下是元素继承来的样式，一直继承自 html，这个继承顺序是按照嵌套顺序来排列的。**在这里可以修改样式来及时的观察页面显示。**

Styles(样式)窗格允许您以尽可能多的方式更改本地 CSS，包括编辑现有样式，添加新样式，添加样式规则。这个只是在浏览器修改了没有在编辑器中改。
如果你想要样式持久（他们页面重新加载而丢失），您需要将它们持久化到您的开发工作区？什么意思没有看懂，还是在自己的编辑器中去修改就好了，不要搞这种不必要的麻烦，以后熟悉的了话可以学习。

## 4.2 computed 模块（该节点的所有样式/盒子模型）

这个元素的盒模型，盒模型的下方是这个元素的所有属性，我们可以通过代码其来判定我们写的代码存在的问题。**可以快速找到需要查看的样式，点击之后跳转到 style 模块去修改调试**

## 4.3 Event Listeners 事件监听模块

我们选择的元素中被绑定的事件都会在这里显示。**我们可以通过查看该事件来查看作用域链。**

# 五、 Console(控制台面板)

[文档与视频](https://www.css88.com/doc/chrome-devtools/console)

## 5.1 console 命令输出

![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190201201717.png)

```JS
// 上面图片中的 console.log 输出，我们可以做成这样拥有样式的，可以让我们在使用 console 命令调试的时候快速的找到目标，也不再显得单调
console.log('%c我%c爱%c你','font-size:60px;color:red','font-size:40px;color:blue','font-size:20px;color:green')

// 用 %c 符号来分开字符串，然后分别修饰 后面是 css 修饰
// %s 还有 %d 啊等等，这些其实都是可以使用在 console 输出命令中的。
// 但是应该没有这么必要，我们最终的目的只是为了调试代码，又不搞什么花样。
```

# 六、 Sources(源代码面板) 断点调试

在编写 JavaScript 代码时，如果出现了 bug，就要不断的去找错误，如果 console 控制台中提示还好说，可是没有提示恐怕就要费一番周折了。但是有了 chrome 这个浏览器，我们通过开发者工具就可以很好的实现调试了。这里我们要学习的就是这个 sources 页面资源面板，通过这个模块，我们可以找到任何我们需要的页面资源。

[设置断点文档与视频](https://www.css88.com/doc/chrome-devtools/javascript/add-breakpoints)
官网文档都看不懂，这里有篇[非常仔细的文档](https://www.cnblogs.com/zhuzhenwei918/p/6132531.html)

## 6.1 在 sources 面板快速找到对应的文件

- 从其他面板直接跳转过来，console 面板，element 面板，等等 跳过 js 文件
- 在 sources 面板 手动的找到文件，但是这个太麻烦了
- 在 sources 面板 使用快捷键， ctrl + p
- 如果代码是压缩的，点击花括号可以展开代码。

[sources 调试 JS 代码视频学习](https://www.imooc.com/video/13423),这个视频调试说得还不错.

## 6.1 调试面板的了解

![sources面板](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190201161838.png)

- 断点：在代码中输入 debugger;  那么就会在运行中自动在这里打一个断点， 但是这样很麻烦，我们直接在 source 面板中中设置断点要好很多，后期还不用删代码。
        可以在代码的左边打断点，蓝色代码所在行表示目前代码的执行阶段，深蓝色代表将要执行但还未执行的代码。而浅蓝色代表已经执行过了的代码。
        我们把鼠标停留在 变量中可以显示变量的值。如果希望得到一个变量的计算值，就选中那个算式，即可显示当前结果值。

### 6.1.1 代码的暂停与开启执行

- ![||](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190201214122.png):
        `pause script excution`。,暂停 js 代码运行，如果有定时器就会定格在定时器。没有就是当前执行到哪里就停止在哪里。
- ![1](http://liuxmoo.foryung.com/11111111111111111111111111111111111111111111111111.png):
        `resume script excution`。恢复 js 代码的执行，点击就可以恢复代码的执行。

### 6.1.2 断点测试

① 先设置断点
② **在显示页面操作，触发事件，触发这个我们设置了断点的 ui 页面的按钮啊，或者其他的什么乱七八糟的元素！！！！！！！原来是这样触发的啊！！！！！！那么多次学习就是这个点没有找到！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！**
  这时候我们可以看到断点之上的语句结果已经被执行出来的，接下来就是看我们希望如何去操作了，利用好 4 个断点调试的操作
③ 点击下面的按钮来操作代码的执行（下面 4 个选项操作）
④ 代码被执行完了，没有错误肯定就会一直执行下去了,如果有页面跳转啊什么的,页面都不一样的,(没错肯定也就不调试了.)
    有错误啊还要观察，点击 ![1](http://liuxmoo.foryung.com/11111111111111111111111111111111111111111111111111.png) ，来恢复执行

- ![2](http://liuxmoo.foryung.com/222222222222222222222222222222222.png):
        `step over next function`, **over 也就是跨函数方法运行，它不会进入到函数内部，而是直接给出方法执行之后的结果**
        直接跳到下一个函数。即如果遇到一个函数，它会直接执行完这个函数，直接执行函数进入下一步，不显示函数执行的细节。
- ![3](http://liuxmoo.foryung.com/33333333333333333333333333333333.png):
        `step into next function`, **into 也就是进入函数方法去运行。可以在函数方法里面一步步执行来观察结果**
        进入函数。即如果遇到一个函数，它不会一下运行完这个函数，而是进入函数内部，一步一步地执行，这样，我们可以更清楚地观察执行过程。
        恢复执行之后,如果后面有断点,它就会又停下来的.所以我们设置多个断点调试完全 ok .
        恢复执行之后,如果后面没有代码了,它就会跑到第一个断点处,让我们可以再次快速定位去调试.
- ![4](http://liuxmoo.foryung.com/444444444444444444444444444444.png):
        `step out of current function`, **out of current 就是退出函数函数方法的运行，与 into 是配套的呀**
        前面函数内部，但是我们现在不希望一步步执行了，希望尽快退出这个函数。点击这个按钮可以结束这个函数的步骤执行。
        我们可以通过此功能来一下执行完函数内部剩下的代码。其实也就是让他从进入可以一步步执行的状态,转成![2](http://liuxmoo.foryung.com/222222222222222222222222222222222.png)这个一步执行完成的状态,不要浪费时间.
- ![5](http://liuxmoo.foryung.com/555555555555555555555555555.png):
        `step` **step 就是一步步的执行**

### 6.1.3 禁用断点

- ![6](http://liuxmoo.foryung.com/6666666666666666666.png):
    `Deactivate breakpoints` 停用断点
    在我们调试的时候不可能都是只用一个断点,很多时候我们打了多个断点,这样一样,代码就是老是会暂停,我们不得不一次次的恢复代码执行,这个是很烦的,但是我们又不希望去取消我们设置好的断点,我们调试需要的呀,
    那么这个 停止断点使用的按钮就是拿来解决这个问题用的。
    `activate breakpoints` 恢复使用断点
    当然如果不是需要关闭恢复所有的断点，可以使用 breakpoints 中的勾选来挑选暂停使用与恢复使用。
    使用中的断点是深蓝色的，禁用的是浅色的
- ![7](http://liuxmoo.foryung.com/77777777777777777777.png):
    `pause on exceptions` 遇到异常就暂停
    运行代码的时候，将这个打开，勾选功能。这样运行的时候，遇到异常的话，代码就会在这里停下来，比如变量没有定义就是用。打开这个也方便我们找到问题代码。




## 6.2 watch 的使用

- 利用鼠标：在设置断点的片段代码中我们可以得知其中变量的当前值，或者几个变量的计算值。
- watch：这个方法更加直观的去观察我们变量计算

如果在代码中 b = a - 1 的值对我们十分重要，我们把它加入到 watch 中去调试
① 选中 b = a - 1 代码
② 然后在点击最后一个选项 `Add selected text to watches`, 然后注意观察右上角的 watch
③ 在执行过程中，表达式的值有改变，可以在 watch 中可以看到。Watch 下面的表达式会立即更新，这对于我们监控起来还是非常方便的。

```JS
Array.prototype.binary_search = function (low, high, key) {
    if (low > high) {
        return -1;
    }
    // 注意： 这里是两者相加，如果是相减，明显就是错的，实践出真知~
    var mid = parseInt((high + low) / 2);
    if (key < this[mid]) { // 如果需要观察 this[mid] 的值，就必须使用 watch ，使用鼠标就没得到这样的变量的值
        return this.binary_search(low, mid - 1, key);
    } else if (key > this[mid]) {
        return this.binary_search(mid + 1, high, key);
    } else {
        // return this[key]; // 最后返回key也是可以的。
        return this[mid];
    }
}
var arr = [15, 18, 25, 45, 56, 59, 78, 83];
console.log(arr.binary_search(0, arr.length - 1, 56));
```

## 6.3 call stack 的使用

先来读懂代码错误的位置吧，如果错误提示在 console 面板中的话，都会告诉我们错误是在哪里的（庆幸 console 面板 有提示错误吧，没有提示错误的 bug 绝对难找）。

```BASH
test.html:15 Uncaught ReferenceError: a is not defined                    test.html:15 # 这里提示在  test.html 文件的第 15 行中有错误，变量 a 没有定义
    at test.html:15 # ① 错误在 test.html 文件的第 15 行 （因为它处在一个匿名函数中，所以 at 就没有说明具体的环境，程序在这里停止了，当前栈的环境在第 15 行）
    at aa (test.html:17) # ② at aa 这是一个函数，即如果退出当前栈环境后所在的环境，那显然就是在函数 aa 的环境之下了（也就是提示我们 ① 如果得到执行，
                         #    下一步即将进入的环境应该是 17 行的坏境，也就是 aa 函数环境）
    at test.html:19      # ③ 如果第 ② 步能够执行完，即将进入的是 19 行的环境
```

上面错误提示是 console 面板直接告诉我们的错误。其实 sources 面板中的 call stack 就是这个错误的就是这么一个由当前错误退出栈的一个过程。 核心问题就在当前错误上。后面指定的位置时行数。一句话：`call stack 的顺序是由当前到原来的一个栈的退出的过程`

## 6.4 scope 变量的作用域

## 6.5 breakpoints 断点

点击勾选可以关闭或者是选用需要调试的断点。使用中的断点是深蓝色的，禁用的是浅蓝色的。
右键可以对断点进行操作，取消断点等等。

## 6.6 DOMpoints DOM 断点

## 6.7 XHRpoints XHR 断点

## 6.8 Event Listener breakpoints 事件监听断点

当我们需要看某个元素，例如按钮的是如何执行哪些事件的，我们使用 element 面板来看，看到的对应的 DOM ，但是上面没有任何的 js，也没有显示的绑定事件。这个使用，我们就只能使用这个 Event Listener breakpoints 事件监听断点。勾选我们需要调试的事件，比如说勾选上 mouse-click 点击事件，然后再去 页面去点击这个按钮，然后就可以跳转到对应的这个按钮的点击事件函数里面去了，然后就可以对这个函数进行断点调试了。

```BASH
`OPTIONS http://hete-api.gofoer.com/v1/user/session net::ERR_CONNECTION_RESET      xhr.js?d13b:178`
dispatchXhrRequest @ xhr.js?d13b:178
xhrAdapter @ xhr.js?d13b:12
dispatchRequest @ dispatchRequest.js?875c:59
Promise.then (async)
request @ Axios.js?7d5c:51
wrap @ bind.js?4514:9
Login @ login.vue?cef9:69
click @ login.vue?7853:93
invoker @ vue.esm.js?3bbd:2128
fn._withTask.fn._withTask @ vue.esm.js?3bbd:1913
`GET http://hete-api.gofoer.com/v1/result net::ERR_CONNECTION_RESET                xhr.js?d13b:178` # 链接重置
# 浏览器控制台错误 101 (net::ERR_CONNECTION_RESET) 的本身含义就是这个网站存在故障暂时无法访问，
# 也就是说这个网站服务器被关闭或者是你的网络提供商将这个网站 IP 屏蔽，可以尝试刷新这个页面，或者搜索这个网站以方便寻找更多的访问途径。

# 本机和测试环境都是 OK 的。但是一到线上就报错；可能原因总结如下，
# 1、可能是服务器限制了文件上传的权限。解决方法：开通了文件上传权限。
# 2、也许导致这种错误的方式有很多，可能是因为 post 请求时提交的数据过多而导致的。解决办法：修改 tomcat 的配置文件 server.xml
# 3、服务器未开启；如静态文件运行时没有开启静态资源服务器就会报这个错误，文件上传功能。
# 4、跨域请求的问题；如上传 excel 表格时，打开 FQ 就可以进行上传，否则会报 net::ERR_CONNECTION_RESET

`GET http://hete-api.gofoer.com/v1/xxxx.png net::ERR_BLOCKED_BY_CLIENT             xhr.js?d13b:178` # 客户端的网络问题
# 如果遇到这个问题，我们复制网址可以打开的，遇到这类情况，一般都是浏览器安装的某个第三方扩展程序已阻止对此网页的访问。
# 对服务器的请求已遭到某个扩展程序的阻止。
# 可以通过以下办法解决：点击浏览器上的“工具”》“选项”》“广告过滤”》“拦截模式”》把拦截模式等级调低，比如原来是选第三个，现在可以更改为第二或第一个，那样就能解决这个问题了。其他浏览器应该也是广告拦截的缘故，
```

## 6.9 Event Listener 事件监听

# 七、 Network(网络面板)

[文档与视频]()

![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190204234905.png),看到这样的错误的话，如果没有前端发送的请求是没有问题的，那么就是后端的代码出现的 bug，让测试人员去找后端同事。

# 八、 Performace【原 Timeline (时间轴面板)】

[文档与视频]()

# 九、Memory【 Profiles(分析面板)】

[文档与视频]()

# 十、Application(资源面板)

[文档与视频]()

# 十一、Security(安全面板)

[文档与视频]()

# 十二、Security(安全面板)

[文档与视频]()

# 十三、Audits(安全面板)

[文档与视频]()

# 十四、移动设备模拟器

点击面板的手机标识，就可以转化成移动设备模式，这个是开发移动端使用的调试模式。

下图为手机端下的显示模块。
![t](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20190201201334.png)