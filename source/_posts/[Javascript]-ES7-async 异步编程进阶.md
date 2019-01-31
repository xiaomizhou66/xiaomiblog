---
title: 'async 异步编程进阶'
date: '2018/8/19 23:57:28'
categories:
  - ② Javascript-ES6-Typescript
  - ES6
updated:
tags:
comments:
---
## 一、前言

异步编程对 JavaScript 语言太重要。JavaScript 语言的执行环境是“单线程”的，如果没有异步编程，根本没法用，非卡死不可。

单线程：就相当于一个人干所有的事情，小事都是大事。
多线程：相当于很多人去干一件事情，就大事化小了。

但是很多时候，我们一个语句的执行需要依赖另外一个语句的结果，那么就需要去处理异步操作。

## 二、异步操作

- 回调函数
- 事件监听
- new proxy({})
- Promise 对象
- Generator 函数
- async....await（应该算是 ES7 的内容）

### 2.1 异步？

同步：等待上一个的结果，下一个才能执行
异步：不需要等待上一个的结果，下面的语句也执行了

所谓"异步"，简单说就是一个任务不是连续完成的，**可以理解成该任务被人为分成两段，先执行第一段，然后转而执行其他任务，等做好了准备，再回过头执行第二段。**比如，有一个任务是读取文件进行处理，任务的第一段是向操作系统发出请求，要求读取文件。然后，程序执行其他任务，等到操作系统返回文件，再接着执行任务的第二段（处理文件）。这种不连续的执行，就叫做异步。

相应地，连续的执行就叫做同步。由于是连续执行，不能插入其他任务，所以操作系统从硬盘读取文件的这段时间，程序只能干等着。

### 2.1 回调函数（太难了）

回调函数，就是 B 函数作为 A 函数的参数，在 A 函数中调用。

```JS
function A(b, c) {
    b(c)
    console.log('AAAAAAAAA')
}

function B(c) {
    c()
    console.log('我是回调函数B，作为别的函数的参数')
}

function C() {
    console.log('我是回调函数C，作为别的函数的参数')
}

A(B,C)
// 我是回调函数C，作为别的函数的参数
// 我是回调函数B，作为别的函数的参数
// AAAAAAAAA
```

```JS
//付款的简易流程，先找人，再找订单，最后支付。其中找人、找订单和支付都是异步逻辑。
function pay() {
    getUserByDB(function (err, user) {
        if (err) {
            console.error('出错了');
            return false;
        }
        if (user) {
            getOrderByDB(function (err, order) {
                if (err) {
                    console.error('出错了');
                    return false;
                }
                if (order) {
                    toPayByDB(function (err) {
                        if (err) {
                            console.error('出错了');
                            return false;
                        }
                        console.log('支付成功');
                    });
                } else {
                    createOrderByDB(function (err, order) {
                        if (err) {
                            console.error('出错了');
                            return false;
                        }
                        toPayByDB(function (err) {
                            if (err) {
                                console.error('出错了');
                                return false;
                            }
                            console.log('支付成功');
                        });
                    });
                }
            });
        } else {
            createUserByDB(function (err, user) {
                if (err) {
                    console.error('出错了');
                    return false;
                }
                getOrderByDB(function (err, order) {
                    if (err) {
                        console.error('出错了');
                        return false;
                    }
                    if (order) {
                        toPayByDB(function (err) {
                            if (err) {
                                console.error('出错了');
                                return false;
                            }
                            console.log('支付成功');
                        });
                    } else {
                        createOrderByDB(function (err, order) {
                            if (err) {
                                console.error('出错了');
                                return false;
                            }
                            toPayByDB(function (err) {
                                if (err) {
                                    console.error('出错了');
                                    return false;
                                }
                                console.log('支付成功');
                            });
                        });
                    }
                });
            });
        }
    });
}
pay();
```

### 2.2 new proxy({})

### 2.3 promise 对象 new Promise({})

Promise 内部具备三种状态（pending 进行中,fulfilled 已成功,rejected 已失败）

缺点：

- 首先，无法取消 Promise，一旦新建它就会立即执行，无法中途取消。
- 其次，如果不设置回调函数，Promise 内部抛出的错误，不会反应到外部。
- 第三，当处于 pending 状态时，无法得知目前进展到哪一个阶段（刚刚开始还是即将完成）

```JS
// Promise 对象是一个构造函数，用来生成 Promise 实例，对象
// 这里的 resolve, reject 是两个函数参数，由 JavaScript 引擎提供，不用自己部署。
const promise = new Promise(function(resolve, reject) {
  // ... some code

  if (/* 异步操作成功 */){
    resolve(value);
  } else {
    reject(error);
  }
});

promise.then((res)=>{
    //resolved
},(err)=>{
    //rejected 这个函数参数是可选的
}).catch((err)=>{
    //
})
```

```JS

// 这里假设所有异步操作的返回都是符合 Promise 规范的。不符合怎么办
// 实际场景中，比如 mongoose 是可以配置的，异步回调也可以自己去封装
function pay() {
    return getUserByDB()
        .then(function (user) {
            if (user) return user;
            return createUserByDB();
        })
        .then(getOrderByDB)
        .then(function (order) {
            if (order) return order;
            return createOrderByDB();
        })
        .then(toPayByDB)
        .catch(function (err) {
            console.error(err);
        });
}
pay().then(function (order) {
    console.log('付款成功了');
});
```

### 2.4 Generator 函数 *...yield...

```JS
function B() {
    // 协程B可以是字符串、同步函数、异步函数、对象、数组
    // 这里用函数更能说明问题
    console.log('222222222')
    return '协程 B 交还了执行权';
}

function * A() {
    console.log('111111111');//next()
    let A2 = yield B();
    console.log('333333333');//
    return A2;
}

let it = A();//这是 generator 的调用方法，用来实例化一个变量
console.log(it.next())//1111111 222222 { value: '协程 B 交还了执行权', done: false }
console.log(it.next())//3333333        { value: undefined, done: true }
// 变量的 it.next()  执行了变量 it 的第一步，与异步的 B ，返回{ value: '协程 B 交还了执行权', done: false }
//        此时 A 是没有执行完的
// 再次   it.next()  执行了变量 it 的第二部，返回 { value: undefined, done: true }
//        此时 A 已经执行完了
```

```JS
function * Pay() {
    // 这四个变量是为了更好的说明这个过程
    // 其实只需user 和  order 两个变量就能解决问题
    let oldUser = null;
    let newUser = null;
    let oldOrder = null;
    let newOrder = null;
    try {
        let oldUser = yield getUserByDB();
        if (!oldUser) {
            newUser = yield createUserByDB();
        }
        let oldOrder = yield getOrderByDB();
        if (!oldOrder) {
            newOrder = yield createOrderByDB();
        }
        const result = yield toPayByDB();
        return result;
    } catch (error) {
        console.error('支付失败');
    }
}

const pay = Pay();
pay.next().value.then(function (user) { // 执行getUserByDB()，得到user，并停止
    // user不存在，next()不传值，则oldUser被赋值为undefined，然后执行createUserByDB()，得到user，并停止
    if (!user) return pay.next().value;
    return user; // 如果user存在，直接返回
}).then(function (user) {
    // 这个next(user)就有点复杂了。
    // 如果代码在执行了getUserByDB()后停止的，则next(user)就是把user赋值给oldUser
    // 如果代码在执行了createUserByDB()后停止的，则next(user)就是user赋值给newUser
    // 然后执行getOrderByDB()，得到order，并停止
    return pay.next(user).value.then(function (order) {
        // order不存在，next()不传值，则oldOrder被赋值为undefined，然后执行createOrderByDB()，得到order，并停止
        if (!order) return pay.next().value;
        return order; // 如果order存在，直接返回
    });
}).then(function (order) {
    // 这个next(order)同样。
    // 如果代码在执行了getOrderByDB()后停止的，则next(order)就是把order赋值给oldOrder
    // 如果代码在执行了createOrderByDB()后停止的，则next(order)就是order赋值给newOrder
    // 然后执行toPayByDB()，并停止。
    return pay.next(order).value; //  done的值为false
}).then(function () {
    // next(),将undefined赋值给result，并返回result
    pay.next(); // 此时done的值为true
});
```

### 2.5 async....await

async/await 就像自然界遵循着进化论一样，从最初的回调一步一步的演化而来，达到异步编程的最高境界，就是根本不用关心它是不是异步。

```JS
function sleep(s) {
    setTimeout(() => {
        console.log('希望我会先执行')
    }, s * 1000)
}

async function testAsync() {
    sleep(3);
    console.log('我会后面执行')
}
testAsync();
//我在后面执行
//希望我会先执行

// 上面的结果并不是我们需要的
```

```JS
function sleep(s) {
    setTimeout(() => {
        console.log('希望我会先执行')
    }, s * 1000)
}

// 异步函数
async function testAsync() {
    const data = await sleep(3);
    console.log('我会后面执行')
}
testAsync();

// async....await...异步编程,就是等待 await 后面跟着的函数先执行完之后，下面的语句才会执行
// 希望我会先执行
// 我会后面执行
```

```JS
//wepy 框架小程序的 代码
// 页面加载
onLaunch() {
  this.testAsync();//调用 testAsync 函数
  wepy.showShareMenu({
    withShareTicket: true
  });
}
sleep(s) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve('promise resolved');
    }, s * 1000);
  });
}
// 异步函数
async testAsync() {
  const data = await this.sleep(3);
  console.log(data);//保证上面的 sleep(3) 会先执行，才会执行这里的语句
}
```