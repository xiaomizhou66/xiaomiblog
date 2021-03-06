---
title: 'HTTP--[小白入门版、速学版]'
date: '2018/8/19 23:57:28'
categories:
  - ⑨ HTTP
updated:
tags:
comments:
---

## 一、前言

在公司合作项目，前后端都是分开的，主打前端可以不知道怎么写后端，但是后端提供的 API 接口文件需要知道如何调用、获取数据展现在前端。
后端会提供类似以下格式的 api 接口文件：

发送登录请求 API 示例

``` text
POST /v1/login Http/1.1  
Content-Type: application/json

{
"username":<username>,
"password":<password>
}
```

这里的前后端通信就需要通过 http 协议进行，要理解就要掌握 http 协议是如何工作的。两本高手级别的书 《HTTP权威指南》，《TCP/IP详解，卷I》，内容艰涩难懂，学习难度大。对于像我这种门外汉来说，直接学习两本圣经书，我是没法看下去的，好在日本 上野宣 著有一书 《图解HTTP》 ，本书全书几乎全以图片讲解，让人易于学习。

## 二、HTTP 工作原理

在学习如何使用 http 之前，首先要知道它的工作原理。 HTTP 协议工作于客户端-服务端架构上。用于客户端和服务端的通信。请求访问文本或图像等资源的一段被称为客户端：例如浏览器，桌面应用，手机浏览器，手机 APP 应用等。提供资源相应的一端称为服务器。

客户端通过URL向服务端发送所有请求消息（请求报文），服务器根据接收到的请求后，向客户端发送响应消息（相应报文）。例如上面写的代码，前端发送这段代码给后端以获取信息。

** 请求与相应的消息都称为报文，包括报文首部+空行+报文主体 **
![报文](http://liuxmoo.foryung.com/baowen.jpg)

## 三、HTTP协议使用

### 3.1 客户端发送请求

HTTP报文结构
![请求报文](http://liuxmoo.foryung.com/qingqiubaowen.jpg)
客户端发送一个HTTP请求(请求报文)到服务器的请求。

请求消息包括以下格式：
>请求行：请求方法，请求 URI/URL，HTTP 协议版本
&nbsp;&nbsp;&nbsp;HTTP首部字段：（可选）
&nbsp;&nbsp;&nbsp;空行
&nbsp;&nbsp;&nbsp;请求数据/请求内容实体：（可选）

以下为新增文件夹的接口示例：（后端提供的API文件）

```text
    POST /v1/account/storage/folder Http/1.1     请求行
    Authorization: <token>                       首部字段-(postman中的headers)
                                                 空行
    {
    "label":"folder",                            请求实体--(postman中的body)
    "name":"?????",
    "parentID":"5aa14f9f8e1a0be97ee9abe3"
    }
```

#### 3.1.1请求行

** 请求行：POST /v1/account/storage/folder Http/1.1 **
请求----方法：POST（请求访问服务器的类型），
请求----URL：/v1/account/storage/folder（指明访问的资源对象），
http 版本号：Http/1.1（提示客户端用的 http 协议功能）

| 序号|请求方法 | 说明 | 支持的 HTTP 协议版本|  
| :----: | :----: |:---- | :----: |
| 1|GET | 获取资源 | -1.1|  
| 2|POST | 传输实体主体：向指定资源提交数据进行处理请求（例如提交表单或者上传文件）。数据被包含在请求体中。POST请求可能会导致新的资源的建立和/或已有资源的修改。 | -1.1|  
| 3|PUT | 传输文件：从客户端向服务器传送的数据取代指定的文档的内容。| -1.1|  
| 4|HEAD | 获取报文首部：类似于get请求，只不过返回的响应中没有具体的内容，用于获取报头 | -1.1|  
| 5|DELETE | 删除文件：请求服务器删除指定的页面。 | -1.1|  
| 6|link | 建立和资源的联系 | 仅支持1.0| 
| 7|unlink | 断开连接关系| 仅支持1.0| 
| 8|TRACE | 追踪路径：回显服务器收到的请求，主要用于测试或诊断。 | 1.1|  
| 9|OPTIONS | 询问支持的方法：允许客户端查看服务器的性能。 | 1.1|  
| 10|CONNECT | 要求用隧道协议链接代理：HTTP/1.1协议中预留给能够将连接改为管道方式的代理服务器。| 1.1|

#### 3.1.2 首部字段

** Authorization: token **
具体学习见第四章:<a href="#id4" target="_self">HTTP 报文首部</a>

### 3.2 服务器相应信息反馈

![响应报文](http://liuxmoo.foryung.com/xiangyingbaowen.jpg)

响应消息包括以下格式：
>状态行：HTTP 协议版本,状态码,原因短语
HTTP 首部字段：（可选）
空行
响应数据/响应内容实体：（可选）

以下为新增文件夹的接口示例：（后端提供的 API 文件）

HTTP 响应(相应报文)也由四个部分组成，分别是：状态行、消息报头、空行和响应正文。
以下为相应示例：

```text
    HTTP/1.1 200 OK                                     状态行
    Date: Mon, 27 Jul 2018 12:28:53 GMT                 HTTP首部字段
    Content-Length: 724
    Content-Type: text/html

    <html>                                             响应内容实体
    ...
    </html>  
```

#### 3.2.1 状态行

** 状态行：TTP/1.1 200 OK **
http版本号：Http/1.1
状态----码：200
原因--短语：ok

```BASH
# 状态码       类别                     原因短语
#  1..     informational(信息状态码)    服务器收到请求，需要请求者继续执行操作，正在处理请求
#  2..     success（成功状态码）        请求正常处理完毕，操作被成功接收并处理         (成功)
#  3..     Redirction（重定向）         需要进一步的操作以完成请求  
#  4..     Client（客户端错误）         客户端错误，请求包含语法错误或无法完成请求      (前端错误/后端错误)
#  5..     Server Error（服务端错误）   服务器错误，服务器在处理请求的过程中发生了错误  (后端错误)
```

```BASH
#  1..     informational(信息状态码)   服务器收到请求，需要请求者继续执行操作，正在处理请求

#  100     Continue  继续。
#                    客户端应继续其请求，需要请求者继续执行操作|  
#  102     Switching Protocols（成功状态码）切换协议。
#                    服务器根据客户端的请求切换协议。只能切换到更高级的协议，例如，切换到 HTTP 的新版本协议


#  2..     success（成功状态码）        请求正常处理完毕，操作被成功接收并处理         (成功)

#  200     OK  请求成功。
#              一般用于 GET 与 POST 请求
#  201     Created  已创建。
#                   成功请求并创建了新的资源
#  202     Accepted 已接受
#                   已经接受请求但未处理完成
#  203     Non-Authoritative Information 非授权信息
#                                         请求成功。但返回的 meta 信息不在原始的服务器，而是一个副本
#  204     No Content  无内容
#                      服务器成功处理，但未返回内容。在未更新网页的情况下，可确保浏览器继续显示当前文档
#  205     Reset Content 重置内容
#                        服务器处理成功，用户终端（例如：浏览器）应重置文档视图。可通过此返回码清除浏览器的表单域|
#  206     Partial Content 部分内容
#                          服务器成功处理了部分GET请求|


#  3..     Redirction（重定向）         需要进一步的操作以完成请求  

#  300    Multiple Choices  =>多种选择
#                             请求的资源可包括多个位置，相应可返回一个资源特征与地址的列表用于用户终端（例如：浏览器）选择
#  301    Moved Permanently  =>永久移动，请求的资源已被永久的移动到新URI，返回信息会包括新的URI，浏览器会自动定向到新URI。
#                             今后任何新的请求都应使用新的URI代替
#  302    Found  => 临时移动。与 301 类似。但资源只是临时被移动。客户端应继续使用原有URI
#  303    See Other => 查看其它地址。 与301类似。使用GET和POST请求查看
#  304    Not Modified => 未修改。 所请求的资源未修改，服务器返回此状态码时，不会返回任何资源。
#                         客户端通常会缓存访问过的资源，通过提供一个头信息指出客户端希望只返回在指定日期之后修改的资源
#  305    Use Proxy  => 使用代理。 所请求的资源必须通过代理访问
#  306    Unused xxxxx  => 已经被废弃的HTTP状态码
#  307    Temporary Redirect  => 临时重定向。与302类似。使用GET请求重定向

#  4..     Client（客户端错误）         客户端错误，请求包含语法错误或无法完成请求      (前端错误/后端错误)

#  400      Bad Request  => 客户端请求的语法错误，服务器无法理解
#  401      Unauthorized => 请求要求用户的身份认证
#  402      Payment Required => 保留。将来使用
#  403      Forbidden => 服务器理解请求客户端的请求，但是拒绝执行此请求
#  404      Not Found => 服务器无法根据客户端的请求找到资源（网页）                    【前端错误/后端错误】
#                        通过此代码，网站设计人员可设置 "您所请求的资源无法找到" 的个性页面
#  405      Method Not Allowed  =>  客户端请求中的方法被禁止
#  406      Not Acceptable  => 服务器无法根据客户端请求的内容特性完成请求
#  407      Proxy Authentication Required => 请求要求代理的身份认证
#                                         与 401 类似，但请求者应当使用代理进行授权
#  408      Request Time-out => 服务器等待客户端发送的请求时间过长，超时
#  409      Conflict   => 服务器完成客户端的 PUT 请求是可能返回此代码，服务器处理请求时发生了冲突
#  410      Gone   => 客户端请求的资源已经不存在
#                     410 不同于 404，如果资源以前有现在被永久删除了可使用 410 代码，网站设计人员可通过 301 代码指定资源的新位置
#  411      Length Required  => 服务器无法处理客户端发送的不带 Content-Length 的请求信息
#  412      Precondition Failed  => 客户端请求信息的先决条件错误
#  413      Request Entity Too Large => 由于请求的实体过大，服务器无法处理，因此拒绝请求。
#                                       为防止客户端的连续请求，服务器可能会关闭连接。
#                                       如果只是服务器暂时无法处理，则会包含一个 Retry-After 的响应信息
#  414      Request-URI Too Large  =>  请求的 URI 过长（ URI 通常为网址），服务器无法处理
#  415      Unsupported Media Type => 服务器无法处理请求附带的媒体格式
#  416      Requested range not satisfiable => 客户端请求的范围无效
#  417      Expectation Failed => 服务器无法满足 Expect 的请求头信息


#  5..     Server Error（服务端错误）   服务器错误，服务器在处理请求的过程中发生了错误  (后端错误)

#  500      Internal Server Error  => 服务器内部错误，无法完成请求
#  501      Not Implemented  =>   服务器不支持请求的功能，无法完成请求
#  502      Bad Gateway    =>   充当网关或代理的服务器，从远端服务器接收到了一个无效的请求
#  503      Service Unavailable =>  由于超载或系统维护，服务器暂时的无法处理客户端的请求。
#                                   延时的长度可包含在服务器的Retry-After头信息中
#  504      Gateway Time-out =>  充当网关或代理的服务器，未及时从远端服务器获取请求
#  505      HTTP Version not supported  => 服务器不支持请求的HTTP协议的版本，无法完成处理
```

#### 3.2.2 首部字段

``` text
    Date: Mon, 27 Jul 2018 12:28:53 GMT
    Content-Length: 724
    Content-Type: text/html
```

具体学习见第四章:<a href="#id4" target="_self">HTTP报文首部</a>

## 四、HTTP 报文首部

<p id="id4"></p>

![请求报文首部](http://liuxmoo.foryung.com/qingqiubaowen50.jpg)![响应报文首部](http://liuxmoo.foryung.com/xiangyingbaowen50.jpg)

### 4.1 HTTP 报文分类

- 请求报文
- 响应报文

### 4.2 HTTP 首部字段类型

- 通用首部字段：请求报文和响应报文两方都会使用的首部
- 请求首部字段：从客户端向服务器发送请求报文时使用的首部。补充了请求的附加内容、客户端信息、响应内容相关 优先级等信息
- 响应首部字段：从服务器向客户端返回响应报文时使用的首部。补充了响应的附加内容，也会要求客户端附加额外的内容信息
- 实体首部字段：针对请求报文和响应报文的实体部分使用的首部。补充了资源内容更新时间等实体有关的信息

>HTTP首部字段由 **首部字段名** : **字段值** 构成，字段值可以有多个，如：Keep-Alive：timeout=15，max=100

   -------------------**通用首部字段** ---------------------------------------------------------------------------------------------------------------------------------------**实体首部字段**-----------------

|序号|*通用首部字段名*|说明|||序号|*实体首部字段名*|说明|
|:----|:---- |:---- |:----|:----|:----|:----|:----|
|1|Cache-Control|控制缓存的行为|||1|Allow|资源可支持的HTTP方法
|2|Connection|逐跳首部、连接的管理|||2|Content-Encoding|实体主体的适用的编码方式|
|3|Date|创建报文的日期时间|||3|Content-Language|实体主体的自然语言|
|4|Pragma|报文指令|||4|Content-Length|实体主体的大小（单位：字节）|
|5|Trailer|报文末端的首部一览|||5|Content-Location|替代对应资源的URI|
|6|Transfer-Encoding|指定报文主体的传输编码方式|||6|Content-MD5|实体主体的报文摘要|
|7|Upgrade|升级为其他协议|||7|Content-MD5|实体主体的报文摘要|
|8|Via|代理服务器的相关信息|||8|Content-Range|实体主体的位置范围|
|9|Warning|错误通知|||9|Content-Type|实体主体的媒体类型|
||||||10|Expires|实体主体过期的日期时间|

   -------------------**请求首部字段** ---------------------------------------------------------------------------------------------------------------------------------------**响应首部字段**-----------------

|序号|*请求首部字段名*|说明|||序号|*响应首部字段名*|说明|
|:----|:---- |:---- |:----|:----|:----|:----|:----|
|1|Accept|用户代理可处理的媒体类型|||1|Accept-Ranges|是否接受字节范围请求
|2|Accept-Charset|优先的字符集|||2|Age|推算资源创建经过时间
|3|Accept-Encoding|优先的内容编码|||3|ETag|资源的匹配信息
|4|Accept-Language|优先的语言（自然语言）|||4|Location|令客户端重定向至指定的URI
|5|Authorization|Web认证信息|||5|Proxy-Authenticate|代理服务器对客户端的认证信息
|6|Expect|期待服务器的特定行为|||6|Reter-After|对再次发起请求的时机要求
|7|From|用户的电子邮箱地址|||7|Server|HTTP服务器的安装信息
|8|Host|请求资源所在服务器|||8|Vary|代理服务器缓存的管理信息
|9|if-Match|比较实体标记（ETag）|||9|WWW-Authenticate|服务器对客户端的认证信息
|10|if-Modified-Since|比较资源的更新时间||||||
|11|if-None-Match|比较实体标记（与if-Match相反）||||||
|12|if-Range|资源未更新时发送实体Byte的范围请求||||||
|13|if-Unmodified-Since|比较资源的更新时间（与if-Modified-Since相反）||||||
|14|Max-Forwards|最大传输逐跳数||||||
|15|Proxy-Authorization|代理服务器要求客户端的认证信息||||||
|16|Proxy-Authorization|代理服务器要求客户端的认证信息||||||
|17|Referer|对请求中URI的原始获取方法||||||
|18|TE|传输编码的优先级||||||
|19|User-Agent|HTTP客户端程序的信息||||||

### 4.3 HTTP 请求报文首部、 HTTP 响应报文首部

HTTP请求报文首部

- **请求行**
- **请求首部字段**
- 通用首部字段
- 实体首部字段

HTTP响应报文首部

- **状态行**
- **响应首部字段**
- 通用首部字段
- 实体首部字段

## 五、HTTP 背景，web、网络基础 TCP/IP



## 十、bug

### 10.1

```BASH
Uncaught (in promise) DOMException: Failed to execute 'open' on 'XMLHttpRequest': '' is not a valid HTTP method.
    at dispatchXhrRequest (webpack-internal:///./node_modules/axios/lib/adapters/xhr.js:45:13)
    at new Promise (<anonymous>)
    at xhrAdapter (webpack-internal:///./node_modules/axios/lib/adapters/xhr.js:12:10)
    at dispatchRequest (webpack-internal:///./node_modules/axios/lib/core/dispatchRequest.js:59:10)
```

是因为在 ajax 请求，或者是 axios 封装的请求中，url 或者是 method 写了 ''。
没有写到的代码就先不要把 请求先写了，会报各种的错误。

这个错误有的时候回说是 url 的问题，可能是填写的 url 不完整，没有 http 或者 https ，或者是缺少其他的。