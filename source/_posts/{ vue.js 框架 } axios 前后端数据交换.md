---
title: axios 小白入门篇、速学篇
date: '2018/8/19 23:57:28'
tags:
  - axios(使用于 vue.js react.js)
categories:
  - ④  vue.js
  - axios 前后端数据交互
abbrlink: 6f49cdfd
updated:
comments:
---
# 一、前言


## 一、 axios 简介

Vue 原本有一个官方推荐的 ajax 插件 vue-resource，但是自从 Vue 更新到 2.0 之后，官方就不再更新 vue-resource，不再维护了，后面更新版本的 vue.js 框架项目都是使用 axios 来做请求后端操作。

axios 是一个基于 Promise 用于浏览器和 nodejs 的 HTTP 客户端，它本身具有以下特征：

- 从浏览器中创建 XMLHttpRequest
- 从 node.js 发出 http 请求
- 支持 Promise API
- 拦截请求和响应
- 转换请求和响应数据
- 取消请求
- 自动转换 JSON 数据
- 客户端支持防止 [CSRF](https://baike.baidu.com/item/CSRF/2735433?fr=aladdin)/XSRF

[网站学习](https://www.kancloud.cn/yunye/axios/234845)

## 三、 axios 发送请求（执行单个请求）

### 3.1 执行 GET 请求 （几种方法）

#### 3.1.1 改造 url 传参（不建议这样传参）（别名方法）

语法：`axios.get('/user?ID=12345')`

在使用别名方法时， url、method、data 这些属性都不必在配置中指定。

- method 提到外面跟在 axios 后面用 点 操作了
- url 在 （） 中 作为第一个参数
- data 作为第二个参数
- 其他的配置项还是写在 {} 配置对象中

```JS
//向具有指定 ID 的用户发出请求
// 方法 ① 为给定 ID 的 user 创建请求
axios.get('/user?ID=12345')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```

#### 3.1.2 使用 params 对象传参（这样来使用传参比较好）（别名方法）

上面的是将需要传递的参数 用 ？ 与 = 号放到 url 中，下面这种方法看起来比较好，需要传递的参数一眼就可以看出来，如果需要传递的的参数多了也好写，用下面这种办法比较好吧。具体看自己习惯怎么用了

语法：
  axios.get('url',{
    params:{},
    orthers:{}
  })

  在使用别名方法时， url、method、data 这些属性都不必在配置中指定。

- method 提到外面跟在 axios 后面用 点 操作了
- url 在 （） 中 作为第一个参数
- data 作为第二个参数
- 其他的配置项还是写在 {} 配置对象中

```JS
// 方法 ② ：通过 params 对象传递参数
axios.get('/user', {
    params: {
      ID: 12345
    }
  })
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```

#### 3.1.3 可以通过向 axios 传递相关配置来创建请求 传参（配置请求，是最原始的方法吧？）

语法：axios({})

```JS
  // 发送 GET 请求（默认的方法）
axios('/user/12345');
```

### 3.2 POST 请求

#### 3.2.1 改造 url 的方法（不推荐用这里不写了）

#### 3.2.2 使用 params 对象（别名方法）

在使用别名方法时， url、method、data 这些属性都不必在配置中指定。

- method 提到外面跟在 axios 后面用 点 操作了
- url 在 （） 中 作为第一个参数
- data 作为第二个参数
- 其他的配置项还是写在 {} 配置对象中

```JS
// 别名方法
axios.post('/user', {
  firstName: 'Fred',
  lastName: 'Flintstone'
})
.then(function (response) {
console.log(response);
})
.catch(function (error) {
console.log(error);
});
```

#### 3.2.3 请求配置方法：axios API 使用配置方法请求后端（配置请求方法）

```JS
// 发送 POST 请求
axios({
  method: 'post',
  url: '/user/12345',
  data: {
    firstName: 'Fred',
    lastName: 'Flintstone'
  }
});
```

### 3.3 PUT DELETE 方法都是一样的道理

#### 3.3.1 别名方法

在使用别名方法时， url、method、data 这些属性都不必在配置中指定。

- method 提到外面跟在 axios 后面用 点 操作了
- url 在 （） 中 作为第一个参数
- data 作为第二个参数
- 其他的配置项还是写在 {} 配置对象中

```JS
axios.request(config)
axios.get(url[, config])
axios.delete(url[, config])
axios.head(url[, config])
axios.post(url[, data[, config]])
axios.put(url[, data[, config]])
axios.patch(url[, data[, config]])
```

#### 3.3.2 配置请求方法

```JS
axios({config})// 所有的方法都是写在配置里面 ，详见 [第四章]!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

## 四、请求配置 axios({config})

### 4.1 单个请求配置

**其实请求配置的方法，其实就是 将第 2 种 params 方法中，将 url 也放到 对象中咯。!!!!!!!!!!!!!!!!!!!!!!!!!!**

```JS
// 这里是创建请求时可以用的配置选项。
// 也就是 {config}  的内容!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//只有 url 是必需的。如果没有指定 method 请求方法，请求将默认使用 get 方法。


// 示例
axios({
    url: '/user', // ①请求后端服务器接口地址 必填 ，除了这个是必填的，其他的 项 都是非必填的
    method: 'get', // ②创建请求时使用的方法  否    默认是 get
    baseURL: 'https://some-domain.com/api/',// `baseURL` 将自动加在 `url` 前面，除非 `url` 是一个绝对 URL。
                                            // 它可以通过设置一个 `baseURL` 便于为 axios 实例的方法传递相对 URL
    transformRequest: [function (data) {
      return data; // 对 data 进行任意转换处理 返回所需
      //③ `transformRequest` 允许在向服务器发送前，修改请求数据，且只能用在 'PUT', 'POST' 和 'PATCH' 这几个请求方法
      // 数组中的函数必须返回 一个字符串，或 ArrayBuffer，或 Stream
    }],
    transformResponse: [function (data) {
      return data;// 对 data 进行任意转换处理
      //④`transformResponse` 在传递给 then/catch 前，允许修改响应数据
    }],

    // headers  是重点 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //headers 包含的所有字段可以去看 http 文章
    headers: {// ⑥`headers` 是即将被发送的自定义请求头,可以设置在默认里面
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',//默认值为 'application/json' 可以不用设置
      //const token = localStorage.getItem('token');// 在 axios({}) 前面要获取 token 赋值
      'Authorization' = `${token}`
      },

    params: {
      ID: 12345 //⑦ `params` 是即将与请求一起发送的 URL 参数，必须是一个无格式对象(plain object)或 URLSearchParams 对象
    },

    paramsSerializer: function(params) {
      return Qs.stringify(params, {arrayFormat: 'brackets'})
      //⑧ `paramsSerializer` 是一个负责 `params` 序列化的函数
      //(e.g. https://www.npmjs.com/package/qs, http://api.jquery.com/jquery.param/)
    },
    data: {
      firstName: 'Fred'
      //⑨ `data` 是作为请求主体被发送的数据，只适用于这些请求方法 'PUT', 'POST', 和 'PATCH'
      //在没有设置 `transformRequest` 时，必须是以下类型之一：
      // - string, plain object, ArrayBuffer, ArrayBufferView, URLSearchParams
      // - 浏览器专属：FormData, File, Blob
      // - Node 专属： Stream
    },
    timeout: 1000,// `timeout` 指定请求超时的毫秒数(0 表示无超时时间)，如果请求花费了超过 `timeout` 的时间，请求将被中断
    withCredentials: false, // 默认的 `withCredentials` 表示跨域请求时是否需要使用凭证
    adapter: function (config) {
      //`adapter` 允许自定义处理请求，以使测试更轻松,
      //返回一个 promise 并应用一个有效的响应 (查阅 [response docs](#response-api)).
    },
    auth: {
      username: 'janedoe',// `auth` 表示应该使用 HTTP 基础验证，并提供凭据
      password: 's00pers3cret'// 这将设置一个 `Authorization` 头，覆写掉现有的任意使用 `headers` 设置的自定义 `Authorization`头
    },
    responseType: 'json', // 默认的类型为 'json'
    // `responseType` 表示服务器响应的数据类型，可以是 'arraybuffer', 'blob', 'document', 'json', 'text', 'stream'
    xsrfCookieName: 'XSRF-TOKEN', // default， `xsrfCookieName` 是用作 xsrf token 的值的cookie的名称
    xsrfHeaderName: 'X-XSRF-TOKEN', // `xsrfHeaderName` 是承载 xsrf token 的值的 HTTP 头的名称,默认值 'X-XSRF-TOKEN'
    onUploadProgress: function (progressEvent) {
      // 对原生进度事件的处理，// `onUploadProgress` 允许为上传处理进度事件
    },
    onDownloadProgress: function (progressEvent) {
      // 对原生进度事件的处理， `onDownloadProgress` 允许为下载处理进度事件
    },
    maxContentLength: 2000,// `maxContentLength` 定义允许的响应内容的最大尺寸
    validateStatus: function (status) {
      return status >= 200 && status < 300; // 默认的值
      // `validateStatus` 定义对于给定的HTTP 响应状态码是 resolve 或 reject  promise 。
      //如果 `validateStatus` 返回 `true` (或者设置为  `null` 或 `undefined`)，promise 将被 resolve;
      //否则，promise 将被 rejecte
    },
    maxRedirects: 5, // 默认为 5 ， `maxRedirects` 定义在 node.js 中 follow 的最大重定向数目
    //如果设置为0，将不会 follow 任何重定向

    httpAgent: new http.Agent({ keepAlive: true }),
    httpsAgent: new https.Agent({ keepAlive: true }),// `keepAlive` 默认没有启用
    // `httpAgent` 和 `httpsAgent` 分别在 node.js 中用于定义在执行 http 和 https 时使用的自定义代理。允许像这样配置选项

    proxy: {
      host: '127.0.0.1',
      port: 9000,
      auth: : {
        username: 'mikeymike',
        password: 'rapunz3l'
      }
      // 'proxy' 定义代理服务器的主机名称和端口
      // `auth` 表示 HTTP 基础验证应当用于连接代理，并提供凭据
      // 这将会设置一个 `Proxy-Authorization` 头，覆写掉已有的通过使用 `header` 设置的自定义 `Proxy-Authorization` 头。
    },
    cancelToken: new CancelToken(function (cancel) {
      // `cancelToken` 指定用于取消请求的 cancel token，（查看后面的 Cancellation 这节了解更多）
    })
})
```

### 4.2 全局配置/ defaults 默认值

很多请求的配置可能存在相同的字段，特别是 url 如果我们每个请求都写长长的一段，麻烦也不好看。
默认值配置（或者说是全局配置）可以让我们减少这些不必要的麻烦。

#### 4.2.1 全局的 axios 默认值

```JS
//main.js  或者在 interceptor/index.js 中设置
axios.defaults.baseURL = 'https://api.example.com';
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;// 在 main.js 或者在拦截器 interceptor 中做处理
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
```

#### 4.2.2 自定义实例默认值

```JS
// 创建实例时设置配置的默认值
var instance = axios.create({
  baseURL: 'https://api.example.com'
});

// 在实例已创建后修改默认值
instance.defaults.headers.common['Authorization'] = AUTH_TOKEN;
```

#### 4.2.3 配置的优先顺序

配置会以一个优先顺序进行合并。这个顺序是：在 lib/defaults.js 找到的库的默认值，然后是实例的 defaults 属性，最后是请求的 config 参数。后者将优先于前者。这里是一个例子：

```JS
// 使用由库提供的配置的默认值来创建实例
// 此时超时配置的默认值是 `0`
var instance = axios.create();

// 覆写库的超时默认值
// 现在，在超时前，所有请求都会等待 2.5 秒
instance.defaults.timeout = 2500;

// 为已知需要花费很长时间的请求覆写超时设置
instance.get('/longRequest', {
  timeout: 5000
});
```

## 五、axios 发送请求（执行多个并发请求）?????????????????????????

处理并发请求的助手函数

- `axios.all(iterable)`
- `axios.spread(callback)`

```JS
function getUserAccount() {
  return axios.get('/user/12345');
}

function getUserPermissions() {
  return axios.get('/user/12345/permissions');
}

axios.all([getUserAccount(), getUserPermissions()])
  .then(axios.spread(function (acct, perms) {
    // 两个请求现在都执行完成
  }));
```

## 六、响应结构 && 拦截器（后端服务器返回的结果）

### 6.1 相应结构

```JS
{
  data: {},// `data` 由服务器提供的响应
  status: 200,// `status` 来自服务器响应的 HTTP 状态码
  statusText: 'OK',// `statusText` 来自服务器响应的 HTTP 状态信息
  headers: {},// `headers` 服务器响应的头
  config: {} // `config` 是为请求提供的配置信息
}
```

### 6.2 then，catch 处理响应

```JS
axios.get('/user/12345')
  .then(function(response) {
    console.log(response.data);
    console.log(response.status);
    console.log(response.statusText);
    console.log(response.headers);
    console.log(response.config);
  })
  .catch(function (error) {
    if (error.response) {
      // 请求已发出，但服务器响应的状态码不在 2xx 范围内
      console.log(error.response.data);
      console.log(error.response.status);
        /* 可以使用 validateStatus 配置选项定义一个自定义 HTTP 状态码的错误范围。
          axios.get('/user/12345', {
            validateStatus: function (status) {
              return status < 500; // 状态码在大于或等于500时才会 reject
              //返回 true 的时候  resolve ，false 的时候reject
            }
          }) */
      console.log(error.response.headers);
    } else {
      // Something happened in setting up the request that triggered an Error
      console.log('Error', error.message);
    }
    console.log(error.config);
  });
```

### 6.3 拦截器 在请求或响应被 then 或 catch 处理前拦截它们（在 then，catch 之前发生）

#### 6.3.1 添加拦截器？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？

```JS
// 添加请求拦截器
axios.interceptors.request.use(function (config) {
    // 在发送请求之前做些什么
    return config;
  }, function (error) {
    // 对请求错误做些什么
    return Promise.reject(error);
  });

// 添加响应拦截器
axios.interceptors.response.use(function (response) {
    // 对响应数据做点什么
    return response;
  }, function (error) {
    // 对响应错误做点什么
    return Promise.reject(error);
  });
```

```JS
//bigdata 项目中的设置
// interceptor/index.js 文件
import axios from 'axios'
import Router from 'router'

axios.interceptors.request.use((config) => {
  // 发送请求之前给 token 再其他的请求中就不需要给 token 了
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Code ${token}`;
  }
  return config;
}, (error) => {
  console.error('request interceptor: ', error)
  return Promise.reject(error)
})

axios.interceptors.response.use((res) => {
  return res;
}, (error) => {
  console.error('response interceptor: ', error)
  if (error.response.status) {
    switch (error) {
      case 401:
        Router.replace('/login');
    }
  }
  return Promise.reject(error);
})
```

#### 6.3.2 移除拦截器

```JS
var myInterceptor = axios.interceptors.request.use(function () {/*...*/});
axios.interceptors.request.eject(myInterceptor);
```

#### 6.3.3 为自定义 axios 实例添加拦截器

```JS
var instance = axios.create();
instance.interceptors.request.use(function () {/*...*/});
```

## 七、axios 实例

### 7.1 axios.create([config]) 创建实例

可以使用自定义配置新建一个 axios 实例：`axios.create([config])`

```JS
var instance = axios.create({
  baseURL: 'https://some-domain.com/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});
```

### 7.2 实例方法

```JS
//以下是可用的实例方法。指定的配置将与实例的配置合并
axios#request(config)
axios#get(url[, config])
axios#delete(url[, config])
axios#head(url[, config])
axios#post(url[, data[, config]])
axios#put(url[, data[, config]])
axios#patch(url[, data[, config]])
```

## 八、取消请求

使用 cancel token 取消请求

Axios 的 cancel token API 基于cancelable promises proposal，它还处于第一阶段。

### 8.1 可以使用 CancelToken.source 工厂方法创建 cancel token，像这样：

```JS
var CancelToken = axios.CancelToken;
var source = CancelToken.source();

axios.get('/user/12345', {
  cancelToken: source.token
}).catch(function(thrown) {
  if (axios.isCancel(thrown)) {
    console.log('Request canceled', thrown.message);
  } else {
    // 处理错误
  }
});

// 取消请求（message 参数是可选的）
source.cancel('Operation canceled by the user.');
```

### 8.2 通过传递一个 executor 函数到 CancelToken 的构造函数来创建 cancel token：

```JS
var CancelToken = axios.CancelToken;
var cancel;

axios.get('/user/12345', {
  cancelToken: new CancelToken(function executor(c) {
    // executor 函数接收一个 cancel 函数作为参数
    cancel = c;
  })
});

// 取消请求
cancel();
```

### 8.3 可以使用同一个 cancel token 取消多个请求

## 九、TypeScript 中使用 axios

```JS
import axios from 'axios';
axios.get('/user?ID=12345');
```

## 十、在 vue 中使用 axios!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

安装其他插件的时候， npm 之后，可以直接在 main.js 中引入并 Vue.use()，但是 axios 并不能 use，只能每个需要发送请求的组件中即时引入，那就是下面说的 修改原型链的方法，或者是大型项目中使用 vuex 封装  action 的办法。

```JS
Vue.use(iView)
Vue.use(APlayer, {
  defaultCover: 'https://github.com/u3u.png',//这里是默认图片设置
  productionTip: true,
});
```

### 10.1 axios 安装/引入

```BASH
$ npm install axios  # npm 方法，推荐使用这个方法
$ cnpm install axios # cnpm 方法: taobao 源 (貌似 cnpm 不稳定老是出错？)
$ bower install axios # bower 方法
<script src="https://unpkg.com/axios/dist/axios.min.js"></script> # cdn 方法 这个方法可以确认版本

# 以上四种方法 四选一
```

### 10.1.1 修改原型链引入法（在 main.js 文件引入）

main.js 导入 axios

```JS
//main.js
import axios from 'axios'   // 全局引入 axios
Vue.prototype.axios = axios // 修改 vue 的原型链？？？？？需要这样么
// 在 main.js 中添加了这两行代码之后，就能直接在组件的 methods 中使用 axios 命令
// Vue.prototype.$ajax = axios    使用的就是 $ajax 命令了，还是使用上面的 axios 好（这里只是为了说明学习一下）
```

```JS
// 在 pages.vue 中使用 axios
  methods: {
    //获取每日推荐歌单,函数名不要与 data 中的数据名称重名
    getRecommendEverday() {
      let vm = this;//将 this 保存下来，避免作用域的改变 this 的值，当然用 that 保存也 ok 啦。

      axios.get(`/recommend/resource`, {
          withCredentials: true,
          params: {
            ID: 12345
          }
        })
        .then(function(res) {
          vm.recommendEverdays = res.data.recommend;
        })
        .catch(function(err) {
          console.log(err);
        });
    },
    //获取推荐歌单，函数名不要与 data 中的数据名称重名
    getRecommend() {
      let vm = this;
      axios.get(`/personalized`, {
          withCredentials: true
        })
        .then(function(response) {
          vm.recommends = response.data.result;
        })
        .catch(function(error) {
          console.log(error);
        });
    },
    //  写成箭头函数，就不需要中间变量 vm 来保存实例了，
    getRecommend() {
      axios.get(`/personalized`, {
          withCredentials: true
        })
        .then((response)=>{
          this.recommends = response.data.result;
        })
        .catch((error)=> {
          console.log(error);
        });
    }
  }
```

then 与 catch 这两个回调函数中都有各自独立的作用域（函数作用域），如果直接在里面访问 this，无法访问到 Vue 实例，
3 种弄办法解决问题。

- 方法 ① 就是上面的例子，先将 vue 实例 用 vm 变量保存，这样在 then，catch 中就可以通过访问 vm 得到 vue 实例 this了。
- 方法 ② 这时只要添加一个 .bind(this) 就能解决这个问题
          .then(function(res){
            console.log(this.data)
          }.bind(this))
          .catch(function(error) {
            console.log(error);
          }.bind(this));
- 方法 ③ 用箭头函数咯，不要使用 function 函数。这样就可以在箭头函数中使用 this ，它依然指向 vue 实例。
      function 函数存在 函数作用域，this 表示的是  function 函数坏境，不再是 vue 实例。
      而箭头函数中是存在 词法作用域，箭头函数会 继承 外层函数调用的 this。
      箭头函数中的 this 因为绑定了词法作用域，所以始终指向自身外的第一个 this（由于自身没有声明 this，所以会去作用域链上找 this ），也就是始终等于调用它的函数的 this（以为这个 this 离它最近）
      [ES6 箭头函数的 this](http://es6.ruanyifeng.com/#docs/function#%E7%AE%AD%E5%A4%B4%E5%87%BD%E6%95%B0)
      （1）函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象。
      这可能也是在 vue 的声明周期 还有其他选项不能使用 箭头函数？

### 10.1.2 vuex 封装 aciton 引入法（大型项目使用 vuex）

目前主流的 Vue 项目，都选择 axios 来完成 ajax 请求，而大型项目都会使用 Vuex 来管理数据，这章将结合两者来发送请求。**如果是大型项目才会使用到 vuex ，一般的项目就要给自己添加麻烦了。**

Vuex 的 mutations，从结果上看，
mutations:类似于事件，用于提交 Vuex 中的状态 state
action:   和 mutations 也很类似，主要的区别在于，action 可以包含异步操作，而且可以通过 action 来提交 mutations

另外还有一个重要的区别：
mutations:有一个固有参数 state，接收的是 Vuex 中的 state 对象
action   :也有一个固有参数 context，但是 context 是 state 的父级，包含  state、getters

```JS
// store.js
//Vuex 的仓库是 store.js，将 axios 引入，并在 action 添加新的方法
import Vue from 'Vue'
import Vuex from 'vuex'

// 引入 axios
import axios from 'axios'

Vue.use(Vuex)

const store = new Vuex.Store({
  // 定义状态
  state: {
    test01: {
      name: 'Wise Wrong'
    },
    test02: {
      tell: '12312345678'
    }
  },
  actions: {
    // 封装一个 ajax 方法
    saveForm (context) {
      axios({
        // 这里使用的是配置的方法 创建请求
        method: 'post',
        url: '/user',
        data: context.state.test02
      })
    }
  }
})

export default store
```

```JS
// pages.vue 组件调用
methods: {
  submitForm () {
    this.$store.dispatch('saveForm')
  }
}
//submitForm 是绑定在组件上的一个方法，将触发 saveForm，从而通过 axios 向服务器发送请求
```

注意：即使已经在 main.js 中引入了 axios，并改写了原型链，也无法在 store.js 中直接使用 axios 命令.换言之，这两种方案是相互独立的

### 10.2 上传例子

```HTML
<!-- iview-ui : Upload 组件-->
<template>
    <div>
        <Upload
            :before-upload="handleUpload"
            action="//jsonplaceholder.typicode.com/posts/">
            <Button icon="ios-cloud-upload-outline">Select the file to upload</Button>
        </Upload>
        <div v-if="file !== null">Upload file: {{ file.name }} <Button type="text" @click="upload" :loading="loadingStatus">{{ loadingStatus ? 'Uploading' : 'Click to upload' }}</Button></div>
    </div>
</template>
<script>
  export default {
      data () {
          return {
              file: null,
              loadingStatus: false
          }
      },
      methods: {
          handleUpload (file) {
              this.file = file;
              return false;
          },
          upload () {
              this.loadingStatus = true;
              setTimeout(() => {
                  this.file = null;
                  this.loadingStatus = false;
                  this.$Message.success('Success')
              }, 1500);
          }
      }
  }
</script>
```

```HTML
<!-- iview-ui : Upload 组件-->
<template>
  <div>
    <div>
      <Upload :before-upload="handleUpload" action="">
         <Button icon="ios-cloud-upload-outline">请上传实例程序</Button>
      </Upload>
      <div v-if="file!==null">实例名称：{{file.name}}</div>
    </div>
    <Modal
        v-model="model2"
        title="请填写以下字段以增加实例"
        mask
        class-name="vertical-center-modal">
        <Form ref="formValidate2" :model="formValidate2" :rules="ruleValidate2" :label-width="80">
          <FormItem label="实例名称" prop="name">
            <Upload :before-upload="handleUpload" action="">
              <Button icon="ios-cloud-upload-outline">请上传实例程序</Button>
            </Upload>
            <div v-if="file!==null">实例名称：{{file.name}}</div>
          </FormItem>
          <FormItem label="类型" prop="type">
            <Select v-model="formValidate2.type" style="width:100%" placeholder="请选择类型">
              <Option v-for="item in type" :value="item.value" :key="item.value">{{ item.label }}</Option>
            </Select>
          </FormItem>
        </Form>
        <div slot="footer">
          <Button @click.native="cancel2">取消</Button>
          <Button type="primary" @click.native="ok2('formValidate2')" :loading="loading">确定</Button>
        </div>
      </Modal>
  </div>
</template>
<script>
  export default {
    data () {
        return {
          file: null,
          loadingStatus = false
        }
    },
    methods: {
      handleUpload(file) {
        this.file = file
        return false
      },
      ok2(name) {
        this.loading = true
        this.$refs[name].validate((valid) => {
          if (valid) {
            let formData = new FormData();
            formData.append('exec', this.file);
            formData.append('type', this.formValidate2.type);

            axios({
              url: 'http://hete-api.gofoer.com/v1/exec',// 上传的地址
              method: 'post',
              headers: {'content-type': 'multipart/form-data'},
              data: formData
            }).then((res) => {
              console.log(res.data)
              if (res.data.code === 200) {
                this.$Message.success('添加成功！');
                this.loading = false
              } else {
                this.$Message.error(res.data.message);
                this.loading = false
              }
            }).catch((err) => {
              this.$Message.error(err.data.message);
              this.loading = false
            })
            this.model2 = false
          } else {
            this.$Message.info('请填写完整！');
            this.loading = false
          }
        })
      },
      upload () {
        this.loadingStatus = true;
        setTimeout(() => {
            this.file = null;
            this.loadingStatus = false;
            this.$Message.success('Success')
        }, 1500);
      }
    }
  }
</script>
```

```HTML
<!-- iview ：Button 自定义上传 -->
<template>
  <Button type="info" icon="md-cloud-upload" @click="handleUpload" size="large">
    上传
    <input type="file" ref="btnFile" style="display:none" @change="handleUpload">
  </Button>
</template>
<script>
 export default {
  methods: {
    // 上传文件，触发事件， event
    handleUpload(event) {
      if (!event.isTrusted) {
        return;
      }
      if (event.type === "change") {
        //选择了文件
        if (event.target.files.length !== 1) {// 这里的条件是明确表示一次只能上传一个文件。
          this.$Message.warning('只能选择一个文件');
          return
        }
        store.dispatch('CHANGE_SHOW_LOADING', true);// 上传的转圈，可以自己用其他好理解的方式写
        // 下面是上传请求
        axios({
          url: apiRoot + '/form?type=file',
          method:'post',
          contentType: 'multipart/form-data',
          data: {
            file: event.target.files[0]// 事件 event event.target 下有一个 files 数组，可以获取相应的文件。
          }
        }).then(() => {
          this.$Message.success('上传成功！');
        }).catch((error)=>{
          this.$Message.error(`上传失败！${error.response.data.message}`);
        }).finally(()=>{
          store.dispatch('CHANGE_SHOW_LOADING', false);// 上传的转圈，可以自己用其他好理解的方式写
        });
        this.uploadFilesOffline(event.target.files.name)
      } else {
        //点击了上传
        let target = this.$refs.btnFile;// 获取输入框 DOM 节点 赋值给 target
        target.files = null;// 文件指空
        target.value = null;// 值 指空
        target.click();// 这里是干嘛的？？？？
        target = null; //指空，防止BOM内存泄露
      }
```

### 10.3 下载例子

![文件流](https://user-gold-cdn.xitu.io/2018/10/17/16680f13447e4d8c?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

```JS
export function apiDownloadFiles(fielId) {
  return axios({
    url: `/document/${fielId}`,
    method: 'get',
    responseType: 'blob'//下载的时候设置 responseType 为 blob,看后端返回的接口
  })
}
// 上面的函数获取到的是一个 文件流，文件流，如上图
// 将获取到的文件流，处理成文件
apiDownloadFiles(file.id).then(res => {
  if (res.data.type === "application/json") {// 一定是这个 json 格式？？？？这个对么？？？？
    this.$message({
      type: "error",
      message: "下载失败，文件不存在或权限不足"
    });
  } else {
    let blob = new Blob([res.data]);
    if (window.navigator.msSaveOrOpenBlob) {
      navigator.msSaveBlob(blob, file.fileName);
    } else {
      let link = document.createElement("a");
      let evt = document.createEvent("HTMLEvents");
      evt.initEvent("click", false, false);
      link.href = URL.createObjectURL(blob); 
      link.download = file.fileName;
      link.style.display = "none";
      document.body.appendChild(link);
      link.click();
      window.URL.revokeObjectURL(link.href);
    }
  }
});
```

上面写成这样我们熟悉的样式

```JS
methods:{
  downLoad(fielId){
    axios({
      url: `/document/${fielId}`,
      method: 'get',
      responseType: 'blob'//下载的时候设置 responseType 为 blob,看后端返回的接口
    }).then(res => {
      if (res.data.type === "application/json") {// 一定是这个 json 格式？？？？这个对么？？？？
        this.$message({
          type: "error",
          message: "下载失败，文件不存在或权限不足"
        });
      } else {
        let blob = new Blob([res.data]);
        if (window.navigator.msSaveOrOpenBlob) {
          navigator.msSaveBlob(blob, file.fileName);
        } else {
          let link = document.createElement("a");
          let evt = document.createEvent("HTMLEvents");
          evt.initEvent("click", false, false);
          link.href = URL.createObjectURL(blob); 
          link.download = file.fileName;
          link.style.display = "none";
          document.body.appendChild(link);
          link.click();
          window.URL.revokeObjectURL(link.href);
        }
      }
    })
  }
}
```