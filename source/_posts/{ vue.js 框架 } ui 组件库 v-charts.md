---
title: v-charts- 图表组件库
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

在使用 echarts 生成图表时，经常需要做繁琐的数据类型转化、修改复杂的配置项，v-charts 的出现正是为了解决这个痛点。基于 Vue2.0 和 echarts 封装的 v-charts 图表组件，只需要统一提供一种对前后端都友好的数据格式设置简单的配置项，便可轻松生成常见的图表。

eCharts  是基础
v-charts 是基于 Vue2.0 和 echarts 封装，更方便我们使用于 vue 项目中。饿了么团队开源的基于 Vue 和 ECharts 的图表工具

[eCharts 官网文档](http://echarts.baidu.com/tutorial.html#5%20%E5%88%86%E9%92%9F%E4%B8%8A%E6%89%8B%20ECharts)
[v-charts 官网文档](https://v-charts.js.org/#/)，使用教程[地址](https://juejin.im/entry/5b0567c8f265da0b7d0bbf34)

# 二、安装-引入-使用

## 2.1  echarts 安装引入

```bash
$ npm install echarts --save
#
```

npm 的方法还需要导入

[导入](http://echarts.baidu.com/tutorial.html#%E5%9C%A8%20webpack%20%E4%B8%AD%E4%BD%BF%E7%94%A8%20ECharts)

## 2.2 v-charts 的安装引入（vue 项目就直接使用这个吧!!!）

### 2.2.1 安装

```BASH
$ npm i v-charts echarts -S
$ yarn add v-charts echarts
```

### 2.2.2 完全导入

```JS
// main.js  完全导入 ，没有问题！！
import Vue from 'vue'
import VCharts from 'v-charts'
import App from './App.vue'

Vue.use(VCharts)

new Vue({
  el: '#app',
  render: h => h(App)
})
```

### 2.2.3 按需导入

>官网给的例子，这个是 CDN 的例子吧？？使用 npm 安装的方法这样用不成功 xxxxxxxxxxxx 不用这个

```BASH
# v-charts/lib 文件夹下 有的每种图表组件，都单独打包好了
|- lib/
    |- line.common.js  -------------- 折线图
    |- bar.common.js  --------------- 条形图
    |- histogram.common.js  --------- 柱状图
    |- pie.common.js  --------------- 饼图
    |- ring.common.js  -------------- 环图
    |- funnel.common.js  ------------ 漏斗图
```

```JS
// main.js 引入（官网给的按需还是在 main.js 引入的，我们实际工作不要全局，在需要使用的页面去导入使用就好了）
// 当然，如果我们只是在一个页面有图标的话，不应噶是全局引入吧！！！！！！！！！！！！！！！！！！！在响应的页面去引入啊！！！！
// v-charts/lib 文件夹下 有的每种图表组件，都单独打包好了 使用的时候，我们只需要单独的引入就 ok
// 但是在按需引入的时候回出现很多问题！！！！！！！！！！！！！！！！！！！
import Vue from 'vue'
import VeLine from 'v-charts/lib/line.common'// 例如现在需要使用 line 图表
import App from './App.vue'

Vue.component(VeLine.name, VeLine)

new Vue({
  el: '#app',
  render: h => h(App)
})
```

<div style="color:red;">npm-yarn 安装的按需加载使用方法（使用这个√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√√）</div>

```HTML
<template>
  <div>
    <ve-line :data="chartData"></ve-line>
  </div>
</template>

<script>
import VeLine from 'v-charts/lib/line'//这样来导入，与官网说的有一点不一样，官网的 line.common 导入，在 npm 包包装这使用是不对的！！！！！！
export default {
  data(){
    return{
      chartData:{
        columns: ['日期', '销售量'],
        rows: [
          { '日期': '1月1日', '销售量': 123 },
          { '日期': '1月2日', '销售量': 1223 },
          { '日期': '1月3日', '销售量': 2123 },
          { '日期': '1月4日', '销售量': 4123 },
          { '日期': '1月5日', '销售量': 3123 },
          { '日期': '1月6日', '销售量': 7123 }
        ]
      }
    }
  }
  components: {
    VeLine
  }
  created () {
    this.getChartData();
  },
  methods:{
    getChartData(){
      //ajax 请求给 chartData 赋值
    }
  }
}
</script>
```

## 2.5 官网的项目示例（但是自己这样按需加载就是错误的啊）

```JS
// main.js
import Vue from 'vue';
import App from './App';
import router from './router/index';
//import "echarts";// 示例中没哟这一句的，就会一直说 Component series.line not exists. Load it first. 错误，加了这句才没有问题
// 是因为下面导入错误，如果下面换成 import VeLine from 'v-charts/lib/line'; 与  import VeMap from 'v-charts/lib/map'; 就不需要额外的加载了
// 并且也不应该在 main.js 里面来的！！！！！！！！
import VeLine from 'v-charts/lib/line.common';
import VeMap from 'v-charts/lib/map.common';
// 下面的依赖可以按照需求选择性加载
// 官网链接：https://v-charts.js.org/#/props
// The following dependencies can be selectively loaded on demand
import 'echarts/lib/component/markLine';//标线
import 'echarts/lib/component/markPoint';//标点
import 'echarts/lib/component/markArea';//标志区域
import 'echarts/lib/component/visualMap';
import 'echarts/lib/component/dataZoom';
import 'echarts/lib/component/toolbox'; // 提示框组件
import 'echarts/lib/component/title';   // 标题组件
import 'zrender/lib/svg/svg';
import 'v-charts/lib/style.css';    // 这个是 v-charts 的样式啊？？？？？也是需需要引入的？？？？？

// 多个图标这样
[VeLine, VeMap].forEach(comp => {
  Vue.component(comp.name, comp);
});
//Vue.component(VeLine.name, VeLine) 单个这样

Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
  el: '#app',
  render: h => h(App),
  router
});
```

* columns（绑定的是写在 return 里面）
      示例 `columns:  ["日期", "访问用户", "下单用户", "下单率"]`
      columns 中是维度和指标的集合，v-charts 中的大部分图表都是单维度多指标，所以默认第一个值为 维度，剩余的值为指标
* rows 中是数据的集合。

```HTML
<template>
  <div class="page-line-chart">
    <h4>简单折线图</h4>
    <ve-line :data="chartData" :settings="chartSettings" :extend="extend"></ve-line>
  </div>
</template>

<script>
export default {
  data() {
    this.chartSettings = {
      //setting 属性中统一有两个配置：
      //dimension 用于指定维度
      metrics: ['下单用户'] //用于指定指标，指定了之后，图表就会按照这个来限制，只有 '下单用户' 了。"访问用户"，"下单率" 这两个就看不见了的。
      //yAxisType: ['0.0a'] 这个是什么？？？？？？？？
    } //注意到，这里要设置图表的其他参数的话，是写在 data 下， return  外面的，并且最后是没有逗号的！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    // 但是为啥要这样放在外面呢！！！真是不好看啊，直接放在 return 里面就好了呀！！！！！！！！！！！！
    return {
      // chartData 这个数据还是在 return 里面的
      chartData: {
        columns: ["日期", "访问用户", "下单用户", "下单率"],
        // ①①①① columns 中是维度和指标的集合，v-charts 中的大部分图表都是单维度多指标，所以默认第一个值为 维度，剩余的值为指标
        // ②②②② rows 中是数据的集合。
        rows: [
          { 日期: "1/1", 访问用户: 1393, 下单用户: 1093, 下单率: 0.32 },
          { 日期: "1/2", 访问用户: 3530, 下单用户: 3230, 下单率: 0.26 },
          { 日期: "1/3", 访问用户: 2923, 下单用户: 2623, 下单率: 0.76 },
          { 日期: "1/4", 访问用户: 1723, 下单用户: 1423, 下单率: 0.49 },
          { 日期: "1/5", 访问用户: 3792, 下单用户: 3492, 下单率: 0.323 },
          { 日期: "1/6", 访问用户: 4593, 下单用户: 4293, 下单率: 0.78 }
        ]
      },
      // 像这样放在 return 里面就好了呀！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
      // 可能是放在 放在外面比较好看？？？？？看自己的需求咯。
      // chartSettings: {
      //   //
      // },
      // extend: {
      //   series: {
      //     label: { show: true, position: "top" }
      //   }
      // }
    };
  }
};
</script>
```

## 2.1 按需加载导入模块

gittub [链接](https://github.com/apache/incubator-echarts/blob/master/index.js)

```JS
import VeHistogram from "v-charts/lib/line"  -------------- 折线图
import VeHistogram from "v-charts/lib/bar"  --------------- 条形图
import VeHistogram from "v-charts/lib/histogram"  --------- 柱状图
import VeHistogram from "v-charts/lib/pie"  --------------- 饼图
import VeHistogram from "v-charts/lib/ring"  -------------- 环图
import VeHistogram from "v-charts/lib/funnel"  ------------ 漏斗图
import VeHistogram from "v-charts/lib/waterfall" --------- 瀑布图
import VeHistogram from "v-charts/lib/radar" ------------- 雷达图
import VeHistogram from "v-charts/lib/map"  --------------- 地图
import VeHistogram from "v-charts/lib/sankey"  ------------ 桑基图
import VeHistogram from "v-charts/lib/heatmap" ----------- 热力图
import VeHistogram from "v-charts/lib/scatter" ----------- 散点图
import VeHistogram from "v-charts/lib/candle" ------------ k线图
import VeHistogram from "v-charts/lib/gauge"  ------------- 仪表盘
import VeHistogram from "v-charts/lib/tree"  -------------- 树图
import VeHistogram from "v-charts/lib/bmap"  -------------- 百度地图
import VeHistogram from "v-charts/lib/amap"  -------------- 高德地图

// 上面是各种图表，导入之后需要在 js 中 component 注册
// 下面的是 图表的其他配置，需要的时候导入

import "echarts/lib/chart/line"
import "echarts/lib/chart/bar"
import "echarts/lib/chart/pie"
import "echarts/lib/chart/scatter"
import "echarts/lib/chart/radar"
import "echarts/lib/chart/map"
import "echarts/lib/chart/tree"
import "echarts/lib/chart/treemap"
import "echarts/lib/chart/graph"
import "echarts/lib/chart/gauge"
import "echarts/lib/chart/funnel"
import "echarts/lib/chart/parallel"
import "echarts/lib/chart/sankey"
import "echarts/lib/chart/boxplot"
import "echarts/lib/chart/candlestick"
import "echarts/lib/chart/effectScatter"
import "echarts/lib/chart/lines"
import "echarts/lib/chart/heatmap"
import "echarts/lib/chart/pictorialBar"
import "echarts/lib/chart/themeRiver"
import "echarts/lib/chart/sunburst"
import "echarts/lib/chart/custom"
import "echarts/lib/component/dataset"
import "echarts/lib/component/graphic"
import "echarts/lib/component/grid"
import "echarts/lib/component/legendScroll"
import "echarts/lib/component/tooltip"
import "echarts/lib/component/axisPointer"
import "echarts/lib/component/polar"
import "echarts/lib/component/geo"
import "echarts/lib/component/parallel"
import "echarts/lib/component/singleAxis"
import "echarts/lib/component/brush"
import "echarts/lib/component/calendar"
import "echarts/lib/component/title"
import "echarts/lib/component/dataZoom"
import "echarts/lib/component/visualMap"
import "echarts/lib/component/markPoint"
import "echarts/lib/component/markLine"
import "echarts/lib/component/markArea"
import "echarts/lib/component/timeline"
import "echarts/lib/component/toolbox"
import "zrender/lib/vml/vml"
import "zrender/lib/svg/svg"
```

# 三、后台获取数据复制

## 3.1 官方给的例子

真的是里面的 const 值，写的。。。。。。。。。。。。。。

```HTML
<template>
  <div>
    <button @click="getData">获取数据</button>
    <ve-line
      :data="chartData"
      :loading="loading"
      :data-empty="dataEmpty"
      :settings="chartSettings">
    </ve-line>
  </div>
</template>
<script>
  // 要这一堆干嘛？？？？？？
  const DATA_FROM_BACKEND = {
    columns: ['date', 'PV', 'Order'],
    rows: [
      { 'date': '2018-05-22', 'PV': 32371, 'Order': 19810 },
      { 'date': '2018-05-23', 'PV': 12328, 'Order': 4398 },
      { 'date': '2018-05-24', 'PV': 92381, 'Order': 52910 }
    ]
  }
    // 要这一堆干嘛？？？？？？
  const EMPTY_DATA = {
    columns: [],
    rows: []
  }
  export default {
    data () {
      this.chartSettings = {
        yAxisType: ['0,0a']
      }
      return {
        chartData: {
          columns: [],
          rows: []
        },
        loading: false,// 这个数据又是在 return 里面的
        dataEmpty: false// 这个数据又是在 return 里面的
      }
    },
    created () {
      this.getData()
    }
    methods: {
      getData () {
        this.loading = true
        // ajax 请求，axios 请求 ....
        // 要使用 setTimeout 的，如果需求是间断不听的去获取的话，就要不停的 setInterval 咯
        setTimeout(() => {
          // 这里面写的一堆啥呀？？？完全看不懂
          this.chartData = this.chartData.rows.length
            ? EMPTY_DATA
            : DATA_FROM_BACKEND
          this.dataEmpty = !this.chartData.rows.length
          this.loading = false
        }, 1000)
      }
    }
  }
</script>
```

## 3.2 自己写的例子（用这个！！！！！！！！！！！！！！！！！！！！！）

```JS
  data () {
    return {
        chartData: {
          columns: ['id', 'sum'],
          rows: []
        },
        chartSettings:{
          dimension: 'id',
          metrics: 'sum'
        }
      }
    }
  },
  created () {
    this. getData()
  },
  methods:{
    getData()
      axios({
        url:'xxxx',
        method:'get'
      }).then(res => {
          this.chartData.rows = res.data
        }
      })
    }
  }
```

# 四、图表属性

官网链接：[地址](https://v-charts.js.org/#/props)

```HTML
<template>
  <ve-line
    width="100px"                     # 公有属性
    :data="chartData"                 # 数据
    :settings="chartSettings"         # 私有属性配置
    :events="chartEvents"             # 事件
    :init-options="chartInitOptions"
    :tooltip-visible="ture"            # 跟 vue 一样，绑定值，一定要用 冒号 不然就会发生错误了，false 也是 true 值，得不到想要的效果
    :legend-visible="ture"
    :theme="chartTheme"
    theme-name="chartThemeName"
    :judge-width="false"
    :width-change-delay="300"          # 这个绑定的是 number 需要 冒号么？？？
    :resizeable="true"
    :cancel-resize-check="false"
    :resize-delay="200"
    :change-delay="0"
    :set-option-opts="true"
    :not-set-unchange="['dataZoom']"
    :log="false"
    :mark-line="markLine"
    :mark-area="markArea"
    :mark-point="markPoint"
    :loading="false"                  # 使用这个属性的话要加载样式 import 'v-charts/lib/style.css'
    :data-empty="false"  # 使用这个属性的话要加载样式 import 'v-charts/lib/style.css'
    :before-config="beforeConfig"
    :after-config=""
    :after-set-optiong=""
    :after-set-option-once=""
    :extend="lineExtend"
    @ready="ready"              # 写在 methods 里面
    @ready-once="readyOnce"
    >
  </ve-line>
</template>
<script>
export default {
  name: "overview",
  data() {
    this.chartSettings={
      //私有属性在这里设置，或者也可以在 return 里面与 组件的数据一样的 对象写法
      // 每种图表的私有属性都是不一样的
    }
    var self = this
    this.chartEvents = {
      //事件属性，官网是这样在 return 外面写的，应该也是可以在 methods 里面的，不过要换个办法写的
      click: function (e) {
        self.name = e.name
        console.log(e)
      }
    }
    this.chartTheme = {
      categoryAxis: {
        axisLine: { show: false },
        axisTick: { show: false },
        splitLine: { show: false }
      },
      valueAxis: {
        axisLine: { show: false }
      }
    }
    this.markLine={
      data: [
        {
          name: '平均线',
          type: 'average'
        }
      ]
    }
    this.markPoint={
      data: [
        {
          name: '最大值',
          type: 'max'
        }
      ]
      // data: [
      //   {
      //     name: '最大值',
      //     type: 'max',//最小值是min
      //     symbolSize: 60,//标记大小
      //     symbol: 'rect',//标记形状
      //     symbolOffset: [0, '-50%']//标记位置坐标
      //   }
      // ]
    }
    this.lineExtend={
      // init 附加参数，参考文档 https://echarts.baidu.com/api.html#echarts.init
      // grid: [object, array],
      // colors: array,
      // visualMap: [object, array],
      // dataZoom: [object, array],
      // toolbox: [object, array],
      // title: object,
      title:{
        text: 'v-Charts 入门示例'
      },
      // legend: [object, array],  这个是表格顶中部的 方框数据
      legend: {
        data:['销量']
      },
      // xAxis: [object, array],   x 轴上的数据
      // yAxis: [object, array],  y 轴上的数据
      xAxis: {
        data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
      },
      xAxis: {type: 'category'},
      'xAxis.0.axisLabel.show': false,//x轴标签不显示
      'yAxis.0.axisLabel.show': false,//y轴标签不显示
      'xAxis.0.splitLine.show': false//x轴表格线不显示
      yAxis: {},
      // radar: object,
      // tooltip: object,
      tooltip (v) {
        v.trigger = 'none'//提示线不显示
        return v
      },
      // axisPointer: object,
      // brush: [object, array],
      // geo: object,
      // timeline: [object, array],
      // graphic: [object, array],
      // series: [object, array],
      series: [{
          name: '销量',
          type: 'bar',
          data: [5, 20, 36, 10, 10, 20]
      }],
      // 声明多个 bar 系列，默认情况下，每个系列会自动对应到 dataset 的每一列。
      series: [
        {type: 'bar'},
        {type: 'bar'},
        {type: 'bar'}
      ],
      series (v) {
        v.forEach(i => {
          i.barWidth = 20//柱状图柱子宽度
        })
        return v
      },
      // backgroundColor: [object, string], 背景颜色设置
      // textStyle: object,
      // animation: object
    }
    return {
      // return 里面放置的是的 页面的数据，上面那些是图表的数据放置在外面了，但是也可以放在里面的
      name: '',
      chartData:{
        columns: ['日期', '访问用户', '下单用户'],
        rows: [
          { '日期': '2018-05-22', '访问用户': 32371, '下单用户': 19810 },
          { '日期': '2018-05-23', '访问用户': 12328, '下单用户': 4398 },
          { '日期': '2018-05-24', '访问用户': 92381, '下单用户': 52910 }
        ]
      }
    },
    methods:{
      ready (v) {
        console.log('ready')
      }
    }
  }
</script>
```

## 4.1 基本属性（含有 公有属性+私有属性）

* width  图表宽度 默认值 auto                     （公有属性，所有图表都有的属性）
                可以设置为百分比的，但是不要忘记设置父元素的宽度，否则设置的 百分比没有效果的。
                width  这是 canvas 标签的宽度
                   `<div class="overview-charts">`
                      `<ve-histogram`
                      `width="100%"`
                      `:data="histogramChartData"`
                      `:settings="histogramSettings"`
                      `:extend="histogramExtend"`
                      `:theme="histogramTheme"`
                      `></ve-histogram>`
                   `</div>`
                    .overview-charts{
                      width：100%;
                      .ve-histogram{
                        width：100%;
                        // 父元素设置 100%，`<ve-histogram>` 标签中设置的宽度属性是 canvas 的宽度
                      }
                    }
* height 图表高度 默认值 400px                    （公有属性，所有图表都有的属性）
* data   图表数据，写在组件 data return 里面的数据 （图表数据）
              columns（绑定的是写在 return 里面）
                  示例 `columns:  ["日期", "访问用户", "下单用户", "下单率"]`
                  columns 中是维度和指标的集合，v-charts 中的大部分图表都是单维度多指标，所以默认第一个值为 维度，剩余的值为指标
              rows 中是数据的集合。
* events                    （公有属性，所有图表都有的属性）

* settings   私有属性设置对象                      （私有属性，所有图表都有的属性）

* init-options      是 init 附加参数，用户覆盖初始参数
                    与 echarts 配置项对应的属性也被加到了组件上，用于直接覆盖 options 原有的对应属性
* tooltip-visible   鼠标滑到图表上面的提示    true  就是
* legend-visible    图例组件 legend 是否显示 true ？？？？？？？？？？？？？？？？？？？？？？？？？？
* theme             自定义主题               object
* theme-name        自定义主题名称           string
* judge-width       是否处理生成图表时的宽度问题  boolean    false
* width-change-delay  容器宽度变化的延迟         number     300
* resizeable          是否处理窗口 resize 事件   boolean    true
* cancel-resize-check 是否禁用 resize 时的容器检测  boolean false
* resize-delay        窗口 resize 事件回调的延迟    number  200
* change-delay        属性修改触发图表重绘回调的延迟 number  0
* set-option-opts     是 echarts setOption 的第二个参数, 参考文档 boolean/object  true
* not-set-unchange    未发生变化时不参加 setOption 的属性     array
* log                 在控制台打印内部生成的 echarts options  boolean    false

## 4.2 增加标识元素的属性

* mark-line   标线      object
                        使用这个属性的话需要导入 import 'echarts/lib/component/markLine'
* mark-area   标点      object
                        使用这个属性的话需要导入 import 'echarts/lib/component/markArea'
* mark-point  标志区域  object
                        使用这个属性的话需要导入 import 'echarts/lib/component/markPoint'

## 4.3 状态属性

* loading     加载状态      boolean false
                        使用这个属性的话需要导入 import 'v-charts/lib/style.css'
* data-empty  暂无数据状态  boolean false
                        使用这个属性的话需要导入 import 'v-charts/lib/style.css'

## 4.4 钩子函数

* before-config 对数据提前进行额外的处理，在数据转化为配置项开始前触发  参数为 data，返回值为表格数据
* after-config  对生成好的 echarts 配置进行额外的处理，在数据转化为配置项结束后触发 参数为 options，返回值为 echarts 配置
* after-set-option  生成图之后获取 echarts 实例 参数为 echarts 实例
* after-set-option-once 生成图后获取 echarts 实例（只执行一次） 参数为 echarts 实例

## 4.5 extend 属性

```JS
this.extend={
  //grid: [object, array],
  //colors: array,
  //visualMap: [object, array],
  //dataZoom: [object, array],  在使用 dataZoom 组件时，数据发生改变会引起 dataZoom 的重置，
  //                            在组件上设置 :not-set-unchange="['dataZoom']" 即可解决这个问题。
  //toolbox: [object, array],     需要引入模块    import "echarts/lib/component/toolbox";
  //title: object,                需要引入标题模块 import "echarts/lib/component/title";
  //legend: [object, array],
  //xAxis: [object, array],
  'xAxis.0.axisLabel.rotate': 45 // 横坐标的倾斜
  //yAxis: [object, array],
  //radar: object,
  //tooltip: object,              需要引入模块    import "echarts/lib/component/tooltip";
  //axisPointer: object,
  //brush: [object, array],
  //geo: object,
  //timeline: [object, array],    需要引入模块    import "echarts/lib/component/timeline";
  //graphic: [object, array],
  //series: [object, array],
  series: {
    label: {
      normal: {
        show: true //显示指标数值
      }
    }
  }
  //backgroundColor: [object, string],
  //textStyle: object,
  //animation: object
}
```

* extend `对已配置好`的内部属性进行单独的设置（ extend 为对象类型，对象内的属性可以是函数，也可以对象，也可以是其他类型的值）
          1. 当属性为函数时，设置的是函数的返回值
          2. 当属性为对象时，如果在 options 中对应的属性为对象(eg: tooltip)或包含对象的数组(eg: series)
              对应的配置会被合并，否则将直接 `覆盖` 对应的配置

## 4.6 事件

* ready       图表渲染完成后触发，每次渲染都会触发一次
* ready-once  只会在首次渲染完成后触发

```HTML
<template>
  <div class="page-test">
    <ve-line
      :data="chartData"
      :theme="chartTheme"
      @ready="chartReady($event, 1)"
      @ready-once="chartReadyOnce($event, 1)"
      ref="chart">
    </ve-line>
    <button @click="changeTheme">切换主题</button>
  </div>
</template>

<script>
import VeLine from 'v-charts/lib/line'
import 'echarts/lib/component/toolbox'
const CHART_THEMES = [
  {
    color: ['#000']
  },
  {
    color: ['#0f0']
  }
]
export default {
  data () {
    this.themeSign = false
    return {
      chartData: {
        columns: ['日期', '余额', '年龄'],
        rows: [
          { '日期': 1, '余额': 2123, '年龄': 300 },
          { '日期': 10, '余额': 123, '年龄': 600 },
          { '日期': 20, '余额': 1323, '年龄': 900 },
          { '日期': 50, '余额': 4123, '年龄': 1200 },
          { '日期': 100, '余额': 3223, '年龄': 1500 },
          { '日期': 120, '余额': 123, '年龄': 2000 }
        ]
      },
      chartTheme: {}
    }
  },
  methods: {
    changeTheme () {
      this.themeSign = !this.themeSign
      this.chartTheme = CHART_THEMES[+this.themeSign]
    },
    chartReady () {
      console.log('ready', arguments)
    },
    chartReadyOnce () {
      console.log('ready-once', arguments)
    }
  },
  components: { VeLine }
}
</script>

<style>
.page-test .ve-line {
  width: 0;
}
</style>
```

# 五、几个属性的拓展

## 5.1 私有属性 settings 配置项 拓展

具体的就在各个图表的下面都有配置项的

```HTML
<template>
  <ve-XXXX :data="chartData" :settings="chartSettings"></ve-XXXX>
</template>

<script>
  export default {
    data () {
      this.chartSettings = {
        // ① 【折线】
        //dimension 用于指定维度,“维度” 指的是数据的属性，例如表格中的 “日期” 维度，表示生成的每组数据的日期。
        dimension:['日期']
        metrics: ['下单用户'],//  metrics 用于指定指标,“指标” 是量化衡量标准，例如表格中的 “访问用户” 和 “下单用户”。
        // ② 设置指标的别名【折线】
        labelMap: {
          PV: '访问用户',
          Order: '下单用户'
        },
        //设置指标的别名【折线】
        legendName: {
          '访问用户': '访问用户 total: 10000'
        }
        //③ 设置数据格式:基本类型【折线】
        dataType: {
          '访问用户': 'KMB',
          '年龄': 'percent',
          '下单用户': 'normal'
        },
        //设置数据格式:使用 numerify 格式【折线】
        yAxisType: ['0,0a'],
        xAxisType: 'value', // 设置横轴为连续的数值轴【折线】
        xAxisType: 'time'//设置横轴为连续的时间轴

        axisSite: { right: ['下单率'] },// 双 y 轴，将 下单率 放在 右边
        yAxisType: ['KMB', 'percent'],  // 双 y 轴，左边的数值类型 KMB，右边的是 百分比
        yAxisName: ['数值', '比率']     // 双 y 轴，左边的名称 数值，右边的是 比率

        //设置数据格式:使用回调函数【折线】
        dataType: function (v) {
          return v + ' ￥'
        },
        //④ 堆叠面积图【折线】
        stack: { '用户': ['访问用户', '下单用户'] },
        area: true,
      }
      return {
        chartData: {
          columns: ['日期', '访问用户', '下单用户'],
          rows: [
            { '日期': '2018-05-22', '访问用户': 32371, '下单用户': 19810 },
            { '日期': '2018-05-23', '访问用户': 12328, '下单用户': 4398 },
            { '日期': '2018-05-24', '访问用户': 92381, '下单用户': 52910 }
          ]
        }
      }
    }
  }
</script>
```

## 5.5  events 事件属性的拓展（写在 methods 里面）

```HTML
<ve-ring :settings="chartSettings" :events="{ click: clickHandler.bind(this, 1) }" :data="chartData" @ready="ready"></ve-ring>
```

```JS
data () {
    this.chartSettings = {
      radius: ['50%', '40%']
    }
    return {
      chartData: {
        columns: ['日期', '访问用户'],
        rows: [
          { '日期': '1/1', '访问用户': 1393 },
          { '日期': '1/2', '访问用户': 3530 },
          { '日期': '1/3', '访问用户': 2923 },
          { '日期': '1/4', '访问用户': 1723 },
          { '日期': '1/5', '访问用户': 3792 },
          { '日期': '1/6', '访问用户': 4593 }
        ]
      }
    }
  },
  methods: {
    clickHandler (p, e) {
      console.log('outer-params', p)
      console.log('event', e)
    },
    ready (v) {
      console.log('ready')
    }
  }
```

# 十、 bug 使用过程中各种各种错误

## 10.1 安装错误 1

```BASH
λ cnpm install iveiw --save
× Install fail! Error: GET https://registry.npm.taobao.org/iveiw response 404 status
Error: GET https://registry.npm.taobao.org/iveiw response 404 status
    at get (C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\npminstall\lib\get.js:57:17)
    at get.next (<anonymous>)
    at onFulfilled (C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\co\index.js:65:19)
    at <anonymous>
    at process._tickCallback (internal/process/next_tick.js:188:7)
npminstall version: 3.10.0
npminstall args: C:\Program Files\nodejs\node.exe C:\Users\Administrator\AppData\Roaming\npm\node_modules\cnpm\node_modules\npminstall\bin\install.js --fix-bug-versions --china --userconfig=C:\Users\Administrator\.cnpmrc --disturl=https://npm.taobao.org/mirrors/node --registry=https://registry.npm.taobao.org iveiw --save
```

## 10.2 安装错误 2

```BASH
λ npm install iview --save
npm WARN checkPermissions Missing write access to F:\qianduan_dir\00program\todolist1\node_modules\ajv\node_modules\fast-json-stable-stringify
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

**填坑**

## 10.3 按需引入的错误

```JS
// 官网给的办法也是错误的！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
import Vue from 'vue'
import VeLine from 'v-charts/lib/line.common'// 例如现在需要使用 line 图表
import App from './App.vue'

Vue.component(VeLine.name, VeLine)

new Vue({
  el: '#app',
  render: h => h(App)
})
```

```BASH
`clazz.js?625e:158 Uncaught Error: Component series.line not exists. Load it first.`
# 组件 series.line 不存在，需要先加载它
at Function.entity.getClass (clazz.js?625e:158)
at ExtendedClass.eval (Global.js?7e63:203)
at Array.forEach (<anonymous>)
at each (util.js?1ee1:298)
at ExtendedClass.visitComponent (Global.js?7e63:192)
at Function.entity.topologicalTravel (component.js?8918:105)
at ExtendedClass.mergeOption (Global.js?7e63:174)
at ExtendedClass.initBase (Global.js?7e63:643)
at ExtendedClass.resetOption (Global.js?7e63:121)
at ExtendedClass.setOption (Global.js?7e63:103)
```

解决：
    看官网的我们就知道，这个 v-chart 是依赖 echart 的，怎么只引入 v-chart ，不引入 echart 呢！！！！！！但是好像官网的示例不是这样的！！！。到底是想要干嘛呀？？？怎么做才是对的？？？？
    反正就是 `import "echarts";` 这样做之后才是正确的，应该是 echarts 更新了什么东西， v-chart 没有跟着更新吧！！！！

```JS
// 官网给的办法也是错误的！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
import Vue from 'vue'
import "echarts";// 这样知道就解决问题了啊！！！！！！！！！！！！！！！！！！！！！！！！！！！！但是好像也不是这样用改动？？？？？
import VeLine from 'v-charts/lib/line.common'// 例如现在需要使用 line 图表
import App from './App.vue'

Vue.component(VeLine.name, VeLine)

new Vue({
  el: '#app',
  render: h => h(App)
})
```

## 10.4