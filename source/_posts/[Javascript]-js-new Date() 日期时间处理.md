---
title: 'JavaScript---new Date]'
date: '2018/8/19 23:57:28'
tags:
  - 'cookie,session,token'
categories:
  - ② Javascript-ES6-Typescript
  - Javascript
updated:
comments:
---
## 一、 前言

new Date 类的所有内置方法，与拓展方法的列举，方便使用的时候查阅与快速引用。[MDN 查看](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/setFullYear)

更多的时间处理可以去看 dayjs 的使用的。

## 二、JavaScript Date 的内置方法

```JS
//以下结果是2018-9-10得到的。
var d = new Date();
d.setFullYear(year,month,date)  // year 是必填项，后面 2 个是可选项，这个方法取代了 setYear 方法，因为它可以有 3 个变量
                                // 其中 year 对应的是就是 年份，month 对应的是 0-11,date 对应的是 1-31 ！！！！！！！！！！！！！只有月份是特殊的。
                                // 例如 d.setFullYear(2019,2,19)  这里 d ：2019-03-19T12:33:32.107Z

var d = new Date() //今天
d.setFullYear(2019, 2, 19)
console.log(d);             // 2019-03-19T12:49:20.409Z
d.setMonth(6)
console.log(d);             // 2019-07-19T12:51:05.590Z
d.setDate(32)
console.log(d);             // 2019-08-31T12:51:05.590Z   为啥设置 32 然后天数是 1 然后月数 + 1
// 就不要设置错误的过来就好了！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
d.setTime()

// 有设置函数也有获取函数，按照上面的变化
console.log(d.getFullYear());            // 2019
console.log(d.getMonth());               // 7    获取的是 月数，对应的值是 0-11     0  是 1 月
console.log(d.getDate());                // 1    获取的是 天数，对应的值是 1-31     1  是 1 天
console.log(d.getDay());                 // 4    获取的是 星期几，对应的值是 0-6    0  是 星期 1
console.log(d.getTime());                // 1564664314855     获取当前时间(从1970.1.1开始的毫秒数) 会改变的，因为时间一直在走呀，这个  时间 搓
console.log(d.getHours());               // 20                  （当前时间 2019-8-1 20:59:42）
console.log(d.getMinutes());             // 59                  （当前时间 2019-8-1 20:59:42）
console.log(d.getSeconds());             // 42                  （当前时间 2019-8-1 20:59:42）
console.log(d.getMilliseconds());        // 656                 （当前时间 2019-8-1 20:59:42）
console.log(d.toLocaleDateString());     // 2019-8-1            （当前时间 2019-8-1 20:59:42）
console.log(d.toLocaleString());         // 2019-8-1 20:59:42 / 2019/8/1 下午8:58:34 视本地电脑环境时间而定  （当前时间 2019-8-1 20:59:42）
console.log(d.toLocaleTimeString());     // 20:59:42             (当前时间 2019-8-1 20:59:42）


var day = new Date('9102-02-02T12:51:05.590Z')
console.log(day.toLocaleDateString());//9102-2-2
day = new Date('August 19, 1975 23:15:30')
console.log(day.toLocaleString());//1975-8-19 23:15:30
```

```JS
// 将时间戳 1564664314855 转化为 2019-8-1 20:58:34 格式
var d = new Date() //今天
d.setTime(1564664314855)
// 有设置函数也有获取函数，按照上面的变化
console.log(d.toLocaleString()); // 2019-8-1 20:58:34
```

```JS
// 将  时间戳 (毫秒：1564664314855) 格式化
var d = new Date(1564664314855)
console.log(d.toLocaleString()); // 2019-8-1 20:58:34
```

```JS
// 将 (秒：1551591644) 格式化
var d = new Date(1551591644*1000)// 先转化为 时间戳， new Date 知道是什么。
console.log(d.toLocaleString()); // 2019-8-1 20:58:34
//                                  2019/8/1 下午8:58:34
//                                   后面这个函数，会根据系统（电脑系统）的时间设置格式来显示的，可以自己去规定
```

## 三、 JavaScript Date 的原型方法扩展

在JavaScript开发中，经常需要对 Date 类型的对象进行各种验证或格式化，但是 js 并没有提供那么多的那么细的函数，所以只好自己去用 prototype 扩充。

**不过多人的项目应该不要去修改内置对象吧，这样多人合作的话会产生很多问题的！！！！不要去修改内置对象！！！**
而且在 ESlint 中根不让这样添加的！！！原型只读，不让你添加！！！给 js 的内置对象 做修改，那是一个大坑。

做法：自己封装一个类，然后类里封装一个 date 实例。除了 polyfill，永远都不要扩展原生，感觉是个坑。所以不要用下面这种形式哦。

```BASH
# 这里的做法是错误的示范  按照后面的每个小节的方法来写。
Date.prototype.isLeapYear #判断闰年
Date.prototype.Format     #日期格式化
Date.prototype.DateAdd    #日期计算
Date.prototype.DateDiff   #比较日期差
```

### 3.1 判断是否是闰年 Date.prototype.isLeapYear => ture or false

>闰年是公历中的名词。
普通年:能被 4 整除但不能被 100 整除的年份为普通闰年。（如 2004 年就是闰年，1999 年不是闰年）；
世纪年:能被 400 整除的为世纪闰年。（如 2000 年是闰年， 1900 年不是闰年）；
四年一闰，百年不闰，四百年再闰

```JS
Date.prototype.isLeapYear = function(){
  if (this.getYear()%4==0&&((this.getYear()%100!=0)||(this.getYear()%400==0))) return true
  return false
}
/* Date.prototype.isLeapYear = function(){
  return (this.getYear()%4==0&&((this.getYear()%100!=0)||(this.getYear()%400==0)));
  这段代码写得太简单了我看不懂，它也是返回 ture or false
} */
// 这里的做法直接去修改 js 的内置/原型对象 Date 是不理智的。
```

```JS
// 应该封装自己的类
class MyDate {
  constructor() {
    this.data = new Date()
  }
}
MyDate.prototype.isLeapYear = function() {
  let that = this.data
  if (that.getYear() % 4 === 0 && ((that.getYear() % 100 !== 0) || (that.getYear() % 400 === 0))) return true
  return false
}

var day = new MyDate()
console.log(day.isLeapYear())
```

```BASH
SyntaxError: redeclaration of formal parameter year
#某个变量名称已经作为函数参数出现了，但是又使用了 let 在函数体里重声明了。
#在 JavaScript 中不允许使用 let 在相同的函数或块范围内重新声明相同的变量。
```

### 3.2 format 日期格式化 => 星期三 2018-9-10 20:43:36 任意选择

```JS
class MyDate {
  constructor() {
    this.data = new Date()
  }
  format(str) {
    var Week = ['日', '一', '二', '三', '四', '五', '六']
    let that = this.data
    str = str.replace(/YYYY/, that.getFullYear())
    str = str.replace(/YY/, (that.getYear() % 100) > 9 ? (that.getYear() % 100).toString() : '0' + (that.getYear() % 100))
    str = str.replace(/MM/, that.getMonth() > 8 ? (that.getMonth() + 1).toString() : '0' + (that.getMonth() + 1))
    str = str.replace(/DD/, that.getDate() > 9 ? that.getDate().toString() : '0' + that.getDate()) // /dd/DD/ 我只要大DD
    str = str.replace(/hh/, that.getHours() > 9 ? that.getHours().toString() : '0' + that.getHours()) /// hh|HH/  我只要小 hh
    str = str.replace(/mm/, that.getMinutes() > 9 ? that.getMinutes().toString() : '0' + that.getMinutes())
    str = str.replace(/ss/, that.getSeconds() > 9 ? that.getSeconds().toString() : '0' + that.getSeconds()) // /ss|SS/ 我只要小ss
    str = str.replace(/w/g, '星期' + Week[that.getDay()]) /// w|W/g  我只要小w
    return str
  }
}

var myDate = new MyDate()
console.log(myDate.format('w YYYY-MM-DD hh:mm:ss')) // 结果 星期三 2018-9-10 20:43:36
console.log(myDate.format('w YYYY/MM/DD hh:mm:ss')) // 结果 星期三 2018/10/10 20:43:36
console.log(myDate.format('mm:ss')) // 结果 43:36
console.log(myDate.format('MM')) // 结果 10 */
```

格式化拓展方法使用说明：大小写太混乱了，把一些代码注释了，要区分大小写。
w ：代表星期几
YYYY：代表年份（4位）
YY：代表年份（2位）
MM：代表月份
DD：代表日期
hh：代表小时
mm：代表分钟
ss：代表秒

调用方法：new MyDate().Format('') 在这里传入格式化的参数，需要什么就写入对应的字符，中间希望以什么字符空格连接都行。

### 3.3 daysBetween 日期天数差 => 365

```JS
function daysBetween(DateOne, DateTwo) {
  let OneLeftIndex = DateOne.indexOf('-') || DateOne.indexOf('/') || DateOne.indexOf('.')
  let OneRightIndex = DateOne.lastIndexOf('-') || DateOne.indexOf('/') || DateOne.indexOf('.')

  var OneMonth = DateOne.substring(OneLeftIndex+1, OneRightIndex);
  var OneDay = DateOne.substring(OneRightIndex+1);
  var OneYear = DateOne.substring(0, OneLeftIndex);

  let TwoLeftIndex = DateTwo.indexOf('-') || DateTwo.indexOf('/') || DateTwo.indexOf('.')
  let TwoRightIndex = DateTwo.lastIndexOf('-') || DateTwo.indexOf('/') || DateTwo.indexOf('.')

  var TwoMonth = DateTwo.substring(TwoLeftIndex+1, TwoRightIndex);
  var TwoDay =   DateTwo.substring(TwoRightIndex+1);
  var TwoYear =  DateTwo.substring(0, TwoLeftIndex);

  var cha = ((Date.parse(OneMonth + '/' + OneDay + '/' + OneYear) - Date.parse(TwoMonth + '/' + TwoDay + '/' + TwoYear)) / 86400000);
  return Math.abs(cha);
}
console.log(daysBetween('2018-11-23', '2019-2-1')) //70
console.log(daysBetween('2018/3/1', '2018/3/12'))//12
console.log(daysBetween('2018.11.23', '2019/11/23'))//365
```