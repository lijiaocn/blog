---
layout: default
title: "JavaScript/ES6 快速上手教程（六）：异步编程"
author: 李佶澳
date: "2019-06-23T21:19:47+0800"
last_modified_at: "2019-06-28T23:55:45+0800"
categories: tutorial
tags: 语法
cover: javascript.006.jpg
keywords: promise,async,js异步编程
description: promise/async/yield等异步编程方法，异步编程是javascript的重要特点，js因为是单线程运行的，天然需要采用异步的方式编程
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

JavaScript 因为是单线程运行的，天然需要采用异步的方式编程，回调函数和事件是最传统的异步编程方法。ES6 提供了一些新的用于异步编程的指令，例如 Promise 对象和 async 函数，使异步代码更简洁。

## 用 Promise 封装异步执行的代码

Promise 是非常重要的 JS 异步编程技术，Promise 是一个类，它的实例中保存着未来才会发生的事件。一个 Promise 对象就是一个异步操作，有 `pending`、`fulfilled` 和 `rejected` 三种状态，这三种状态由异步操作的结果决定。

使用 Promise 对象的时候，需要为 Promise 对象提供回调函数，Promise 对象一旦新建就会立即执行，执行结果和异常等通过回调函数反馈到外部。

阮一峰提到一句，如果事件是不断反复发生的，使用 [Stream](https://nodejs.org/api/stream.html) 更好。

### 基本使用

创建 Promise 实例，构造函数的传入参数是一个类型为 function(resolve,reject){} 的函数。

```js
let promise1 = new Promise(function(resolve, reject){
  /* 处理代码 */
  let result = true
  let value = "promise1 success"
  if(result){
    resolve(value);
  }else{
    reject(error);
  }
});
```

在传入的函数中添加要异步执行的代码：如果执行成功没有错误，使用传入的第一个参数 `resolve`，将结果传送出去 `resolve(value)`；如果执行失败，用传入的第二个参数 `reject` 将错误信息传送出去。resolve 和 reject 会分别将 Promise 实例的状态变更为 `fulfilled` 和 `rejected`，调用这两个函数意味着异常处理完成。

那么要如何获取返回的结果呢？用 Promise 的方法 `then(func1, func2)` 设置异步操作成功时的回调函数和异步操作失败时的回调函数：

```js
promise1.then(function(value){
  console.log(value)
},function(error){
  console.log(error)
});
```

`then()` 的参数是两个类型为 `function(value)` 的参数，第一个是异步操作成功时的回调函数，第二个是异步操作失败时的回调函数，这两个函数的唯一参数分别是创建 Promeise 对象时用到的 resolve 和 reject 的参数。

运行结果如下：

```js
$ node ./app.js
promise1 success
```

构造一个异步操作失败的例子：

```js
let promise2 = new Promise(function(resolve, reject){
  /* 处理代码 */
  let result = false
  let value = "promise2 success"
  let error = "promise2 fail"
  if(result){
    resolve(value);
  }else{
    reject(error);
  }
});

promise2.then(function(value){
  console.log(value)
},function(error){
  console.log(error)
  });

```

运行结果是：

```js
$ node ./app.js
promise2 fail
```

### then() 方法链式调用

Promise 的 then 方法返回的是一个新的  promise 实例，可以使用链式的写法，上一个 then 的回调函数的返回是下一个 then 的回调函数输入参数：

```js
// Promise.prototype.then
let promise3 = new Promise(function(resolve, reject){
  /* 处理代码 */
  let result = true
  let value = "promise1 success"
  let error = "promise1 fail"
  if(result){
    resolve(value);
  }else{
    reject(error);
  }
});

promise3.then(function(value){
  return "first then"
},function(error){
  console.log(error)
}).then(function(str){
  console.log("print first then return: %s",str)
});
```

then 的参数是两个回调函数分别处理 resolved 和 rejected 的状态。

### catch() 和 finally()

catch() 在两种情况下会被调用：

1. 异步操作过程的状态变成 rejected；
2. then 方法的回调函数抛出异常。

第一种情况下，catch() 的作用类似于 then() 的第二个参数，使用 catch 处理失败的情形是推荐的做法。

catch() 返回的还是一个 Promise 对象，可以继续链式调用 then 方法。

finally() 是无论状态如何，一定会被执行的，ES2018 引入的，该方法不接受任何参数。

### all() 和 race() 组合 Promise

Promise.all() 将多个 Promise 实例组合成一个新的 Pomise 实例，只有当所有的实例状态变成 fulfilled，混合后的 Promise 实例才是 fulfilled。

Promise.race() 也是将多个 Promise 实例组合成一个新的 Promise 实例，不同于 all 的是，哪个实例状态先改变，采用哪个实例的状态。

### resolve() 和 reject()

Promise.resolve() 将现有对象转换为 Promise 对象，Promise.reject() 返回一个状态为 rejected 的 Promise 实例。

## Generator 函数实现异步执行

Generator 是 ES6 引入的异步编程解决方案。

### 定义和使用

Generator 函数的 function 后面带有一个 `*` 号，函数内部使用 yield 定义多个状态，Generator 函数的返回结果是一个迭代器，该迭代器的每次 next 返回一个 yield 对应的状态：

```js
function* Generator1() {
  yield 'generator content 1';
  yield 'generator content 2';
  return 'ending';
}

let iter1 = Generator1()
console.log(iter1.next())
console.log(iter1.next())
console.log(iter1.next())
```

运行结果如下：

```js
$ node ./app.js
{ value: 'generator content 1', done: false }
{ value: 'generator content 2', done: false }
{ value: 'ending', done: true }
```

yield 只能在 Generator 函数内使用。

Generator 生成的迭代器的 next() 方法可以带参数，参数被认为是上一个 yield 的返回值，可以在 Generator 函数中根据这个值执行不同的操作。

### 使用 co 自动执行

Generator 返回的迭代器需要用 next() 方法推动执行，[co](https://github.com/tj/co) 模块可以让 Generator 自动执行，co 返回的是一个 Promise 实例，可以使用 then()、catch() 等方法。

```js
let co = require('co');

function* Generator2() {
  console.log('generator content 1');
  console.log('generator content 2');
  return 'hello'
}

iter2 = Generator2()

co(iter2).then(function(v){
  console.log(v)
}).catch(function(err){
  console.log(err)
})
```

## 用 async 执行异步代码

async 是 Generator 函数的语法糖，async 等同于 function *，await 等同于 yield，但是在语法上有改进：

1. async 本身就是自动执行的，不需要借助 co 等模块；
2. await 命令后面可以是 Promise 对象或者原始类型值（被自动转换成 resoved 状态的 Promise 对象）；
3. async 函数返回的是 Promise 对象，可以直接使用 then() 等方法。

await 语句是异步、严格按照出现的顺序执行的，await 只能在 async 函数内使用。

```js
async function asyncFunc1(){
  await console.log('asyncFunc content 1')
  await console.log('asyncFunc content 2')
  return 'asyncFunc1 return'
}

asyncFunc1().then(v => console.log(v))
```

执行结果如下：

```sh
$ node ./app.js
asyncFunc content 1
asyncFunc content 2
asyncFunc1 return
```

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
