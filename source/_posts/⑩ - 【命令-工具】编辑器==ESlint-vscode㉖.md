---
title: 编辑器默认格式化， ESlint 扩展格式化，vetur 扩展格式化，三者之间的冲突 关闭令人抓狂的ESlint 语法检测配置方法
date: '2018/8/19 23:57:28'
tags:
  - ESlint之坑
categories:
  - ⑩ 打包工具-命令行工具-包管理器-github
  - 编辑器
updated:
comments:
---

## 一、前言

在使用 vue-cli 创建项目的使用，命令行就让我们选择是否使用 ESlint 来优化我们的代码。如果我们是自己一个人的项目可以不使用，但是在一个公司一个团队协作上，项目都是需要有个代码的统一格式化风格的，因此 ESlint 是有必要的，即使一个项目不使用 ESlint 应该也会选择其他的插件来统一优化代码。

VS code 插件非常之多，各种格式化的插件也是非常的多，插件大多不是官方的，固然会出现冲突的时候。这个冲突会让我们在代码编辑的时候非常的头疼。

现在就来解决一下 vue 项目中的代码保存冲突问题。
    vscode 编辑器默认格式化， ESlint 扩展格式化，vetur 扩展格式化，三者之间的冲突

- 微软：[Visual Studio code](https://code.visualstudio.com/docs/getstarted/keybindings)
- jetbrains公司:[WebStorm](https://www.jetbrains.com/webstorm/download/download-thanks.html?platform=windows)

## 二、冲突表现（坑）

在说这些坑之前，我们先来了解一下 vscode 与它的插件。

- ①vscode：微软公司的 vscode 编辑器本身自带一个格式化风格，也就是文件→首选项→设置 中默认的代码格式化
- ②vetur 扩展：是用来格式化 vue.js 代码的。Vue tooling for VS Code, powered by vue-language-server.
- ③ESlint 扩展：Integrates ESLint JavaScript into VS Code.
- Beautify 扩展：Beautify javascript, JSON, CSS, Sass, and HTML in Visual Studio Code.

### 2.1 坑一：使用官网组件的时候 .vue 文件报错。

```HTML
<template>
  <!-- 这个 class 与 script 中的 name 没有关系，原 class 为 hello -->
  <div class="layout">
        <Layout>
            <Header>
                <Menu mode="horizontal" theme="dark" active-name="1">
                    <div class="layout-logo"></div>
                    <div class="layout-nav">
                        <MenuItem name="1">
                            <Icon type="ios-navigate"></Icon>
                            Item 1
                        </MenuItem>
                        <MenuItem name="2">
                            <Icon type="ios-keypad"></Icon>
                            Item 2
                        </MenuItem>
                        <MenuItem name="3">
                            <Icon type="ios-analytics"></Icon>
                            Item 3
                        </MenuItem>
                        <MenuItem name="4">
                            <Icon type="ios-paper"></Icon>
                            Item 4
                        </MenuItem>
                    </div>
                </Menu>
            </Header>
            <Content :style="{padding: '0 50px'}">
                <Breadcrumb :style="{margin: '20px 0'}">
                    <BreadcrumbItem>Home</BreadcrumbItem>
                    <BreadcrumbItem>Components</BreadcrumbItem>
                    <BreadcrumbItem>Layout</BreadcrumbItem>
                </Breadcrumb>
                <Card>
                    <div style="min-height: 200px;">
                        Content
                    </div>
                </Card>
            </Content>
            <Footer class="layout-footer-center">2011-2016 &copy; TalkingData</Footer>
        </Layout>
    </div>
</template>
<script>
export default {
  name: 'HelloWorld', // 这里是组件名称，给 template 中的 class 没有关系，原名为 HelloWorld
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
```

![BUG图片](http://pdt3c10xj.bkt.clouddn.com/vscode-bug-1.png)
如上面的代码段，命名跟着 iview 官网拷贝过来的，怎么就出错了呢？？一直提示错误：

```TEXT
[eslint]Parsing error: x-invalid-end-tag.(vue/no-parsing-error)

[eslint-plugin-vue]
[vue/no-parsing-error]
Parsing error: x-invalid-end-tag.
```

- 首先 vscode 编辑器是自带一个默认格式化风格的。
- 然后再这里使用了 ESlint 的风格，二者会导致冲突，
- 如果 vscode 还安装了 vetur 插件就又多了一个冲突。

## 三、填坑-解决冲突

### 3.1  步骤①：vscode 设置页面设置

    需要使用 ESlint 的格式化，就要将 vscode 编辑器默认的格式化去掉、把 vetur 插件的格式化改写

```JSON
     "vetur.validation.template": false    // 把 vetur 扩展的 template 格式化去掉
      "editor.formatOnSave": false,        // 去掉 vscode 自带的自动保存 ，vscode 默认也是 false                                        //的，如果要用 eslint 格式化，默认的格式化就不能开启
     "eslint.enable": true,              // eslint 格式化的配置
     "eslint.autoFixOnSave": true,
     "eslint.run": "onType",
     "eslint.options": {
        "extensions": [".js",".vue"]
     },
     "eslint.validate": [
     "javascript",
     {
      "language": "vue",
      "autoFix": true,
     },
     "html","vue"
     ],
```

### 3.2 vue-cli 搭建的项目中，.eslintrc.js 文件中设置
    这个文件就是用于配置当前项目的 ESlint 格式化规则，可以根据团队项目的要求设置格式化规则

```JS
  extends:                           # 增加如下两行
    "eslint:recommended",
    "plugin:vue/recommended"
  rules:                       # 增加如下两行
    "vue/no-parsing-error": [2, {
      "x-invalid-end-tag": false
    }]
```

## 三、解析.eslintrc.js 文件中的配置项：

```JS
module.exports = {
    root: true,
    parser: 'babel-eslint',
    parserOptions: {
    //设置 "script"（默认）或 "module" 如果你的代码是在 ECMAScript 中的模块。
    sourceType: 'module'
   },
    env: {
    browser: true,
    },
   // https://github.com/feross/standard/blob/master/RULES.md#javascript-standard-style
    extends: 'standard',
    // required to lint *.vue files
   plugins: [
    'html'
   ],
   // add your custom rules here
   'rules': {
    // allow paren-less arrow functions
    'arrow-parens': 0,
    // allow async-await
    'generator-star-spacing': 0,
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0,
    "no-unused-vars": [2, { 
      // 允许声明未使用变量
      "vars": "local",
      // 参数不检查
      "args": "none" 
    }],
    // 关闭语句强制分号结尾
    "semi": [0],
    //空行最多不能超过 100 行
    "no-multiple-empty-lines": [0, {"max": 100}],
    //关闭禁止混用 tab 和空格
    "no-mixed-spaces-and-tabs": [0],
  }
}
```

**配置参数**

```text
rules: {
    "规则名": [规则值, 规则配置]
}
```

**规则值：**

```text
"off"或者0    //关闭规则
"warn"或者1    //在打开的规则作为警告（不影响退出代码）
"error"或者2    //把规则作为一个错误（退出代码触发时为 1 ）
```

**常见规则列表:**

- "no-alert": 0,//禁止使用alert confirm prompt
- "no-array-constructor": 2,//禁止使用数组构造器
- "no-bitwise": 0,//禁止使用按位运算符
- "no-caller": 1,//禁止使用arguments.caller或arguments.callee
- "no-catch-shadow": 2,//禁止catch子句参数与外部作用域变量同名
- "no-class-assign": 2,//禁止给类赋值
- "no-cond-assign": 2,//禁止在条件表达式中使用赋值语句
- "no-console": 2,//禁止使用console
- "no-const-assign": 2,//禁止修改const声明的变量
- "no-constant-condition": 2,//禁止在条件中使用常量表达式 if(true) if(1)
- "no-continue": 0,//禁止使用continue
- "no-control-regex": 2,//禁止在正则表达式中使用控制字符
- "no-debugger": 2,//禁止使用debugger
- "no-delete-var": 2,//不能对var声明的变量使用delete操作符
- "no-div-regex": 1,//不能使用看起来像除法的正则表达式/=foo/
- "no-dupe-keys": 2,//在创建对象字面量时不允许键重复 {a:1,a:1}
- "no-dupe-args": 2,//函数参数不能重复
- "no-duplicate-case": 2,//switch中的case标签不能重复
- "no-else-return": 2,//如果if语句里面有return,后面不能跟else语句
- "no-empty": 2,//块语句中的内容不能为空
- "no-empty-character-class": 2,//正则表达式中的[]内容不能为空
- "no-empty-label": 2,//禁止使用空label
- "no-eq-null": 2,//禁止对null使用==或!=运算符
- "no-eval": 1,//禁止使用eval
- "no-ex-assign": 2,//禁止给catch语句中的异常参数赋值
- "no-extend-native": 2,//禁止扩展native对象
- "no-extra-bind": 2,//禁止不必要的函数绑定
- "no-extra-boolean-cast": 2,//禁止不必要的bool转换
- "no-extra-parens": 2,//禁止非必要的括号
- "no-extra-semi": 2,//禁止多余的冒号
- "no-fallthrough": 1,//禁止switch穿透
- "no-floating-decimal": 2,//禁止省略浮点数中的0 .5 3.
- "no-func-assign": 2,//禁止重复的函数声明
- "no-implicit-coercion": 1,//禁止隐式转换
- "no-implied-eval": 2,//禁止使用隐式eval
- "no-inline-comments": 0,//禁止行内备注
- "no-inner-declarations": [2, "functions"],//禁止在块语句中使用声明（变量或函数）
- "no-invalid-regexp": 2,//禁止无效的正则表达式
- "no-invalid-this": 2,//禁止无效的this，只能用在构造器，类，对象字面量
- "no-irregular-whitespace": 2,//不能有不规则的空格
- "no-iterator": 2,//禁止使用__iterator__ 属性
- "no-label-var": 2,//label名不能与var声明的变量名相同
- "no-labels": 2,//禁止标签声明
- "no-lone-blocks": 2,//禁止不必要的嵌套块
- "no-lonely-if": 2,//禁止else语句内只有if语句
- "no-loop-func": 1,//禁止在循环中使用函数（如果没有引用外部变量不形成闭包就可以）
- "no-mixed-requires": [0, false],//声明时不能混用声明类型
- "no-mixed-spaces-and-tabs": [2, false],//禁止混用tab和空格
- "linebreak-style": [0, "windows"],//换行风格
- "no-multi-spaces": 1,//不能用多余的空格
- "no-multi-str": 2,//字符串不能用\换行
- "no-multiple-empty-lines": [1, {"max": 2}],//空行最多不能超过2行
- "no-native-reassign": 2,//不能重写native对象
- "no-negated-in-lhs": 2,//in 操作符的左边不能有!
- "no-nested-ternary": 0,//禁止使用嵌套的三目运算
- "no-new": 1,//禁止在使用new构造一个实例后不赋值
- "no-new-func": 1,//禁止使用new Function
- "no-new-object": 2,//禁止使用new Object()
- "no-new-require": 2,//禁止使用new require
- "no-new-wrappers": 2,//禁止使用new创建包装实例，new String new Boolean new Number
- "no-obj-calls": 2,//不能调用内置的全局对象，比如Math() JSON()
- "no-octal": 2,//禁止使用八进制数字
- "no-octal-escape": 2,//禁止使用八进制转义序列
- "no-param-reassign": 2,//禁止给参数重新赋值
- "no-path-concat": 0,//node中不能使用__dirname或__filename做路径拼接
- "no-plusplus": 0,//禁止使用++，--
- "no-process-env": 0,//禁止使用process.env
- "no-process-exit": 0,//禁止使用process.exit()
- "no-proto": 2,//禁止使用__proto__属性
- "no-redeclare": 2,//禁止重复声明变量
- "no-regex-spaces": 2,//禁止在正则表达式字面量中使用多个空格 /foo bar/
- "no-restricted-modules": 0,//如果禁用了指定模块，使用就会报错
- "no-return-assign": 1,//return 语句中不能有赋值表达式
- "no-script-url": 0,//禁止使用javascript:void(0)
- "no-self-compare": 2,//不能比较自身
- "no-sequences": 0,//禁止使用逗号运算符
- "no-shadow": 2,//外部作用域中的变量不能与它所包含的作用域中的变量或参数同名
- "no-shadow-restricted-names": 2,//严格模式中规定的限制标识符不能作为声明时的变量名使用
- "no-spaced-func": 2,//函数调用时 函数名与()之间不能有空格
- "no-sparse-arrays": 2,//禁止稀疏数组， [1,,2]
- "no-sync": 0,//nodejs 禁止同步方法
- "no-ternary": 0,//禁止使用三目运算符
- "no-trailing-spaces": 1,//一行结束后面不要有空格
- "no-this-before-super": 0,//在调用super()之前不能使用this或super
- "no-throw-literal": 2,//禁止抛出字面量错误 throw "error";
- "no-undef": 1,//不能有未定义的变量
- "no-undef-init": 2,//变量初始化时不能直接给它赋值为undefined
- "no-undefined": 2,//不能使用undefined
- "no-unexpected-multiline": 2,//避免多行表达式
- "no-underscore-dangle": 1,//标识符不能以_开头或结尾
- "no-unneeded-ternary": 2,//禁止不必要的嵌套 var isYes = answer === 1 ? true : false;
- "no-unreachable": 2,//不能有无法执行的代码
- "no-unused-expressions": 2,//禁止无用的表达式
- "no-unused-vars": [2, {"vars": "all", "args": "after-used"}],//不能有声明后未被使用的变量或参数
- "no-use-before-define": 2,//未定义前不能使用
- "no-useless-call": 2,//禁止不必要的call和apply
- "no-void": 2,//禁用void操作符
- "no-var": 0,//禁用var，用let和const代替
- "no-warning-comments": [1, { "terms": ["todo", "fixme", "xxx"], "location": "start" }],//不能有- 警告备注
- "no-with": 2,//禁用with
- "array-bracket-spacing": [2, "never"],//是否允许非空数组里面有多余的空格
- "arrow-parens": 0,//箭头函数用小括号括起来
- "arrow-spacing": 0,//=>的前/后括号
- "accessor-pairs": 0,//在对象中使用getter/setter
- "block-scoped-var": 0,//块语句中使用var
- "brace-style": [1, "1tbs"],//大括号风格
- "callback-return": 1,//避免多次调用回调什么的
- "camelcase": 2,//强制驼峰法命名
- "comma-dangle": [2, "never"],//对象字面量项尾不能有逗号
- "comma-spacing": 0,//逗号前后的空格
- "comma-style": [2, "last"],//逗号风格，换行时在行首还是行尾
- "complexity": [0, 11],//循环复杂度
- "computed-property-spacing": [0, "never"],//是否允许计算后的键名什么的
- "consistent-return": 0,//return 后面是否允许省略
- "consistent-this": [2, "that"],//this别名
- "constructor-super": 0,//非派生类不能调用super，派生类必须调用super
- "curly": [2, "all"],//必须使用 if(){} 中的{}
- "default-case": 2,//switch语句最后必须有default
- "dot-location": 0,//对象访问符的位置，换行的时候在行首还是行尾
- "dot-notation": [0, { "allowKeywords": true }],//避免不必要的方括号
- "eol-last": 0,//文件以单一的换行符结束
- "eqeqeq": 2,//必须使用全等
- "func-names": 0,//函数表达式必须有名字
- "func-style": [0, "declaration"],//函数风格，规定只能使用函数声明/函数表达式
- "generator-star-spacing": 0,//生成器函数*的前后空格
- "guard-for-in": 0,//for in循环要用if语句过滤
- "handle-callback-err": 0,//nodejs 处理错误
- "id-length": 0,//变量名长度
- "indent": [2, 4],//缩进风格
- "init-declarations": 0,//声明时必须赋初值
- "key-spacing": [0, { "beforeColon": false, "afterColon": true }],//对象字面量中冒号的前后空格
- "lines-around-comment": 0,//行前/行后备注
- "max-depth": [0, 4],//嵌套块深度
- "max-len": [0, 80, 4],//字符串最大长度
- "max-nested-callbacks": [0, 2],//回调嵌套深度
- "max-params": [0, 3],//函数最多只能有3个参数
- "max-statements": [0, 10],//函数内最多有几个声明
- "new-cap": 2,//函数名首行大写必须使用new方式调用，首行小写必须用不带new方式调用
- "new-parens": 2,//new时必须加小括号
- "newline-after-var": 2,//变量声明后是否需要空一行
- "object-curly-spacing": [0, "never"],//大括号内是否允许不必要的空格
- "object-shorthand": 0,//强制对象字面量缩写语法
- "one-var": 1,//连续声明
- "operator-assignment": [0, "always"],//赋值运算符 += -=什么的
- "operator-linebreak": [2, "after"],//换行时运算符在行尾还是行首
- "padded-blocks": 0,//块语句内行首行尾是否要空行
- "prefer-const": 0,//首选const
- "prefer-spread": 0,//首选展开运算
- "prefer-reflect": 0,//首选Reflect的方法
- "quotes": [1, "single"],//引号类型 `` "" ''
- "quote-props":[2, "always"],//对象字面量中的属性名是否强制双引号
- "radix": 2,//parseInt必须指定第二个参数
- "id-match": 0,//命名检测
- "require-yield": 0,//生成器函数必须有yield
- "semi": [2, "always"],//语句强制分号结尾
- "semi-spacing": [0, {"before": false, "after": true}],//分号前后空格
- "sort-vars": 0,//变量声明时排序
- "space-after-keywords": [0, "always"],//关键字后面是否要空一格
- "space-before-blocks": [0, "always"],//不以新行开始的块{前面要不要有空格
- "space-before-function-paren": [0, "always"],//函数定义时括号前面要不要有空格
- "space-in-parens": [0, "never"],//小括号里面要不要有空格
- "space-infix-ops": 0,//中缀操作符周围要不要有空格
- "space-return-throw-case": 2,//return throw case后面要不要加空格
- "space-unary-ops": [0, { "words": true, "nonwords": false }],//一元运算符的前/后要不要加空格
- "spaced-comment": 0,//注释风格要不要有空格什么的
- "strict": 2,//使用严格模式
- "use-isnan": 2,//禁止比较时使用NaN，只能用isNaN()
- "valid-jsdoc": 0,//jsdoc规则
- "valid-typeof": 2,//必须使用合法的typeof的值
- "vars-on-top": 2,//var必须放在作用域顶部
- "wrap-iife": [2, "inside"],//立即执行函数表达式的小括号风格
- "wrap-regex": 0,//正则表达式字面量用小括号包起来
- "yoda": [2, "never"]//禁止尤达条件

### 2.2 坑二：使用 console.log 调试错误

![console.log错误](http://liuxmoo.foryung.com/console.png)

如上错误是 ESlint 的限制。`[eslint] Unexpected console statement.(no-console)`，就是 eslint 不允许使用这个 console.log() 语句，如果调试需要使用这个语句的话，要修改 eslint 的限制。

**填坑：**

在2.1中已经列举出来很多 .eslintrc.js 中 rules **常见规则列表:**，可以根据这些规则来设置 eslint.js 配置文件。给 rules 添加此行："no-console": 0, 即可避免这个错误，但是需要知道的是生产阶段需要记得把这些后台输出语句删除。或者直接选择其他的调试方式。

```BASH
设置为 "no-console": 2 （也就是 error ，就是说不能出现 console，出现就会报错）
        可以在项目完成之后，设置为 2 ，快速的找到删除这些不必要的 console
设置为 "no-console": 1 （也就是 warn ，就是说可以 console，只是会警告，console 下面会是绿色波浪线）
设置为 "no-console": 20（也就是 无规则，不开启这个规则判断，就不会有任何报错了）
```