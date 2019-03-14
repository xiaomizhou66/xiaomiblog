---
title: API 接口
date: '2018/8/18 21:57:28'
categories:
  - ⑦ 小程序
  - MINA 框架
updated:
tags:
comments:
---

## 一、前言

API 是微信小程序的 API 接口，原生 MINA 框架下 API 接口都是在 wx 这个对象上，在 wepy 框架使用的是 wepy 对象，因为 wepy 对象继承了 wx 对象的所有属性与方法。

并且 wepy 还优化了 wx 的某些个方法。具体看 wepy-cli 的框架中的 API

## 二、网络

### 2.1 下载

#### 2.1.1 wx.downloadFile 下载文件资源到本地。

客户端直接发起一个 HTTPS GET 请求，返回文件的本地临时路径。使用前请注意阅读相关 [使用说明](https://developers.weixin.qq.com/miniprogram/dev/framework/ability/network.html)。

注意：请在服务端响应的 header 中指定合理的 Content-Type 字段，以保证客户端正确处理文件类型。

```JS
// 返回值是一个  DownloadTask 实例 对象：一个可以监听下载进度变化事件和取消下载的对象
const downloadTask = wx.downloadFile({
  url: 'https://example.com/audio/123', //下载资源的 url    必填
  header:{},//HTTP 请求的 Header，Header 中不能设置 Referer   否
  filePath:'',//指定文件下载后存储的路径  否
  success (res) {
    // 只要服务器有响应数据，就会把响应内容写入文件并进入 success 回调，业务需要自行判断是否下载到了想要的内容
    //res.statusCode // number开发者服务器返回的 HTTP 状态码
    //res.tempFilePath//string 临时文件路径。如果没传入 filePath 指定文件存储路径，则下载后的文件会存储到一个临时文件
    if (res.statusCode === 200) {
      wx.playVoice({
        filePath: res.tempFilePath
      })
    }
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})
```

#### 2.1.1 DownloadTask.abort（） 中断下载任务  无参数

语法：

```JS
const downloadTask = wx.downloadFile({....})
downloadTask.abort()
```

#### 2.1.1 DownloadTask.offHeadersReceived 取消监听 HTTP Response Header 事件。会比请求完成事件更早

```JS
const downloadTask = wx.downloadFile({....})
downloadTask.offHeadersReceived(()=>{
  //function callback
  //HTTP Response Header 事件的回调函数
})
```

#### 2.1.1 DownloadTask.offProgressUpdate 取消监听下载进度变化事件

```JS
const downloadTask = wx.downloadFile({....})
downloadTask.offProgressUpdate(()=>{
  //function callback
})
```

#### 2.1.1 DownloadTask.onHeadersReceived 监听 HTTP Response Header 事件。会比请求完成事件更早

```JS
const downloadTask = wx.downloadFile({....})
downloadTask.onHeadersReceived((res)=>{
  //function callback
  //res.header:obj 开发者服务器返回的 HTTP Response Header
  /* {
    //
  } */
})
```

#### 2.1.1 DownloadTask.onProgressUpdate 监听下载进度变化事件

```JS
const downloadTask = wx.downloadFile({....})
downloadTask.onProgressUpdate((res)=>{
  res.progress//80,                 //下载进度百分比
  res.totalBytesWritten//1024,      //已经下载的数据长度，单位 Bytes
  res.totalBytesExpectedToWrite//5000,//预期需要下载的数据总长度，单位 Bytes
})
```

### 2.2 mDNS 服务器/IP 使用

在局域网内，你要通过一台主机和其他主机进行通信，你需要知道对方的 ip 地址，但是有些时候，你并不知道对方的 ip 地址，因为一般使用 DHCP 动态分配 ip 地址的局域网内，各个主机的 IP 地址是由 DHCP 服务器来帮你分配 IP 地址的。所以在很多情况下，你要知道对方的 IP 地址是比较麻烦的。

mDNS 的工作原理：
首先，在 IP 协议里规定了一些保留地址，其中有一个是 224.0.0.251，对应的 IPv6 地址是 [FF02::FB]。mDNS 协议规定了一个端口，5353。mDNS 基于 UDP 协议。

每个进入局域网的主机，如果开启了 mDNS 服务的话，都会向局域网内的所有主机组播一个消息，我是谁，和我的 IP 地址是多少。然后其他也有该服务的主机就会响应，也会告诉你，它是谁，它的 IP 地址是多少。

#### 2.2.1 wx.offLocalServiceDiscoveryStop 取消监听 mDNS 服务停止搜索的事件

```JS
wx.offLocalServiceDiscoveryStop(()=>{
  //mDNS 服务停止搜索的事件的回调函数
})
```

#### 2.2.1 wx.offLocalServiceFound 取消监听 mDNS 服务发现的事件

```JS
wx.offLocalServiceFound(()=>{
  //mDNS 服务发现的事件的回调函数
})
```

#### 2.2.1 wx.offLocalServiceLost 取消监听 mDNS 服务离开的事件

```JS
wx.offLocalServiceLost(()=>{
  //mDNS 服务离开的事件的回调函数
})
```

#### 2.2.1 wx.offLocalServiceResolveFail 取消监听 mDNS 服务解析失败的事件

```JS
wx.offLocalServiceResolveFail(()=>{
  //mDNS 服务解析失败的事件的回调函数
})
```

#### 2.2.1 wx.onLocalServiceDiscoveryStop 监听 mDNS 服务停止搜索的事件

```JS
wx.onLocalServiceDiscoveryStop(()=>{
  //mDNS 服务停止搜索的事件的回调函数
})
```

#### 2.2.1 wx.onLocalServiceFound 监听 mDNS 服务发现的事件

```JS
wx.onLocalServiceFound((res)=>{
  //mDNS 服务发现的事件的回调函数
  res.serviceType:'',//服务的类型
  res.serviceName:'',//服务的名称
  res.ip:'',//服务的 ip 地址
  res.port:8080//服务的端口
})
```

#### 2.2.1 wx.onLocalServiceLost 监听 mDNS 服务离开的事件

```JS
wx.onLocalServiceLost((res)=>{
  //mDNS 服务离开的事件的回调函数
  res.serviceType:'',//服务的类型
  res.serviceName:''//服务的名称
})
```

#### 2.2.1 wx.onLocalServiceResolveFail 监听 mDNS 服务解析失败的事件

```JS
wx.onLocalServiceResolveFail((res)=>{
  //mDNS 服务解析失败的事件的回调函数
  res.serviceType:'',//服务的类型
  res.serviceName:''//服务的名称
})
```

#### 2.2.1 wx.startLocalServiceDiscovery 开始搜索局域网下的 mDNS 服务。搜索的结果会通过 wx.onLocalService* 事件返回。

```JS
wx.startLocalServiceDiscovery({
  //// 当前手机所连的局域网下有一个 _http._tcp. 类型的服务
  serviceType:'_http._tcp.',//string 服务的类型  必填
  success(){
    //
  },
  fail(res){
    //
    console.log(res.errMsg) // string 错误信息
    //值为：'invalid param'      表示： serviceType 为空
    //值为：'scan task already exist'
    //表示：在当前 startLocalServiceDiscovery 发起的搜索未停止的情况下，再次调用 startLocalServiceDiscovery
  },
  complete(){
    //
  })
```

注意

- wx.startLocalServiceDiscovery 是一个消耗性能的行为，开始 30 秒后会自动 stop 并执行 wx.onLocalServiceDiscoveryStop 注册的回调函数。
- 在调用 wx.startLocalServiceDiscovery 后，在这次搜索行为停止后才能发起下次 wx.startLocalServiceDiscovery。停止本次搜索行为的操作包括调用 wx.stopLocalServiceDiscovery 和 30 秒后系统自动 stop 本次搜索。

#### 2.2.1 wx.stopLocalServiceDiscovery 停止搜索 mDNS 服务

```JS
wx.stopLocalServiceDiscovery({
  //// 当前手机所连的局域网下有一个 _http._tcp. 类型的服务
  serviceType:'_http._tcp.',//string 服务的类型  必填
  success(){
    //
  },
  fail(res){
    //
    console.log(res.errMsg) // 得到值为：'task not found' 说明：在当前没有处在搜索服务中的情况下调用 stopLocalServiceDiscovery
  },
  complete(){
    //
  })
```

### 2.3 发起请求 （请求后端数据）

[网络](https://developers.weixin.qq.com/miniprogram/dev/framework/ability/network.html)

#### 2.3.1 wx.request 发起 HTTPS 网络请求。

```JS
// 返回一个 请求任务对象
const request = wx.request({
  url: 'test.php', //仅为示例，并非真实的接口地址  开发者服务器接口地址  必填
  data: {    // data ：string/object/ArrayBuffer 请求的参数           否
    x: '',// 可以是字符串，可以是对象，可以是 JavaScript 操作二进制数据的一个接口（ArrayBuffer 对象）。
    y: ''
  },
  // 请求头，设置请求的 header， ① header 中不能设置 Referer， ② content-type 默认为 application/json    否
  header: {
    'content-type': 'application/json' // 默认值
  },
  method:'GET',//HTTP 请求方法          默认值为 'GET'                否 ,和法制学习 http 文档，看后端给的文档
  dataType:'json',//返回的数据格式      默认值   'json'               否
  //返回的数据为 JSON 格式，返回后自行会对返回的数据进行一次 JSON.parse，不需要开发者去解析（只有 JSON 格式）
  // 其他格式不对返回的内容进行 JSON.parse
  responseType:'text',//响应的数据类型  默认值   'text'               否
  //① text  响应的数据为文本, ② arraybuffer 响应的数据为 ArrayBuffer
  success (res) {
    console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
    console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
    console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
  },
  // 或者是可以写成下面这样的箭头函数
  // success:(res)=>{
  //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
  //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
  //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
  // }
  fail(res){
    //
  }/* ,
  complete(res){
    //
  } */
})
```

##### 2.3.1.1 ArrayBuffer 对象(就是各种类数组对象)

[ArrayBuffer 对象 网址](http://es6.ruanyifeng.com/#docs/arraybuffer)是 JavaScript 操作二进制数据的一个接口，
代表内存之中的一段二进制数据，可以通过“视图”进行操作。“视图”部署了数组接口，这意味着，可以用数组的方法操作内存。

rrayBuffer 有两种视图，一种是 TypedArray 视图，另一种是 DataView 视图。

```TEXT
目前，TypedArray 视图一共包括 9 种类型，每一种视图都是一种构造函数。

Int8Array：         8 位有符号整数，长度 1 个字节。
Uint8Array：        8 位无符号整数，长度 1 个字节。
Uint8ClampedArray： 8 位无符号整数，长度 1 个字节，溢出处理不同。
Int16Array：        16 位有符号整数，长度 2 个字节。
Uint16Array：       16 位无符号整数，长度 2 个字节。
Int32Array：        32 位有符号整数，长度 4 个字节。
Uint32Array：       32 位无符号整数，长度 4 个字节。
Float32Array：      32 位浮点数，长度 4 个字节。
Float64Array：      64 位浮点数，长度 8 个字节。
```

##### 2.3.1.2 http 文档学习请求头

[请求头 学习](https://liuxmoo.com/2018/09/02/1-(3)-24.1-http-rumen/)

##### 2.3.1.3 data 参数说明

最终发送给服务器的数据是 String 类型，如果传入的 data 不是 String 类型，会被转换成 String 。转换规则如下：

- 对于 GET 方法的数据，会将数据转换成 query
    `string（encodeURIComponent(k)=encodeURIComponent(v)&encodeURIComponent(k)=encodeURIComponent(v)...）`
- 对于 POST 方法且 header['content-type'] 为 `application/json` 的数据，会对数据进行 JSON 序列化
- 对于 POST 方法且 header['content-type'] 为 `application/x-www-form-urlencoded` 的数据，会将数据转换成 query string
    `（encodeURIComponent(k)=encodeURIComponent(v)&encodeURIComponent(k)=encodeURIComponent(v)...）

#### 2.3.1 RequestTask.abort 中断请求任务

```JS
const request = wx.request({....})
request.abort() //中断请求，无参数
```

#### 2.3.1 RequestTask.offHeadersReceived 取消监听 HTTP Response Header 事件。会比请求完成事件更早

```JS
const request = wx.request({....})
request.offHeadersReceived(()=>{ //HTTP Response Header 事件的回调函数
  //
})
```

#### 2.3.1 RequestTask.onHeadersReceived 监听 HTTP Response Header 事件。会比请求完成事件更早

```JS
const request = wx.request({....})
request.onHeadersReceived((res)=>{ //HTTP Response Header 事件的回调函数
  //res.header {....} 开发者服务器返回的 HTTP Response Header
})
```

### 2.4 上传

#### 2.4.1 wx.uploadFile 将本地资源上传到服务器。

客户端发起一个 HTTPS POST 请求，其中 content-type 为 multipart/form-data。使用前请注意阅读相关说明。 [使用说明](https://developers.weixin.qq.com/miniprogram/dev/framework/ability/network.html)。

```JS
wx.chooseImage({
  success (res) {
    const tempFilePaths = res.tempFilePaths

    // 返回一个 上传任务对象
    const uploadFile = wx.uploadFile({
      url: 'https://example.weixin.qq.com/upload', //仅为示例，非真实的接口地址 开发者服务器地址   必填
      filePath: tempFilePaths[0],// 要上传文件资源的路径       必填
      name: 'file',   //文件对应的 key，开发者在服务端可以通过这个 key 获取文件的二进制内容   必填
      // 请求头，设置请求的 header， ① header 中不能设置 Referer， ② content-type 默认为 application/json    否
      header: {                                              // 否
        'content-type': 'application/json' // 默认值
      },
      formData: {          //HTTP 请求中其他额外的 form data    否
        'user': 'test'
      },
      success (res){
        const data = res.data
        console.log(res.data)//''  开发者服务器返回的数据
        console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
      },
    // 或者是可以写成下面这样的箭头函数
    // success:(res)=>{
    //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
    //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
    //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
    // }
      fail(res){
        //
      }/* ,
      complete(res){
        //
      } */
    })
  }
})
```

#### 2.4.2 UploadTask.abort 中断上传任务

```JS
const uploadFile = wx.uploadFile({....})
uploadFile.abort() //中断上传任务，无参数
```

#### 2.4.3 UploadTask.offHeadersReceived 取消监听 HTTP Response Header 事件。会比请求完成事件更早

```JS
const uploadFile = wx.uploadFile({....})
uploadFile.offHeadersReceived(()=>{ //HTTP Response Header 事件的回调函数
  //
})
```

#### 2.4.4 UploadTask.offProgressUpdate 取消监听上传进度变化事件

```JS
const uploadFile = wx.uploadFile({....})
uploadFile.offProgressUpdate(()=>{ //上传进度变化事件的回调函数
  //
})
```

#### 2.4.5 UploadTask.onHeadersReceived 监听 HTTP Response Header 事件。会比请求完成事件更早

```JS
const uploadFile = wx.uploadFile({....})
uploadFile.onHeadersReceived((res)=>{ //HTTP Response Header 事件的回调函数
  //res.header {....} 开发者服务器返回的 HTTP Response Header
})
```

#### 2.4.6 UploadTask.onProgressUpdate 监听上传进度变化事件

```JS
const uploadFile = wx.uploadFile({....})
uploadFile.onHeadersReceived((res)=>{ //上传进度变化事件的回调函数
  res.progress                //80 上传进度百分比
  res.totalBytesSent          //80 已经上传的数据长度，单位 Bytes
  res.totalBytesExpectedToSend//200 预期需要上传的数据总长度，单位 Bytes
})
```

### 2.5 WebSocket

**并发数**

1.7.0 及以上版本，最多可以同时存在 5（小游戏）/2（小程序）个 WebSocket 连接。
1.7.0 以下版本，一个小程序同时只能有一个 WebSocket 连接，如果当前已存在一个 WebSocket 连接，会自动关闭该连接，并重新创建一个 WebSocket 连接。

- wx.connectSocket     创建一个 WebSocket 连接。
- wx.onSocketOpen      监听 WebSocket 连接打开事件
- wx.closeSocket       关闭 WebSocket 连接，需要先用wx.onSocketOpen 监听 WebSocket 连接打开事件，才能关闭
- wx.onSocketClose     监听 WebSocket 连接关闭事件
- wx.onSocketError     监听 WebSocket 错误事件
- wx.onSocketMessage   监听 WebSocket 接受到服务器的消息事件
- wx.sendSocketMessage 通过 WebSocket 连接发送数据。需要先 wx.connectSocket，并在 wx.onSocketOpen 回调之后才能发送。

使用前请注意阅读相关说明。[网络使用说明](https://developers.weixin.qq.com/miniprogram/dev/framework/ability/network.html)。

```JS
const socketOpen = false
const socketMsgQueue = []
// ① 返回一个 WebSocket 任务
const socketTask = wx.connectSocket({
  url: 'wss://example.qq.com',  //开发者服务器 wss 接口地址   必填
  data:{                        // 这个好像官网没有说啊？？？？官网写的文档有问题的啊？？？所以别的的接口应该也是可以传参的把？？？
    x: '',// 比如 navigateBack 没有写传参，我想应该也是可以传参的？？？？？？
    y: ''
  },
  header:{                      //HTTP Header，Header 中不能设置 Referer   否
    'content-type': 'application/json'
  },
  protocols: ['protocol1'],   //子协议数组                      否
  method:"GET",//这个好像官网没有说啊？？？？  
  success(){
    //
  },
    // 或者是可以写成下面这样的箭头函数
    // success:(res)=>{
    //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
    //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
    //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
    // }
  fail(){
    //
  }/* ,
  complete(){
    //
  } */
})

//注意这里有时序问题，
//如果 wx.connectSocket 还没回调 wx.onSocketOpen，而先调用 wx.closeSocket，那么就做不到关闭 WebSocket 的目的。
//必须在 WebSocket 打开期间调用 wx.closeSocket 才能关闭。
// ② 监测 是否是链接状态
wx.onSocketOpen((res)=> {
    //res.header//object  连接成功的 HTTP 响应 Header 2.0.0
  socketOpen = true
  for (let i = 0; i < socketMsgQueue.length; i++){
    //sendSocketMessage(socketMsgQueue[i]) 当然可以把这段写到外面的 作为一个函数调用
    if (socketOpen) {
      //通过 WebSocket 连接发送数据。需要先 wx.connectSocket，并在 wx.onSocketOpen 回调之后才能发送。也是时序的问题
      wx.sendSocketMessage({
        data:msg,// string/ArrayBuffer  需要发送的内容   必填
        success(){},//
            // 或者是可以写成下面这样的箭头函数
        // success:(res)=>{
        //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
        //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
        //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
        // }
        fail(){},//
        complete(){}
      })
    } else {
      socketMsgQueue.push(msg)
    }
  }
  socketMsgQueue = []
  wx.closeSocket({
    code:1000,//一个数字值表示关闭连接的状态号，表示连接被关闭的原因。 默认值 1000，表示正常关闭连接  否
    reason:'',//一个可读的字符串，表示连接被关闭的原因。这个字符串必须是不长于 123 字节的 UTF-8 文本（不是字符） 否
    success(){},
    // 或者是可以写成下面这样的箭头函数
    // success:(res)=>{
    //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
    //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
    //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
    // }
    fail(){},
    complete(){}
  })
})

wx.onSocketClose((res)=> {
  console.log('WebSocket 已关闭！')
})


//下面这两个是应该写在这里的么？？？正确的应该是怎么样的


wx.onSocketError((res)=>{
  //WebSocket 错误事件的回调函数
  res.errMsg//''错误信息
})
wx.onSocketMessage((res)=>{
  res.data//string/ArrayBuffer  服务器返回的消息
  //WebSocket 接受到服务器的消息事件的回调函数
})
```

#### 2.5.4 SocketTask.close，SocketTask.onClose，SocketTask.onError，SocketTask.onMessage，SocketTask.onOpen，SocketTask.send

这里就是使用实例的方法来 监控操作 SocketTask 对象，不是使用 API 接口咯。功能与 wx 对象的方法是一样的。

```JS
const socketOpen = false
const socketMsgQueue = []

// ① 创建/返回一个 WebSocket 任务
const socketTask = wx.connectSocket({
  url: 'wss://example.qq.com',  //开发者服务器 wss 接口地址   必填
  data:{                        // 这个好像官网没有说啊？？？？官网写的文档有问题的啊？？？所以别的的接口应该也是可以传参的把？？？
    x: '',// 比如 navigateBack 没有写传参，我想应该也是可以传参的？？？？？？
    y: ''
  },
  header:{                      //HTTP Header，Header 中不能设置 Referer   否
    'content-type': 'application/json'
  },
  protocols: ['protocol1'],   //子协议数组                      否
  method:"GET",//这个好像官网没有说啊？？？？  
  success(){
    //
  },
    // 或者是可以写成下面这样的箭头函数
    // success:(res)=>{
    //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
    //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
    //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
    // }
  fail(){
    //
  }/* ,
  complete(){
    //
  } */
})

//注意这里有时序问题，
//如果 wx.connectSocket 还没回调 wx.onSocketOpen，而先调用 wx.closeSocket，那么就做不到关闭 WebSocket 的目的。
//必须在 WebSocket 打开期间调用 wx.closeSocket 才能关闭。
// ② 监测 是否是链接状态
//wx.onSocketOpen((res)=> {}) 上面的 API 是使用 wx.xxxx 这里换成 socketTask.xxxx  实例对象的 方法
socketTask.onOpen((res)=>{
  //res.header//object  连接成功的 HTTP 响应 Header 2.0.0
  socketOpen = true
  for (let i = 0; i < socketMsgQueue.length; i++){
    //sendSocketMessage(socketMsgQueue[i]) 当然可以把这段写到外面的 作为一个函数调用
    if (socketOpen) {
      //通过 WebSocket 连接发送数据。需要先 wx.connectSocket，并在 wx.onSocketOpen 回调之后才能发送。也是时序的问题
      socketTask.send({
        data:msg,// string/ArrayBuffer  需要发送的内容   必填
        success(){},//
            // 或者是可以写成下面这样的箭头函数
            // success:(res)=>{
            //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
            //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
            //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
            // }
        fail(){},//
        complete(){}
      })
    } else {
      socketMsgQueue.push(msg)
    }
  }
  socketMsgQueue = []
  socketTask.close({
    code:1000,//一个数字值表示关闭连接的状态号，表示连接被关闭的原因。 默认值 1000，表示正常关闭连接  否
    reason:'',//一个可读的字符串，表示连接被关闭的原因。这个字符串必须是不长于 123 字节的 UTF-8 文本（不是字符） 否
    success(){},
    // 或者是可以写成下面这样的箭头函数
    // success:(res)=>{
    //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
    //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
    //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
    // }
    fail(){},
    complete(){}
  })
})

wx.onClose((res)=> {
  console.log('WebSocket 已关闭！')
})


//下面这两个是应该写在这里的么？？？正确的应该是怎么样的

wx.onError((res)=>{
  //WebSocket 错误事件的回调函数
  res.errMsg//''错误信息
})
wx.onMessage((res)=>{
  res.data//string/ArrayBuffer  服务器返回的消息
  //WebSocket 接受到服务器的消息事件的回调函数
})
```

## 三、媒体

### 3.1 音频 AudioContext  对象 （是单个组件的音频对象？？？？？）

#### 3.1.1 wx.createAudioContext  创建音频对象

创建 音频 audio 上下文 AudioContext 对象。（返回一个 AudioContext 对象

```HTML
<audio poster="{{poster}}" name="{{name}}" author="{{author}}" src="{{src}}" id="myAudio" controls loop></audio>
<button type="primary" bindtap="audioPlay">播放</button>
<button type="primary" bindtap="audioPause">暂停</button>
<button type="primary" bindtap="audio14">设置当前播放时间为14秒</button>
<button type="primary" bindtap="audioStart">回到开头</button>
```

```JS
wx.createAudioContext('myAudio',this)// this ：在自定义组件下，当前组件实例的this，以操作组件内 <audio> 组件 是可选参数
```

#### 3.1.2 wx.getAvailableAudioSources 获取当前支持的音频输入源

```JS
wx.getAvailableAudioSources({
  success(res){
    //res.audioSources:['']//支持的音频输入源列表，可在 RecorderManager.start() 接口中使用。
  },
    // 或者是可以写成下面这样的箭头函数
    // success:(res)=>{
    //   console.log(res.data)//string/Object/Arraybuffer  开发者服务器返回的数据
    //   console.log(res.statusCode)//200 开发者服务器返回的 HTTP 状态码
    //   console.log(res.header)//{} 开发者服务器返回的 HTTP Response Header
    // }
  fail(res){
  },//
  complete(res){}//
})
```

[返回值定义参考](https://developer.android.com/reference/kotlin/android/media/MediaRecorder.AudioSource)
res.audioSources 的合法值

- auto        自动设置，默认使用手机麦克风，插上耳麦后自动切换使用耳机麦克风，所有平台适用
- buildInMic  手机麦克风，仅限 iOS
- headsetMic  耳机麦克风，仅限 iOS
- mic         麦克风（没插耳麦时是手机麦克风，插耳麦时是耳机麦克风），仅限 Android
- camcorder   同 mic，适用于录制音视频内容，仅限 Android
- voice_communication   同 mic，适用于实时沟通，仅限 Android
- voice_recognition     同 mic，适用于语音识别，仅限 Android

#### 3.1.3 wx.playVoice、wx.pauseVoice、wx.stopVoice 暂停/播放/停止 正在播放的语音

- wx.playVoice
    开始播放语音。同时只允许一个语音文件正在播放，如果前一个语音文件还没播放完，将中断前一个语音播放。
- wx.pauseVoice:
    暂停正在播放的语音。再次调用 wx.playVoice **播放同一个文件时，会从暂停处开始播放**。如果想从头开始播放，需要先调用 wx.stopVoice。
- wx.stopVoice
    结束播放语音。下次播放同一个文件，也只会从头开始播放。

```JS
//wx.startRecord 开始录音
wx.startRecord({
  success (res) {
    const tempFilePath = res.tempFilePath
    //暂停正在播放的语音
    wx.playVoice({
      filePath: tempFilePath,//string 需要播放的语音文件的文件路径            必填
      duration:60,//指定录音时长，到达指定的录音时长后会自动停止录音，单位：秒   否     默认值 60
      success(res){},//否
      fail(){},//否
      /* complete(){} */ // 成功与失败都会执行
    })

    // 为什么这里用 延迟执行？？？？？？
    setTimeout(() => {
      wx.pauseVoice({
        success(res){},//否
        fail(){},//否
        /* complete(){} */ // 成功与失败都会执行
      })
      // 暂停或者是停止
      wx.stopVoice({
        success(res){},//否
        fail(){},//否
        /* complete(){} */ // 成功与失败都会执行
      })
    }, 5000)
  }
})
```

#### 3.1.4  AudioContext 音频对象的方法

AudioContext.pause、 AudioContext.play、AudioContext.seek、AudioContext.setSrc

对象的方法，与上面的 wx 接口的方法功能一样的。

- AudioContext.pause   暂停音频
- AudioContext.play    播放音频
- AudioContext.seek    跳转到指定位置
- AudioContext.setSrc  设置音频地址

```JS
<!-- audio.wxml -->
<audio  src="{{src}}" id="myAudio" ></audio>
<button type="primary" bindtap="audioPlay">播放</button>
<button type="primary" bindtap="audioPause">暂停</button>
<button type="primary" bindtap="audio14">设置当前播放时间为14秒</button>
<button type="primary" bindtap="audioStart">回到开头</button>
// audio.js
Page({
  onReady (e) {
    // 使用 wx.createAudioContext 获取 audio 上下文 context
    // 创建音频对象   wx.createAudioContext('idNamd',this)
    this.audioCtx = wx.createAudioContext('myAudio')
    // 设置音频地址 AudioContext.setSrc('url')
    this.audioCtx.setSrc('http://ws.stream.qqmusic.qq.com/M500001VfvsJ21xFqb.mp3?guid=ffffffff82def4af4b12b3cd9337d5e7&uin=346897220&vkey=6292F51E1E384E06DCBDC9AB7C49FD713D632D313AC4858BACB8DDD29067D3C601481D36E62053BF8DFEAF74C0A5CCFADD6471160CAF3E6A&fromtag=46')
    this.audioCtx.play()// 播放音频 无参数
  },
  data: {
    src: ''
  },
  audioPlay () {
    this.audioCtx.play()// 播放音频 无参数
  },
  audioPause () {
    this.audioCtx.pause()// 暂停音频 无参数
  },
  audio14 () {
    this.audioCtx.seek(14)// 跳转位置，单位 s   AudioContext.seek(number) 跳转到几秒的时间播放
  },
  audioStart () {
    this.audioCtx.seek(0) //从头开始播放
  }
})
```

### 3.2 音频 InnerAudioContext  对象 （是整个小程序的音频对象？？？？？）

#### 3.2.1 wx.createInnerAudioContext   创建 内部音频对象

创建 内部音频 audio 上下文 InnerAudioContext 对象。（返回一个 内部 InnerAudioContext 对象）

```JS
wx.createInnerAudioContext() //无参数
```

#### 3.2.2 wx.setInnerAudioOption 设置 InnerAudioContext 的播放选项。设置之后对当前小程序全局生效。

```JS
wx.setInnerAudioOption({
  mixWithOther:true,//是否与其他音频混播，设置为 true 之后，不会终止其他应用或微信内的音乐  否  默认值为 true
  obeyMuteSwitch:true,//（仅在 iOS 生效）是否遵循静音开关，设置为 false 之后，即使是在静音模式下，也能播放声音  否  默认值为 true
  success(res){},//否
  fail(){},//否
  /* complete(){} */ // 成功与失败都会执行
})
```

#### 3.2.3 内部音频对象的方法

- InnerAudioContext.destroy    销毁当前实例    无参数
- InnerAudioContext.offCanplay 取消监听音频进入可以播放状态的事件。但不保证后面可以流畅播放 回调函数
- InnerAudioContext.offEnded   取消监听音频自然播放至结束的事件   回调函数
- InnerAudioContext.offError   取消监听音频播放错误事件          回调函数
- InnerAudioContext.offPause   取消监听音频暂停事件            回调函数
- InnerAudioContext.offPlay   取消监听音频播放事件             回调函数
- InnerAudioContext.offSeeked  取消监听音频完成跳转操作的事件   回调函数
- InnerAudioContext.offSeeking  取消监听音频进行跳转操作的事件   回调函数
- InnerAudioContext.offStop    取消监听音频停止事件              回调函数
- InnerAudioContext.offTimeUpdate  取消监听音频播放进度更新事件
- InnerAudioContext.offWaiting    取消监听音频加载中事件。当音频因为数据不足，需要停下来加载时会触发  回调函数
- InnerAudioContext.onCanplay   监听音频进入可以播放状态的事件。但不保证后面可以流畅播放    回调函数
- InnerAudioContext.onEnded     监听音频自然播放至结束的事件   回调函数
- InnerAudioContext.onError     监听音频播放错误事件    回调函数
    audioContext.onError(()=>{
      res.errCode//
        10001 系统错误
        10002 网络错误
        10003 文件错误
        10004 格式错误
        -1    未知错误
    })
- InnerAudioContext.onPause   监听音频暂停事件                        回调函数
- InnerAudioContext.onPlay    监听音频播放事件                        回调函数
- InnerAudioContext.onSeeked  监听音频完成跳转操作的事件              回调函数
- InnerAudioContext.onSeeking  监听音频进行跳转操作的事件             回调函数
- InnerAudioContext.onStop    监听音频停止事件                        回调函数
- InnerAudioContext.onTimeUpdate  监听音频播放进度更新事件             回调函数
- InnerAudioContext.onWaiting  监听音频加载中事件。当音频因为数据不足，需要停下来加载时会触发  回调函数
- InnerAudioContext.pause     暂停。暂停后的音频再播放会从暂停处开始播放  无参数
- InnerAudioContext.play      播放                                    无参数
- InnerAudioContext.seek     跳转到指定位置                            参数为 s
- InnerAudioContext.stop     停止。停止后的音频再播放会从头开始播放。     无参数

```JS
const innerAudioContext = wx.createInnerAudioContext()// ① 创建内部 音频对象 返回值赋值给 innerAudioContext  对象
innerAudioContext.autoplay = true // data 数据
innerAudioContext.src = 'http://ws.stream.qqmusic.qq.com/M500001VfvsJ21xFqb.mp3?guid=ffffffff82def4af4b12b3cd9337d5e7&uin=346897220&vkey=6292F51E1E384E061FF02C31F716658E5C81F5594D561F2E88B854E81CAAB7806D5E4F103E55D33C16F3FAC506D1AB172DE8600B37E43FAD&fromtag=46' // data 数据
innerAudioContext.onPlay(() => {//② 监听音频 播放音频
  console.log('开始播放')
})
innerAudioContext.onError((res) => {//③ 监听 音频回调错误  输出错误信息
  console.log(res.errMsg)//这个有么？？？
  console.log(res.errCode)
})
```

### 3.3 背景音频 BackgroundAudioManager 对象 （背景音频对象）

#### 3.3.1 创建 背景音频 BackgroundAudioManager 对象

```JS
wx.getBackgroundAudioManager()  //无参数
```

获取全局唯一的背景音频管理器。 小程序切入后台，如果音频处于播放状态，可以继续播放。但是后台状态不能通过调用API操纵音频的播放状态。

从微信客户端6.7.2版本开始，若需要在小程序切后台后继续播放音频，需要在 app.json 中配置 requiredBackgroundModes 属性。开发版和体验版上可以直接生效，正式版还需通过审核。

#### 3.3.2 背景音频 BackgroundAudioManager 对象  wx.API 接口方法

- wx.getBackgroundAudioPlayerState 获取后台音乐播放状态  success，fail ，complete 三个回调函数
- wx.onBackgroundAudioPause 监听音乐暂停事件。 回调函数
- wx.onBackgroundAudioPlay  监听音乐播放事件。回调函数
- wx.onBackgroundAudioStop  监听音乐停止事件。回调函数
- wx.pauseBackgroundAudio   暂停播放音乐。 success，fail ，complete 三个回调函数
- wx.playBackgroundAudio   使用后台播放器播放音乐。三个回调函数，还有其他必填与不必填的属性
    对于微信客户端来说，只能同时有一个后台音乐在播放。当用户离开小程序后，音乐将暂停播放；当用户在其他小程序占用了音乐播放器，原有小程序内的音乐将停止播放。
- wx.seekBackgroundAudio 控制音乐播放进度。三个回调函数，还有个必填的位置属性
- wx.stopBackgroundAudio 停止播放音乐。三个回调函数，

```JS
wx.getBackgroundAudioPlayerState({
  success (res) {
    const status = res.status// number   播放状态   0:暂停中  1:播放中  2：没有音乐播放
    const dataUrl = res.dataUrl//''      歌曲数据链接，只有在音乐播放中时返回
    const currentPosition = res.currentPosition//number  选定音频的播放位置（单位：s），只有在音乐播放中时返回
    const duration = res.duration//number  选定音频的长度（单位：s），只有在音乐播放中时返回
    const downloadPercent = res.downloadPercent//number 音频的下载进度百分比，只有在音乐播放中时返回
  },
  fail(res){},
  complete(res){}
})

wx.pauseBackgroundAudio({
  success (res) {},
  fail(res){},
  complete(res){}
})

wx.playBackgroundAudio({
  dataUrl: '',//音乐链接，目前支持的格式有 m4a, aac, mp3, wav   必填
  title: '',//音乐标题  否
  coverImgUrl: '',//封面URL 否
  success (res) {},
  fail(res){},
  complete(res){}
})

wx.seekBackgroundAudio({
  position: 30,//s
  success (res) {},
  fail(res){},
  complete(res){}
})

wx.stopBackgroundAudio({
  success (res) {},
  fail(res){},
  complete(res){}
})
```

#### 3.3.2 背景音频 BackgroundAudioManager 对象  的方法

- .onCanplay 监听背景音频进入可播放状态事件。但不保证后面可以流畅播放      回调函数
- .onEnded   监听背景音频自然播放结束事件                                回调函数
- .onError   监听背景音频播放错误事件                                    回调函数
- .onNext    监听用户在系统音乐播放面板点击下一曲事件（仅iOS）             回调函数
- .onPause   监听背景音频暂停事件                                        回调函数
- .onPlay    监听背景音频播放事件                                         回调函数
- .onPrev    监听用户在系统音乐播放面板点击上一曲事件（仅iOS）               回调函数
- .onSeeked  监听背景音频完成跳转操作事件                                   回调函数
- .onSeeking 监听背景音频开始跳转操作事件                                   回调函数
- .onStop    监听背景音频停止事件                                          回调函数
- .onTimeUpdate 监听背景音频播放进度更新事件                                回调函数
- .onWaiting    监听音频加载中事件。当音频因为数据不足，需要停下来加载时会触发 回调函数
- .pause   暂停音乐  无参数
                    错误码 10001  系统错误
                          10002   网络错误
                          10003   文件错误
                          10004   格式错误
                          -1      未知错误
- .play    播放音乐，无参数  ，错误码同 .pause
- .seek    跳转到指定位置  
                    参数：跳转的位置，单位 s。精确到小数点后 3 位，即支持 ms 级别精确度。
                    错误码同 .pause
- .stop    停止音乐 错误码同 .pause

```JS
const backgroundAudioManager = wx.getBackgroundAudioManager()// 创建 背景音频对象 赋值给 backgroundAudioManager 对象

// 设置 data 值
backgroundAudioManager.title = '此时此刻'
backgroundAudioManager.epname = '此时此刻'
backgroundAudioManager.singer = '许巍'
backgroundAudioManager.coverImgUrl = 'http://y.gtimg.cn/music/photo_new/T002R300x300M000003rsKF44GyaSk.jpg?max_age=2592000'
// 设置了 src 之后会自动播放
backgroundAudioManager.src = 'http://ws.stream.qqmusic.qq.com/M500001VfvsJ21xFqb.mp3?guid=ffffffff82def4af4b12b3cd9337d5e7&uin=346897220&vkey=6292F51E1E384E061FF02C31F716658E5C81F5594D561F2E88B854E81CAAB7806D5E4F103E55D33C16F3FAC506D1AB172DE8600B37E43FAD&fromtag=46'

backgroundAudioManager.onCanplay(()=>{....})
backgroundAudioManager.onEnded(()=>{....})

```

### 3.4 相机

#### 3.4.1 wx.createCameraContext 创建 相机上下文对象 [无参数]

```JS
wx.createCameraContext()//无参数
```

#### 3.4.2 CameraContext  相机上下文对象 的方法

- .startRecord 开始录像
- .stopRecord  停止录像
- .takePhoto   拍照

#### 3.4.3 相机完整的代码实例

[效果图]()

```HTML
<view class="page-body">
  <view class="page-body-wrapper">
    <camera device-position="back" flash="off" binderror="error" style="width: 100%; height: 300px;"></camera>

    <view class="btn-area">
      <button type="primary" bindtap="takePhoto">拍照</button>
    </view>
    <view class="btn-area">
      <button type="primary" bindtap="startRecord">开始录像</button>
    </view>
    <view class="btn-area">
      <button type="primary" bindtap="stopRecord">结束录像</button>
    </view>
    <view class="preview-tips">预览</view>
    <image wx:if="{{src}}" mode="widthFix" src="{{src}}"></image>
    <video wx:if="{{videoSrc}}" class="video" src="{{videoSrc}}"></video>
  </view>
</view>
```

```JS
Page({
  onLoad() {
    this.ctx = wx.createCameraContext()// 创建 对象  赋值给  ctx
  },
  takePhoto() {
    this.ctx.takePhoto({
      quality: 'high',//成像质量   否  'high': 高质量   'low':低质量   'normal':普通质量（默认值）
      success: (res) => {
        //res.tempImagePath '' 照片文件的临时路径
        this.setData({
          src: res.tempImagePath
        })
      },
      fail:(res) => {
        //
      },
      complete:(res)=>{..}
    })
  },
  startRecord() {
    this.ctx.startRecord({
      timeoutCallback:(res)=>{
        //超过30s或页面 onHide 时会结束录像   否
        res.tempThumbPath//string 封面图片文件的临时路径
        res.tempVideoPath//string 视频的文件的临时路径
      },
      success: (res) => {
        console.log('startRecord')
      },
      fail:(res) => {
        //
      },
      complete:(res)=>{..}
    })
  },
  stopRecord() {
    this.ctx.stopRecord({
      success: (res) => {
        //res.tempThumbPath//string 封面图片文件的临时路径
        //res.tempVideoPath//string 视频的文件的临时路径
        this.setData({
          src: res.tempThumbPath,
          videoSrc: res.tempVideoPath
        })
      },
      fail:(res) => {
        //
      },
      complete:(res)=>{..}
    })
  },
  error(e) {
    console.log(e.detail)
  }
})
```

```LESS
//page
.preview-tips {
  margin: 20rpx 0;  
}

.video {
  margin: 50px auto;
  width: 100%;
  height: 300px;
}
```

```LESS
//app
page {
  background-color: #F8F8F8;
  height: 100%;
  font-size: 32rpx;
  line-height: 1.6;
}

.page-body {
  padding: 20rpx 0;
}

.page-body-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

.btn-area {
  margin-top: 60rpx;
  box-sizing: border-box;
  width: 100%;
  padding: 0 30rpx;
}
```

### 3.5 字体 wx.loadFontFace 动态加载网络字体。

文件地址需为下载类型。iOS 仅支持 https 格式文件地址。

注意：

- 引入中文字体，体积过大时会发生错误，建议抽离出部分中文，减少体积，或者用图片替代
- 字体链接必须是 https（ios 不支持 http 仅支持 https 格式文件地址)
- 字体链接必须是同源下的，或开启了cors支持，小程序的域名是 servicewechat.com
- canvas 等原生组件不支持使用接口添加的字体
- 工具里提示 Faild to load font可以忽略

```HTML
<view class="container">
  <view class="page-body">
    <view class="page-section">
      <view class="page-body-info display-area {{ loaded ? 'font-loaded' : '' }}">
        <text wx:if="{{!loaded}}">Load {{ fontFamily }}</text>
        <text wx:else>{{ fontFamily }} is loaded</text>
      </view>
      <view class="btn-area">
        <button type="primary" bindtap="loadFontFace">加载字体</button>
      </view>
    </view>
  </view>
</view>
```

```JS
Page({
  data: {
    fontFamily: 'Bitstream Vera Serif Bold',
    loaded: false,
  },
  onLoad() {
    this.setData({
      loaded: false
    })
  },
  loadFontFace() {
    const self = this
    wx.loadFontFace({
      family: this.data.fontFamily,// 定义的字体名称   必填
      source: 'url("https://sungd.github.io/Pacifico.ttf")',  //必填
      //字体资源的地址。建议格式为 TTF 和 WOFF，WOFF2 在低版本的iOS上会不兼容。
      desc:{   //可选的字体描述符                      否
        style: 'normal'//  否      字体样式，可选值为 normal / italic / oblique
        weight: 'normal'// 否     字体粗细，可选值为 normal / bold / 100 / 200../ 900
        variant: 'normal'//否    设置小型大写字母的字体显示文本，可选值为 normal / small-caps / inherit
      },
      success(res) {
        console.log(res.status)
        self.setData({ loaded: true })
      },
      fail: function(res) {
        console.log(res.status)
      },
      complete: function(res) {
        console.log(res.status)
      }
    });
  }
})
```

```LESS
.page-body-info {
  align-items: center;
  padding: 200rpx 0;
}

.font-loaded {
  font-family: "Bitstream Vera Serif Bold";
}

.display-area {
  font-size: 40rpx;
  display: flex;
  justify-content: center;
}
```

### 3.6 图片

- wx.chooseImage    从本地相册选择图片或使用相机拍照。
- wx.compressImage  压缩图片接口，可选压缩质量
- wx.getImageInfo   获取图片信息。网络图片需先配置 download 域名才能生效。
- wx.previewImage   在新页面中全屏预览图片。预览的过程中用户可以进行保存图片、发送给朋友等操作。
- wx.saveImageToPhotosAlbum 保存图片到系统相册。 调用前需要 **用户授权**

```JS
wx.chooseImage({
  count: 1,// 最多可以选择的图片张数   否，默认值为 9
  sizeType: ['original', 'compressed'],//所选的图片的尺寸   否  默认值为 ['original', 'compressed']
  //original : 原图    compressed:压缩图
  sourceType: ['album', 'camera'],//选择图片的来源          否 默认值为  ['album', 'camera']
  //album 从相册选图    camera 使用相机
  success (res) {
    // tempFilePath 可以作为 img 标签的 src 属性显示图片
    const tempFilePaths = res.tempFilePaths//[''] 图片的本地临时文件 路径列表
    const tempFiles = res.tempFiles        //[{}] 图片的本地临时     文件列表
    /*  res.tempFiles{
          path:'',//本地临时文件路径
          size:200//本地临时文件大小，单位 B
        } */
        //网络图片需先配置 download 域名才能生效。！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
    wx.getImageInfo({
      src: res.tempFilePaths[0],//'images/a.jpg',//图片的路径，可以是相对路径、临时文件路径、存储文件路径、网络图片路径  必填
      success (res) {
        console.log(res.width)//number 图片原始宽度，单位px。不考虑旋转。
        console.log(res.height)//number 图片原始高度，单位px。不考虑旋转。
        res.path//''  图片的本地路径
        res.orientation//''     拍照时设备方向
            //'up'              默认方向（手机横持拍照），对应 Exif 中的 1。或无 orientation 信息。
            //'up-mirrored'     同 up，但镜像翻转，对应 Exif 中的 2
            //'down'            旋转180度，对应 Exif 中的 3
            //'down-mirrored'   同 down，但镜像翻转，对应 Exif 中的 4
            //'left-mirrored'   同 left，但镜像翻转，对应 Exif 中的 5
            //'right'           顺时针旋转90度，对应 Exif 中的 6
            //'right-mirrored'  同 right，但镜像翻转，对应 Exif 中的 7
            //'left'            逆时针旋转90度，对应 Exif 中的 8
        re.type//'' 图片格式
      },
      fail(res){},
      complete(res){}
    })
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})


//两个方法的结合使用
wx.chooseImage({
  success (res) {
    wx.getImageInfo({
      src: res.tempFilePaths[0],
      success (res) {
        console.log(res.width)
        console.log(res.height)
      },
      fail(res){},
      complete(res){}
    })
  }
})


//压缩图片接口，可选压缩质量
wx.compressImage({
  src: '', // 图片路径,图片路径，图片的路径，可以是相对路径、临时文件路径、存储文件路径  必填
  quality: 80, // 压缩质量，压缩质量，范围0～100，数值越小，质量越低，压缩率越高（仅对jpg有效）。  否 默认值 80
  success(res){},
  fail(res){},
  complete(res){}
})


wx.previewImage({
  current: '', // 当前显示图片的 http 链接  否    默认值：urls 的第一张
  urls: [], // 需要预览的图片 http 链接列表,2.2.3 起支持云文件ID。  必填
  success(res) { },
  fail(res) { },
  complete(res) { }
})


wx.saveImageToPhotosAlbum({
  filePath:'',//图片文件路径，可以是临时文件路径或永久文件路径，不支持网络图片路径  必填
  success(res) { },
  fail(res) { },
  complete(res) { }
})
```

#### 3.6.1 运用实例

```HTML
<view class="weui-panel">
  <view class="weui-panel__hd"></view>
  <view class="weui-panel__bd">
    <image mode='widthFix' src="{{src}}" style='width: 300px;'></image>
    <button bindtap="getImageInfo">getImageInfo</button>
  </view>
  <view class="weui-panel__ft"></view>
</view>

<view wx:if="{{!!info}}" class='result'>
  <text space="nbsp">{{info}}</text>
</view>
```

```JS
const app = getApp()

Page({
  data: {
    src: 'http://mmbiz.qpic.cn/mmbiz_png/icTdbqWNOwNTTiaKet81gQJDXYnPiaJFSzRlp9frTTX2hSN01xhiackVLHHrG7ZQI3XQsbM7Gr9USZdN4f26SO5xjg/0?wx_fmt=png',
    info: '',
  },
  getImageInfo() {
    wx.getImageInfo({
      src: this.data.src,
      complete: (res) => {
        this.setData({
          info: this.format(res)
        })
      }
    })
  },
  format(obj) {
    return '{\n' +
      Object.keys(obj).map(function (key) { return '  ' + key + ': ' + obj[key] + ',' }).join('\n') + '\n' +
    '}'
  }
})
```

### 3.7 实时音视频 (直播)

#### 3.7.1 LivePlayerContext 对象  (观看直播)

- wx.createLivePlayerContext  创建对象  参数为 `<live-player>` 组件的 id, 第二个可选参数 this
- .exitFullScreen     退出全屏  三个回调函数
- .mute               静音     三个回调函数
- .pause              暂停     三个回调函数
- .play               播放     三个回调函数
- .requestFullScreen  进入全屏  direction 以及 三个回调函数   0：正常竖向  90：屏幕逆时针90度  -90：屏幕顺时针90度
- .resume             恢复         三个回调函数
- .stop               停止         三个回调函数

```HTML
<view class="page-body">
  <view class="page-section tc">
    <live-player id="player" src="https://domain/pull_stream" mode="RTC" autoplay bindstatechange="statechange" binderror="error" />

    <view class="btn-area">
      <button bindtap="bindPlay" class="page-body-button" type="primary">播放</button>
      <button bindtap="bindPause" class="page-body-button" type="primary">暂停</button>
      <button bindtap="bindStop" class="page-body-button" type="primary">停止</button>
      <button bindtap="bindResume" class="page-body-button" type="primary">恢复</button>
      <button bindtap="bindMute" class="page-body-button" type="primary">静音</button>
    </view>
  </view>
</view>
```

```JS
Page({
  onReady(res) {
    this.ctx = wx.createLivePlayerContext('player')// 创建
  },
  statechange(e) {
    console.log('live-player code:', e.detail.code)
  },
  error(e) {
    console.error('live-player error:', e.detail.errMsg)
  },
  bindPlay() {
    // 播放
    this.ctx.play({
      success: res => {
        console.log('play success')
      },
      fail: res => {
        console.log('play fail')
      },
      complete:res => {}
    })
  },
  bindPause() {
    this.ctx.pause({
      success: res => {
        console.log('pause success')
      },
      fail: res => {
        console.log('pause fail')
      },
      complete:res => {}
    })
  },
  bindStop() {
    this.ctx.stop({
      success: res => {
        console.log('stop success')
      },
      fail: res => {
        console.log('stop fail')
      },
      complete:res => {}
    })
  },
  bindResume() {
    this.ctx.resume({
      success: res => {
        console.log('resume success')
      },
      fail: res => {
        console.log('resume fail')
      },
      complete:res => {}
    })
  },
  bindMute() {
    this.ctx.mute({
      success: res => {
        console.log('mute success')
      },
      fail: res => {
        console.log('mute fail')
      },
      complete:res => {}
    })
  }
})
```

```LESS
.page-body-button {
  margin-bottom: 30rpx;
}

live-player {
  width: 100%;
  height: 225px;
}
```

#### 3.7.2 LivePusherContext 对象 （开直播）

- wx.createLivePusherContext 创建对象  参数为 id
- .pause        暂停推流        三个回调函数
- .pauseBGM     暂停背景音      三个回调函数
- .playBGM      播放背景音      三个回调函数 必填 url 与
    livePusherContext.playBGM({
      url:'',       // 加入背景混音的资源地址 必填
      success(res){},
      fail(res){},
      complete(res){}
    })
- .resume       恢复推流        三个回调函数
- .resumeBGM    恢复背景音      三个回调函数
- .setBGMVolume 设置背景音音量  三个回调函数 必填 Volume
    livePusherContext.setBGMVolume({
      Volume:'',   //音量大小     必填
      success(res){},
      fail(res){},
      complete(res){}
    })
- .snapshot     快照           三个回调函数
- .start        播放推流       三个回调函数
- .stop         停止推流       三个回调函数
- .stopBGM      停止背景音     三个回调函数
- .switchCamera 切换前后摄像头  三个回调函数
- .toggleTorch  切换           三个回调函数

```HTML
<view class="page-body">
  <view class="page-section tc">
    <live-pusher id="pusher" url="https://domain/push_stream" mode="RTC" autopush bindstatechange="statechange" />

    <view class="btn-area">
      <button bindtap="bindStart" class="page-body-button" type="primary">播放推流</button>
      <button bindtap="bindPause" class="page-body-button" type="primary">暂停推流</button>
      <button bindtap="bindStop" class="page-body-button" type="primary">停止推流</button>
      <button bindtap="bindResume" class="page-body-button" type="primary">恢复推流</button>
      <button bindtap="bindSwitchCamera" class="page-body-button" type="primary">切换前后摄像头</button>
    </view>
  </view>
</view>
```

```JS
Page({
  onReady(res) {
    this.ctx = wx.createLivePusherContext('pusher')// 创建对象
  },
  statechange(e) {
    console.log('live-pusher code:', e.detail.code)
  },
  bindStart() {
    // 播放
    this.ctx.start({
      success: res => {
        console.log('start success')
      },
      fail: res => {
        console.log('start fail')
      },
      complete:res=>{
        //
      }
    })
  },
  bindPause() {
    this.ctx.pause({
      success: res => {
        console.log('pause success')
      },
      fail: res => {
        console.log('pause fail')
      }
    })
  },
  bindStop() {
    this.ctx.stop({
      success: res => {
        console.log('stop success')
      },
      fail: res => {
        console.log('stop fail')
      }
    })
  },
  bindResume() {
    this.ctx.resume({
      success: res => {
        console.log('resume success')
      },
      fail: res => {
        console.log('resume fail')
      }
    })
  },
  bindSwitchCamera() {
    this.ctx.switchCamera({
      success: res => {
        console.log('switchCamera success')
      },
      fail: res => {
        console.log('switchCamera fail')
      }
    })
  }
})
```

```CSS
.page-body-button {
  margin-bottom: 30rpx;
}

live-pusher {
  margin: 0 auto;
  width: 300px;
  height: 225px;
}
```

#### 3.7.3 实时音视频 (直播) 权限

当然不是小程序使用了这些标签 `<live-pusher>`,`<live-player>` 就可以做到实时直播功能的，
这个需要是符合微信的某些分类，并且在后台接口端设置之后才可以用的。
符合类目要求的小程序，需要在小程序管理后台的 “设置 - 接口设置” 中自助开通该组件权限。

[官网常见问题解析](https://cloud.tencent.com/document/product/454/13037)

### 3.7 录音

#### 3.7.1 wx.getRecorderManager  获取全局唯一的录音管理器 RecorderManager 对象   无参数

```JS
```

#### 3.7.2  RecorderManager  的 wx.API

- wx.startRecord        开始录音。**需要授权**
    当主动调用 wx.stopRecord，或者录音超过1分钟时自动结束录音。当用户离开小程序时，此接口无法调用。    三个回电函数
    success(res.tempFilePath)  // 录音文件的临时路径
- wx.stopRecord         停止录音。无参数

```JS
wx.startRecord({
  success (res) {
    const tempFilePath = res.tempFilePath
  }
})
setTimeout(function () {
  wx.stopRecord() // 结束录音
}, 10000)
```

#### 3.7.3  RecorderManager 对象的方法

- .onError    监听录音错误事件                                                                回调函数  
    (res)=>{
      res.errMsg  //'' 错误信息
    }
- .onFrameRecorded    监听已录制完指定帧大小的文件事件。如果设置了 frameSize，则会回调此事件。    回调函数
    (res)=>{
      res.frameBuffer  //ArrayBuffer  录音分片数据
      res.isLastFrame  //boolean      当前帧是否正常录音结束前的最后一帧
    }
- .onInterruptionBegin 监听录音因为受到系统占用而被中断开始事件。                                回调函数
    以下场景会触发此事件：微信语音聊天、微信视频聊天。此事件触发后，录音会被暂停。pause 事件在此事件后触发
- .onInterruptionEnd   监听录音中断结束事件。                                                  回调函数
    在收到 interruptionBegin 事件之后，小程序内所有录音会暂停，收到此事件之后才可再次录音成功。
- .onPause      监听录音暂停事件     回调函数
- .onResume     监听录音继续事件     回调函数
- .onStart      监听录音开始事件     回调函数
- .onStop       监听录音结束事件     回调函数
    (res)=>{
      res.tempFilePath  //'' 录音文件的临时路径
    }
- .pause     暂停录音             无参数
- .resume    继续录音             无参数
- .start     开始录音
    recorderManager.start({
      duration:60000,//录音的时长，单位 ms，最大值 600000（10 分钟）      否，默认为 60000 即 10 分钟
      sampleRate:8000,// 采样率      否，默认8000
      numberOfChannels:2,//录音通道数  否，默认2
      encodeBitRate:48000,//编码码率，有效值见下表格 否，默认48000
      format:'abc',//音频格式       否，默认 'abc'
      frameSize:90,//指定帧大小，单位 KB。  否
                  //传入 frameSize 后，每录制指定帧大小的内容后，会回调录制的文件内容，不指定则不会回调。暂仅支持 mp3 格式。
      audioSource:'auto'//指定录音的音频输入源，可通过 wx.getAvailableAudioSources() 获取当前可用的音频源   否
              [**以上这些返回值的可取值参考** 微信官方文档](https://developers.weixin.qq.com/miniprogram/dev/api/RecorderManager.start.html)
    })
- .stop      停止录音             无参数

```JS
const recorderManager = wx.getRecorderManager()//获取全局唯一的录音管理器 RecorderManager 无参数

recorderManager.onStart(() => {
  console.log('recorder start')
})
recorderManager.onPause(() => {
  console.log('recorder pause')
})
recorderManager.onStop((res) => {
  console.log('recorder stop', res)
  const { tempFilePath } = res
})
recorderManager.onFrameRecorded((res) => {
  const { frameBuffer } = res
  console.log('frameBuffer.byteLength', frameBuffer.byteLength)
})

const options = {
  duration: 10000,
  sampleRate: 44100,
  numberOfChannels: 1,
  encodeBitRate: 192000,
  format: 'aac',
  frameSize: 50
}

recorderManager.start(options)
```

### 3.8 视频

#### 3.8.1 VideoContext 的 wx.Api

- wx.createVideoContext     创建 video 上下文 VideoContext 对象 ，参数 id，第二个 可选参数 this
- wx.chooseVideo            拍摄视频或从手机相册中选视频。
- wx.saveVideoToPhotosAlbum 保存视频到系统相册 **需要先用户授权**

```HTML
<video id="myVideo" src="http://wxsnsdy.tc.qq.com/105/20210/snsdyvideodownload?filekey=30280201010421301f0201690402534804102ca905ce620b1241b726bc41dcff44e00204012882540400&bizid=1023&hy=SH&fileparam=302c020101042530230204136ffd93020457e3c4ff02024ef202031e8d7f02030f42400204045a320a0201000400" danmu-list="{{danmuList}}" enable-danmu danmu-btn controls></video>
```

```JS
onReady: function (res) {
  this.videoContext = wx.createVideoContext('myVideo')// 创建视频 对象
},

wx.saveVideoToPhotosAlbum({
  filePath: 'wxfile://xxx',//视频文件路径，可以是临时文件路径也可以是永久文件路径   必填
  success (res) {
    console.log(res.errMsg)
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})

wx.chooseVideo({
  sourceType: ['album','camera'],//视频选择的来源 否 默认值 ['album', 'camera']
  //album 从相册选择视频     camera 使用相机拍摄视频
  compressed:true,//是否压缩所选择的视频文件       否 默认值 true
  maxDuration: 60,//拍摄视频最长拍摄时间，单位秒   否 默认值 60
  camera: 'back',//默认拉起的是前置或者后置摄像头。部分 Android 手机下由于系统 ROM 不支持无法生效  否 默认值 'back'
  //back  默认拉起后置摄像头   front  默认拉起前置摄像头
  success(res) {
    console.log(res.tempFilePath)
      empFilePath//string 选定视频的临时文件路径
      duration//number    选定视频的时间长度
      size//number        选定视频的数据量大小
      height//number      返回选定视频的高度
      width//number       返回选定视频的宽度
  },
  fail(res){},
  complete(res){}
})
```

#### 3.8.1 VideoContext 对象的 方法

- .exitFullScreen 退出全屏  无参数
- .hideStatusBar  隐藏状态栏，仅在iOS全屏下有效 无参数
- .pause          暂停视频  无参数
- .play           播放视频  无参数
- .playbackRate   设置倍速播放  参数：倍率，支持 0.5/0.8/1.0/1.25/1.5 （number）
- .requestFullScreen 进入全屏   参数：direction  //设置全屏时视频的方向，不指定则根据宽高比自动判断。 否：不是必填（number）
                                        0   正常竖向
                                        90  屏幕逆时针90度
                                        -90 屏幕顺时针90度
- .seek          跳转到指定位置 参数  position 跳转到的位置，单位 s（number）
- .sendDanmu    发送弹幕 （观看视频发送弹幕）                      (obj)
    videoContext.sendDanmu({
      text:'',// tring   必填 弹幕文字
      color:''// tring  否   弹幕颜色
    })
- .showStatusBar 显示状态栏，仅在iOS全屏下有效  无参数
- .stop         停止视频  无参数

```HTML
<view class="page-body">
  <view class="page-section tc">
    <video id="myVideo" src="http://wxsnsdy.tc.qq.com/105/20210/snsdyvideodownload?filekey=30280201010421301f0201690402534804102ca905ce620b1241b726bc41dcff44e00204012882540400&bizid=1023&hy=SH&fileparam=302c020101042530230204136ffd93020457e3c4ff02024ef202031e8d7f02030f42400204045a320a0201000400" binderror="videoErrorCallback" danmu-list="{{danmuList}}" enable-danmu danmu-btn controls></video>

    <view class="weui-cells">
      <view class="weui-cell weui-cell_input">
        <view class="weui-cell__hd">
          <view class="weui-label">弹幕内容</view>
        </view>
        <view class="weui-cell__bd">
          <input bindblur="bindInputBlur" class="weui-input" type="text" placeholder="在此处输入弹幕内容" />
        </view>
      </view>
    </view>
    <view class="btn-area">
      <button bindtap="bindSendDanmu" class="page-body-button" type="primary" formType="submit">发送弹幕</button>
      <button bindtap="bindPlay" class="page-body-button" type="primary">播放</button>
      <button bindtap="bindPause" class="page-body-button" type="primary">暂停</button>
    </view>
  </view>
</view>

```

```JS
function getRandomColor () {
  const rgb = []
  for (let i = 0 ; i < 3; ++i){
    let color = Math.floor(Math.random() * 256).toString(16)
    color = color.length == 1 ? '0' + color : color
    rgb.push(color)
  }
  return '#' + rgb.join('')
}

Page({
  onReady: function (res) {
    this.videoContext = wx.createVideoContext('myVideo')// 创建
  },
  inputValue: '',
    data: {
    src: '',
    danmuList:
      [{
        text: '第 1s 出现的弹幕',
        color: '#ff0000',
        time: 1
      },
      {
        text: '第 3s 出现的弹幕',
        color: '#ff00ff',
        time: 3
      }]
    },
  bindInputBlur: function(e) {
    this.inputValue = e.detail.value
  },
  bindSendDanmu: function () {
    // 发送弹幕
    this.videoContext.sendDanmu({
      text: this.inputValue,
      color: getRandomColor()
    })
  },
  bindPlay: function() {
    this.videoContext.play()
  },
  bindPause: function() {
    this.videoContext.pause()
  },
  videoErrorCallback: function(e) {
    console.log('视频错误信息:')
    console.log(e.detail.errMsg)
  }
})
```

```CSS
@import "../lib/weui.wxss";

.weui-cells{
  margin-top: 80rpx;
  text-align: left;
}
.weui-label{
  width: 5em;
}

.page-body-button {
  margin-bottom: 30rpx;
}
```

## 四、文件

wx.getFileInfo
wx.getFileSystemManager
wx.getSavedFileInfo
wx.getSavedFileList
wx.openDocument
wx.removeSavedFile
wx.saveFile

FileSystemManager
.access
.accessSync
.appendFile
.appendFileSync
.copyFile
.copyFileSync
.getFileInfo
.getSavedFileList
.mkdir
.mkdirSync
.readdir
.readdirSync
.readFile
.readFileSync
.removeSavedFile
.rename
.renameSync
.rmdir
.rmdirSync
.saveFile
.saveFileSync
.stat
.statSync
.unlink
.unlinkSync
.unzip
.writeFile
.writeFileSync

Stats
.isDirectory
.isFile

## 五、数据缓存

synchronous：同步    sync  同步
asynchronous：异步   async 异步

### 5.1 异步操作

- wx.setStorage
    将数据存储在本地缓存中指定的 key 中。会覆盖掉原来该 key 对应的内容。数据存储生命周期跟小程序本身一致，即除用户主动删除或超过一定时间被自动清理，否则数据都一直可用。**单个 key 允许存储的最大数据长度为 1MB，所有数据存储上限为 10MB。**
- wx.getStorage      从本地缓存中异步获取指定 key 的内容
- wx.getStorageInfo  异步获取当前storage的相关信息
- wx.clearStorage    清理本地数据缓存
- wx.removeStorage   从本地缓存中移除指定 key

```JS
wx.setStorage({
  key:"key",// 本地缓存中指定的 key   必填
  data:"value",// 需要存储的内容。只支持原生类型、Date、及能够通过 JSON.stringify 序列化的对象。  必填
  success(res){},
  fail(res){},
  complete(res){}
})

wx.getStorage({
  key: 'key',//本地缓存中指定的 key   必填
  success (res) {
    console.log(res.data)// Object/string       key 对应的内容
  },
  fail(res){},
  complete(res){}
})

wx.getStorageInfo({
  success (res) {
    console.log(res.keys)//['']       当前 storage 中所有的 key
    console.log(res.currentSize)//80  当前占用的空间大小, 单位 KB
    console.log(res.limitSize)//90    限制的空间大小，单位 KB
  },
  fail(res){},
  complete(res){}
})

wx.clearStorage({
  success (res) {},
  fail(res){},
  complete(res){}
})

wx.removeStorage({
  key: 'key',// 本地缓存中指定的 key   必填
  success (res) {
    console.log(res.data)
  },
  fail(res){},
  complete(res){}
})
```

### 5.2 同步操作

- wx.setStorageSync     wx.setStorage 的同步版本
- wx.getStorageSync     wx.getStorage 的同步版本
- wx.getStorageInfoSync wx.getStorageInfo 的同步版本
- wx.clearStorageSync   wx.clearStorage 的同步版本
- wx.removeStorageSync  wx.removeStorage 的同步版本

```JS
try {
  wx.setStorageSync('key', 'value')
} catch (e) { }


try {
  var value = wx.getStorageSync('key')
  if (value) {
    // Do something with return value
  }
} catch (e) {
  // Do something when catch error
}


try {
  wx.clearStorageSync()
} catch(e) {
  // Do something when catch error
}

try {
  const res = wx.getStorageInfoSync()
  console.log(res.keys)
  console.log(res.currentSize)
  console.log(res.limitSize)
} catch (e) {
  // Do something when catch error
}

try {
  wx.clearStorageSync()
} catch(e) {
  // Do something when catch error
}

try {
  wx.removeStorageSync('key')
} catch (e) {
  // Do something when catch error
}
```

## 六、位置（地理位置）**调用前需要授权**

- wx.chooseLocation 打开地图选择位置。**调用前需要授权**
- wx.getLocation   获取当前的地理位置、速度。当用户离开小程序后，此接口无法调用。**调用前需要授权**
- wx.openLocation  使用微信内置地图查看位置

```JS
wx.chooseLocation({
  success(res){
    res.name//string      位置名称
    res.address//string   详细地址
    res.latitude//string  纬度，浮点数，范围为-90~90，负数表示南纬。使用 gcj02 国测局坐标系	
    res.longitude//string 经度，浮点数，范围为-180~180，负数表示西经。使用 gcj02 国测局坐标系
  },
  fail(res){},
  complete(res){}
})

wx.getLocation({
 type: 'wgs84',// wgs84 返回 gps 坐标，gcj02 返回可用于 wx.openLocation 的坐标   否 默认值 'wgs84'
 altitude:'false',//传入 true 会返回高度信息，由于获取高度需要较高精确度，会减慢接口返回速度  否，默认值是 'false'
 success (res) {
   const latitude = res.latitude//80  纬度，范围为 -90~90，负数表示南纬
   const longitude = res.longitude//100 经度，范围为 -180~180，负数表示西经
   const speed = res.speed//2 速度，单位 m/s
   const accuracy = res.accuracy//2 位置的精确度
   res.altitude          //2 高度，单位 m
   res.verticalAccuracy  //2    垂直精度，单位 m（Android 无法获取，返回 0）
   res.horizontalAccuracy//2 水平精度，单位 m

   wx.openLocation({
     latitude,//这里是外层 wx.getLocation 返回值来的，纬度，范围为-90~90，负数表示南纬。使用 gcj02 国测局坐标系  必填
     longitude,//这里是外层 wx.getLocation 返回值来的，经度，范围为-180~180，负数表示西经。使用 gcj02 国测局坐标系 必填
     scale: 18,// 缩放比例，范围5~18  否
     name:'',//位置名  否
     address:'',//地址的详细说明 否
    success(res){}，
    fail(res){},
    complete(res){}
   })
 },
 fail(res){},
 complete(res){}
})
```

注意
工具中定位模拟使用 IP 定位，可能会有一定误差。且工具目前仅支持 gcj02 坐标。
使用第三方服务进行逆地址解析时，请确认第三方服务默认的坐标系，正确进行坐标转换。

## 七、设备

### 7.1 加速计

wx.onAccelerometerChange 获取设备电量。同步 API wx.getBatteryInfoSync 在 iOS 上不可用。
wx.startAccelerometer
wx.stopAccelerometer

```JS
```

### 7.2 电量

wx.getBatteryInfo     异步获取设备电量。
wx.getBatteryInfoSync 同步获取设备电量。
    顾名思义，这个api是需要同步的，所以可能会对游戏造成一定的卡顿；而且，这个api在iOS上是不可用的。
    所以说同步的版本我们是不会用的咯？其他的接口我们也是不会用同步版本的咯。

**在这里说一下小程序与小游戏的区别：他们的接口方法是不太一样的。**
    在小游戏中 wx.getSystemInfo 系统的接口中 wx.getSystemInfo 中 success的参数res中，res.battery是代表电量的，我们可以用来设置界面上的电量显示。
    但是我们在小程序中  wx.getSystemInfo 系统的接口中 wx.getSystemInfo 中 success的参数res中 是没有 res.battery ，所以我们是获取不到这个电量的。

以上几个api都是只获取一次电量的值，所以我们在程序中需要做一个计时器以在固定的时间去获取电量值，这样才能保证实时更新电量。

```JS
wx.getBatteryInfo({
  success(res){
    res.level//string   设备电量，范围 1 - 100
    isCharging//boolean 是否正在充电中
  },
  fail(res){},
  complete(res){}
})
```

### 7.3 蓝牙

wx.closeBluetoothAdapter
wx.getBluetoothAdapterState
wx.getBluetoothDevices
wx.getConnectedBluetoothDevices
wx.onBluetoothAdapterStateChange
wx.onBluetoothDeviceFound
wx.openBluetoothAdapter
wx.startBluetoothDevicesDiscovery
wx.stopBluetoothDevicesDiscovery

### 7.4 低功耗蓝牙

wx.closeBLEConnection
wx.createBLEConnection
wx.getBLEDeviceCharacteristics
wx.getBLEDeviceServices
wx.notifyBLECharacteristicValueChange
wx.onBLECharacteristicValueChange
wx.onBLEConnectionStateChange
wx.readBLECharacteristicValue
wx.writeBLECharacteristicValue

### 7.5 剪贴板

wx.getClipboardData
wx.setClipboardData

### 7.6 罗盘

wx.onCompassChange
wx.startCompass
wx.stopCompass

### 7.7 联系人 wx.addPhoneContact

### 7.8 陀螺仪

wx.onGyroscopeChange
wx.startGyroscope
wx.stopGyroscope
iBeacon
wx.getBeacons
wx.onBeaconServiceChange
wx.onBeaconUpdate
wx.startBeaconDiscovery
wx.stopBeaconDiscovery
IBeaconInfo

### 7.9 设备方向

wx.onDeviceMotionChange
wx.startDeviceMotionListening
wx.stopDeviceMotionListening

### 7.10 网络

wx.getNetworkType
wx.onNetworkStatusChange

### 7.10 NFC

wx.getHCEState
wx.onHCEMessage
wx.sendHCEMessage
wx.startHCE
wx.stopHCE

### 7.11 性能

wx.onMemoryWarning

### 7.12 电话

wx.makePhoneCall

### 7.13 扫码

wx.scanCode

### 7.14 屏幕

wx.getScreenBrightness
wx.onUserCaptureScreen
wx.setKeepScreenOn
wx.setScreenBrightness

### 7.15 振动

wx.vibrateLong
wx.vibrateShort

### 7.16 Wi-Fi

- wx.startWifi     初始化 Wi-Fi 模块。
- wx.getConnectedWifi
- wx.getWifiList
- wx.onGetWifiList
- wx.onWifiConnected
- wx.setWifiList
- wx.stopWifi
- WifiInfo
- wx.connectWifi  连接 Wi-Fi。若已知 Wi-Fi 信息，可以直接利用该接口连接。仅 Android 与 iOS 11 以上版本支持。

```JS
wx.startWifi({
  success (res) {
    console.log(res.errMsg)
  },
  fail(res){},
  complete(res){}
})

wx.connectWifi({
  SSID: '',//SSID   必填
  BSSID: '',// Wi-Fi 设备 BSSID  必填
  password:'',//Wi-Fi 设备密码   否
  success (res) {
    console.log(res.errMsg)
  },
  fail(res){},
  complete(res){}
})

//0     ok                    正常
//12000 not init              未先调用 startWifi 接口
//12001 system not support    当前系统不支持相关能力
//12002 password error Wi-Fi  密码错误
//12003 connection timeout    连接超时
//12004 duplicate request     重复连接 Wi-Fi
//12005 wifi not turned on    Android 特有，未打开 Wi-Fi 开关
//12006 gps not turned on     Android 特有，未打开 GPS 定位开关
//12007 user denied           用户拒绝授权链接 Wi-Fi
//12008 invalid SSID          无效 SSID
//12009 system config err     系统运营商配置拒绝连接 Wi-Fi
//12010 system internal error 系统其他错误，需要在 errmsg 打印具体的错误原因
//12011 weapp in background   应用在后台无法配置 Wi-Fi
```

#### 7.16.2 实例

```HTML
<view class="container">
  <view class="page-body">
    <view class="page-body-info">
      <scroll-view class="device-list" scroll-y>
        <view class="item" wx:for="{{wifiList}}" wx:key="{{index}}">
          <view class="list">
            <text>{{ item.SSID }}</text>
            <span class="wifi-icon">
              <span class="wifi-1"></span>
              <span class="wifi-2 {{item.strength < 2 ? 'off' : ''}}"></span>
              <span class="wifi-3 {{item.strength < 3 ? 'off' : ''}}"></span>
              <span class="wifi-4 {{item.strength < 4 ? 'off' : ''}}"></span>
              <span class="lock" wx:if="{{item.secure}}"></span>
            </span>
          </view>
        </view>
      </scroll-view>
    </view>
    <view class="btn-area">
      <button type="primary" bindtap="startSearch">搜索Wi-Fi</button>
      <button bindtap="stopSearch">停止搜索</button>
    </view>
  </view>
</view>
```

```JS
Page({
  data: {
    wifiList: []
  },

  onUnload() {
    this.stopSearch();
  },

  startSearch() {
    const getWifiList = () => {
      wx.getWifiList({
        success: (res) => {
          wx.onGetWifiList((res) => {
            const wifiList = res.wifiList
              .sort((a, b) => b.signalStrength - a.signalStrength)
              .map(wifi => {
                const strength = Math.ceil(wifi.signalStrength * 4)
                return Object.assign(wifi, { strength })
              })
            this.setData({
              wifiList
            })
          })
        },
        fail(err) {
          console.error(err);
        }
      })
    }

    const startWifi = () => {
      wx.startWifi({
        success: getWifiList,
        fail(err) {
          console.error(err);
        }
      })
    }

    wx.getSystemInfo({
      success(res) {
        const isIOS = res.platform === 'ios'
        if (isIOS) {
          wx.showModal({
            title: '提示',
            content: '由于系统限制，iOS用户请手动进入系统WiFi页面，然后返回小程序。',
            showCancel: false,
            success() {
              startWifi()
            }
          })
          return
        }
        startWifi()
      }
    })

  },

  stopSearch() {
    wx.stopWifi({
      success(res) {
        console.log(res);
      },
      fail(err) {
        console.error(err);
      }
    })
  }
})
```




## 八、界面

### 8.1 动画

#### 8.1.1  wx.createAnimation 创建 动画对象

创建一个动画实例 animation。调用实例的方法来描述动画。最后通过动画实例的 export 方法导出动画数据传递给组件的 animation 属性。

```HTML
<view animation="{{animationData}}" style="background:red;height:100rpx;width:100rpx"></view>
```

```JS
const animation = wx.createAnimation({
  duration:400,//动画持续时间，单位 ms   否，默认值 400
  timingFunction:'linear',// 动画的效果 否，默认值 'linear'
  delay:0,//动画延迟时间，单位 ms       否，默认值 0
  transformOrigin:'50% 50% 0'          //否默认值 '50% 50% 0'
    /*  'linear'      动画从头到尾的速度是相同的
        'ease'        动画以低速开始，然后加快，在结束前变慢
        'ease-in'     动画以低速开始
        'ease-in-out' 动画以低速开始和结束
        'ease-out'    动画以低速结束
        'step-start'  动画第一帧就跳至结束状态直到结束
        'step-end'    动画一直保持开始状态，最后一帧跳到结束状态 */
})
```

#### 8.1.2  Animation 动画对象的方法

```BASH
# 6 个长度单位制，可以是 number 类型，可以是 字符串 '' 类型，
# ① 如果传入 number 则默认使用 px，
# ② 希望可传入其他自定义单位的长度值，就用字符串的形式
.width    设置宽度       返回新的 Animation对象
.height   设置高度       返回新的 Animation对象
.left     设置 left，    返回新的 Animation对象
.right    设置 right     返回新的 Animation对象
.bottom   设置 bottom    返回新的 Animation对象
.top      设置 top，     返回新的 Animation对象

.backgroundColor  设置背景色         参数 '' 颜色值     返回新的 Animation对象

.opacity  设置透明度
     参数 透明度，范围 0-1                     返回新的 Animation对象
.rotate  从 【原点】顺时针旋转一个角度
     参数：旋转的角度。范围 [-180, 180]          返回新的 Animation对象
.rotate3d 从 【X】 轴顺时针旋转一个角度
    animation.rotate3d(x,y,z,angle) 旋转轴 x，y，z 轴的坐标  旋转的角度：[-180, 180]   返回新的 Animation对象
.rotateX 从 X 轴顺时针旋转一个角度 旋转的角度：[-180, 180]   返回新的 Animation对象
.rotateY 从 Y 轴顺时针旋转一个角度 旋转的角度：[-180, 180]   返回新的 Animation对象
.rotateZ 从 Z 轴顺时针旋转一个角度 旋转的角度：[-180, 180]   返回新的 Animation对象

.scale  缩放
    animation.scale(sx,sy)
    sx:在 X 轴缩放 sx 倍数  当仅有 sx 参数时，表示在 X 轴、Y 轴同时缩放sx倍数
    sy:在 Y 轴缩放 sy 倍数
.scale3d 缩放
    animation.scale3d(sx,sy,sz)
    sx:在 X 轴缩放 sx 倍数
    sy:在 Y 轴缩放 sy 倍数
    sz:在 Z 轴缩放 sz 倍数
.scaleX(sx)  缩放 X 轴
.scaleY(sy)  缩放 Y 轴
.scaleZ(sz)  缩放 Z 轴

.skew   对 X、Y 轴坐标进行倾斜
    animation.skew(number ax, number ay)
    ax:对 X 轴坐标倾斜的角度，范围 [-180, 180]
    ay:对 Y 轴坐标倾斜的角度，范围 [-180, 180]
.skewX  对 X 轴坐标进行倾斜
.skewY  对 Y 轴坐标进行倾斜

.translate   平移变换
    animation.translate(number tx, number ty)
    tx:在 X 轴平移的距离，单位为 px，当仅有该参数时表示在 X 轴偏移 tx，单位 px
    ty:在 X 轴平移的距离，单位为 px
.translate3d 对 xyz 坐标进行平移变换
    animation.translate3d(number tx, number ty, number tz)
    tx:在 X 轴平移的距离，单位为 px
    ty:在 X 轴平移的距离，单位为 px
    tz:在 Z 轴平移的距离，单位为 px
.translateX 对 X 轴平移
.translateY 对 Y 轴平移
.translateZ 对 Z 轴平移

.matrix
    matrix(a, b, c, d, tx, ty) 是 matrix3d(a, b, 0, 0, c, d, 0, 0, 0, 0, 1, 0, tx, ty, 0, 1) 的简写
.matrix3d
    matrix3d（a1，b1，c1，d1，a2，b2，c2，d2，a3，b3，c3，d3，a4，b4，c4，d4）
#  .step 表示一组动画完成。可以在一组动画中调用任意多个动画方法，一组动画中的所有动画会同时开始，一组动画完成后才会进行下一组动画。
    animation.step({
      duration:400, # 动画持续时间，单位 ms  否  默认值 400
      timingFunction:'linear', # 动画的效果 否  默认值 'linear'
      delay:0,    #动画延迟时间，单位 ms        否  默认值 0
      transformOrigin:'50% 50% 0' #       否  默认值 '50% 50% 0'
    })
# timingFunction 的合法值
'linear'      动画从头到尾的速度是相同的
'ease'        动画以低速开始，然后加快，在结束前变慢
'ease-in'     动画以低速开始
'ease-in-out' 动画以低速开始和结束
'ease-out'    动画以低速结束
'step-start'  动画第一帧就跳至结束状态直到结束
'step-end'    动画一直保持开始状态，最后一帧跳到结束状态 */

.export           导出动画队列。      无参数            返回 animationData  [{}]
      export 方法每次调用后会清掉之前的动画操作
```

总结一下：
就是 ① 创建 动画对象， ② 给对象添加各种动作。 ③ 使用 .step 结束本轮动作。 ④ 使用 .export 导出并且清除原来的动作。

```HTML
<view class="container">
  <view class="page-body">
    <view class="page-section">

      <view class="animation-element-wrapper">
        <view class="animation-element" animation="{{animation}}"></view>
      </view>
      <view class="animation-buttons" scroll-y="true">
        <button class="animation-button" bindtap="rotate">旋转</button>
        <button class="animation-button" bindtap="scale">缩放</button>
        <button class="animation-button" bindtap="translate">移动</button>
        <button class="animation-button" bindtap="skew">倾斜</button>
        <button class="animation-button" bindtap="rotateAndScale">旋转并缩放</button>
        <button class="animation-button" bindtap="rotateThenScale">旋转后缩放</button>
        <button class="animation-button" bindtap="all">同时展示全部</button>
        <button class="animation-button" bindtap="allInQueue">顺序展示全部</button>
        <button class="animation-button animation-button-reset" bindtap="reset">还原</button>
      </view>
    </view>
  </view>
</view>
```

```JS
Page({
  onReady: function () {
    this.animation = wx.createAnimation()//创建动画
  },
  rotate: function () {
    this.animation.rotate(Math.random() * 720 - 360).step()// 围绕圆点旋转，然后停止 本轮动画
    this.setData({animation: this.animation.export()})//导出动画（给到页面展现），并且清除原来的动画
  },
  scale: function () {
    this.animation.scale(Math.random() * 2).step()//缩放
    this.setData({animation: this.animation.export()})
  },
  translate: function () {
    this.animation.translate(Math.random() * 100 - 50, Math.random() * 100 - 50).step()//平移
    this.setData({animation: this.animation.export()})
  },
  skew: function () {
    this.animation.skew(Math.random() * 90, Math.random() * 90).step()//倾斜
    this.setData({animation: this.animation.export()})
  },
  rotateAndScale: function () {
    this.animation.rotate(Math.random() * 720 - 360)//旋转 然后 缩放
        .scale(Math.random() * 2)
        .step()
    this.setData({animation: this.animation.export()})
  },
  rotateThenScale: function () {
    this.animation.rotate(Math.random() * 720 - 360).step()
        .scale(Math.random() * 2).step()
    this.setData({animation: this.animation.export()})
  },
  all: function () {
    this.animation.rotate(Math.random() * 720 - 360)
        .scale(Math.random() * 2)
        .translate(Math.random() * 100 - 50, Math.random() * 100 - 50)
        .skew(Math.random() * 90, Math.random() * 90)
        .step()
    this.setData({animation: this.animation.export()})
  },
  allInQueue: function () {
    this.animation.rotate(Math.random() * 720 - 360).step()
        .scale(Math.random() * 2).step()
        .translate(Math.random() * 100 - 50, Math.random() * 100 - 50).step()
        .skew(Math.random() * 90, Math.random() * 90).step()
    this.setData({animation: this.animation.export()})
  },
  reset: function () {
    this.animation.rotate(0, 0)
                  .scale(1)
                  .translate(0, 0)
                  .skew(0, 0)
                  .step({duration: 0})
    this.setData({animation: this.animation.export()})
  }
})
```

```CSS
.animation-element-wrapper {
  display: flex;
  width: 100%;
  padding-top: 150rpx;
  padding-bottom: 150rpx;
  justify-content: center;
  overflow: hidden;
  background-color: #ffffff;
}
.animation-element {
  width: 200rpx;
  height: 200rpx;
  background-color: #1AAD19;
}
.animation-buttons {
  padding: 30rpx 50rpx 10rpx;
  width: 100%;
  height: 700rpx;
  box-sizing: border-box;
}
.animation-button {
  float: left;
  line-height: 2;
  width: 300rpx;
  margin: 15rpx 12rpx;
}

.animation-button-reset {
  width: 620rpx;
}
```

### 8.2 背景

wx.setBackgroundColor      动态设置窗口的背景色
wx.setBackgroundTextStyle  动态设置下拉背景字体、loading 图的样式

```JS
wx.setBackgroundColor({
  backgroundColor: '#ffffff', // 窗口的背景色，必须为十六进制颜色值   否
  backgroundColorTop: '#ffffff', // 顶部窗口的背景色，必须为十六进制颜色值，仅 iOS 支持  否
  backgroundColorBottom: '#ffffff', // 底部窗口的背景色，必须为十六进制颜色值，仅 iOS 支持 否
  success(res){},
  fail(res){},
  complete(res){}
})

wx.setBackgroundTextStyle({
  textStyle: 'dark', // 下拉背景字体、loading 图的样式。  必填   'light'，'dark'
  success(res){},
  fail(res){},
  complete(res){}
})
```

### 8.3 自定义组件 wx.nextTick  延迟一部分操作到下一个时间片再执行。（类似于 setTimeout）？？？？？？？？

```JS
// 以 wepy 框架的来编辑示例
data = {
  isplay:false,
  intervalId = null,
  text:'等会看我变'
}
methods ={
  pause() {
    this.isplay = false;
    clearTimeout(this.intervalId);
  },
  play() {
    this.isplay = true;
    this.setTimeoutFunc();
  },
}
setTimeoutFunc() {
    this.intervalId = clearTimeout(() => {
      this.text='3 秒过了，我变啦'
      this.$apply();// wepy 框架如是编辑
    }, 3000);
  }
```

```JS
Component({
    doSth() {
        this.setData({
            number: 1
        }) // 直接在当前同步流程中执行

        wx.nextTick(() = > {
            this.setData({
                number: 3
            }) // 在当前同步流程结束后，下一个时间片执行
        })

        this.setData({
            number: 2
        }) // 直接在当前同步流程中执行
    }
})
```

说明
因为自定义组件中的 setData 和 triggerEvent 等接口本身是同步的操作，当这几个接口被连续调用时，都是在一个同步流程中执行完的，因此若逻辑不当可能会导致出错。

一个极端的案例：当父组件的 setData 引发了子组件的 triggerEvent，进而使得父组件又进行了一次 setData，期间有通过 wx:if 语句对子组件进行卸载，就有可能引发奇怪的错误，所以对于不需要在一个同步流程内完成的逻辑，可以使用此接口延迟到下一个时间片再执行。

### 8.4 交互（提示框，对话框）

wx.showActionSheet ​显示操作菜单
wx.showLoading  显示 loading 提示框。需主动调用 wx.hideLoading 才能关闭提示框
wx.hideLoading  隐藏 loading 提示框   三个回调函数
wx.showModal    显示模态对话框
wx.showToast    显示消息提示框
wx.hideToast    隐藏消息提示框        三个回调函数

loading 提示框
![loading 提示框](https://upload-images.jianshu.io/upload_images/5616361-46ebe31f2d24e9f8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/163/format/webp)

```JS
wx.showActionSheet({
  itemList: ['A', 'B', 'C'],//按钮的文字数组，数组长度最大为 6  必填
  itemColor:'#000000',//按钮的文字颜色   否
  success (res) {
    console.log(res.tapIndex)//9     用户点击的按钮序号，从上到下的顺序，从0开始
  },
  fail (res) {
    console.log(res.errMsg)
  },
  complete(res){}
})
//注意
//Android 6.7.2 以下版本，点击取消或蒙层时，回调 fail, errMsg 为 "fail cancel"；
//Android 6.7.2 及以上版本 和 iOS 点击蒙层不会关闭模态弹窗，所以尽量避免使用「取消」分支中实现业务逻辑

wx.showLoading({
  title: '加载中',  //提示的内容             必填
  mask:false,//是否显示透明蒙层，防止触摸穿透  否 默认值 false
  success(res){},
  fail (res) {},
  complete(res){}
})

setTimeout(function () {
  wx.hideLoading({
    success(res){},
    fail (res) {},
    complete(res){}
  })
}, 2000)
//注意
//wx.showLoading 和 wx.showToast 同时只能显示一个
//wx.showLoading 应与 wx.hideLoading 配对使用


wx.showModal({
  title: '提示',// 提示的标题  必填
  content: '这是一个模态弹窗',//提示的内容  必填
  showCancel:true,  //是否显示取消按钮     否  默认值true
  cancelText:'取消',//取消按钮的文字，最多 4 个字符  否 默认值 '取消'
  cancelColor:'#000000',//取消按钮的文字颜色，必须是 16 进制格式的颜色字符串  否 默认值 '#000000'
  confirmText:'确定',//确认按钮的文字，最多 4 个字符  否 默认值 '确定'
  confirmColor:'#3cc51f',//确认按钮的文字颜色，必须是 16 进制格式的颜色字符串  否 默认值 #3cc51f
  success (res) {
    res.confirm//boolean  为 true 时，表示用户点击了确定按钮
    res.cancel//boolean   为 true 时，表示用户点击了取消（用于 Android 系统区分点击蒙层关闭还是点击取消按钮关闭）
    if (res.confirm) {
      console.log('用户点击确定')
    } else if (res.cancel) {
      console.log('用户点击取消')
    }
  },
  fail (res) {},
  complete(res){}
})
//注意
//Android 6.7.2 以下版本，点击取消或蒙层时，回调 fail, errMsg 为 "fail cancel"；
//Android 6.7.2 及以上版本 和 iOS 点击蒙层不会关闭模态弹窗，所以尽量避免使用「取消」分支中实现业务逻辑

wx.showToast({
  title: '成功',//提示的内容  必填
  icon: 'success',//图标      否  默认值 'success'
        //success 显示成功图标，此时 title 文本最多显示 7 个汉字长度
        //loading 显示加载图标，此时 title 文本最多显示 7 个汉字长度
        //none    不显示图标，此时 title 文本最多可显示两行，1.9.0及以上版本支持
  image:'',//自定义图标的本地路径，image 的优先级高于 icon
  duration: 2000,// 提示的延迟时间  默认值 1500
  mask:false,//是否显示透明蒙层，防止触摸穿透  否 默认值 false
  success(res){},
  fail (res) {},
  complete(res){}
})
//注意
//wx.showLoading 和 wx.showToast 同时只能显示一个
//wx.showToast 应与 wx.hideToast 配对使用
```

### 8.5 菜单（导航栏） wx.getMenuButtonBoundingClientRect 获取菜单按钮（右上角胶囊按钮）的布局位置信息。

坐标信息以屏幕左上角为原点。

```JS
const menuButtonBoundingClientRect = wx.getMenuButtonBoundingClientRect()
menuButtonBoundingClientRect.width//number  宽度，单位：px
menuButtonBoundingClientRect.height//number 高度，单位：px
menuButtonBoundingClientRect.top//number    上边界坐标，单位：px
menuButtonBoundingClientRect.right//number  右边界坐标，单位：px
menuButtonBoundingClientRect.bottom//number 下边界坐标，单位：px
menuButtonBoundingClientRect.left//number   左边界坐标，单位：px
```

#### 8.5.1 自定义导航栏(顶部导航条)

[自定义导航栏](https://juejin.im/post/5c0dc99c5188257d5e39657c)

### 8.6 导航栏

wx.hideNavigationBarLoading 在当前页面隐藏导航条加载动画（就是一个加载转动圆圈）  三个回调函数
wx.setNavigationBarColor    设置页面导航条颜色
wx.setNavigationBarTitle    动态设置当前页面的标题(顶部导航条)
wx.showNavigationBarLoading 在当前页面显示导航条加载动画（就是一个加载转动圆圈）  三个回调函数

![加载动画](https://upload-images.jianshu.io/upload_images/5616361-bc8fb4a9c86743ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/320/format/webp)

```JS
wx.setNavigationBarColor({
    frontColor: '#ffffff',//前景颜色值，包括按钮、标题、状态栏的颜色，仅支持 #ffffff 和 #000000  必填
    backgroundColor: '#ff0000',//背景颜色值，有效值为十六进制颜色  必填
    animation: {//动画效果 必填
        duration: 400,//动画变化时间，单位 ms   否，默认值 0
        timingFunc: 'easeIn'//动画变化方式     否，默认值 'linear'
                    //'linear'  动画从头到尾的速度是相同的
                    //'easeIn'  动画以低速开始
                    //'easeOut' 动画以低速结束
                    //'easeInOut' 动画以低速开始和结束
    },
    success(res){},
    fail(res){},
    complete(res){}
})

onready(){
  // wx.setNavigationBarTitle 一定要写在 onReady 方法中，因为这是页面才完全渲染完成。
  // 通常在 onLoad 中我们是不能对 UI 进行操作的。
  // 我们可以从 onLoad 中获取到一个动态变量，那如何将这个变量从 onLoad 中传递给 onReady 方法呢？
  // 我们可以在 onLoad 中通过 this.setData({key: value}) 将这个变量传递给 data，在 onReady 中再通过 this.data.key 获得这个变量。
  // 确定是写在 onready ？？  https://blog.csdn.net/m0_37893932/article/details/70155310 这个是写在 onload 有问题？？
  wx.setNavigationBarTitle({
    title: '当前页面',//页面标题  必填
    success(res){},
    fail(res){},
    complete(res){}
  })
}

```

### 8.7 下拉刷新

wx.startPullDownRefresh 开始下拉刷新。调用后触发下拉刷新动画，效果与用户手动下拉刷新一致。  三个回调函数
wx.stopPullDownRefresh  停止当前页面下拉刷新。                                          三个回调函数

```JS
Page({
  onPullDownRefresh () {
    wx.stopPullDownRefresh()
  }
})
```

### 8.8 滚动 wx.pageScrollTo 将页面滚动到目标位置

```JS
wx.pageScrollTo({
  scrollTop: 0,//滚动到页面的目标位置，单位 px  必填
  duration: 300,//滚动动画的时长，单位 ms  否， 默认 300
  success(res){},
  fail(res){},
  complete(res){}
})
```

### 8.9 置顶 （动态设置导航栏 与 tabbar 栏）

#### 8.9.1 wx.setTopBarText 动态设置置顶栏文字内容。

基础库 1.4.3 开始支持，低版本需做兼容处理。**从基础库 1.9.9 开始，本接口停止维护**?????几个意思

只有当前小程序被置顶时能生效，如果当前小程序没有被置顶，也能调用成功，但是不会立即生效，只有在用户将这个小程序置顶后才换上设置的文字内容.

```JS
wx.setTopBarText({
  text: 'hello, world!',//置顶栏文字 必填
  success(res){},
  fail(res){},
  complete(res){}
})
```

注意
调用成功后，需间隔 5s 才能再次调用此接口，如果在 5s 内再次调用此接口，会回调
`fail，errMsg："setTopBarText: fail invoke too frequently"`

#### 8.9.2 Tab Bar 动态设置 tabbar 栏

官方文档：[网址](https://developers.weixin.qq.com/miniprogram/dev/api/wx.hideTabBar.html)

wx.hideTabBar        隐藏 tabBar
wx.hideTabBarRedDot  隐藏 tabBar 某一项的右上角的红点
wx.removeTabBarBadge 移除 tabBar 某一项右上角的文本
wx.setTabBarBadge    为 tabBar 某一项的右上角添加文本
wx.setTabBarItem     动态设置 tabBar 某一项的内容
wx.setTabBarStyle    动态设置 tabBar 的整体样式
wx.showTabBar        显示 tabBar
wx.showTabBarRedDot  显示 tabBar 某一项的右上角的红点

### 8.10 窗口（窗口尺寸变化处理）

wx.onWindowResize 监听窗口尺寸变化事件
wx.offWindowResize 取消监听窗口尺寸变化事件

```JS
wx.onWindowResize((res)=>{
  res.size
  /* {
      windowWidth//   number  变化后的窗口宽度，单位 px
      windowHeight//  number  变化后的窗口高度，单位 px
    } */
})
wx.offWindowResize(()=>{
  //
})
```

## 九、开放接口 (就是获取到用户的各种数据 的接口，开方消息的意思么)

https://blog.csdn.net/weixin_39735923/article/details/79202563  后面看下这个文章是什么意思。

### 9.1 接口调用凭证

#### 9.1.1 什么是调用凭证，就是凭什么给你资料咯，就是给微信要的 token

access_token 是公众号的全局唯一票据，公众号调用各接口时都需使用 access_token。开发者需要进行妥善保存。access_token 的存储至少要保留512 个字符空间。access_token 的有效期目前为 2 个小时，需定时刷新，重复获取将导致上次获取的 access_token 失效。

公众平台的 API 调用所需的 access_token 的使用及生成方式说明：

- 为了保密 appsecrect，第三方需要一个 access_token 获取和刷新的中控服务器。而其他业务逻辑服务器所使用的 access_token 均来自于该中控服务器，不应该各自去刷新，否则会造成 access_token 覆盖而影响业务；
- 目前 access_token 的有效期通过返回的 expire_in 来传达，目前是 7200 秒之内的值。中控服务器需要根据这个有效时间提前去刷新新access_token。在刷新过程中，中控服务器对外输出的依然是老 access_token，此时公众平台后台会保证在刷新短时间内，新老 access_token 都可用，这保证了第三方业务的平滑过渡；
- access_token 的有效时间可能会在未来有调整，所以中控服务器不仅需要内部定时主动刷新，还需要提供被动刷新 access_token 的接口，这样便于业务服务器在 API 调用获知 access_token 已超时的情况下，可以触发 access_token 的刷新流程。

#### 9.1.2 getAccessToken 获取小程序全局唯一后台接口调用凭据（access_token）。

##### 9.1.2.1 获取Access Token的3种方式：

【微信公众平台】[网址](https://blog.csdn.net/qq_32616843/article/details/78670303)
当然 获取 token 是后端的工作。前端只要使用就好了。并且不要把 token 写在自己的前端代码中，这样做看到代码不就入侵了。总之就是后端写这个获取接口就对了。[官方获取接口方法/参数要求](https://developers.weixin.qq.com/miniprogram/dev/api/open-api/access-token/getAccessToken.html)

**官方的接口调试工具。调试 token**

[官方网址](https://mp.weixin.qq.com/debug/cgi-bin/apiinfo?t=index&type=%E5%9F%BA%E7%A1%80%E6%94%AF%E6%8C%81&form=%E8%8E%B7%E5%8F%96access_token%E6%8E%A5%E5%8F%A3%20/token)

##### 9.1.2.2 **调用各后台接口时都需使用 access_token，开发者需要进行妥善保存。

本章下面所有的 API 接口都需要使用这个凭证才可以成功调用的。当然不能讲对应的值写在代码中，用变量保存就ok。
并且 token 是有时效的，2 小时。如果请求很多，还不保存，系统应付不来这么多请求，就会崩溃的。每天仅限2000次。
检查是否有效，重新请求也是后端的事情，不是前端干的事情。[后端 php 代码](https://blog.csdn.net/vigliang/article/details/79998895)

### 9.2 wx.getAccountInfoSync  获取当前帐号信息

语法：Object wx.getAccountInfoSync()  无参数？？？ 不是说本章的 token 要带上的么？？

```JS
const accountInfo = wx.getAccountInfoSync();
accountInfo.miniProgram//小程序帐号信息
/* {
  appId:''//小程序 appId
} */
console.log(accountInfo.miniProgram.appId) // 小程序 appId

accountInfo.plugin//插件帐号信息（仅在插件中调用时包含这一项）
{
  appId:'',//插件 appId
  version:'1.0.0'//插件版本号
}
console.log(accountInfo.plugin.appId) // 插件 appId
console.log(accountInfo.plugin.version) // 插件版本号， 'a.b.c' 这样的形式
```

### 9.3 wx.chooseAddress 获取用户收货地址。调起用户编辑收货地址原生界面，并在编辑完成后返回用户选择的地址。

#### 9.3.1  调用前需要 用户授权 scope.address，

[用户授权](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/authorize.html)?????????

#### 9.3.2 语法：wx.chooseAddress(Object object) 获取用户收货地址 代码

```html
<view class="container">
  <form>
    <view class="page-section">
      <view class="weui-cells weui-cells_after-title">
        <view class="weui-cell weui-cell_input">
          <view class="weui-cell__hd">
            <view class="weui-label">收货人姓名</view>
          </view>
          <view class="weui-cell__bd">
            {{ addressInfo.userName }}
          </view>
        </view>

        <view class="weui-cell weui-cell_input">
          <view class="weui-cell__hd">
            <view class="weui-label">邮编</view>
          </view>
          <view class="weui-cell__bd">
            {{ addressInfo.postalCode }}
          </view>
        </view>

        <view class="weui-cell weui-cell_input region">
          <view class="weui-cell__hd">
            <view class="weui-label">地区</view>
          </view>
          <view class="weui-cell__bd">
            {{ addressInfo.provinceName }}
            {{ addressInfo.cityName }}
            {{ addressInfo.countyName }}
          </view>
        </view>


        <view class="weui-cell weui-cell_input detail">
          <view class="weui-cell__hd">
            <view class="weui-label">收货地址</view>
          </view>
          <view class="weui-cell__bd">
            {{ addressInfo.detailInfo }}
          </view>
        </view>

          <view class="weui-cell weui-cell_input">
          <view class="weui-cell__hd">
            <view class="weui-label">国家码</view>
          </view>
          <view class="weui-cell__bd">
            {{ addressInfo.nationalCode }}
          </view>
        </view>

        <view class="weui-cell weui-cell_input">
          <view class="weui-cell__hd">
            <view class="weui-label">手机号码</view>
          </view>
          <view class="weui-cell__bd">
            {{ addressInfo.telNumber }}
          </view>
        </view>

      </view>
    </view>
  </form>
  
  <view class="btn-area">
    <button type="primary" bindtap="chooseAddress">获取收货地址</button>
  </view>
</view>
```

```JS
Page({
  data: {
    addressInfo: null
  },
  chooseAddress() {
    //获取用户收货地址。调起用户编辑收货地址原生界面，并在编辑完成后返回用户选择的地址。
    wx.chooseAddress({
      success: (res) => {
        console.log(res.userName)//收货人姓名
        console.log(res.postalCode)//邮编
        console.log(res.provinceName)//国标收货地址第一级地址
        console.log(res.cityName)//国标收货地址第一级地址
        console.log(res.countyName)//国标收货地址第一级地址
        console.log(res.detailInfo)//详细收货地址信息
        console.log(res.nationalCode)//收货地址国家码
        console.log(res.telNumber)//收货人手机号码
        console.log(res.errMsg)//错误信息 String ????错误信息是在这里么？？？
        this.setData({
          addressInfo: res
        })
      },
      fail: function(err) {
        console.log(err)
      },
      /* complete(res){
        //
      } */
    })
  }
})
```

```CSS
@import "../lib/weui.wxss";

form {
  margin-top: 30rpx;
}

.weui-cell__bd {
  display: flex;
  justify-content: flex-start;
  padding: 20rpx 0;
  min-height: 60rpx;
}

.btn-area {
  margin-top: 30rpx;
}
```

```CSS
/*lib/weui.css*/
```

### 9.4 wx.authorize 授权: 提前向用户发起授权请求。

调用后会立刻弹窗询问用户是否同意授权小程序使用某项功能或获取用户的某些数据，但不会实际调用对应接口。如果用户之前已经同意授权，则不会出现弹窗，直接返回成功。更多用法详见 [用户授权](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/authorize.html)。

```JS
// 可以通过 wx.getSetting 先查询一下用户是否授权了 "scope.record" 这个 scope
wx.getSetting({
  success(res) {
    if (!res.authSetting['scope.record']) {

      //提前向用户发起授权请求。
      wx.authorize({
        scope: 'scope.record',//需要获取权限的 scope，详见 scope 列表   必填
        success () {
          wx.startRecord() // 用户已经同意小程序使用录音功能，后续调用 wx.startRecord 接口不会弹窗询问
        },
        fail(){
          //
        },
        complete(){
          //
        }
      })

    }
  }
})
```

### 9.5 卡券

#### 9.5.1 小程序 认证

只有 **通过 认证 的小程序** 才能使用卡券 功能。更多文档请参考 微信卡券接口文档。

[小程序认证](https://developers.weixin.qq.com/miniprogram/product/renzheng.html?t=18112821)
[微信卡券接口文档。](https://mp.weixin.qq.com/cgi-bin/announce?action=getannouncement&key=1490190158&version=1&lang=zh_CN&platform=2)

#### 9.5.2 wx.addCard(Object object) 批量添加卡券。小程序先要认证

[code 解码接口](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1499332673_Unm7V)

```JS
wx.addCard({
  cardList: [
    //参数：需要添加的卡券列表   必填
    {
      cardId: '',//卡券 ID  必填
      // 卡券的扩展参数。需进行 JSON 序列化为字符串传入 必填
      cardExt: '{"code": "", "openid": "", "timestamp": "", "signature":""}'
    }, {
      cardId: '',
      cardExt: '{"code": "", "openid": "", "timestamp": "", "signature":""}'
    }
  ],
  success (res) {
    console.log(res.cardList) // 卡券添加结果
    {
      code:'', //加密 code，为用户领取到卡券的code加密后的字符串，解密请参照：code 解码接口
      cardId: '',//用户领取到卡券的 ID
      cardExt: '',//卡券的扩展参数，结构请参考前文
      isSuccess://numean 是否成功
    }
  }
})
```

**cardExt 的结构**:cardExt 是卡券的扩展参数，其值是一个 JSON 字符串。

- 'code': '',      //否
    用户领取的 code，仅自定义 code 模式的卡券须填写，非自定义 code 模式卡券不可填写，[详情](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1451025056)
- 'openid': '',     // 否
    指定领取者的 openid，只有该用户能领取。 bind_openid 字段为 true 的卡券必须填写，bind_openid 字段为 false 不可填写。
- 'timestamp': 8,    必填
    时间戳，东八区时间,UTC+8，单位为秒  // number？？？？那上面的示例代码为什么是字符串？？？ 
- 'nonce_str': '',
    随机字符串，由开发者设置传入，加强安全性（若不填写可能被重放请求）。随机字符串，不长于 32 位。推荐使用大小写字母和数字，不同添加请求的 nonce_str 须动态生成，若重复将会导致领取失败。
- 'fixed_begintimestamp': 8,   // number  // number？？？？那上面的示例代码为什么是字符串？？？ 
    卡券在第三方系统的实际领取时间，为东八区时间戳（UTC+8,精确到秒）。当卡券的有效期类为 DATE_TYPE_FIX_TERM 时专用，标识卡券的实际生效时间，用于解决商户系统内起始时间和领取微信卡券时间不同步的问题。
- 'outer_str':'',   // 否
    领取渠道参数，用于标识本次领取的渠道值。
- 'signature':'',   // 必填
    签名，商户将接口列表中的参数按照指定方式进行签名,签名方式使用 SHA1，具体签名方案参见：卡券签名

#### 9.5.3 wx.openCard(Object object) 查看微信卡包中的卡券。小程序先要认证

[code 解码接口](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1499332673_Unm7V)

```JS
wx.openCard({
  cardList: [{//需要打开的卡券列表 必填
    cardId: '',//卡券 ID  必填
    code: ''//由 wx.addCard 的返回对象中的加密 code 通过解密后得到，解密请参照：code 解码接口   必填
  }, {
    cardId: '',
    code: ''
  }],
  success (res) {
    //
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})
```

### 9.6 客服消息？？？？？？？？？？？？？？？？？？？不知道具体是怎么做的

#### 9.6.1 customerTyping 客服输入状态接口

下发客服当前输入状态给用户。详见 [客服消息输入状态](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/customer-message/typing.html)

客服输入状态:开发者可通过调用 [客服输入状态接口] customerTyping，返回客服当前输入状态给用户。

- 此接口需要客服消息接口权限。
- 如果不满足发送客服消息的触发条件，则无法下发输入状态。
- 下发输入状态，需要客服之前 30 秒内跟用户有过消息交互。
- 在输入状态中（持续 15 秒），不可重复下发输入态。
- 在输入状态中，如果向用户下发消息，会同时取消输入状态。

#### 9.6.1 getTempMedia  获取客服消息内的临时素材。即下载临时的多媒体文件。目前小程序仅支持下载图片文件。

#### 9.6.1 sendCustomerMessage 发送客服消息给用户。

详细规则见 [发送客服消息](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/customer-message/send.html)

发送客服消息
当用户和小程序客服产生特定动作的交互时（具体动作列表请见下方说明），微信将会把消息数据推送给开发者，开发者可以在一段时间内（目前为 48 小时）调用客服接口，通过调用 发送客服消息接口 来发送消息给普通用户。此接口主要用于客服等有人工消息处理环节的功能，方便开发者为用户提供更加优质的服务。

目前允许的动作列表如下，不同动作触发后，允许的客服接口下发消息条数和下发时限不同。

用户动作      允许下发条数限制    下发时限
用户发送消息         5 条        48 小时

#### 9.6.1 uploadTempMedia 把媒体文件上传到微信服务器。目前仅支持图片。用于发送客服消息或被动回复用户消息。

### 9.7 数据分析

#### 9.7.1 wx.reportAnalytics 自定义分析数据上报接口。

使用前，需要在小程序管理后台自定义分析中新建事件，配置好事件名与字段

```JS
wx.reportAnalytics('purchase', {
  price: 120,
  color: 'red'
})

//'purchase'  自动事件名  必填
/* {
  price: 120,  配置中的字段名 price 上报的数据 120
  color: 'red' 配置中的字段名 color 上报的数据 'red'
} */
```

#### 9.7.1 getAnalysisDailyRetain 获取用户访问小程序日留存 (本接口应在后端服务器调用!!!!!所以这个是后端的工作咯)

[官网地址](https://developers.weixin.qq.com/miniprogram/dev/api/open-api/data-analysis/getAnalysisDailyRetain.html)

#### 9.7.1 getAnalysisDailySummary 获取用户访问小程序数据概况 本接口应在后端服务器调用

[官网地址](https://developers.weixin.qq.com/miniprogram/dev/api/open-api/data-analysis/getAnalysisDailySummary.html)

#### 9.7.1 getAnalysisDailyVisitTrend 获取用户访问小程序数据日趋势 本接口应在后端服务器调用

#### 9.7.1 getAnalysisMonthlyRetain  获取用户访问小程序周留存 本接口应在后端服务器调用

#### 9.7.1 getAnalysisMonthlyVisitTrend 获取用户访问小程序数据月趋势 本接口应在后端服务器调用

#### 9.7.1 getAnalysisUserPortrait  获取小程序新增或活跃用户的画像分布数据。本接口应在后端服务器调用

时间范围支持昨天、最近7天、最近30天。其中，新增用户数为时间范围内首次访问小程序的去重用户数，活跃用户数为时间范围内访问过小程序的去重用户数。

#### 9.7.1 getAnalysisVisitDistribution 获取用户小程序访问分布数据 本接口应在后端服务器调用

#### 9.7.1 getAnalysisVisitPage 访问页面。目前只提供按 page_visit_pv 排序的 top200。 本接口应在后端服务器调用

#### 9.7.1 getAnalysisWeeklyRetain 获取用户访问小程序周留存 本接口应在后端服务器调用

#### 9.7.1 getAnalysisWeeklyVisitTrend 获取用户访问小程序数据周趋势 本接口应在后端服务器调用

### 9.8 发票

#### 9.8.1  用户授权

调用前需要  scope.invoice [用户授权](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/authorize.html)

#### 9.8.1 wx.chooseInvoice 选择用户已有的发票

调用前需要  scope.invoice [用户授权](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/authorize.html)

语法：wx.chooseInvoice(Object object)  基础库 2.3.0 开始支持，低版本需做兼容处理。

```JS
wx.chooseInvoice({
  success(res){
    //res.invoiceInfo  用户选中的发票列表
    /* {
      ardId: '',//所选发票卡券的 cardId
      encryptCode: '',//所选发票卡券的加密 code，报销方可以通过 cardId 和 encryptCode 获得报销发票的信息
      publisherAppId:''//发票方的 appId
    } */
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})
```

通过 cardId 和 encryptCode 获得报销发票的信息
请参考微信电子发票文档中，「查询报销发票信息」部分。 其中 access_token 的获取请参考getAccessToken文档

[微信电子发票文档](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=21517918939oae3U)
[getAccessToken文档](https://developers.weixin.qq.com/miniprogram/dev/api/open-api/access-token/getAccessToken.html)

#### 9.8.2 wx.chooseInvoiceTitle 选择用户的发票抬头

调用前需要  scope.invoiceTitle [用户授权](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/authorize.html)

语法：wx.chooseInvoiceTitle(Object object)

```JS
wx.chooseInvoiceTitle({
  success(res){
    res.type:'0',//string 抬头类型  0：单位 1：个人
    res.title:'',//抬头名称
    res.taxNumber:'',//抬头税号
    res.companyAddress:'',//单位地址
    res.telephone:'',//手机号码
    res.bankName:'',//银行名称
    res.bankAccount:'',//银行账号
    res.errMsg:''//错误信息
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})
```

### 9.9 登录

[官网小程序登录流程图](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/login.html)

小程序可以通过微信官方提供的登录能力方便地获取微信提供的用户身份标识，快速建立小程序内的用户体系。

![官网小程序登录流程图](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/image/api-login.jpg)

#### 9.9.1 wx.checkSession 检查登录态是否过期。

通过 wx.login 接口获得的用户登录态拥有一定的时效性。用户越久未使用小程序，用户登录态越有可能失效。反之如果用户一直在使用小程序，则用户登录态一直保持有效。具体时效逻辑由微信维护，对开发者透明。开发者只需要调用 wx.checkSession 接口检测当前用户登录态是否有效。

登录态过期后开发者可以再调用 wx.login 获取新的用户登录态。调用成功说明当前 session_key 未过期，调用失败说明 session_key 已过期。更多使用方法详见 小程序登录。(就是  9.9 解释的流程)

#### 9.9.2 wx.login 调用接口获取登录凭证 code  （这个code是临时登录凭证，用于获取 openid 的）

通过凭证进而换取用户登录态信息，包括用户的唯一标识（openid）及本次登录的会话密钥（session_key）等。用户数据的加解密通讯需要依赖会话密钥完成。更多使用方法详见 小程序登录。(就是  9.9 解释的流程)

#### 9.9.3 前端登录代码

```JS
wx.checkSession({
  success () {
    //session_key 未过期，并且在本生命周期一直有效
  },
  fail () {
    // session_key 已经失效，需要重新执行登录流程
    //重新登录
    wx.login({
      success (res) {
        if (res.code) {
          //发起网络请求   wepy 框架对这个有封装了。
          wx.request({
            url: 'https://test.com/onLogin',
            data: {
              code: res.code
            }
          })
        } else {
          console.log('登录失败！' + res.errMsg)
        }
      },
      fail(res){
        //
      },
      complete(res){
        //
      }
    })
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})
```

```JS
//wepy 框架的写法

// 方法一、WePY 使用方式, 需要开启 Promise 支持，参考开发规范章节
wepy.request('xxxx').then((d) => console.log(d));

// 方法二、async/await 的使用方式, 需要开启 Promise 和 async/await 支持，参考 WIKI
async function request () {
   let d = await wepy.request('xxxxx');
   console.log(d);
}
```

#### 9.9.4 code2Session 登录凭证校验。 本接口应在后端服务器调用

[官网地址](https://developers.weixin.qq.com/miniprogram/dev/api/code2Session.html)

### 9.10 小程序跳转 (从一个小程序 跳转 另外一个小程序)

#### 9.10.1 wx.navigateToMiniProgram   返回到上一个小程序。只有在当前小程序是被其他小程序打开时可以调用成功

小程序 1.3.0，小游戏 2.2.0

```JS
//A 小程序  => B 小程序
wx.navigateToMiniProgram({
  appId: '',//要打开的小程序 appId   必填
  path: 'page/index/index?id=123',//打开的页面路径，如果为空则打开首页  否
  extraData: {// 需要传递给目标小程序的数据，目标小程序可在 App.onLaunch，App.onShow 中获取到这份数据。  否
    foo: 'bar'
  },
  envVersion: 'develop',//要打开的小程序版本。否   默认值 'release':正式版本，'develop':开发版本，'trial':体验版
  //仅在当前小程序为开发版或体验版时此参数有效。如果当前小程序是正式版，则打开的小程序必定是正式版。
  success(res) {
    // 打开成功
  },
  fail(res){
    //
  },
  complete(res){
    //
  }
})
```

```JS
//  B 小程序(app.js 或者 app.wpy 中)

onShow(){
  //获取到这份数据。extraData
}

//或者
onLaunch(){
  //获取到这份数据。extraData
}
```

使用限制：

- 需要用户触发跳转：
    从 2.3.0 版本开始，若用户未点击小程序页面任意位置，则开发者将无法调用此接口自动跳转至其他小程序。
- 需要用户确认跳转：
    从 2.3.0 版本开始，在跳转至其他小程序前，将统一增加弹窗，询问是否跳转，用户确认后才可以跳转其他小程序。如果用户点击取消，则回调 `fail cancel。`
- 每个小程序可跳转的其他小程序数量限制为不超过 10 个：
    从 2.4.0 版本以及指定日期（具体待定）开始，开发者提交新版小程序代码时，如使用了跳转其他小程序功能，则需要在代码配置中声明将要跳转的小程序名单，限定不超过 10 个，否则将无法通过审核。该名单可在发布新版时更新，不支持动态修改。配置方法详见 配置。调用此接口时，所跳转的 appId 必须在配置列表中，否则回调 `fail appId "${appId}" is not in navigateToMiniProgramAppIdList。`
    在 app.json  / 或者是 app.wpy 中设置如下
    `"navigateToMiniProgramAppIdList": ["wxe5f52902cf4de896"]`
    [该项配置](https://developers.weixin.qq.com/miniprogram/dev/framework/config.html#%E5%85%A8%E5%B1%80%E9%85%8D%E7%BD%AE)

关于调试

- 在开发者工具上调用此 API 并不会真实的跳转到另外的小程序，但是开发者工具会校验本次调用跳转是否成功。[详情](https://developers.weixin.qq.com/miniprogram/dev/devtools/different.html?t=18112917#%E8%B7%B3%E8%BD%AC%E5%B0%8F%E7%A8%8B%E5%BA%8F%E8%B0%83%E8%AF%95%E6%94%AF%E6%8C%81)
- 开发者工具上支持被跳转的小程序处理接收参数的调试。[详情](https://developers.weixin.qq.com/miniprogram/dev/devtools/different.html?t=18112917#%E8%B7%B3%E8%BD%AC%E5%B0%8F%E7%A8%8B%E5%BA%8F%E8%B0%83%E8%AF%95%E6%94%AF%E6%8C%81)

#### 9.10.2 wx.navigateBackMiniProgram  打开另一个小程序

基础库 1.3.0 开始支持，低版本需做兼容处理。注意：微信客户端 iOS 6.5.9，Android 6.5.10 及以上版本支持

```JS
// B 小程序  => A 小程序
wx.navigateBackMiniProgram({
  // 需要返回给上一个小程序的数据，上一个小程序可在 App.onShow 中获取到这份数据。
    extraData: {
    foo: 'bar'
  },
  success(res) {
    // 返回成功
  },
  fail(res){
    //
  }/* ,
  complete(res){
    //
  } */
})
```

```JS
//  A 小程序(app.js 或者 app.wpy 中)
onShow(){
  //获取到这份数据。extraData
}
```

### 9.11 附近的小程序（后端的工作）

[官网文档地址](https://developers.weixin.qq.com/miniprogram/dev/api/addNearbyPoi.html)

#### 9.11.1 addNearbyPoi 添加地点 本接口应在后端服务器调用

#### 9.11.1 deleteNearbyPoi 删除地点 本接口应在后端服务器调用

#### 9.11.1 getNearbyPoiList 查看地点列表 本接口应在后端服务器调用

#### 9.11.1 setNearbyPoiShowStatus 展示/取消展示附近小程序 本接口应在后端服务器调用

### 9.12 支付（仅仅是微信支付）

#### 9.12.1 wx.requestPayment 发起微信支付。

了解更多信息，[请查看微信支付接口文档](https://pay.weixin.qq.com/wiki/doc/api/wxa/wxa_api.php?chapter=7_3&index=1)
了解更多信息，[小程序支付接口文档](https://pay.weixin.qq.com/wiki/doc/api/wxa/wxa_api.php?chapter=7_7&index=3)

```JS
wx.requestPayment({
  timeStamp: '',  // 必填  时间戳，从 1970 年 1 月 1 日 00:00:00 至今的秒数，即当前的时间
  nonceStr: '',   // 必填  随机字符串，长度为32个字符以下
  package: '',    // 必填  统一下单接口返回的 prepay_id 参数值，提交格式如：prepay_id=***
  signType: 'MD5',// 否   签名算法  2 个合法值：'MD5',  'HMAC-SHA256'
  paySign: '',    // 必填 签名，具体签名方案参见 小程序支付接口文档
  success (res) { },
  fail (res) { }
  /* complete(res){} */
})
```

### 9.13 插件管理 （本接口应在后端服务器调用）

[官网教程](https://developers.weixin.qq.com/miniprogram/dev/api/applyPlugin.html)

#### 9.13.1applyPlugin 向插件开发者发起使用插件的申请（本接口应在后端服务器调用）

#### 9.13.1getPluginDevApplyList 获取当前所有插件使用方（供插件开发者调用）（本接口应在后端服务器调用）

#### 9.13.1getPluginList  查询已添加的插件（本接口应在后端服务器调用）

#### 9.13.1setDevPluginApplyStatus 修改插件使用申请的状态（供插件开发者调用）（本接口应在后端服务器调用）

#### 9.13.1unbindPlugin 删除已添加的插件（本接口应在后端服务器调用）

### 9.14 二维码 （本接口应在后端服务器调用）

#### 9.14.1 createWXAQRCode 获取 [小程序二维码]，适用于需要的码数量  [较少]   的业务场景。 （本接口应在后端服务器调用）

通过该接口生成的小程序码，永久有效，有数量限制，[详见获取二维码](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/qr-code.html)

#### 9.14.1 getWXACode     获取 [小程序码]，适用于需要的码数量   [较少]   的业务场景。 （本接口应在后端服务器调用）

通过该接口生成的小程序码，永久有效，有数量限制，[详见获取二维码](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/qr-code.html)

#### 9.14.1 getWXACodeUnlimit 获取 [小程序码]，适用于需要的码数量 [极多] 的业务场景。 （本接口应在后端服务器调用）

通过该接口生成的小程序码，永久有效，数量暂无限制。 [详见获取二维码](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/qr-code.html)

### 9.15 内容安全（检查 用户  图片 或者 文本 的安全性）（本接口应在后端服务器调用）

[官网教程](https://developers.weixin.qq.com/miniprogram/dev/api/imgSecCheck.html)

#### 9.15.1 imgSecCheck  校验一张图片是否含有违法违规内容。（本接口应在后端服务器调用）

#### 9.15.1 msgSecCheck 检查一段文本是否含有违法违规内容。（本接口应在后端服务器调用）

### 9.16 设置

#### 9.16.1 AuthSetting

AuthSetting
用户授权设置信息，详情参考[权限](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/authorize.html)

属性
boolean scope.userInfo
是否授权用户信息，对应接口 wx.getUserInfo

boolean scope.userLocation
是否授权地理位置，对应接口 wx.getLocation, wx.chooseLocation

boolean scope.address
是否授权通讯地址，对应接口 wx.chooseAddress

boolean scope.invoiceTitle
是否授权发票抬头，对应接口 wx.chooseInvoiceTitle

boolean scope.invoice
是否授权获取发票，对应接口 wx.chooseInvoice

boolean scope.werun
是否授权微信运动步数，对应接口 wx.getWeRunData

boolean scope.record
是否授权录音功能，对应接口 wx.startRecord

boolean scope.writePhotosAlbum
是否授权保存到相册 wx.saveImageToPhotosAlbum, wx.saveVideoToPhotosAlbum

boolean scope.camera
是否授权摄像头，对应<camera /> 组件

#### 9.16.2 wx.getSetting 获取用户的当前设置。

返回值中只会出现小程序已经向用户请求过的权限。

```JS
wx.getSetting({
  success (res) {
    console.log(res.authSetting)//用户授权结果
    // res.authSetting = {
    //   "scope.userInfo": true,
    //   "scope.userLocation": true
    // }
  }
})
```

#### 9.16.3 wx.openSetting 调起客户端小程序设置界面，返回用户设置的操作结果。

设置界面只会出现小程序已经向用户请求过的[权限](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/authorize.html)
注意：2.3.0 版本开始，用户发生点击行为后，才可以跳转打开设置页，管理授权信息。[详情](https://developers.weixin.qq.com/community/develop/doc/000cea2305cc5047af5733de751008)

```JS
wx.openSetting({
  success (res) {
    console.log(res.authSetting)//用户授权结果
    // res.authSetting = {
    //   "scope.userInfo": true,
    //   "scope.userLocation": true
    // }
  }
})
```

### 9.17 生物认证(指纹识别，人脸识别，声纹识别)

#### 9.17.1 wx.checkIsSoterEnrolledInDevice 获取设备内是否录入如指纹等生物信息的接口

```JS
wx.checkIsSoterEnrolledInDevice({
  checkAuthMode: 'fingerPrint', //Array.<string> 不是字符串数组 么？？？？？这里好像不对把？？？ 认证方式  必填
  // 'fingerPrint':指纹识别   'facial':人脸识别（暂未支持）  'speech':声纹识别（暂未支持）
  success(res) {
    console.log(res.isEnrolled)//是否已录入信息  boolean
    console.log(res.errMs)//错误信息  string
  },
  fail(res){},
  //complete(res){}
})
```

#### 9.17.1 wx.checkIsSupportSoterAuthentication

#### 9.17.1 wx.startSoterAuthentication

### 9.18 模板消息 （本接口应在后端服务器调用）

[官网文档](https://developers.weixin.qq.com/miniprogram/dev/api/addTemplate.html)

#### 9.18.1 addTemplate 组合模板并添加至帐号下的个人模板库（本接口应在后端服务器调用）

#### 9.18.1 deleteTemplate 删除帐号下的某个模板（本接口应在后端服务器调用）

#### 9.18.1 getTemplateLibraryById 获取模板库某个模板标题下关键词库（本接口应在后端服务器调用）

#### 9.18.1 getTemplateLibraryList 获取小程序模板库标题列表（本接口应在后端服务器调用）

#### 9.18.1 getTemplateList 获取帐号下已存在的模板列表（本接口应在后端服务器调用）

#### 9.18.1 sendTemplateMessage 发送模板消息（本接口应在后端服务器调用）

### 9.19 统一服务消息 （本接口应在后端服务器调用）

#### 9.19.1 sendUniformMessage   下发小程序和公众号统一的服务消息 （本接口应在后端服务器调用）

### 9.20 动态消息 （本接口应在后端服务器调用）

[动态消息](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/share/updatable-message.html)

#### 9.20.1 createActivityId 创建被分享动态消息的 activity_id。 （本接口应在后端服务器调用）

#### 9.20.2 setUpdatableMsg 修改被分享的动态消息。详见动态消息。（本接口应在后端服务器调用）

### 9.21 用户信息 (调用前需要 用户授权)

#### 9.21.1 UserInfo  用户信息

- nickName：string
- avatarUrl：string
    用户头像图片的 URL。URL 最后一个数值代表正方形头像大小（有 0、46、64、96、132 数值可选，0 代表 640x640 的正方形头像，46 表示 46x46 的正方形头像，剩余数值以此类推。默认132），用户没有头像时该项为空。若用户更换头像，原有头像 URL 将失效。
- gender:number
    0:未知   1:男性    2:女性
- country:''
    用户所在国家
- province:''
    用户所在省份
- city:''
    用户所在城市
- 'language':''
    显示 country，province，city 所用的语言
    en:   英文
    zh_CN:简体中文
    zh_TW:体中文

#### 9.21.2 wx.getUserInfo 获取用户信息。

**userInfo 类型的数据**：就是 9.21.1 中说的类型
[加密数据解密算法](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/signature.html)

```JS
// 必须是在用户已经授权的情况下调用
wx.getUserInfo({
    withCredentials:true,//是否带上登录态信息。    否
    //当 withCredentials 为 true 时，要求此前有调用过 wx.login 且登录态尚未过期，
    //此时返回的数据会包含 encryptedData, iv 等敏感信息；
    //当 withCredentials 为 false 时，不要求有登录态，返回的数据不包含 encryptedData, iv 等敏感信息。
    lang:'en',//显示用户信息的语言    否   默认值'en'：英文   zh_CN：简体中文   zh_TW：繁体中文
    success: function(res) {
      var userInfo = res.userInfo// UserInfo  用户信息对象，不包含 openid 等敏感信息
      res.rawData = ''//不包括敏感信息的原始数据字符串，用于计算签名
      res.signature = ''//使用 sha1( rawData + sessionkey ) 得到字符串，用于校验用户信息，详见 用户数据的签名验证和加解密
      res.encryptedData = ''//包括敏感数据在内的完整用户信息的加密数据，详见 用户数据的签名验证和加解密
      res.iv = ''//加密算法的初始向量，详见 用户数据的签名验证和加解密

      var nickName = userInfo.nickName
      var avatarUrl = userInfo.avatarUrl
      var gender = userInfo.gender //性别 0：未知、1：男、2：女
      var province = userInfo.province
      var city = userInfo.city
      var country = userInfo.country
    },
    fail(res){},
  /*   complete(res){} */
})
```

encryptedData 解密后为以下 json 结构，详见加密数据解密算法

```JSON
{
    "openId": "OPENID",
    "nickName": "NICKNAME",
    "gender": GENDER,
    "city": "CITY",
    "province": "PROVINCE",
    "country": "COUNTRY",
    "avatarUrl": "AVATARURL",
    "unionId": "UNIONID",
    "watermark": {
        "appid": "APPID",
        "timestamp": TIMESTAMP
    }
}
```

##### 9.21.1.1 在用户未授权过的情况下调用此接口，将不再出现授权弹窗!!!!!!!!!!!!!!!!!!!!!!!!!!!!每次小程序都提示的消息

会直接进入 fail 回调（详见《公告》)。在用户已授权的情况下调用此接口，可成功获取用户信息。

```HTML
<!-- 如果只是展示用户头像昵称，可以使用 <open-data /> 组件 -->
<open-data type="userAvatarUrl"></open-data>
<open-data type="userNickName"></open-data>
<!-- 需要使用 button 来授权登录 -->
<button wx:if="{{canIUse}}" open-type="getUserInfo" bindgetuserinfo="bindGetUserInfo">授权登录</button>
<view wx:else>请升级微信版本</view>
```

```JS
Page({
  data: {
    canIUse: wx.canIUse('button.open-type.getUserInfo')
  },
  onLoad: function() {
    // 查看是否授权
    wx.getSetting({
      success (res){
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称
          wx.getUserInfo({
            success: function(res) {
              console.log(res.userInfo)
            }
          })
        }
      }
    })
  },
  bindGetUserInfo (e) {
    console.log(e.detail.userInfo)
  }
})
```

### 9.22微信运动 (调用前需要 用户授权)

#### 9.22.1 wx.getWeRunData 获取用户过去三十天微信运动步数。

调用前需要 用户授权 scope.werun。
需要先调用 wx.login 接口。步数信息会在用户主动进入小程序时更新。

[加密数据解密算法](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/signature.html)

```JS
wx.getWeRunData({
  success(res) {
    //res.encryptedData:'',  包括敏感数据在内的完整用户信息的加密数据，详细见加密数据解密算法。
    //res.iv:''              加密算法的初始向量
    const encryptedData = res.encryptedData
  },
  fail(res) {},
  /* complete (res) {} */
})
```

```JSON
//encryptedData 解密后 JSON 结构
{
  "stepInfoList": [
    {
      "timestamp": 1445866601,//时间戳，表示数据对应的时间
      "step": 100//微信运动步数
    },
    {
      "timestamp": 1445876601,
      "step": 120
    }
  ]
}
```

## 十、更新 UpdateManager(小程序版本更新)（个人中心提示用户版本升级用的）

UpdateManager 对象，用来管理更新，可通过 wx.getUpdateManager 接口获取实例。

### 10.1 wx.getUpdateManager  获取全局唯一的版本更新管理器，用于管理小程序更新。关于小程序的更新机制，可以查看运行机制文档。

[小程序运行机制](https://developers.weixin.qq.com/miniprogram/dev/framework/operating-mechanism.html)

小程序启动会有两种情况，一种是「冷启动」，一种是「热启动」。（这个跟小车的启动方式么~）

- 热启动：假如用户已经打开过某小程序，然后在一定时间内再次打开该小程序，此时无需重新启动，只需将后台态的小程序切换到前台，这个过程就是热启动；
- 冷启动：指的是用户首次打开或小程序被微信主动销毁后再次打开的情况，此时小程序需要重新加载启动。

### 10.2 UpdateManager.applyUpdate  强制小程序重启并使用新版本。

在小程序新版本下载完成后（即收到 onUpdateReady 回调）调用。

### 10.3 UpdateManager.onCheckForUpdate 监听向微信后台请求检查更新结果事件。

微信在小程序冷启动时自动检查更新，不需由开发者主动触发。

### 10.4 UpdateManager.onUpdateFailed 监听小程序更新失败事件。

小程序有新版本，客户端主动触发下载（无需开发者触发），下载失败（可能是网络原因等）后回调

### 10.5 UpdateManager.onUpdateReady 监听小程序有版本更新事件。

客户端主动触发下载（无需开发者触发），下载成功后回调

### 10.6 完整示例代码

```JS
const updateManager = wx.getUpdateManager()//获取全局唯一的版本更新管理器，用于管理小程序更新。(更新管理器对象)

//监听向微信后台请求检查更新结果事件。微信在小程序冷启动时自动检查更新，不需由开发者主动触发。
updateManager.onCheckForUpdate((res)=>{
  // 请求完新版本信息的回调
  console.log(res.hasUpdate)//是否有新版本  boolean
})

//监听小程序有版本更新事件。客户端主动触发下载（无需开发者触发），下载成功后回调
updateManager.onUpdateReady(function () {
  wx.showModal({
    title: '更新提示',
    content: '新版本已经准备好，是否重启应用？',
    success: function (res) {
      if (res.confirm) {
        // 新的版本已经下载好，调用 applyUpdate 应用新版本并重启
        // 强制小程序重启并使用新版本。在小程序新版本下载完成后（即收到 onUpdateReady 回调）调用。
        updateManager.applyUpdate()
      }
    }
  })
})

//监听小程序更新失败事件。小程序有新版本，客户端主动触发下载（无需开发者触发），下载失败（可能是网络原因等）后回调
updateManager.onUpdateFailed(function () {
  // 新版本下载失败
})
```

注意：Tips
微信开发者工具上可以通过「编译模式」下的「下次编译模拟更新」开关来调试
小程序开发版/体验版没有「版本」概念，所以无法在开发版/体验版上测试更版本更新情况

## 十一、Worker（运行一些异步处理的任务）（就是变成语言中的单线程 与 多线程 js 中是单线程工作的）

Worker 实例，主线程中可通过 wx.createWorker 接口获取，worker 线程中可通过全局变量 worker 获取。

一些异步处理的任务，可以放置于 Worker 中运行，待运行结束后，再把结果返回到小程序主线程。Worker 运行于一个单独的全局上下文与线程中，不能直接调用主线程的方法。

Worker 与主线程之间的数据传输，双方使用 Worker.postMessage() 来发送数据，Worker.onMessage() 来接收数据，传输的数据并不是直接共享，而是被复制的。

### 11.1 wx.createWorker   创建一个 Worker 线程。

目前限制最多只能创建一个 Worker，创建下一个 Worker 前请先调用 Worker.terminate

### 11.2 Worker.onMessage   监听主线程/Worker 线程向当前线程发送的消息的事件。

### 11.3 Worker.postMessage  向主线程/Worker 线程发送的消息。

语法：Worker.postMessage(Object message)

参数：需要发送的消息，必须是一个可序列化的 JavaScript 对象。

### 11.4 Worker.terminate()   结束当前 Worker 线程。

仅限在主线程 worker 对象上调用。无参数

### 11.5 完整的示例代码！！！！！！！！！！！！！

运行以下代码需先进行基础配置，详细请查阅 多线程 文档了解基础知识和配置方法。

#### 11.5.1 使用流程：配置过程

[官网网址](https://developers.weixin.qq.com/miniprogram/dev/framework/workers.html)

```JS
const worker = wx.createWorker('workers/request/index.js') // 文件名指定 worker 的入口文件路径，绝对路径

worker.onMessage((res)=> {
  console.log(res)
})

worker.postMessage({
  msg: 'hello worker'
})

worker.terminate()
```

## 十二、数据上报（小程序管理后台-运维中心-性能监控-业务数据监控）（说白了就是小程序的用户使用各种情况数据？？？）

### 12.1 wx.reportMonitor 自定义业务数据监控上报接口。

语法：wx.reportMonitor(string name, number value)

```JS
wx.reportMonitor('1', 1)
// 参数 ① string 监控 ID，在「小程序管理后台」新建数据指标后获得
// 参数 ② number 上报数值，经处理后会在「小程序管理后台」上展示每分钟的上报总量
```

使用前，需要在「小程序管理后台-运维中心-性能监控-业务数据监控」中新建监控事件，配置监控描述与告警类型。每一个监控事件对应唯一的监控 ID，开发者最多可以创建 128 个监控事件。

## 十三、小程序（事件错误 与 生命周期）

### 13.1 wx.offError 事件：取消监听小程序错误事件。

语法：wx.offError(function callback)

```JS
wx.offError((res)=>{
  //
})
```

### 13.2 wx.onError 事件：监听小程序错误事件。如脚本错误或API调用报错等。？？？？？看不懂啊？？？？

语法：wx.onError(function callback)

```JS
wx.offError((res)=>{
  //错误信息，包含堆栈
})
```

### 13.3 wx.getLaunchOptionsSync 生命周期 ：获取小程序启动时的参数。与 App.onLaunch 的回调参数一致。

```JS
const obj = wx.getLaunchOptionsSync()
obj.path//打开小程序的路径
obj.scene//打开小程序的场景值  number
obj.query//打开小程序的启动参数 Object 所以原生的 onload 接收参数就是 option.query 就是这个 url 传参的对象!!!
obj.shareTicket//获取更多转发信息 String
obj.referrerInfo//Object 来源信息。从另一个小程序、公众号或 App 进入小程序时返回。否则返回 {}。(参见后文注意)

referrerInfo:{
  appId:'',//来源小程序、公众号或 App 的 appId
  extraData:{
    //来源小程序传过来的数据，scene=1037 或 1038 时支持， 13.3.4 中的其他值呢？？？支持么？？？？
  }
}
```

#### 13.3.1 scene 场景值

[官网网址](https://developers.weixin.qq.com/miniprogram/dev/framework/app-service/scene.html)

1005 ，1104 等

- 对于小程序，可以在 App 的 onLaunch 和 onShow，或 wx.getLaunchOptionsSync 中获取上述场景值。
- 对于小游戏，可以在 wx.getLaunchOptionsSync 和 wx.onShow 中获取上述场景值

##### 小游戏于小程序什么区别？？？？？？

部分场景值下还可以获取来源应用、公众号或小程序的 appId。

Tip: 由于 Android 系统限制，目前还无法获取到按 Home 键退出到桌面，然后从桌面再次进小程序的场景值，对于这种情况，会保留上一次的场景值。

#### 13.3.2  wx.getLaunchOptionsSync 返回有效 referrerInfo 的场景

```BASH
1020  公众号 profile 页相关小程序列表   来源公众号
1035  公众号自定义菜单                 来源公众号
1036  App 分享消息卡片                 来源App
1037  小程序打开小程序                 来源小程序
1038  从另一个小程序返回               来源小程序
1043  公众号模板消息                   来源公众号
```

#### 13.3.3 注意

部分版本在无 referrerInfo 的时候会返回 undefined，建议使用 wx.canIUse 接口进行判断。

```JS
wx.canIUse('options.referrerInfo && options.referrerInfo.appId')
```

## 十四、基础（判断是否可以 某些 API 接口：当然是能用才可以用）

### 14.1 wx.canIUse 判断小程序的API，回调，参数，组件等是否在当前版本可用。

```BASH
参数的写法：
①： ${API}.${method}.${param}.${options}  # API.method.param.options
②:  ${component}.${attribute}.${option}   # component.attribute.option
参数说明:
${API} 代表 API 名字
${method} 代表调用方式，有效值为return, success, object, callback
${param} 代表参数或者返回值
${options} 代表参数的可选值
${component} 代表组件名字
${attribute} 代表组件属性
${option} 代表组件属性的可选值
```

```JS
wx.canIUse('openBluetoothAdapter') //API
wx.canIUse('getSystemInfoSync.return.screenWidth')//API.method.options
wx.canIUse('getSystemInfo.success.screenWidth')//API.method.options
wx.canIUse('showToast.object.image')
wx.canIUse('onCompassChange.callback.direction')
wx.canIUse('request.object.method.GET')//？？？？？？？？？？？？？这个就看不懂了呀

wx.canIUse('live-player')
wx.canIUse('text.selectable')
wx.canIUse('button.open-type.contact')
```

## 十五、画布（是不是做动画的？？？？？后面再学习吧）

### 15.1 Color 颜色。可以用以下几种方式来表示 canvas 中使用的颜色：

```BASH
# RGB 颜色：    如 'rgb(255, 0, 0)'
# RGBA 颜色：   如 'rgba(255, 0, 0, 0.3)' 带有透明度
# 16 进制颜色： 如 '#FF0000'，大小写不敏感
# 预定义的颜色： 如 'red'，   大小写不敏感
```

[预定义的颜色官网网址](https://developers.weixin.qq.com/miniprogram/dev/api/canvas/Color.html)

### 15.2 CanvasContext 是 canvas 组件的绘图上下文

[官网地址](https://developers.weixin.qq.com/miniprogram/dev/api/canvas/CanvasContext.fill.html)

#### 15.2.1 wx.createCanvasContext（） 创建 创建 CanvasContext 对象

**一个参数**

```HTML
<canvas canvas-id="myCanvas" class="myCanvas" ></canvas>
```

```JS
onLoad(){
  // 一、创建对象
  const ctx = wx.createCanvasContext('myCanvas')//
  //对应的参数
  // 参数 ① ：是 <canvas> 组件的  canvas-id  属性值
  //没有 this（省略第二个参数），则不在任何自定义组件内查找，就是重新绘制。？？？？
}
```

**2 个参数**

```HTML
 <canvas canvas-id="canvasIn" class="canvas"></canvas>
 <canvas canvas-id="canvasOut" class="canvas"></canvas>
 <button bindtap="openAndDraw">打开图片并绘制</button>
 <button bindtap="process">处理图像</button>
 <button bindtap="export">导出画布至图片</button>
```

```JS
  openAndDraw() {
    wx.chooseImage({
      success: (res) => {
        const ctx = wx.createCanvasContext('canvasIn', this);
        ctx.drawImage(res.tempFilePaths[0], 0, 0)
        ctx.draw()
      }
    })
  }
// 参数 ① ： 是 <canvas> 组件的  canvas-id  属性值
// 参数 ② ： 在自定义组件下，当前组件实例的 this，表示在这个自定义组件下查找拥有 canvas-id 的 <canvas> ，
```

#### 15.2.1 CanvasContext.arc 与 CanvasContext.arcTo  绘制一段弧线

```HTML
<canvas canvas-id="myCanvas" class="myCanvas" ></canvas>
```

```JS
onLoad(){
  const ctx = wx.createCanvasContext('myCanvas')//
  //对应的参数是 <canvas> 组件的  canvas-id  属性值

  //绘制弧线
  ctx.arc(100, 75, 50, 0, 2 * Math.PI)
  // 参数 ： ① 圆心 x 坐标, ② y 坐标,③ r 半径， ④ 起始弧度,单位弧度（在3点钟方向）???， ⑤ 终止弧度???，
  // ⑥ 弧度的方向是否是逆时针 number????

  //根据 控制点 和 半径 绘制圆弧路径
  ctx.arcTo(0, 0, 50, 50, 50)
  // 参数 ： ① 第 1 个控制点的 x 轴坐标, ② 第 1 个控制点的 y 轴坐标
  //         ③ 第2 个控制点的 x 轴坐标, ④  第 2 个控制点的 y 轴坐标，⑤ 圆弧的半径
}
```

#### 15.2.2  CanvasContext.rect 绘制矩形

```HTML
<canvas canvas-id="myCanvas" class="myCanvas" ></canvas>
```

```JS
onLoad(){
  // 一、创建对象
  const ctx = wx.createCanvasContext('myCanvas')//
  //对应的参数是 <canvas> 组件的  canvas-id  属性值

  //绘制矩形路径
  ctx.rect(10, 10, 150, 75)
  // 参数 ： ① 矩形路径左上角的横坐标, ② 矩形路径左上角的横坐标
  //         ③ 矩形路径的宽度         ④ 矩形路径的高度

  //清除画布上在该矩形区域内的内容
}
```

#### 15.2.3  CanvasContext.bezierCurveTo() 绘制三次方贝塞尔曲线路径。曲线的起始点为路径中前一个点。

```HTML
<canvas canvas-id="myCanvas" class="myCanvas" ></canvas>
```

```JS
onLoad(){
  // 一、创建对象
  const ctx = wx.createCanvasContext('myCanvas')//
  //对应的参数是 <canvas> 组件的  canvas-id  属性值

  // 二、
 

  ctx.setFillStyle('#EEEEEE')// 三、 设置填充色。
  ctx.fill()//对当前路径中的内容进行填充。无参数，颜色由 setFillStyle() 决定，没有设置的话就 默认的填充色为黑色。
  // 如果当前路径没有闭合，fill() 方法会将起点和终点进行连接，然后填充。也就数把弧度首位链接填充起来

  ctx.beginPath()
  ctx.moveTo(40, 75)
  ctx.lineTo(160, 75)
  ctx.moveTo(100, 15)
  ctx.lineTo(100, 135)
  ctx.setStrokeStyle('#AAAAAA')
  ctx.stroke()

  ctx.setFontSize(12)
  ctx.setFillStyle('black')
  ctx.fillText('0', 165, 78)
  ctx.fillText('0.5*PI', 83, 145)
  ctx.fillText('1*PI', 15, 78)
  ctx.fillText('1.5*PI', 83, 10)

  // Draw points
  ctx.beginPath()
  ctx.arc(100, 75, 2, 0, 2 * Math.PI)
  ctx.setFillStyle('lightgreen')
  ctx.fill()

  ctx.beginPath()
  ctx.arc(100, 25, 2, 0, 2 * Math.PI)
  ctx.setFillStyle('blue')
  ctx.fill()

  ctx.beginPath()
  ctx.arc(150, 75, 2, 0, 2 * Math.PI)
  ctx.setFillStyle('red')
  ctx.fill()

  // Draw arc
  ctx.beginPath()
  ctx.arc(100, 75, 50, 0, 1.5 * Math.PI)
  ctx.setStrokeStyle('#333333')
  ctx.stroke()
  ctx.draw()
}
```

### 15.3 CanvasGradient 渐变对象

#### 15.3.1 CanvasGradient.addColorStop 添加颜色的渐变点。

小于最小 stop 的部分会按最小 stop 的 color 来渲染，大于最大 stop 的部分会按最大 stop 的 color 来渲染

语法：CanvasGradient.addColorStop(number stop, Color color)

```JS
const ctx = wx.createCanvasContext('myCanvas')

// Create circular gradient
const grd = ctx.createLinearGradient(30, 10, 120, 10)
grd.addColorStop(0, 'red')//  0 表示渐变中开始与结束之间的位置，范围 0-1。
grd.addColorStop(0.16, 'orange')// orange 渐变点的颜色。
grd.addColorStop(0.33, 'yellow')
grd.addColorStop(0.5, 'green')
grd.addColorStop(0.66, 'cyan')
grd.addColorStop(0.83, 'blue')
grd.addColorStop(1, 'purple')

// Fill with gradient
ctx.setFillStyle(grd)
ctx.fillRect(10, 10, 150, 80)
ctx.draw()
```

### 15.4 wx.canvasGetImageData 获取 canvas 区域隐含的像素数据。

语法：wx.canvasGetImageData(Object object, Object this)

第二个参数：this 在自定义组件下，当前组件实例的this，以操作组件内 <canvas> 组件  可选

```HTML
 <canvas canvas-id="canvasIn" class="canvas"></canvas>
 <canvas canvas-id="canvasOut" class="canvas"></canvas>
 <button bindtap="openAndDraw">打开图片并绘制</button>
 <button bindtap="process">处理图像</button>
 <button bindtap="export">导出画布至图片</button>
```

```JS
  const cfg = {
      x: 0,
      y: 0,
      width: 300,
      height: 300,
  }
  wx.canvasGetImageData({
    canvasId: 'canvasIn',// 画布标识，传入 <canvas> 组件的 canvas-id 属性。  必填
    //x:0,//将要被提取的图像数据矩形区域的左上角横坐标 必填
    //y:0,//将要被提取的图像数据矩形区域的左上角纵坐标 必填
    //width:300,//将要被提取的图像数据矩形区域的宽度 必填
    //height:300,//将要被提取的图像数据矩形区域的高度 必填
    ...cfg,//以这种方法把上面的几个属性移到外面写
    success: (res) => {
      const data = convertToGrayscale(res.data)
      //console.log(res.width) // 300 图像数据矩形的宽度
      //console.log(res.height) // 300 图像数据矩形的高度
      //console.log(res.data instanceof Uint8ClampedArray) // true
      //Uint8ClampedArray data  图像像素点数据，一维数组，每四项表示一个像素点的 rgba
      //console.log(res.data.length) // 300 * 300 * 4
      wx.canvasPutImageData({
        canvasId: 'canvasOut',
        data,
        ...cfg,
        success: (res) => {
          console.log(res)
        },
        fail: (err) => {
          console.error(err)
        }
      })
    },
    fail: (err) => {
      console.error(err)
    },
    complete:(res)=>{
      //
    }
   )
```

### 15.5 wx.canvasPutImageData 将像素数据绘制到画布。

在自定义组件下，第二个参数传入自定义组件实例 this，以操作组件内  `<canvas>` 组件

语法：wx.canvasPutImageData(Object object, Object this)

```HTML
 <canvas canvas-id="canvasIn" class="canvas"></canvas>
 <canvas canvas-id="canvasOut" class="canvas"></canvas>
 <button bindtap="openAndDraw">打开图片并绘制</button>
 <button bindtap="process">处理图像</button>
 <button bindtap="export">导出画布至图片</button>
```

```JS
process() {
    const cfg = {
      x: 0,
      y: 0,
      width: 300,
      height: 300,
    }
    // 获取 canvas 区域隐含的像素数据。
    wx.canvasGetImageData({
      canvasId: 'canvasIn',
      ...cfg,
      success: (res) => {
        const data = convertToGrayscale(res.data)// 在这里定义了data
        //将像素数据绘制到画布。
        wx.canvasPutImageData({
          canvasId: 'canvasOut',// 画布标识，传入 <canvas> 组件的 canvas-id 属性。  必填
          data,//这样使用外面定义的参数，//Uint8ClampedArray  图像像素点数据，一维数组，每四项表示一个像素点的 rgba 必填
            //x:0,//将要被提取的图像数据矩形区域的左上角横坐标 必填
            //y:0,//将要被提取的图像数据矩形区域的左上角纵坐标 必填
            //width:300,//将要被提取的图像数据矩形区域的宽度 必填
            //height:300,//将要被提取的图像数据矩形区域的高度 必填
          ...cfg,//这样使用外面定义的参数对象
          success: (res) => {
            console.log(res)
          },
          fail: (err) => {
            console.error(err)
          },
          complete:(res)=>{
            //
          }
        })
      },
      fail: (err) => {
        console.error(err)
      },
      complete:(res)=>{
        //
      }
    })
  }
```

### 15.6 wx.canvasToTempFilePath 把当前画布指定区域的内容导出生成指定大小的图片。

在 draw() 回调里调用该方法才能保证图片导出成功。

语法：wx.canvasToTempFilePath(Object object, Object this)
第二个参数：在自定义组件下，当前组件实例的 this，以操作组件内  `<canvas>` 组件

```HTML
 <canvas canvas-id="canvasIn" class="canvas"></canvas>
 <canvas canvas-id="canvasOut" class="canvas"></canvas>
 <button bindtap="openAndDraw">打开图片并绘制</button>
 <button bindtap="process">处理图像</button>
 <button bindtap="export">导出画布至图片</button>
```

```JS
export() {
  const cfg = {
    x: 0,
    y: 0,
    width: 300,
    height: 300,
    destWidth: 100,
    destHeight: 100
  }
  //把当前画布指定区域的内容导出生成指定大小的图片。
  wx.canvasToTempFilePath({
    canvasId: 'canvasOut',// 画布标识，传入 <canvas> 组件的 canvas-id   必填
    //x:0,//将要被提取的图像数据矩形区域的左上角横坐标 否
    //y:0,//将要被提取的图像数据矩形区域的左上角纵坐标 否
    //width:300,//将要被提取的图像数据矩形区域的宽度  否   canvas宽度-x
    //height:300,//将要被提取的图像数据矩形区域的高度 否   canvas高度-y
    //destWidth: 100,//指定的画布区域的高度          否   width*屏幕像素密度
    //destHeight: 100//输出的图片的宽度              否   height*屏幕像素密度
    ...cfg,// 上面几个参数的外面 定义里面应用
    fileType:'png',// 目标文件的类型（jpg/png）      否  默认为 png 格式
    quality:0.8,//图片的质量，目前仅对 jpg 有效。取值范围为 (0, 1]，不在范围内时当作 1.0 处理。  必填
    success: (res) => {
      //res.tempFilePath
      wx.saveImageToPhotosAlbum({
        filePath: res.tempFilePath,//res.tempFilePath  生成文件的临时路径，wx.canvasToTempFilePath 接口的 成功回调
        success: (res) => {
          console.log(res)
        },
        fail: (err) => {
          console.error(err)
        }
      })
    },
    fail: (err) => {
      console.error(err)
    }
  }, this)//第二个 参数 在自定义组件下，当前组件实例的this，以操作组件内 <canvas> 组件
}
```

### 15.7 完整的示例!!!!!!!!!!!!!!!!!!

```HTML
 <canvas canvas-id="canvasIn" class="canvas"></canvas>
 <canvas canvas-id="canvasOut" class="canvas"></canvas>
 <button bindtap="openAndDraw">打开图片并绘制</button>
 <button bindtap="process">处理图像</button>
 <button bindtap="export">导出画布至图片</button>
 ```

 ```JS
 function convertToGrayscale(data) {
  let g = 0
  for (let i = 0; i < data.length; i += 4) {
    g = (data[i] * 0.3 + data[i+1] * 0.59 + data[i+2] * 0.11)
    data[i] = g
    data[i+1] = g
    data[i+2] = g
  }
  return data
}

Page({
  onReady() {
  },

//打开图片并绘制
  openAndDraw() {
    wx.chooseImage({
      success: (res) => {
        const ctx = wx.createCanvasContext('canvasIn', this); //wx.createCanvasContext 创建上下文对象
        ctx.drawImage(res.tempFilePaths[0], 0, 0)
        ctx.draw()
      }
    })
  },

 //导出画布至图片
  export() {
    wx.canvasToTempFilePath({
      canvasId: 'canvasOut',
      success: (res) => {
        wx.saveImageToPhotosAlbum({
          filePath: res.tempFilePath,
          success: (res) => {
            console.log(res)
          },
          fail: (err) => {
            console.error(err)
          }
        })
      },
      fail: (err) => {
        console.error(err)
      }
    }, this)
  },

//处理图像
  process() {
    const cfg = {
      x: 0,
      y: 0,
      width: 300,
      height: 300,
    }
    wx.canvasGetImageData({
      canvasId: 'canvasIn',
      ...cfg,
      success: (res) => {
        const data = convertToGrayscale(res.data)
        wx.canvasPutImageData({
          canvasId: 'canvasOut',
          data,
          ...cfg,
          success: (res) => {
            console.log(res)
          },
          fail: (err) => {
            console.error(err)
          }
        })
      },
      fail: (err) => {
        console.error(err)
      }
    })
  }
})
 ```

## 十六、调试（开发过程中对 小程序代码的调试）

### 16.1 LogManager 日志管理器实例，

可以通过 wx.getLogManager 获取。

- 最多保存 5M 的日志内容，超过 5M 后，旧的日志内容会被删除。
- 用户可以通过使用 `<Button>` 组件的 `open-type="feedback"` 来上传打印的日志。
- 开发者可以通过小程序管理后台左侧菜单“客服反馈”页面查看。日志

基础库默认会把 App、Page 的生命周期函数和 wx 命名空间下的函数调用写入日志。？？？？？？什么东西？？

#### 16.1.1 wx.getLogManager  创建 日志管理器实例 对象

参数：取值为 0/1，
取值为0：表示是否会把 App、Page 的生命周期函数和 wx 命名空间下的函数调用写入日志，默认值是 0
取值为1 ：则不会....写入日志

```JS
const logger = wx.getLogManager()// 不给参数 默认为 0
logger.log({str: 'hello world'}, 'basic log', 100, [1, 2, 3])
logger.info({str: 'hello world'}, 'info log', 100, [1, 2, 3])
logger.debug({str: 'hello world'}, 'debug log', 100, [1, 2, 3])
logger.warn({str: 'hello world'}, 'warn log', 100, [1, 2, 3])
```

#### 16.1.2 LogManager.debug  写 debug 日志

Object|Array.<any>|number|string ...args
日志内容，可以有任意多个。每次调用的参数的总大小不超过100Kb

#### 16.1.3 LogManager.info   写 info 日志

Object|Array.<any>|number|string ...args
日志内容，可以有任意多个。每次调用的参数的总大小不超过100Kb

#### 16.1.4 LogManager.log    写 log 日志

Object|Array.<any>|number|string ...args
日志内容，可以有任意多个。每次调用的参数的总大小不超过100Kb

#### 16.1.5 LogManager.warn   写 warn 日志

Object|Array.<any>|number|string ...args
日志内容，可以有任意多个。每次调用的参数的总大小不超过100Kb

### 16.2 wx.setEnableDebug 设置是否打开调试开关。此开关对正式版也能生效。

```JS
wx.setEnableDebug({
  enableDebug:true,//是否打开调试  必填
  success(res){},//回调函数
  fail(res){},//回调函数
  complete(res){}//回调函数
})
```

#### 16.2.1 在正式版打开调试还有一种方法，就是先在开发版或体验版打开调试，再切到正式版就能看到vConsole。

### 16.3 console 向调试面板中打印日志。console 是一个全局对象，可以直接访问。

console 是一个全局对象，可以直接访问。在微信客户端中，向 vConsole 中输出日志。

#### 16.3.1  console.debug 向调试面板中打印 debug 日志

any ...args
日志内容，可以有任意多个。

#### 16.3.2  console.error 向调试面板中打印 error 日志

any ...args
日志内容，可以有任意多个。

#### 16.3.3  console.group 在调试面板中创建一个新的分组。

console.group(string label)  分组标记，可选。
注意：仅在工具中有效，在 vConsole 中为空函数实现。

随后输出的内容都会被添加一个缩进，表示该内容属于当前分组。调用 console.groupEnd之后分组结束。

#### 16.3.1  console.groupEnd() 结束由 console.group 创建的分组,

无参数
注意：仅在工具中有效，在 vConsole 中为空函数实现。

#### 16.3.4  console.info 向调试面板中打印 info 日志

any ...args
日志内容，可以有任意多个。

#### 16.3.5  console.log 向调试面板中打印 log 日志

any ...args
日志内容，可以有任意多个。

#### 16.3.6  console.warn 向调试面板中打印 warn 日志

any ...args
日志内容，可以有任意多个。

#### 16.3.7 注意事项

- 由于 vConsole 功能有限，以及不同客户端对 console 方法的支持情况有差异，建议开发者在小程序中只使用本文档中提供的方法。
- 部分内容展示的限制请参见[调试](https://developers.weixin.qq.com/miniprogram/dev/framework/usability/debug.html)

## 十七、第三方平台

### 17.1 wx.getExtConfig 获取第三方平台自定义的数据字段。

语法：wx.getExtConfig(Object object)

#### 17.1.1  本接口暂时无法通过 wx.canIUse 判断是否兼容，开发者需要自行判断 wx.getExtConfig 是否存在来兼容

```JS
if (wx.getExtConfig) {// 判断兼容
  wx.getExtConfig({
    success(res){
      res.extConfig// Object  第三方平台自定义的数据
    },
    fail(){},
    complete(){}
  })
}
```

### 17.2 wx.getExtConfigSync() 是 wx.getExtConfig 的同步版本。 无参数!!!!!!!!!!!

语法：Object getExtConfigSync()

#### 17.2.1  本接口暂时无法通过 wx.canIUse 判断是否兼容，开发者需要自行判断 wx.getExtConfigSync 是否存在来兼容

```JS
let extConfig = wx.getExtConfigSync? wx.getExtConfigSync(): {}
console.log(extConfig)
```

### 17.3 wx.getExtConfigSync（） 与 wx.getExtConfig（obj） 的区别？？？？？？？？？？？？？？？？？？

wx.getExtConfigSync（） 是不带参数的，它的返回值就是  extConfig  对象，也就是 第三方数据字段。

wx.getExtConfig(obj)  带参数，返回值在 success 回调函数里面。

## 十八、地图 map

### 18.1 MapContext         map 上下文 MapContext 对象。

mapContext 通过 id 跟一个 `<map>` 组件绑定，操作对应的 `<map>` 组件。

### 18.2 wx.createMapContext 创建 map 上下文 MapContext 对象。

语法：MapContext wx.createMapContext(string mapId, Object this)

```HTML
<map id="map" longitude="{{longitude}}" latitude="{{latitude}}" show-location scale="12" style="width: 100%; height: 00px;"></map>
```

```JS
  onReady: function(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
```

### 18.3  MapContext.getCenterLocation 获取当前地图中心的经纬度。返回的是 gcj02 坐标系，可以用于 wx.openLocation()

语法：MapContext.getCenterLocation(Object object)

```JS
  // 以下 为 mina 框架写法
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取地图中心点
  getCenterPoint(e){
    var that = this;
    this.mapCtx.getCenterLocation({
      success(res){
        that.setData({
          longitude: res.longitude,//经度,number
          latitude: res.latitude//纬度,number
        })
      },
      fail(res){},
      complete(res){}
    })
  },
  
  // wepy 框架
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取地图中心点
  getCenterPoint(e){
    var that = this;
    this.mapCtx.getCenterLocation({
      success(res){
        that.longitude = res.longitude,//经度,number
        that.latitude = res.latitude//纬度,number
        })
      },
      fail(res){},
      complete(){res}
    })
  },
```

### 18.3  MapContext.getRegion 获取当前地图的视野范围

语法:MapContext.getRegion(Object object)

```JS
  // 以下 为 mina 框架写法
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取视野范围
  getRegionFunc(e){
    var that = this;
    this.mapCtx.getRegion({
      success(res){
        that.setData({
          southwest: res.southwest,//西南角经纬度,number
          northeast: res.latitude//东北角经纬度,number
        })
      },
      fail(res){},
      complete(res){}
    })
  },
  
  // wepy 框架
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取视野范围
  getRegionFunc(e){
    var that = this;
    this.mapCtx.getRegion({
      success(res){
        that.southwest = res.southwest,//西南角经纬度,number
        that.northeast = res.northeast//东北角经纬度,number
        })
      },
      fail(res){},
      complete(){res}
    })
  },
```

### 18.3  MapContext.getScale 获取当前地图的缩放级别

语法:MapContext.getScale(Object object)

```JS
  // 以下 为 mina 框架写法
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取缩放级别
  getScaleFunc(e){
    var that = this;
    this.mapCtx.getScale({
      success(res){
        that.setData({
          scale: res.scale//缩放值,number
        })
      },
      fail(res){},
      complete(res){}
    })
  },
  
  // wepy 框架
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //缩放级别
  getScaleFunc(e){
    var that = this;
    this.mapCtx.getScale({
      success(res){
        that.scale = res.scale//缩放值,number
        })
      },
      fail(res){},
      complete(){res}
    })
  },
```

### 18.3  MapContext.includePoints 缩放视野展示所有经纬度

语法:MapContext.includePoints(Object object)

```JS
  // 以下 为 mina 框架写法
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取 缩放视野展示所有经纬度
  getIncludePointsFunc(e){
    var that = this;
    this.mapCtx.includePoints({
      points:[// 要显示在可视区域内的坐标点列表   必填
        {
          latitude: 30.4919168,//纬度
          longitude: 114.3061654//经度
        },
        {
          latitude: 30.4919168,
          longitude: 114.3061654
        }
      ],
      padding:[],// 否  坐标点形成的矩形边缘到地图边缘的距离，单位像素。
      //格式为[上,右,下,左]，安卓上只能识别数组第一项，上下左右的padding一致。开发者工具暂不支持padding参数。
      success(res){
        that.setData({
          scale: res.scale//缩放值,number
        })
      },
      fail(res){},
      complete(res){}
    })
  },
  
  // wepy 框架
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  // 缩放视野展示所有经纬度
  getIncludePointsFunc(e){
    var that = this;
    this.mapCtx.includePoints({
      success(res){
        that.scale = res.scale//缩放值,number
        })
      },
      fail(res){},
      complete(){res}
    })
  },
```

### 18.3  MapContext.moveToLocation() 将地图中心移动到当前定位点。  无参数

语法：MapContext.moveToLocation()

需要配合 map 组件的 show-location 使用，`<map>` 组件中要有 `show-location` 属性

```HTML
<map id="map" longitude="{{longitude}}" latitude="{{latitude}}" show-location scale="12" style="width: 100%; height: 00px;"></map>
```

```JS
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取地图中心点
  getCenterPoint(e){
    var $this = this;
    this.mapCtx.getCenterLocation({
      success(res){
        $this.setData({
          latitude: res.latitude,
          longitude: res.longitude
        })
      },
      fail(){},
      complete(){}
    })
  },
  //将地图中心点移动到当前位置
  setCenterPoint(e){
    this.mapCtx.moveToLocation()
  }
```

### 18.3  MapContext.translateMarker 平移 marker，带动画

语法：MapContext.translateMarker(Object object)

```JS
  onReady(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取地图中心点
  translateMarkerFunc(e){
    var $this = this;
    this.mapCtx.translateMarker({
      markerId:999,//number  指定 marker  必填
      destination:{
        //指定 marker 移动到的目标点 必填
        latitude: 30.4919168,//纬度
        longitude: 114.3061654//经度
      },
      autoRotate:true, //移动过程中是否自动旋转 marker 必填
      rotate:90,//marker 的旋转角度  必填
      duration:1000,//动画持续时长，平移与旋转分别计算   否  默认值 1000
      animationEnd(){
        //  否  动画结束回调函数
      }
      success(res){
        $this.setData({
          latitude: res.latitude,
          longitude: res.longitude
        })
      },
      fail(){},
      complete(){}
    })
  },
  //将地图中心点移动到当前位置
  setCenterPoint(e){
    this.mapCtx.moveToLocation()
  }
```

### 18.4 综合示例

以下示例 为 mina 框架的示例。

```HTML
<view class="container">
  <map id="map" longitude="{{longitude}}" latitude="{{latitude}}" show-location scale="12" style="width: 100%; height: 00px;"></map>
  <button bindtap="getCenterPoint">获取地图中心点</button>
  <text>中心点经度：{{longitude}}</text>
  <text>中心点纬度：{{latitude}}</text>
  <button bindtap="setCenterPoint">移动到当前位置</button>
</view>
```

```JS
//index.js
//获取应用实例
var app = getApp()
Page({
  data: {
    latitude: 30.4919168,
    longitude: 114.3061654
  },
  onReady: function(e){
    //关联<map />组件
    this.mapCtx = wx.createMapContext('map') // 创建 map 上下文 MapContext 对象。
  },
  //获取地图中心点
  getCenterPoint: function(e){
    var $this = this;
    this.mapCtx.getCenterLocation({
      success: function(res){
        $this.setData({
          latitude: res.latitude,
          longitude: res.longitude
        })
      }
    })
  },
  //将地图中心点移动到当前位置
  setCenterPoint: function(e){
    this.mapCtx.moveToLocation()
  }
})
```

## 十九、路由(页面跳转)

以下是 原生的 API ，如果是 wepy 框架又对这几个 API 进行封装了

### 19.1 wx.navigateTo 保留当前页面，跳转到应用内的某个页面。但是不能跳到 tabbar 页面。使用 wx.navigateBack 可以返回到原页面。

也就是说需要跳转到某个不在 tabbar 设置过的页面，并且需要返回 原来的页面的话就使用这个方法 wx.navigateTo。

调用 navigateTo 跳转时，调用该方法的页面会被加入堆栈，而 redirectTo 方法则不会。需要返回 原来的页面的话就使用这个方法 wx.navigateTo。
将经历过 的页面压入栈，后面就可以使用 wx.navigateBack 调用跳转回来。

```JS
wx.navigateTo({
  url: 'test?id=1'// test 是  test 的路径，例如    "pages/products/products"
  //    url:"pages/products/products?id=1"
})

// test.js
Page({
  onLoad(option) {
    console.log(option.query)
  }
})
```

```JS
// A 页面 => B 页面
// ①：原生写法
wx.navigateTo({
  url: './B?id=1', // 必填  需要跳转的应用内非 tabBar 的页面的路径, 路径后可以带参数。
                    //参数与路径之间使用 ? 分隔，参数键与参数值用 = 相连，不同参数用 & 分隔；如 'path?key=value&key2=value2
  success(res){
    //否
  },
  fail(){
    // 否
  },
  complete(){
    // 否
  }
})

// B.js 页面
//① mina 框架
Page({
  onLoad: function(option){
    console.log(option.query)
  }
})
```

````js
//wepy 框架 可以使用上面的方法，并且还封装了方法  注意这里没有 TO 了 哦!!!!!!!!!!!!!!!!!!!!!!!!!!
//②：wepy 框架包装写法
  this.$navigate({
    url: './B?id=1',
    success(res){},
    fail(){},
    complete(){}
  })

//wepy 框架 或者更加直接的
//③：wepy 框架包装写法
  this.$navigate('./B',{id:1})
  // 问题：然后这里的 success 这 3 个属性是怎么用的？？？是下面这样么
  this.$navigate('./B',{id:1}).success(res=>{
    //
  }).fail(res=>{
    //
  }).complete(res=>{
    //
  })
```

```JS
//② wepy 框架
export default class Index extends wepy.page {
  onLoad(options) {
    this.pageBId = options.id;
    console.log(options.id)
  }
}
```

### 19.2 wx.navigateBack 关闭当前页面，返回上一页面或多级页面。可通过 getCurrentPages() 获取当前的页面栈，决定需要返回几层。

当前页面是通过 wx.navigateTo 接口过来的话，那么可以使用 wx.navigateBack  返回原来的页面。

调用 navigateTo 跳转时，调用该方法的页面会被加入堆栈，而 redirectTo 方法则不会。需要返回 原来的页面的话就使用这个方法 wx.navigateTo。
将经历过 的页面压入栈，后面就可以使用 wx.navigateBack 调用跳转回来。

```JS
// 此处是 A 页面 => B 页面
toPageB(){
  wx.navigateTo({
    url: './B?id=1'
  })
}

// 此处是 B 页面 => C 页面
toPageC(){
  wx.navigateTo({
    url: './C?id=1'
  })
}
```

```JS
// 此处是 C 页面 => A 页面
Back(){
  wx.navigateBack({
    delta:2,//number   必填 返回的页面数，如果 delta 大于现有页面数，则返回到首页。
    // delta:1  返回 B 页面， delta:2/3/4..... 返回 A页面（这里假设 A 是首页）
    success(res){},//   否 接口调用成功的回调函数
    fail(res){},//      否 接口调用失败的回调函数
    complete(res){}//   否 接口调用结束的回调函数（调用成功、失败都会执行）
  })
}
```

#### 19.2.1  wx.navigateBack 返回上一个页面并且带参数

看上面的内容之后发现，wx.navigateBack 只有三个回调函数参数，没有其他的参数，那么如果希望返回上面一个页面，并且传参怎么办？

[文档](https://www.jianshu.com/p/f846a2cc6c53)
文档这里只是 mina 框架可以这样用，发现并不能用在 wepy 框架。

```JS
// A页面
data={
  this.title='title'
}
onLoad(){
  this.$navigate('./B')
  this.title//'title'
}
onShow(){
  this.title//'title' 这里希望会改变
}
```

```JS
//b 页面
 methods = {
    test() {
      var pages = this.getCurrentPages();
      console.log(pages)
      var prevPage = pages[pages.length - 2];
      console.log(prevPage)
      prevPage.title = 'newTitle';// prevPage 改变了，但是 A 页面的值没有被改变，这个压入栈的东西是不是要自己取出来使用呀？
      // this.$apply() 可以使用么？ 是 this 么？？  原生的 setData 还这样用么？
      wepy.navigateBack({ delta: 1 });
    }
  };
```

问题？success(res){}, 不能传么？？后面做到的时候自己研究一下。

### 19.3 wx.redirectTo 关闭当前页面，跳转到应用内的某个页面。但是不允许跳转到 tabbar 页面。

关闭当前页面，跳转到应用内的某个页面。但是不允许跳转到 tabbar 页面。

wx.redirectTo 不会压入栈，不能使用 返回 API 接口。

```JS
// A 页面 => B 页面
// ①：原生写法
wx.redirectTo({
  url: './B?id=1', // 必填  需要跳转的应用内非 tabBar 的页面的路径, 路径后可以带参数。
                    //参数与路径之间使用 ? 分隔，参数键与参数值用 = 相连，不同参数用 & 分隔；如 'path?key=value&key2=value2
  success(res){
    //否
  },
  fail(){
    // 否
  },
  complete(){
    // 否
  }
})


//wepy 框架 可以使用上面的方法，并且还封装了方法
//②：wepy 框架包装写法
  this.$redirectTo({
    url: './B?id=1',
    success(res){},
    fail(){},
    complete(){}
  })

//wepy 框架 或者更加直接的
//③：wepy 框架包装写法
  this.$redirectTo('./B',{id:1})
  // 问题：然后这里的 success 这 3 个属性是怎么用的？？？是下面这样么
  this.$redirectTo('./B',{id:1}).success(res=>{
    //
  }).fail(res=>{
    //
  }).complete(res=>{
    //
  })
```

```JS
// B.js 页面
//① mina 框架
Page({
  onLoad: function(option){
    console.log(option.query)
  }
})

//② wepy 框架
export default class Index extends wepy.page {
  onLoad(options) {
    this.pageBId = options.id;
    console.log(options.id)
  }
}
```

### 19.4 wx.reLaunch 关闭所有页面，打开到应用内的某个页面

```JS
// A 页面 => B 页面 （可以是任意的页面）
// ①：原生写法
wx.reLaunch({
  url: './B?id=1', //需要跳转的应用内页面路径，路径后可以带参数。参数与路径之间使用?分隔，参数键与参数值用=相连，不同参数用&分隔；
                  //如 'path?key=value&key2=value2'，如果跳转的页面路径是 tabBar 页面则不能带参数
  success(res){
    //否
  },
  fail(){
    // 否
  },
  complete(){
    // 否
  }
})
```

```JS
// B.js 页面
//① mina 框架
Page({
  onLoad: function(option){
    console.log(option.query)// 如果是 tabbar 页面就没有这里了
  }
})

//② wepy 框架
export default class Index extends wepy.page {
  onLoad(options) {
    this.pageBId = options.id; // 如果是 tabbar 页面就没有这里了
    console.log(options.id)
  }
}
```

### 19.5 wx.switchTab 跳转到 tabBar 页面，并关闭其他所有非 tabBar 页面

```JS
// A 页面 => index 页面（ index 页面必须以是 tebbar 页面）
// ①：原生写法
wx.switchTab({
  url: './index'  //不能带参数的
  success(res){
    //否
  },
  fail(){
    // 否
  },
  complete(){
    // 否
  }
})
```

```JS
//app.wpy 中的 cinfig
{
  "tabBar": {
    "list": [{
      "pagePath": "index",
      "text": "首页"
    },{
      "pagePath": "other",
      "text": "其他"
    }]
  }
}
```

## 二十、转发（右上角的转发功能，或者在其他地方自定义的转发功能）

### 20.1 wx.getShareInfo 获取转发详细信息       基础库 1.1.0 开始支持，低版本需做兼容处理。

wx.getShareInfo 接口是在 **页面的周期函数  onShareAppMessage 函数中 中设置分享的界面。** 20.1.3 实例中有几个相关的 api 接口完整的示例。

```JS
onShareAppMessage(){
  if (res.from === 'button') {
      console.log(res.target)
  }
  return {
    title: '自定义转发标题',
    path: '/pages/main',
    success(res) {
      let shareId = res.shareTickets[0]
      wx.getShareInfo({
        shareTicket:shareId,//string   必填  shareTicket 获取分享信息
        timeout:1000,//number          否    超时时间，单位 ms 1.9.90
        success(res){
        //function    否    接口调用成功的回调函数
        res.errMsg        //string 错误信息
        res.encryptedData //string 包括敏感数据在内的完整转发信息的加密数据，详细见加密数据解密算法
        res.iv            //string 加密算法的初始向量，详细见加密数据解密算法
        },
        fail(res){
                    //function    否    接口调用失败的回调函数
        },
        complete(res){
                    //function    否    接口调用结束的回调函数（调用成功、失败都会执行
        }
      })
    }
  }
}
```

#### 20.1.1 加密数据解密算法

[官网网址](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/signature.html)

加密数据解密算法：接口如果涉及敏感数据（如wx.getUserInfo当中的 openId 和 unionId），接口的明文内容将不包含这些敏感数据。开发者如需要获取敏感数据，需要对接口返回的加密数据(encryptedData) 进行对称解密。 解密算法如下：

- 对称解密使用的算法为 AES-128-CBC，数据采用PKCS#7填充。
- 对称解密的目标密文为 Base64_Decode(encryptedData)。
- 对称解密秘钥 aeskey = Base64_Decode(session_key), aeskey 是16字节。
- 对称解密算法初始向量 为Base64_Decode(iv)，其中iv由数据接口返回。

微信官方提供了多种编程语言的示例代码（点击下载）。每种语言类型的接口名字均一致。调用方式可以参照示例。

另外，为了应用能校验数据的有效性，会在敏感数据加上数据水印( watermark )

watermark参数说明：

参数	类型	说明
appid	String	敏感数据归属 appId，开发者可校验此参数与自身 appId 是否一致
timestamp	Int	敏感数据获取的时间戳, 开发者可以用于数据时效性校验
如接口 wx.getUserInfo 敏感数据当中的 watermark：

{
    "openId": "OPENID",
    "nickName": "NICKNAME",
    "gender": GENDER,
    "city": "CITY",
    "province": "PROVINCE",
    "country": "COUNTRY",
    "avatarUrl": "AVATARURL",
    "unionId": "UNIONID",
    "watermark":
    {
        "appid":"APPID",
        "timestamp":TIMESTAMP
    }
}
注：

解密后得到的json数据根据需求可能会增加新的字段，旧字段不会改变和删减，开发者需要预留足够的空间
会话密钥 session_key 有效性
开发者如果遇到因为 session_key 不正确而校验签名失败或解密失败，请关注下面几个与 session_key 有关的注意事项。

wx.login 调用时，用户的 session_key 可能会被更新而致使旧 session_key 失效（刷新机制存在最短周期，如果同一个用户短时间内多次调用 wx.login，并非每次调用都导致 session_key 刷新）。开发者应该在明确需要重新登录时才调用 wx.login，及时通过 code2Session 接口更新服务器存储的 session_key。
微信不会把 session_key 的有效期告知开发者。我们会根据用户使用小程序的行为对 session_key 进行续期。用户越频繁使用小程序，session_key 有效期越长。
开发者在 session_key 失效时，可以通过重新执行登录流程获取有效的 session_key。使用接口 wx.checkSession可以校验 session_key 是否有效，从而避免小程序反复执行登录流程。
当开发者在实现自定义登录态时，可以考虑以 session_key 有效期作为自身登录态有效期，也可以实现自定义的时效性策略。

#### 20.1.2 如需要展示群名称，可以使用开放数据组件 open-data

[官网开方组件网址](https://developers.weixin.qq.com/miniprogram/dev/component/open-data.html)

open-data
基础库 1.4.0 开始支持，低版本需做兼容处理。

用于展示微信开放的数据。

属性名	类型	默认值	说明
type	String		开放数据类型
open-gid	String		当 type="groupName" 时生效, 群id
lang	String	en	当 type="user*" 时生效，以哪种语言展示 userInfo，有效值有：en, zh_CN, zh_TW
type 有效值：

值	说明	最低版本
groupName	拉取群名称	1.4.0
userNickName	用户昵称	1.9.90
userAvatarUrl	用户头像	1.9.90
userGender	用户性别	1.9.90
userCity	用户所在城市	1.9.90
userProvince	用户所在省份	1.9.90
userCountry	用户所在国家	1.9.90
userLanguage	用户的语言	1.9.90
Tips: 只有当前用户在此群内才能拉取到群名称

示例：

在开发者工具中预览效果

<open-data type="groupName" open-gid="xxxxxx"></open-data>
<open-data type="userAvatarUrl"></open-data>
<open-data type="userGender" lang="zh_CN"></open-data>
Tips: 关于open-gid的获取请使用 wx.getShareInfo

### 20.2 wx.hideShareMenu 隐藏转发按钮          基础库 1.1.0 开始支持，低版本需做兼容处理。

```JS
wx.hideShareMenu({
  success (res) {
    // 接口调用成功的回调函数
  },
  fail(res){
    //② 接口调用失败的回调函数
  },
  complete(res){
    //② 接口调用结束的回调函数（调用成功、失败都会执行)
  }
})
```

### 20.3 wx.showShareMenu 显示当前页面的转发按钮 基础库 1.1.0 开始支持，低版本需做兼容处理。

这个接口是在 onload 周期函数中使用的。

```JS
onload(){
  wx.showShareMenu({
    withShareTicket: true,//获取更多转发信息 否(不是必须的) // 用于显示分享的群列表
    success (res) {
      // 接口调用成功的回调函数 否
    },
    fail(res){
      //② 接口调用失败的回调函数 否
    },
    complete(res){
      //② 接口调用结束的回调函数（调用成功、失败都会执行) 否
    }
  })
}
```

#### 20.3.1 获取更多转发信息

通常开发者希望转发出去的小程序被二次打开的时候能够获取到一些信息，例如群的标识。现在通过调用 wx.showShareMenu 并且设置 withShareTicket 为 true ，当用户将小程序转发到任一群聊之后，此转发卡片在群聊中被其他用户打开时，可以在 App.onLaunch 或 App.onShow 获取到一个 shareTicket。通过调用 wx.getShareInfo() 接口传入此 shareTicket 可以获取到转发信息。

### 20.4 wx.updateShareMenu 更新转发属性         基础库 1.2.0 开始支持，低版本需做兼容处理。

```JS
wx.updateShareMenu({
  withShareTicket: true,//是否使用带 shareTicket 的转发 否(不是必须的) 默认值为 false
  isUpdatableMessage:true,//是否是动态消息              否(不是必须的) 默认值为 false
  activityId:'',//string 动态消息的 activityId。通过 createActivityId 接口获取 否(不是必须的)
  templateInfo:{
    //动态消息的模板信息 否(不是必须的),
    parameterList: [{// 参数列表
      name: 'member_count',//参数名
      value: '1'          // 参数值
    }, {
      name: 'room_limit',
      value: '3'
    }]
  },
  success (res) {
    // 接口调用成功的回调函数 否
  },
  fail(res){
    //② 接口调用失败的回调函数 否
  },
  complete(res){
    //② 接口调用结束的回调函数（调用成功、失败都会执行) 否
  }
})
```

#### 20.4.1 获取更多转发消息

通常开发者希望转发出去的小程序被二次打开的时候能够获取到一些信息，例如群的标识。现在通过调用 wx.showShareMenu 并且设置 withShareTicket 为 true ，当用户将小程序转发到任一群聊之后，此转发卡片在群聊中被其他用户打开时，可以在 App.onLaunch 或 App.onShow 获取到一个 shareTicket。通过调用 wx.getShareInfo() 接口传入此 shareTicket 可以获取到转发信息。

#### 20.4.2 动态消息

[官网动态消息网址](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/share/updatable-message.html)

动态消息
从基础库 2.4.0 开始，支持转发动态消息。动态消息对比普通消息，有以下特点：

消息发出去之后，开发者可以通过后台接口修改部分消息内容。
消息有对应的提醒按钮，用户点击提醒按钮可以订阅提醒，开发者可以通过后台修改消息状态并推送一次提醒消息给订阅了提醒的用户
消息属性
动态消息有状态、文字内容、文字颜色。

状态
消息有两个状态，分别有其对应的文字内容和颜色。其中状态 0 可以转移到状态 0 和 1，状态 1 无法再转移。

状态	文字内容	颜色	允许转移的状态
0	"成员正在加入，当前 {member_count}/{room_limit} 人"	#FA9D39	0, 1
1	"已开始"	#CCCCCC	无
状态参数
每个状态转移的时候可以携带参数，具体参数说明如下。

参数	类型	说明
member_count	string	状态 0 时有效，文字内容模板中 member_count 的值
room_limit	string	状态 0 时有效，文字内容模板中 room_limit 的值
path	string	状态 1 时有效，点击「进入」启动小程序时使用的路径。对于小游戏，没有页面的概念，可以用于传递查询字符串（query），如 "?foo=bar"
version_type	string	状态 1 时有效，状态 1 时有效，点击「进入」启动小程序时使用的版本。有效参数值为：develop（开发版），trial（体验版），release（正式版）
使用方法
一、创建 activity_id
每条动态消息可以理解为一个活动，活动发起前需要通过 createActivityId 接口创建 activity_id。后续转发动态消息以及更新动态消息都需要传入这个 activity_id。

活动的默认有效期是 24 小时。活动结束后，消息内容会变成统一的样式：

文字内容：“已结束”
文字颜色：#00ff00
二、在转发之前声明消息类型为动态消息
通过调用 wx.updateShareMenu 接口，传入 isUpdatableMessage: true，以及 templateInfo、activityId 参数。其中 activityId 从步骤一中获得。

三、修改动态消息内容
动态消息发出去之后，可以通过 setUpdatableMsg 修改消息内容。

低版本兼容
对于不支持动态消息的客户端版本，收到动态消息后会展示成普通消息

### 20.5 转发功能 实际使用示例：群转发设置!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

以下实例是在 wepy 框架下写的。

```JS
//在wpy类型文件的onload中设置 eg： 用于显示分享的群列表
onload(){
  wepy.showShareMenu({
    withShareTicket: true
  })
}
//在 onShareAppMessage 页面周期函数中 中设置分享的界面，在分享成功后的回调函数中通过 wepy.getShareInfo 获取分享群的信息。
//群的信息是经过加密的，需要通过后台来进行解密操作。
onShareAppMessage (res) {
  if (res.from === 'button') {
      console.log(res.target)
  }
  return {
    title: '自定义转发标题',
    path: '/pages/main',
    success(res) {
        let shareId = res.shareTickets[0]
        // 转发成功
        wepy.getShareInfo({
            shareTicket: shareId,
            success: (data) => {
              var appId = '小程序的appID'
              var encryptedData = data.encryptedData
              var iv = data.iv
              wepy.request({
                url: 'http://localhost:3000/api/decode',
                method: 'post',
                data: {
                  appId: appId,
                  encryptedData: encryptedData,
                  iv: iv
                },
                success: (info) => {
                  console.log('info:' + info)
                },
                fail: (info) => {
                  console.log(info)
                }
              })
              console.log(data)
            },
            fail: (data) => {
              console.log(data)
            }
        })
        console.log(res)
    },
    fail(res) {
      // 转发失败
      console.log(res)
    }
  }
}
```

## 二十一、系统 (手机系统，设备系统)

### 21.1 wx.getSystemInfo 获取系统信息

wx.getSystemInfo 有三种状态 success，fail，complete

```JS
wx.getSystemInfo({
  success (res) {
    // 接口调用成功的回调函数,目前 success 的回调数据中有 16 个数据
    res.brand       //①string 手机品牌   1.5.0
    res.model       //②String 手机型号
    res.pixelRatio  //③number 设备像素比
    res.screenWidth //④number 屏幕宽度
    res.screenHeight//⑤number屏幕高度
    res.windowWidth //⑥number 可使用窗口宽度
    res.windowHeight//⑦number 可使用窗口高度
    res.statusBarHeight//⑧number 状态栏的高度 1.9.0
    res.language      //⑨string 微信设置的语言
    res.version       //⑩string  微信版本号
    res.system        //⑪string   操作系统版本
    res.platform      //⑫string 客户端平台
    res.fontSizeSetting//⑬number 用户字体大小设置。以“我-设置-通用-字体大小”中的设置为准，单位 px。 1.5.0
    res.SDKVersion      //⑭string 客户端基础库版本      1.1.0
    res.benchmarkLevel  //⑮(仅Android小游戏) 性能等级， 1.8.0
    //-2 或 0：该设备无法运行小游戏，
    //-1：性能未知，
    //>=1 设备性能值，该值越高，设备性能越好 (目前设备最高不到50)
  },
  fail(res){
    //② 接口调用失败的回调函数
  },
  complete(res){
    //② 接口调用结束的回调函数（调用成功、失败都会执行)
  }
})
```

### 21.2 wx.getSystemInfoSync 获取系统信息 wx.getSystemInfo 的同步版本

wx.getSystemInfoSync 有 2 种状态 try ，catch

```JS
try {
  const res = wx.getSystemInfoSync()
  // try 返回的数据与 wx.getSystemInfo 中 success 一致。
  // 上面有的在这都有的
  console.log(res.model)
  console.log(res.pixelRatio)
  console.log(res.windowWidth)
  console.log(res.windowHeight)
  console.log(res.language)
  console.log(res.version)
  console.log(res.platform)
} catch (e) {
  // Do something when catch error
}
```

### 21.3  wx.getSystemInfoSync()  与  wx.getSystemInfo(obj)  区别

wx.getSystemInfoSync() 是不带参数的，它的返回值就是  res  对象。

wx.getSystemInfo(obj)  带参数，返回值在 success 回调函数里面。

## 二十二、定时器

### 22.1 setInterval && clearInterval 设定/取消一个定时器。间隔执行（多次）

**语法**

number setInterval(function callback, number delay, any rest)

按照指定的周期（以毫秒计）来执行注册的回调函数

**参数：**

- function callback : 回调函数
- number delay      : **执行回调函数之间的时间间隔，单位 ms。**
- any rest          : param1, param2, ..., paramN 等附加参数，它们会作为参数传递给回调函数。（可选参数）

**返回值:**

- number 定时器的编号。这个值可以传递给 clearInterval 来取消该定时。

```JS
// 以 wepy 框架的来编辑示例
data = {
  isplay:false,
  intervalId:null,
  useTime:0
}
methods ={
  pause() {
    this.isplay = false;
    clearInterval(this.intervalId);
  },
  play() {
    this.isplay = true;
    this.setIntervalFunc();
  },
}
setIntervalFunc() {
    this.intervalId = setInterval(() => {
      this.useTime++;
      this.$apply();// wepy 框架如是编辑
    }, 1000);
  }
```

### 22.2 setTimeout  && clearTimeout 设定/取消一个定时器。延迟执行（1 次）

在定时到期以后执行注册的回调函数

**语法**

number setTimeout(function callback, number delay, any rest)

按照指定的周期（以毫秒计）来执行注册的回调函数

**参数：**

- function callback : 回调函数
- number delay      : **延迟的时间，函数的调用会在该延迟之后发生，单位 ms。**
- any rest          : param1, param2, ..., paramN 等附加参数，它们会作为参数传递给回调函数。（可选参数）

**返回值:**

- number 定时器的编号。这个值可以传递给 clearInterval 来取消该定时。

```JS
// 以 wepy 框架的来编辑示例
data = {
  isplay:false,
  intervalId = null,
  text:'等会看我变'
}
methods ={
  pause() {
    this.isplay = false;
    clearTimeout(this.intervalId);
  },
  play() {
    this.isplay = true;
    this.setTimeoutFunc();
  },
}
setTimeoutFunc() {
    this.intervalId = clearTimeout(() => {
      this.text='3 秒过了，我变啦'
      this.$apply();// wepy 框架如是编辑
    }, 3000);
  }
```

## 二十三、WXML

### 23.1 IntersectionObserver 布局相交状态 对象

IntersectionObserver 对象，用于推断某些节点是否可以被用户看见、有多大比例可以被用户看见。

#### 23.1.1 IntersectionObserver.disconnectt() 停止监听。回调函数将不再触发

注意：
与页面显示区域的相交区域并不准确代表用户可见的区域，因为参与计算的区域是“布局区域”，布局区域可能会在绘制时被其他节点裁剪隐藏（如遇祖先节点中 overflow 样式为 hidden 的节点）或遮盖（如遇 fixed 定位的节点）。

#### 23.1.2 IntersectionObserver.observet() 指定目标节点并开始监听相交状态变化情况

IntersectionObserver.observet(string targetSelector, function callback)

参数
string targetSelector：选择器

function callback：监听相交状态变化的回调函数

参数
Object res

属性	类型	说明	最低版本
intersectionRatio	number	相交比例	
intersectionRect	Object	相交区域的边界	
boundingClientRect	Object	目标边界	
relativeRect	Object	参照区域的边界	
time	number	相交检测时的时间戳

es.intersectionRect 的结构

属性	类型	说明	最低版本
left	number	左边界	
right	number	右边界	
top	number	上边界	
bottom	number	下边界	
res.boundingClientRect 的结构

属性	类型	说明	最低版本
left	number	左边界	
right	number	右边界	
top	number	上边界	
bottom	number	下边界	
res.relativeRect 的结构

属性	类型	说明	最低版本
left	number	左边界	
right	number	右边界	
top	number	上边界	
bottom	number	下边界

#### 23.1.3 IntersectionObserver.relativeTot() 使用选择器指定一个节点，作为参照区域之一。

IntersectionObserver.relativeTo(string selector, Object margins)

参数
string selector
选择器

Object margins
用来扩展（或收缩）参照节点布局区域的边界

属性	类型	默认值	必填	说明	最低版本
left	number		否	节点布局区域的左边界
right	number		否	节点布局区域的右边界
top	number		否	节点布局区域的上边界
bottom	number		否	节点布局区域的下边界

#### 23.1.4 IntersectionObserver.relativeToViewportt() 指定页面显示区域作为参照区域之一

IntersectionObserver.relativeToViewport(Object margins)

参数
Object margins
用来扩展（或收缩）参照节点布局区域的边界

属性	类型	默认值	必填	说明	最低版本
left	number		否	节点布局区域的左边界	
right	number		否	节点布局区域的右边界	
top	number		否	节点布局区域的上边界	
bottom	number		否	节点布局区域的下边界	
示例代码
下面的示例代码中，如果目标节点（用选择器 .target-class 指定）进入显示区域以下 100px 时，就会触发回调函数。

```JS
Page({
  onLoad: function(){
    wx.createIntersectionObserver().relativeToViewport({bottom: 100}).observe('.target-class', (res) => {
      res.intersectionRatio // 相交区域占目标节点的布局区域的比例
      res.intersectionRect // 相交区域
      res.intersectionRect.left // 相交区域的左边界坐标
      res.intersectionRect.top // 相交区域的上边界坐标
      res.intersectionRect.width // 相交区域的宽度
      res.intersectionRect.height // 相交区域的高度
    })
  }
})
```

### 23.2 wx.createIntersectionObserver 创建布局相交状态

语法：`wx.createIntersectionObserver(Object this, Object options)`，
在自定义组件中，可以使用 `this.createIntersectionObserver([options])` 来代替

参数：Object this：自定义组件实例
     Object options：选项

返回值：IntersectionObserver 对象实例

[开发者工具中查看效果](https://developers.weixin.qq.com/s/LAbMxkmI7F2A)

```HTML
<style>
.scroll-view {
  height: 400rpx;
  background: #fff;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

.scroll-area {
  height: 1300rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  transition: .5s;
}

.notice {
  margin-top: 150rpx;
}

.ball {
  width: 200rpx;
  height: 200rpx;
  background: #1AAD19;
  border-radius: 50%;
}

.filling {
  height: 400rpx;
}

.message {
  width: 100%;
  display: flex;
  justify-content: center;
}

.message text {
  font-size: 40rpx;
  font-family: -apple-system-font, Helvetica Neue,Helvetica,sans-serif;
}
</style>
<view class="container">
  <view class="page-body">
    <view class="page-section message">
      <text wx:if="{{appear}}">
        小球出现
      </text>
      <text wx:else>
        小球消失
      </text>
    </view>
    <view class="page-section">
      <scroll-view class="scroll-view" scroll-y>
        <view class="scroll-area" style="{{appear ? 'background: #ccc' : ''}}">
          <text class="notice">向下滚动让小球出现</text>
          <view class="filling"></view>
          <view class="ball"></view>
        </view>
      </scroll-view>
    </view>
  </view>
</view>
<script>
Page({
  data: {
    appear: false
  },
  onLoad() {
    this._observer = wx.createIntersectionObserver(this)
    this._observer
      .relativeTo('.scroll-view')
      .observe('.ball', (res) => {
        console.log(res);
        this.setData({
          appear: res.intersectionRatio > 0
        })
      })
  },
  onUnload() {
    if (this._observer) this._observer.disconnect()
  }
})
</script>

```

### 23.5 SelectorQuery 查询节点信息的对象

#### 23.1.1 SelectorQuery.exec

#### 23.1.1 SelectorQuery.in

#### 23.1.1 SelectorQuery.select

#### 23.1.1 SelectorQuery.selectAll

#### 23.1.1 SelectorQuery.selectViewport

### 23.4 wx.createSelectorQuery

```JS
const query = wx.createSelectorQuery()
query.select('#the-id').boundingClientRect()
query.selectViewport().scrollOffset()
query.exec(function(res){
  res[0].top       // #the-id节点的上边界坐标
  res[1].scrollTop // 显示区域的竖直滚动位置
})
```

### 23.5 NodesRef

#### 23.5.1 .boundingClientRect

#### 23.5.2 .fields

#### 23.5.3 .scrollOffset
