---
title: echarts 图表组件库
date: '2018/8/19 23:57:28'
tags:
  - v-charts 图标库
categories:
  - ④ vue.js
  - vue.js 的 UI 组件库
updated:
comments:
---
# 一、图表组件库

使用 echarts 生成图表， 是百度研发的 UI 图表组件库。
eCharts  是基础

[eCharts 官网文档](https://echarts.baidu.com/tutorial.html#%E5%9C%A8%20webpack%20%E4%B8%AD%E4%BD%BF%E7%94%A8%20ECharts)

学习 echarts 在 vue 中的使用。vue 使用的是 webpack 的，这里我们使用 echart 也就是在 webpack 中使用。

# 二、echarts 下载安装使用

## 2.1 下载

```BASH
$ npm install echarts --save
# 或是
$ yarn add echarts
```

## 2.2 导入

```JS
//main.js  全局引入。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。
import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import echarts from "echarts"; // 导入............
import iView from 'iview'
import 'iview/dist/styles/iview.css'
import axios from 'axios'


Vue.config.productionTip = false
Vue.use(echarts)
Vue.use(iView);

```

```HTML
<!-- 按需引入使用 。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。 -->
<template>
  <div class="chargeback">
    <div id="barChart" style="width:90%; height:350px;"></div>
  </div>
</template>

<script>
//import axios from "axios";
import echarts from 'echarts/lib/echarts';// 引入主模块
// 下面都是按需引入
// 按需引入 图表组件
import bar from 'echarts/lib/chart/bar'; // 引入柱状图
// 其他的组件列表 https://github.com/apache/incubator-echarts/blob/master/index.js
// 按需引入 图表配置组件
import 'echarts/lib/component/tooltip';// 引入提示框
import 'echarts/lib/component/title';// 引入标题组件

export default {
  name: "chargeback",
  data() {
    return {
      //
    };
  },
  components: {
    bar // 这里注册 图表组件
  },
  created() {
    this.initBarChart();
  },
  mounted() {
    //
  },
  computed: {
    //
  },
  methods: {
    initBarChart(){
      // 基于准备好的 dom 初始化 echarts 实例
      var barChart = echarts.init(document.getElementById('barChart'));
      var barChart = echarts.init(this.$refs.barChart);// 如果使用的是的 ref 可以这样做的,就是要在 mounted() 去调用这个函数，否则就不对了
      // 绘制图表
      barChart.setOption({
          // 所有的配置项，查看：https://echarts.baidu.com/option.html#title
          title: {
              text: 'ECharts 入门示例'
          },
          tooltip: {},
          xAxis: {
              data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子']
          },
          yAxis: {},
          series: [{
              name: '销量',
              type: 'bar',
              data: [5, 20, 36, 10, 10, 20]
          }]
      });
      //（这里是数据是前端自己设置的，实际上我们的数据应该是从后端获取来前端渲染的）
      axios({
        url:'',
        methods:''
      }).then(res=>{
        const data = res.data
        const list = data.series.map(item=>{
          let list = item.xxx;
          return [...list]
        })
        // 请求到数据之后去配置图表的 配置
        // 所有的配置项，查看：https://echarts.baidu.com/option.html#title
        // 官网的例子是 jQuery 的例子，我们这里是 vue 就这样来赋值就 ok 了（双向绑定的）
        barChart.setOption({
          title: {
            text: data.title
          },
          tooltip: {},
          xAxis: {
              data: data.xAxis.data
          },
          yAxis: {},
          series: [{
              name: '销量',
              type: 'bar',
              data: Array.from(...list)
          }]
        });
      })
    }
  }
};
</script>

<style lang="scss" scoped>
@import "Chargeback.scss";
</style>

<style lang="scss">
  .chargeback {
    //
  }
</style>
```

# 三、 vue 中 echarts 与 axios 配合使用

# 五、自定义选项配置