---
title: 'vue 中使用 Vue-Quill-Editor 富文本编辑器'
date: '2018/8/19 23:57:28'
categories:
  - ④ vue.js
  - vue.js 框架学习
updated:
tags:
comments:
---

# 一、前言

Vue-Quill-Editor 富文本编辑器的使用！！！！

用了然后发现得到的编辑块 css 全是烂的！！！！！！！！

# 二、安装引入

>npm 安装

```bash
$ npm install vue-quill-editor --save

$ yarn add vue-quill-editor

# 拓展学习
# yarn 中不需要 --save
# yarn 中还是需要 -dev 的，有需要的话就使用的
```

>es6 引入(全局引用)

```JS
//main.js  es6 引入方法
import Vue from 'vue'
import VueQuillEditor from 'vue-quill-editor' // import with ES6

// use
Vue.use(VueQuillEditor)
```

>组件引入（按需引用）

```HTML
<!-- .vue 组件使用方法
    or use with component(ES6) -->

<template>
    <!-- use with components - bidirectional data binding（双向数据绑定） -->
    <quill-editor ref="myTextEditor"
                  v-model="content"
                  :options="editorOption"
                  @blur="onEditorBlur($event)"
                  @focus="onEditorFocus($event)"
                  @ready="onEditorReady($event)">
    </quill-editor>


    <!-- If you need to manually control the data synchronization, you can monitor the code change event    like this（如果你需要手动控制数据流，就需要像这样手动监听 changed 事件） -->
    <quill-editor ref="myTextEditor"
                  :content="content"
                  :options="editorOption"
                  @change="onEditorChange($event)">
    </quill-editor>
</template>
<script>
import { quillEditor } from 'vue-quill-editor'

export default {
  components: {
    quillEditor
  }
}
</script>
```

```JS
// editor option example:
export default {
  data () {
    return {
      content: '<h2>I am Example</h2>',
      editorOption: {
       // something config
      }
    }
  },
  // if you need to manually control the data synchronization, parent component needs to explicitly emit an event instead of relying on implicit binding
  // 如果需要手动控制数据同步，父组件需要显式地处理changed事件
  methods: {
    onEditorBlur(editor) {
      console.log('editor blur!', editor)
    },
    onEditorFocus(editor) {
      console.log('editor focus!', editor)
    },
    onEditorReady(editor) {
      console.log('editor ready!', editor)
    },
    onEditorChange({ editor, html, text }) {
      // console.log('editor change!', editor, html, text)
      this.content = html
    }
  },
  // if you need to get the current editor object, you can find the editor object like this, the $ref object is a ref attribute corresponding to the dom redefined
  // 如果你需要得到当前的editor对象来做一些事情，你可以像下面这样定义一个方法属性来获取当前的editor对象，实际上这里的$refs对应的是当前组件内所有关联了ref属性的组件元素对象
  computed: {
    editor() {
      return this.$refs.myTextEditor.quillEditor
    }
  },
  mounted() {
    // you can use current editor object to do something(editor methods)
    console.log('this is my editor', this.editor)
    // this.editor to do something...
  }
}
```