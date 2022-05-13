---
layout: default
title: "JavaScript/ES6 快速上手教程（四）：Node.js用法"
author: 李佶澳
date: "2019-06-22T12:28:28+0800"
last_modified_at: "2019-06-28T18:42:49+0800"
categories: tutorial
tags: 环境
cover: javascript.004.jpg
keywords: nodejs,node使用方法,node运行
description: 有必要先了解 node 的基本用法，如何运行代码，断点调试、性能分析以及制作火焰图，Node 自带的标准模块以及异步编程的特点和实现方法
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

这里主要用 node（也就是 node.js） 运行 javascript 代码，因此有必要先了解 node 的基本用法。安装方法在 [运行环境](https://www.lijiaocn.com/tutorial/javascript/2019/06/19/2019-06-16-javascript-02-env/#%E6%9C%8D%E5%8A%A1%E7%AB%AF%E8%BF%90%E8%A1%8C%E7%8E%AF%E5%A2%83-nodejs)  章节已经介绍过，这里不赘述。

下面的内容主要来自 [Node.js Guides][2]。

## 运行启动

Node 默认支持用 require 指令导入模块，下面是用 node 写的一个 http 服务：

```js
const http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World\n');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
```

用 node 直接运行 .js 文件：

```
node ./app.js
```

## 断点调试

Node 运行时如果带有 `--inspect` 参数，会启动一个进程默认监听 `127.0.0.1:9229`，用于与调试客户端交互。每个调试进程会有一个 UUID，调试客户端用类似下面的连接接入调试进程：

```
ws://127.0.0.1:9229/0f2c936f-b1cd-4ac9-aab3-f63b0f33d55e
```

最后一段是 UUID，在 node 运行时候的会输出调试进程地址：

```sh
$ node --inspect ./app.js
Debugger listening on ws://127.0.0.1:9229/2f51127b-357c-4506-81ed-b536fa9ff455
For help, see: https://nodejs.org/en/docs/inspector
Server running at http://127.0.0.1:3000/
```

调试进程拥有 node 运行环境的所有权限，注意不要把调试进程的监听地址暴露到公网中。

主流的 IDE 譬如 Visual Studio Code 1.10+、Visual Studio 2017、JetBrains WebStorm 2017.1+ 等都支持接入 node 的调试进程。

命令行调试可以使用 `node-inspect`，支持单步调试：

```sh
$ npm install -g node-inspect
$ node-inspect ./app.js
< Debugger listening on ws://127.0.0.1:9229/3294e5af-125a-4eb1-ae41-f2c094786029
< For help, see: https://nodejs.org/en/docs/inspector
< Debugger attached.
Break on start in app.js:7
  5  * Distributed under terms of the GPL license.
  6  */
> 7 const http = require('http');
  8
  9 const hostname = '127.0.0.1';
debug>
```

## 性能分析

Node 内置了性能分析工具 [profiler inside V8](https://nodejs.org/en/docs/guides/simple-profiling/)，运行时加上 `--prof` 参数启用：

```sh
node --prof app.js
```

加上 --prof 后，运行时会生成一个名为 `isolate-0x103cee000-79976-v8.log` 的文件，这个文件中记录了性能相关的数据，用下面的命令解读：

```sh
$ node --prof-process isolate-0x103cee000-79976-v8.log
Statistical profiling result from isolate-0x103cee000-79976-v8.log, (231 ticks, 6 unaccounted, 0 excluded).

 [Shared libraries]:
   ticks  total  nonlib   name
      4    1.7%          /usr/lib/system/libsystem_platform.dylib
      1    0.4%          /usr/lib/system/libsystem_malloc.dylib
      1    0.4%          /usr/lib/libc++.1.dylib

 [JavaScript]:
   ticks  total  nonlib   name

 [C++]:
   ticks  total  nonlib   name
    114   49.4%   50.7%  T __ZN2v810Int16Array9CheckCastEPNS_5ValueE
     40   17.3%   17.8%  T node::native_module::NativeModuleEnv::CompileFunction(v8::FunctionCallbackInfo<v8::Value> const&)
     14    6.1%    6.2%  T _read
     12    5.2%    5.3%  T __kernelrpc_vm_remap
      8    3.5%    3.6%  T _fcntl$NOCANCEL
      4    1.7%    1.8%  T __ZN4node7TTYWrap3NewERKN2v820FunctionCallbackInfoINS1_5ValueEEE
...
```

## 火焰图分析

可以用 perf 采集运行时的数据，然后依据采集到数据生成 [火焰图][3]，perf 是一个 Linux 工具，要在 Linux 系统上使用。

用 perf 采集运行时数据：

```sh
perf record -e cycles:u -g -- node --perf-basic-prof app.js
perf script > perfs.out
```

用 stackvis 生成火焰图：

```sh
# 安装方法：npm i -g stackvis 
stackvis perf < perfs.out > flamegraph.htm
```

如果要分析正在运行的 node 应用，可以用下面的方法，`-p` 指定进程号，`-F99` 意思是数据采集频率为每秒 99 次：

```sh
perf record -F99 -p `pgrep -n node` -g -- sleep 3
```

如果希望火焰图中只包含 node 的函数，在生成火焰图前用下面的命令清除非 node 函数的记录：

```sh
sed -i \
  -e "/( __libc_start| LazyCompile | v8::internal::| Builtin:| Stub:| LoadIC:|\[unknown\]| LoadPolymorphicIC:)/d" \
  -e 's/ LazyCompile:[*~]\?/ /' \
  perfs.out
```

更多用法见 [Node.js：Flame Graphs](https://nodejs.org/en/docs/guides/diagnostics-flamegraph/)。

## Node API

Node 自带了大量的模块，可以直接使用，见：[Node.js v12.4.0 Documentation][4]。

## 同步与异步

Node 自带一些模块同时提供了同步与异步的方法，前者在调用时会阻塞到执行完成。

同步方法：

```js
const fs = require('fs');
const data = fs.readFileSync('./file.md'); // blocks here until file is read
console.log(data);
console.log("finish"); // will run after console.log
```

运行输出为：

```sh
$ node ./sync.js
<Buffer 41 42 43 20 48 65 6c 6c 6f 20 57 6f 72 6c 64 21 20 0a>
finish
```

异步方法：

```js
const fs = require('fs');
fs.readFile('./file.md', (err, data) => {
  if (err) throw err;
  console.log(data);
});
console.log("finish") // will run before console.log
```

运行输出为：

```sh
$ node ./async.js
finish
<Buffer 41 42 43 20 48 65 6c 6c 6f 20 57 6f 72 6c 64 21 20 0a>
```

上面两种方式，输出结果中 finish 出现的位置不同。

JS 代码在 node 中是单线程运行的，这一点和其它语言非常不同，要尽量使用异步的方法。

Node 的并发机制是事件驱动，可以到 [The Node.js Event Loop, Timers, and process.nextTick()](https://nodejs.org/en/docs/guides/event-loop-timers-and-nexttick/) 中详细了解。

并发编程时的注意事项：[Don't Block the Event Loop (or the Worker Pool)](https://nodejs.org/en/docs/guides/dont-block-the-event-loop/)。

Node 定时器的原理：[Timers in Node.js and beyond](https://nodejs.org/en/docs/guides/timers-in-node/)。

## Node 项目管理

Node 项目的依赖用 package.json 管理，用 npm 初始化生成：

```sh
$ mkdir 07-ES6-Async-Generator
$ cd 07-ES6-Async-Generator
$ npm init
# 根据提示填入项目名称等
```

用下面的命令安装依赖包，依赖被自动写入 package.json 文件中：

```sh
npm install co --save
```

## 参考

1. [李佶澳的博客][1]
2. [Node.js Guides][2]
3. [火焰图，Flame Graphs][3]
4. [Node.js v12.4.0 Documentation][4]

[1]: https://www.lijiaocn.com "李佶澳的博客"
[2]: https://nodejs.org/en/docs/guides/ "Node.js Guides"
[3]: https://www.lijiaocn.com/%E6%96%B9%E6%B3%95/2019/03/01/performance-analysis-methodology.html#%E7%81%AB%E7%84%B0%E5%9B%BEflame-graphs "火焰图，Flame Graphs"
[4]: https://nodejs.org/dist/latest-v12.x/docs/api/ "Node.js v12.4.0 Documentation"
