---
title: iview-ui【1】- 小白入门篇【记录一些使用的注意之处 & 自己经常犯的错】
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 的 UI 组件库
updated:
tags:
comments:
---
## 一、前言

iView 是一套基于 Vue.js 的开源 UI 组件库，主要服务于 PC 界面的中后台产品。面向中后台业务的一整套前端解决方案，包含了工程构建、主题定制、多语言等功能，极大提升了开发效率。官网：[网址](https://www.iviewui.com/components/form)。

由于官网对各个组件的使用并没有详细的使用方法，有个的属性或者方法的使用还是有比较大的坑的，这里的文章就是用来填补这些坑的。
使用的时候查阅官网即可，本文写一些注意的地方，以及自己经常犯的错。对官网各个组件的使用的补充

## 二、安装过程的坑

### 2.1 cnpm 的问题

```BASH
λ cnpm install iveiw --save
`× Install fail! Error: GET https://registry.npm.taobao.org/iveiw response 404 status`
Error: GET https://registry.npm.taobao.org/iveiw response 404 status
    at get (C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\npminstall\lib\get.js:57:17)
    at get.next (<anonymous>)
    at onFulfilled (C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\co\index.js:65:19)
    at <anonymous>
    at process._tickCallback (internal/process/next_tick.js:188:7)
npminstall version: 3.10.0
npminstall args: C:\Program Files\nodejs\node.exe C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\npminstall\bin\install.js --fix-bug-versions --china --userconfig=C:\Users\Administrator\.cnpmrc --disturl=https://npm.taobao.org/mirrors/node --registry=https://registry.npm.taobao.org iveiw --save
```

### 2.2

```BASH
λ npm install iview --save
`npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-json-stable-stringify`  
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-deep-equal
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\pinkie-promise\node_modules\pinkie
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\pinkie-promise\node_modules
npm WARN request-promise-core@1.1.1 requires a peer of request@^2.34 but none is installed. You must install peer dependencies yourself.
npm WARN request-promise-native@1.0.5 requires a peer of request@^2.34 but none is installed. You must install peer dependencies yourself.

npm ERR! path F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-json-stable-stringify
npm ERR! code ENOENT
npm ERR! errno -4058
npm ERR! syscall access
npm ERR! enoent ENOENT: no such file or directory, access 'F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-json-stable-stringify'
npm ERR! enoent This is related to npm not being able to find a file.
npm ERR! enoent

npm ERR! A complete log of this run can be found in:
npm ERR!     C:\Users\Administrator\AppData\Roaming\npm-cache\_logs\2018-08-21T07_18_57_459Z-debug.log
```

## 三、vue 项目中使用 iview-ui 组件引用方法！！！！！！！！！！！！！！！！！！！！！！！！！！重点，重点，重点，重点

**官网中引用，它使用的并不是 vue-cli 脚手架来搭建的，因此它的引用跟我们使用 vue-cli 的有些区别**，如果完全安装官网来操作，会发现自己的项目无法运行.
官网中是使用 iview-cli 脚手架生成的，通常我是使用 vue-cli 脚手架来搭建框架的，因此  main.js 文件与 iview-ui 组件库的官网有出入， vue-cli 以下面的文件为准。

### 3.1 全局引用

- main.js 中引入 iview 与 iview.css
- .vue 文件中使用组件

```js
//main.js
import Vue from 'vue'
import App from './App'
import router from './router'
import iView from 'iview'        //导入iview-ui
import 'iview/dist/styles/iview.css'//导入iview.css

Vue.config.productionTip = false
Vue.use(iView);     //全局使用iview

new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
```

### 3.2 按需引用

- babel-plugin-import插件安装
- 配置  .babelrc  文件（引入 iview）
- main.js 中引入 iview.css
- .vue 文件中使用组件

[babel-plugin-import插件挂网:](https://github.com/ant-design/babel-plugin-import)

```BASH
 npm install babel-plugin-import --save-dev
```

```JSON
// .babelrc
{
  "plugins": [["import", {
    "libraryName": "iview",
    "libraryDirectory": "src/components"
  }]]
}
```

```JS
//main.js
import 'iview/dist/styles/iview.css'; //按需引用还需要引如 css 样式
```

## 四、iview-ui 组件使用规范

### 4.1 props 传参

使用 :prop 传递数据格式为 数字、布尔值或函数时，必须带 : (兼容 String 除外，具体看组件文档)，比如：

```HTML
<Page :current="1" :total="100">正确使用</Page>
<Page current="1" total="100">没有正确使用</Page>
```

### 4.2 非 template/render 模式下组件名要分隔

例如 DatePicker 必须要写成 date-picker

```HTML
<date-picker>正确使用</date-picker>
<DatePicker>没有正确使用</DatePicker>
```

### 4.3 非 template/render 以下组件加i-

- Button:&nbsp;&nbsp;&nbsp;i-button
- Col:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i-col
- Table:&nbsp;&nbsp;&nbsp;&nbsp;i-table
- Input: &nbsp;&nbsp;   i-input
- Form:  &nbsp; &nbsp;    i-form
- Menu:  &nbsp; &nbsp;    i-menu
- Select: &nbsp;    i-select
- Option: &nbsp;   i-option
- Progress:  i-progress
- Time: &nbsp;&nbsp;&nbsp;    i-time

### 4.4 (除非使用 iview-loader)其他任何情况 以下组件加i-

- Switch: i-switch
- Circle: i-circle

**什么是非 template/render模式？**
解析：

## 五、全局配置

使用 iView 3 时，可以进行全局配置组件的一些属性。

目前只支持配置 transfer 和 size 两个属性。组件会优先使用 prop 设置的属性，如果未设置，再使用全局配置。

transfer：所有带浮层的组件，是否将浮层放置在 body 内，默认为不设置，详见各组件默认的 transfer 值。可选值为 true 或 false。
size：所有带有 size 属性的组件的尺寸，默认为不设置，详见各组件默认的 size 值。可选值为 default、small 或 large。
用法如下：

**在 main.js 文件**

```JS
Vue.use(iView, {
    transfer: true,
    size: 'large'
});
```

## 七、定制主题

iView 默认提供了一套 UI 主题，并且可以在一定程度上定制新主题，以满足业务和品牌上的多样化视觉需求。

iView 的样式是基于 Less 进行开发的，默认以前缀 `.ivu-` 作为命名空间，并且定义了一套样式变量，定制主题，就是编辑这个变量列表。

**步骤①：创建如 `my-theme` 目录**

**步骤②：创建 index.less 文件**

```less
@import '~iview/src/styles/index.less';
// Here are the variables to cover, such as:
@primary-color: #8c0776;
```

完整的变量列表可以查看 [默认样式变量网址](https://github.com/iview/iview/blob/2.0/src/styles/custom.less)

**步骤③： main.js 中引入 index.less**

```JS
import Vue from 'vue';
import iView from 'iview';
import '../my-theme/index.less'; //引入 index.less 文件

Vue.use(iView);
```

**步骤④：修改 index.less 文件内容以修改主题颜色**

### 7.1 vue-cli 脚手架床架的项目中修改主题！！！

## 九、使用 iveiw-ui 遇到的坑/自己犯的错

### 9.1 引入 iveiw 的出现 `import iView from '...iview'`，找不到模块

这个不是坑，`import iView from '...iview'`，既然是 import，它肯定需要导入的，需要时间，刚开始打开这个文件，会出现...，一会加载完，它就会好了。

### 9.1 使用 type 类型正确的坑

```HTML
vue.esm.js?efeb:591 [Vue warn]: Invalid prop: custom validator check failed for prop "type".

found in

---> <Button>
       <Content>
         <Layout>
           <HelloWorld> at src\components\home.vue
             <App> at src\App.vue
               <Root>
```

如上错误出现的话，说的是在 src\components\home.vue 这个 vue 文件中的 Button 组件在使用 type 使用错误。可能是编辑错误，字母刺写错了，还是多可空格等等其他符号啦。

示例：可能是想要个灰色的按钮，但是这个按钮的 type 是不能这样写的，不存在这个类型。

```HTML
 <Button
          type="disabled"
          shape="circle"
          @click="handleSelectAll(false)">取消全选
 </Button>
```

### `<Col>`改成`<i-col>`

```TEXT
 ✘  https://google.com/#q=vue%2Fno-parsing-error  Parsing error: x-invalid-end-tag
  src\components\pages\home.vue:13:11
            </Col>
             ^

  ✘  https://google.com/#q=vue%2Fno-parsing-error  Parsing error: x-invalid-end-tag
  src\components\pages\home.vue:14:32
            <Col span="12">col-12</Col>
                                  ^


✘ 2 problems (2 errors, 0 warnings)


Errors:
  2  https://google.com/#q=vue%2Fno-parsing-error

You may use special comments to disable some warnings.
Use // eslint-disable-next-line to ignore the next line.
Use /* eslint-disable */ to ignore all warnings in a file.
```

官网说明
在非 template/render 模式下（例如使用 CDN 引用时），组件名要分隔，例如 DatePicker 必须要写成 date-picker。
以下组件，在非 template/render 模式下，需要加前缀 i-：
Button: i-button
Col: i-col
Table: i-table
Input: i-input
Form: i-form
Menu: i-menu
Select: i-select
Option: i-option
Progress: i-progress
Time: i-time
以下组件，在所有模式下，必须加前缀 i-，除非使用 iview-loader：
Switch: i-switch
Circle: i-circle

### input组件样式修改

iview 框架中，不能使用 css 写样式直接修改，这里用到主题。iview 的样式是用 less 制作的，主题也可以使用less 变量来修改。iview中的网址：[git](https://github.com/iview/iview/blob/2.0/src/styles/custom.less)

在 vue-cli 框架中，用 webpack 创建的项目目录。node_modules→_iview@3.1.1@iview→src→styles 中是这个框架的样式这是文件，可以在这里看iview作者的代码设计，但是不要去改动 node_modules 文件夹的东西。


###  

```TEXT
These dependencies were not found:

* iview in ./src/main.js
* iview/dist/styles/iview.css in ./src/main.js
* !!vue-style-loader!css-loader?{"sourceMap":true}!../../../node_modules/vue-loader/lib/style-compil
er/index?{"vue":true,"id":"data-v-5e4cad4c","scoped":true,"hasInlineConfig":false}!less-loader?{"sou
rceMap":true}!../../../node_modules/vue-loader/lib/selector?type=styles&index=0!./home.vue in ./src/
components/pages/home.vue

To install them, you can run: npm install --save iview iview/dist/styles/iview.css !!vue-style-loade
r!css-loader?{"sourceMap":true}!../../../node_modules/vue-loader/lib/style-compiler/index?{"vue":tru
e,"id":"data-v-5e4cad4c","scoped":true,"hasInlineConfig":false}!less-loader?{"sourceMap":true}!../..
/../node_modules/vue-loader/lib/selector?type=styles&index=0!./home.vue
```

```bash
npm install style-loader --save
```



## 十、各个组件的使用补充!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!(官网写的太简单了)

官网没有对每个组件的，每个属性，时间，或者方法进行完善，对于一些组件使用起来会遇到各种坑，因此这章就是对组件的补充的。

### 10.1 Modal 对话框

#### 10.1.1 Modal instance 对话框实例的 config 对象使用（这个是在 js 代码中写的）

通过直接调用以下方法来使用：

```JS
this.$Modal.info(config)
this.$Modal.success(config)
this.$Modal.warning(config)
this.$Modal.error(config)
this.$Modal.confirm(config)
//以上方法隐式地创建及维护 Vue 组件。参数 config 为对象，具体说明如下：

methods:{
  edit(index) {
    this.$Modal.confirm({
      title: '提示',
      content: '确认要删除这条记录么?一旦删除将无法恢复!',//注意，如果有render 函数，那么这个 content 就没有用了
      render: h => {
        return h(//)
      },
      width:900,// 单位是 px 值是 number，或者 string，默认值是 416px
      width:'10%',// 问题？？？？？？？？？？？？？？？？？？？？？？？如果这个字符串是这样的，有百分百的吧？？？？？
      okText: '删除',//默认值是 确定
      cancelText: '取消',//默认值是 取消（this.$Modal.confirm 中有效，其他无效）
      onOk: () => {
         alert('你赢了！');
         this.changeDesc();
      },
      onCancel:()=>{
        alert('取消！');//这个事件，是在（this.$Modal.confirm 中有效，其他无效）
      }
    })
  },
  changeDesc(){
    //
  }
}
```

### 10.1 按钮 中使用 阿里图库

```HTML
<Button type="primary" shape="circle" icon="ios-search"></Button>
<!-- 这里是 iview 自己的图标  icon="ios-search" 以属性的方式使用-->

<!-- 这里是使用阿里图库 -->
<Button type="primary" size="small" style="margin-right: 5px" @click="show(index)">
  <i class="iconfont icon-fengjin"></i> 查看
</Button>
```

### 10.2 menu 导航栏

#### 10.2.1 Menu methods 导航栏的方法

updateOpened      手动更新展开的子目录，注意要在 $nextTick 里调用
updateActiveName  手动更新当前选择项，注意要在 $nextTick 里调用

```HTML
<Menu ref="left_menu" theme="dark" :active-name="activeName" @on-select="selectMenu">
  <MenuItem name="project">
    <Icon type="md-git-branch"/>
    <span class="menu-text">项目管理</span>
  </MenuItem>
  <MenuItem name="organization">
    <Icon type="ios-people"/>
    <span class="menu-text">组织管理</span>
  </MenuItem>
  <MenuItem name="notice">
    <Icon type="ios-notifications"/>
    <span class="menu-text">消息通知</span>
  </MenuItem>
  <MenuItem name="profile">
    <Icon type="logo-snapchat"/>
    <span class="menu-text">个人中心</span>
  </MenuItem>
</Menu>
<script>
data() {
    return {
      activeName: "project"
    };
  },
  watch: {
    //监听路由器变化，使得 header 点击的时候，侧边菜单栏的 active 值跟着改变，并且渲染 head 的中部！！！！！
    // 监听这里需要设置变化，还有 点击函数  noticeFunc() profileFunc() 这里还是要设置变化的，为什么呀？？
    // 完全看不明白，这个是个什么鬼东西噢噢噢噢哦哦哦哦哦哦
    $route() {
      this.$nextTick(() => {
        this.initMenuActive();
        this.activeName = this.$route.name;
        this.$refs.left_menu.updateActiveName();
      });
    }
  },
  methods:{
    noticeFunc() {
      const that = this;
      that.$nextTick(() => {
        that.activeName = "notice";
        that.$refs.left_menu.updateActiveName();// 注意到他们只是一个调用函数，我们根据更新激活的 :active-name="activeName"
        // 通过改变绑定的激活 name 值来更新展开的 menu 项
      });
      that.$router.push("/notice");
    }
  }
</script>
```

### 10.3 upload 组件

#### 10.3.5 上传图片 ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

```HTML
<template>
     <div class="demo-upload-list" v-for="item in uploadList"> <!--这个 uploadlist 指的是用于展示的，额外加的 一个数据 -->
        <template v-if="item.status === 'finished'"> <!--这个 条件也是可以自己去修改的 -->
            <img :src="item.url"><!--这里直接使用 item.url 是错误的！！！！！！！！！！！！！！！！还有一层 response 才会到 url 这一层-->
            <div class="demo-upload-list-cover">
                <Icon type="ios-eye-outline" @click.native="handleView(item.name)"></Icon>
                <Icon type="ios-trash-outline" @click.native="handleRemove(item)"></Icon>
            </div>
        </template>
        <template v-else>
            <Progress v-if="item.showProgress" :percent="item.percentage" hide-info></Progress>
        </template>
    </div>
    <Modal title="查看图片" v-model="visible">
        <!-- <img :src="'https://o5wwk8baw.qnssl.com/' + imgName + '/large'" v-if="visible" style="width: 100%"> -->
        <img :src="url" v-if="visible" style="width: 100%">
    </Modal>
    <Upload
        ref="upload"
        :show-upload-list="false"
        :default-file-list="defaultList"  // 这里的 defaultList 指的是 upload 组件默认已上传到服务端的文件列表，这个数据的数据格式 iview 规定好的。
        :on-success="handleSuccess"
        :format="['jpg','jpeg','png']"
        :max-size="2048"
        :on-format-error="handleFormatError"
        :on-exceeded-size="handleMaxSize"
        :before-upload="handleBeforeUpload"
        :on-progress="handleProgresseUpload"
        :name="uploadConfig.name"                      // 例子里没有这个属性 ，默认值是 file，要注意跟自己后端连接起来，响应的更新属性值
        multiple                          // 是否支持多选文件,默认值是 false，根据我们的后端接口来确定是否是多选的。
        type="drag"
        //action="//jsonplaceholder.typicode.com/posts/"  // 这是 http 请求的接口，还是写到 data 里面去比较好吧，还有 headers 的请求头设置呢。 -->
        :action="uploadConfig.url"
        :headers="uploadConfig.headers"
        style="display: inline-block;width:58px;">
        <div style="width: 58px;height:58px;line-height: 58px;">
            <Icon type="ios-camera" size="20"></Icon>
        </div>
    </Upload>
</template>

<script>
    export default {
        data () {
            return {
              // 上传图片请求数据
                uploadConfig:{
                  url:'',// 后端接口，注意这里不是用 axios 来请求的，这里就要写上完整的 接口地址
                  headers:{
                    // 根据后端接口写上要求的请求头内容
                    Authorization: localStorage.getItem("token")
                  }
                },
                // 这里是 iview 规定了数据项 的数据（已经上传到 服务端的数据），数据格式就是 {name:'',url:''}
                defaultList: [],
                imgName: '',
                visible: false,
                // 这里是用于展示文件 的数据，如果 defaultList 已经满足要求的话，就可以不需要这个了的。
                // 假设我们不只是要 名称与 url 链接图片，还要创建时间呀，等等，就需要一个中间值了，就是接收后端的 返回
                uploadList: []
            }
        },
        created(){
          this.getUploadConfig()
        },
        mounted () {
            this.uploadList = this.$refs.upload.fileList;// 加载的时候讲数据给它？？？？为啥？？？？？？？？？？？？？？
        }
        methods: {
            // 获取上传图片的 请求配置!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 不要忘记在 created 去调用这个函数
            getUploadConfig(){
              this.uploadConfig.name = 'image'
              this.uploadConfig.url = 'https://api.talcoding.com/v1/images'
              let sessionToken = JSON.parse(localStorage.getItem("sessionToken"));
              this.uploadConfig.headers.Authorization = `Code ${sessionToken.token}`;
            },
            //before-upload 钩子的 函数：上传文件之前的钩子，参数为上传的文件 file，若返回 false 或者 Promise 则停止上传
            handleBeforeUpload (file) {
               // 假设上传需要动态改变附带的参数 data 及上传的路径 url ？但 before-upload 动态改变时，子组件中参数未改变时已执行上传操作？
               //let researchId = this.activeUploadId;
               // this.uploadUrl = 'api?research_id=' + researchId + '&filetype=' + file.name.split('.')[1];
               // this.uploadData = {
               //     role: patient,
               //     abc: file
               // };
               // let promise = new Promise((resolve) => {
               //     this.$nextTick(function () {
               //         resolve(true);
               //     });
               // });
               // return promise; //通过返回一个promis对象解决
                const check = this.uploadList.length < 5;
                if (!check) {
                    this.$Notice.warning({
                        title: '最多只能上传 5 张图片'
                    });
                }
                return check;
            },
            //文件上传时的钩子，返回字段为 event, file, fileList
            handleProgresseUpload(){
              //
            },
            // 文件上传成功时的钩子，返回字段为 response, file, fileList
            handleSuccess (res, file) {
              // res 是后端返回的数据，返回上传文件对应的数据 ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
              // 注意一个问题，是 iview 的 res 不需要 res.data 它直接就是后端返回的数据本身!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
              // 不需要像其他的接口那样去获取 res.data 才得到我们要的数据！！！！！！！！！！！！！！！！！！！！！！！！！！！！
              // res= {
              //      fileName: "微信截图_20190214220147.png"
              //      id: "5c7f836adce08a0005c99b5a"
              //      key: "5c7f836adce08a0005c99b5a/微信截图_20190214220147.png"
              //      url: "https://sources.talcoding.com/5c7f836adce08a0005c99b5a/%E5%BE%AE%E4%BF%A1%E6%88%AA%png"
              //    }
              // file 上传文件的信息
              // fileList 上传文件列表的信息（假设后端可以上传多份文件，前端也设置了 multiple 为 ture）
              // 因为上传过程为实例，这里模拟添加 url，就不要管下面这 2 行就好了，这个是 iview 用来展示用的
              // file.url = 'https://o5wwk8baw.qnssl.com/7eb99afb9d5f317c912f08b5212fd69a/avatar'
              // file.name = '7eb99afb9d5f317c912f08b5212fd69a'
              var tFile = {
                  name: res.fileName,
                  url: res.url
              };
              this.defaultList.push(f1);// 这个需要提供么？
              // 数据应该是用来列出上传的文件列表用的，与 :show-upload-list="false" 这个搭配使用，不需要的话就不需要在这里额外的赋值了
              // defaultList 如果我们有需求的话，需要在这里赋值！！！！！！！！！！！！！！！！！！

              //this.addproductFormData.images.push(res.id); 假设我们后端使用的数据创建产品，还要在这里赋值数据，（其实
              // 我们也应该直接冲 uploadlist 去获取值给到 form 的值，这样我们删除的话就只需要删除一个地方就 ok 了。）
              // res 就是后端返回的数据，数据格式，属性什么的都是后端规定的，前端要根据业务要求去修改数据，
              // 这个 form 的值其实应该直接从 uploadlist 中去获取,因为 uploadlist 就是我们的值啊，它的 response 字段就包含了图片的信息。
              // 外层还有其他的信息

              //uploadlist = [{
              //  name: "微信截图_20190214220147.png"
              //  percentage: 100
              //  response:
              //    {
              //      fileName: "微信截图_20190214220147.png"
              //      id: "5c7f836adce08a0005c99b5a"
              //      key: "5c7f836adce08a0005c99b5a/微信截图_20190214220147.png"
              //      url: "https://sources.talcoding.com/5c7f836adce08a0005c99b5a/%E5%BE%AE%E4%BF%A1%E6%88%AA%png"
              //    }
              //  showProgress: (...)
              //  size: 468927
              //  status: "finished"
              //  uid: 1551860582546
              //}]
                    // 看到后端返回来的数据，我们发现我们的 url 数据是嵌套在 response 对象里面的，html 中的就错误了
                    // 直接 item.url 是错误的，需要 item.response.url，这样属性 . 了太多层次了！！！！！！！！！！！！！！！！！！！
                    // 如果我们不需要 status showProgress 这些字段的话就不要去直接使用官方 uploadlist 这个字段
                    // 可以在 success 这个钩子函数自己去构造自己的数据
              // defaultlist 需要在这里赋值，其实也可以把 uploadlist 那里获取 name 与 url 字段赋值给 defaultlist
            },
            //文件格式验证失败时的钩子，返回字段为 file, fileList
            handleFormatError (file) {
                this.$Notice.warning({
                    title: '文件格式不正确',
                    desc: '文件 ' + file.name + ' 格式不正确，请上传 jpg 或 png 格式的图片'
                });
            },
            //文件超出指定大小限制时的钩子，返回字段为 file, fileList
            handleMaxSize (file) {
                this.$Notice.warning({
                    title: '超出文件大小限制',
                    desc: '文件  ' + file.name + '太大，不能超过 2M。'
                });
            },
            // 查看文件
            handleView (name) {
                this.imgName = name;
                this.visible = true;
            },
            // 移除文件：// 从 upload 实例删除数据
            handleRemove (file) {
                const fileList = this.$refs.upload.fileList;
                this.$refs.upload.fileList.splice(fileList.indexOf(file), 1);
            }
        }
    }
</script>
<style>
    .demo-upload-list{
        display: inline-block;
        width: 60px;
        height: 60px;
        text-align: center;
        line-height: 60px;
        border: 1px solid transparent;
        border-radius: 4px;
        overflow: hidden;
        background: #fff;
        position: relative;
        box-shadow: 0 1px 1px rgba(0,0,0,.2);
        margin-right: 4px;
    }
    .demo-upload-list img{
        width: 100%;
        height: 100%;
    }
    .demo-upload-list-cover{
        display: none;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        background: rgba(0,0,0,.6);
    }
    .demo-upload-list:hover .demo-upload-list-cover{
        display: block;
    }
    .demo-upload-list-cover i{
        color: #fff;
        font-size: 20px;
        cursor: pointer;
        margin: 0 2px;
    }
</style>
```