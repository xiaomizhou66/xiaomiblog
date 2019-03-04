---
title: '[ dayjs 库]--moment.js 的轻量级 '
date: '2018/8/19 23:57:28'
categories:
  - ⑧ JS 工具集/ JS拓展语言
  - day.js 框架
updated:
tags:
comments:
---

## 一、前言

时间格式处理库，在很多时候，我们的页面需要使用到时间日期，但是格式却是有要求的，这个 dayjs 就是一个处理库。

Day.js 是一个轻量的处理时间和日期的 JavaScript 库，和 Moment.js 的 API 设计保持完全一样.**Day.js 虽然仅有 2kb 大小，但是功能一点都没有阉割。包含了时间处理的全部常用方法。**

Day.js -- 2kB超轻量时间库
Moment.js -- 200k+ with locals(可能一般项目也只使用到了她几个常用的API ,因此 dayjs 更好用于时间处理)，
他们之间的比较，[地址](https://juejin.im/post/5b9f4df66fb9a05d2e1b8f02)

- 🕒 和 Moment.js 相同的 API 和用法
    比 moment.js 轻量级
- 💪 不可变数据 (Immutable)
- 🔥 支持链式操作 (Chainable)
    dayjs().startOf('month').add(1, 'day').set('year', 2018).format('YYYY-MM-DD HH:mm:ss');
- 🌐 I18n 国际化
- 📦 仅 2kb 大小的微型库
- 👫 全浏览器兼容

[GitHub 地址](https://github.com/iamkun/dayjs)
源码解析，可以查看这个文章，说得特别的好。[地址](https://segmentfault.com/a/1190000015440889)

Dayjs 并没有改变或覆盖 Javascript 原生的 Date.prototype， 而是创造了一个全新的包含 Javascript Date 对象的 Dayjs 的对象。
Dayjs 对象是不可变的, 所有的 API 操作都将返回一个新的 Dayjs 对象。

## 二、安装 与 引入

```bash
# 安装
$ npm install --save dayjs

$ yarn add dayjs
```

```JS
// .vue 或者 react.js 引入，要引入才能使用的
import dayjs from "dayjs"
```

## 三、 dayjs 使用

Day.js 有很多 API 来解析、处理、校验、增减、展示时间和日期

### 3.1 创建/解析 dayjs

- 构造 dayjs(existing?:string | number | Date | Dayjs)：构造一个 Dayjs 实例对象
- 克隆 .clone() | dayjs(original: Dayjs)：在已有 Dayjs 实例对象的基础上克隆返回一个新的 Dayjs 实例对象
- 验证 .isValid()：验证该 Dayjs 实例对象是否有效

>1.当没有参数时，会返回一个新的 Dayjs 实例对象，且为当前日期和时间

```js
// ① 不传入任何东西
dayjs() // 不传入任何东西，默认为传入 Date.now() 当前时间,获取当前时间
// 等价于
// ② 传入 Date.now()
dayjs(Date.now())

// ③ 传入 一个表达式
dayjs(Date.now() - 24 * 60 * 60 * 1000) // 昨天
```

>2.当参数为 ISO 8601 标准的字符串时

```JS
// ④ 传入一个字符串
var day = dayjs('1995-12-25') // 1995-12-25 传入字符串，一个标准的 ISO 8601 时间字符串。
var day = dayjs('2018-08-08') // 2018-08-08
dayjs('2018-07-01T12:00:00.000Z')
```

>3.当参数为 unix 时间戳时

```JS
// ⑤ 传入一个数字 语法 dayjs(Number);
dayjs(1318781876406);
```

>4.当参数为一个原生的 JavaScript Date 对象时

```JS
// ⑥ 传入一个 Date 对象 语法 dayjs(Date); 传入的一个 Javascript Date 对象。
dayjs(new Date(2018, 8, 18));
```

>dayjs() 构造函数会返回一个 Dayjs 实例对象
克隆 .clone() | dayjs(original: Dayjs)
会克隆返回一个新的 Dayjs 对象，有两种方法

```JS
// 1.使用 .clone() 方法
dayjs().clone()////Dayjs 对象是不可变的，如果你想获得一个对象的拷贝，请执行 .clone()。 向 dayjs() 里传入一个 Dayjs 对象也能实现同样的效果

// 2.使用 dayjs 构造函数，且传入的参数为被克隆的 Dayjs 实例对象
dayjs(dayjs('2018-7-1'))
```

>验证 .isValid()
返回一个布尔值，表示该 Dayjs 实例对象是否有效

```JS
// ② 验证是否有效
dayjs().isValid();// true
```

### 3.2 展示/显示

- 格式化 .format(stringWithTokens: string)
- 差别 .diff(compared: Dayjs, unit: string (default: 'milliseconds'), float?: boolean)
- Unix 时间戳（毫秒） .valueOf()
- Unix 时间戳（秒） .unix()
- 某月的天数 .daysInMonth()
- 转换为 JavaScript Date 对象 .toDate
- 转换为数组 .toArray()
- 转换为 JSON .toJSON()
- 转换为 ISO 8601 标准格式的字符串 .toISOString()
- 转换为对象 .toObject()
- 转换为字符串 .toString()

>1.格式化

```JS
//语法：dayjs().format(String);
dayjs().format('YYYY年MM月DD日 HH:mm:ss') // 2018年08月08日 00:00:00

//从后端获取到的时间 t（时间戳 ms） 格式化 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!这个是重点啦
dayjs(ti).format('YYYY年MM月DD日 HH:mm:ss') // 2018年08月08日 00:00:00
// 如果后端给的时间是 s，不要忘记 * 1000 转化为时间戳
dayjs(t * 1000).format("YYYY-MM-DD HH:mm:ss");// format 后面是自己需要的格式就ok

dayjs().format('[YYYY]') // "[2018]"。     [] 里的会原样输出。
dayjs().format('{YYYY} MM-DDTHH:mm:ss SSS [Z] A') //
dayjs().format();                       // "2014-09-08T08:02:17-05:00" (ISO 8601, no fractional seconds)
dayjs().format("[YYYY] MM-DDTHH:mm:ssZ"); // "[2014] 09-08T08:02:17-05:00"
dayjs('2019-01-25').format('DD/MM/YYYY'); // '25/01/2019'
dayjs('2019-01-25').format('{YYYY} MM-DDTHH:mm:ssZ[Z]'); // '{2019} 01-25T00:00:00-02:00Z
```

>2.时间差:返回两个 Dayjs 实例对象的时间差

```JS
//语法：dayjs().diff(Dayjs, unit); 获取两个 Dayjs 对象的时间差，默认毫秒。
//差别 .diff(compared: Dayjs, unit: string (default: 'milliseconds'), float?: boolean)

dayjs().diff(dayjs(), 'years'); // 0

const date1 = dayjs('2019-01-25');
const date2 = dayjs('2018-06-05');
date1.diff(date2); // 20214000000
date1.diff(date2, 'months'); // 7
date1.diff(date2, 'months', true); // 7.645161290322581
date1.diff(date2, 'days'); // 233
```

>3.unix 时间戳（毫秒） .valueOf()

```js
dayjs().valueOf();// 返回 Unix 时间戳 (毫秒)
dayjs('2019-01-25').valueOf(); // 1548381600000
```

>4.unix 时间戳（秒） .unix()

```js
dayjs().unix();  //返回 Unix 时间戳 (秒)。
dayjs('2019-01-25').unix(); // 1548381600
```

>5.某月的天数 .daysInMonth()

```JS
dayjs().daysInMonth(); //返回月份的天数。
dayjs('2018-7-1').daysInMonth() // 31
```

>6.转换为（原生 Date 对象 | 数组 | json | ISO 8601 字符串 | 对象 | 字符串）

```JS
// 1.转换为 原生 Date 对象
dayjs('2019-01-25').toDate()

// 2.转换为 数组
dayjs('2019-01-25').toArray() // [ 2019, 0, 25, 0, 0, 0, 0 ]

// 3.转换为 json
dayjs('2019-01-25').toJSON() // '2019-01-25T02:00:00.000Z'

// 4.转换为 ISO 8601 字符串
dayjs('2019-01-25').toISOString() // '2019-01-25T02:00:00.000Z'

// 5.转换为 ISO 8601 字符串
dayjs('2019-01-25').toObject()
/* { years: 2019,
     months: 0,
     date: 25,
     hours: 0,
     minutes: 0,
     seconds: 0,
     milliseconds: 0 } */

// 6.转换为 字符串
dayjs('2019-01-25').toString() // 'Fri, 25 Jan 2019 02:00:00 GMT'
```

### 3.3 获取与设置时间

- 年 .year()
- 月 .month()
- 日 .date()
- 星期几 .day()
- 时 .hour()
- 分 .minute()
- 秒 .second()
- 毫秒 .millisecond()
- 设置 .set(unit: string, value: number)

```JS
// 设置时间
// 语法：dayjs().set(unit : String, value : Int);//设置时间 传入的单位 (unit) 对大小写不敏感。
dayjs().set('month', 3);  // April
dayjs().set('date', 1) // 设置 “日” 为 1 日
dayjs().set('month', 3) // 设置 “月” 为 4 月
dayjs().set('second', 30) // 设置 “秒” 为 30 秒

// 获取时间
dayjs().year();  //获取年份
dayjs().month(); //获取月份
dayjs().date();  //获取日期
dayjs().day()    //获取星期几
dayjs().hour();  //获取小时
dayjs().minute();//获取分钟
dayjs().second();//获取秒
dayjs().millisecond();// 获取毫秒
//上面返回的值与用原生 Date.prototype 对象下的方法获取 “年月日...” 的值是一样的，其实在源码中，就是使用的 Date 的原生方法获取的 “年月日...”
```

### 3.4 操作/方法 对 Dayjs 对象如下增加减少之类的操作

- 添加 .add(value: number, unit: string)
- 减少 .subtract(value: number, unit: string)
- 开始的时间 .startOf(unit: string)
- 结束的时间 .endOf(unit: string)

```JS
//① 加法  语法：dayjs().add(value : Number, unit : String);
dayjs().add(7, 'day')        // 之后、往后的第 7 天
dayjs().add(1, 'year')        // 之后的第 1 年

// ② 减法 语法：dayjs().subtract(value : Number, unit : String);
dayjs().subtract(1, 'months') // 上个月
dayjs().subtract(7,'year')

// ③ 开头时间 语法：dayjs().startOf(unit : String); 返回当前时间的开头时间的 Dayjs() 对象，如月份的第一天。
dayjs().startOf('months')     // 获取该月份的第一天。
dayjs().startOf('year');      // 获取该年年初一天
dayjs().startOf('week')       // 本周开始的时间

//④ 末尾时间 语法：dayjs().endOf(unit : String);  返回当前时间的末尾时间的 Dayjs() 对象，如月份的最后一天。
dayjs().endOf('year')       // 获取一年年末
dayjs().endOf('month');     // 获取该月的最后一天
```

```js
// dayjs 中的方法是可以链式的
dayjs().startOf('month').add(1, 'day').subtract(1, 'year')

dayjs('2018-7-1')
  .add(1, 'day')
  .substract(1, 'year').toString()
// 在 2018-7-1 基础上添加 1 天，然后减少 1 年，最后转换为字符串
```

### 3.4 查询 （返回布尔值）

- 是否在之前 .isBefore(compared: Dayjs)
- 是否相同 .isSame(compared: Dayjs)
- 是否在之后 .isAfter(compared: Dayjs)
- 是否是 Dayjs 实例对象 isDayjs()

```js
//是否相同  检查一个 Dayjs 对象是否和另一个 Dayjs 对象时间相同。
dayjs().isSame(dayjs()); // true


//是否早于
dayjs('2010-10-20').isBefore('2010-10-21') // true
dayjs().isBefore(dayjs())  // false

//是否晚于 检查一个 Dayjs 对象是否在另一个 Dayjs 对象时间之后。
dayjs('2010-10-20').isAfter('2010-10-19') // true
dayjs().isAfter(dayjs()); // false

//是否是 Dayjs 实例对象
dayjs.isDayjs(dayjs()); // true
dayjs.isDayjs(new Date()); // false
```

### 3.5 dayjs 内置插件（需要额外的导入加载）

- 相对时间 relativeTime
- 是否是闰年
- 支持农历 buddhistEra
- 特色格式化 advancedFormat

```JS
//dayjs 使用插件的语法
//dayjs 的插件，通过挂载到 dayjs 函数下的 extend 函数加载，然后使用：

import plugin // 导入插件
dayjs.extend(plugin) // 加载插件
dayjs.extend(plugin, options) // 或者加载插件的同时，加入插件所需要的参数
```

>1.相对时间

```JS
//相对时间
//使用 .from .to .fromNow .toNow 方法来获得相对时间



```

>2.判断是否是闰年

```JS
//判断是否是闰年
import isLeapYear from 'dayjs/plugin/isLeapYear'// ① 导入插件像这样，需要先引入才能使用这个方法
dayjs.extend(isLeapYear)                        // ② 加载插件

dayjs('2000-01-01').isLeapYear() // true           ③ 使用插件方法    语法：dayjs().isLeapYear();// dayjs() 没有参数，默认指的是判断当前时间
```

>3.支持农历 buddhistEra


>4.特色格式化 advancedFormat

```JS
import advancedFormat from 'dayjs/plugin/advancedFormat' // 按需加載插件，导入插件

dayjs.extend(advancedFormat) // 加载插件

dayjs().format('Q Do k kk X x') // 使用插件方法
```

### 3.6 编写自己的 dayjs 插件

通过阅读插件的源码，我们知道了插件的方法，可以挂载到 Dayjs 类上、Dayjs 类原型上以及 dayjs 函数对象上。并且，可以通过插件选项（option），来对插件进行配置。通过插件，可以很方便的进行 dayjs 库的方法的扩展，来更好的服务我们的具体的业务需求。
官方文档也提供了插件开发的模板：

```JS
export default (option, dayjsClass, dayjsFactory) => {
  // 扩展 dayjs() 实例
  // 例：添加 dayjs().isSameOrBefore() 实例方法
  dayjsClass.prototype.isSameOrBefore = function (arguments) {}

  // 扩展 dayjs 类
  // 例：添加 dayjs.utc() 类方法
  dayjsFactory.utc = (arguments) => {}

  // 覆盖已存在的 API
  // 例：扩展 dayjs().format() 方法
  const oldFormat = dayjsClass.prototype.format
  dayjsClass.prototype.format = function (arguments) {
    // 原始format结果
    const result = oldFormat(arguments)
    // 返回修改后结果
  }
}
```

### 3.7 国际化（语言，时间）（也是按需加载）

```JS
import 'dayjs/locale/es' // 按需加載

dayjs.locale('es') // 全局使用西班牙語

dayjs('2018-05-05').locale('zh-tw').format() // 局部使用繁體中文
```