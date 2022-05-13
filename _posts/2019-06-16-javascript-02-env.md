---
layout: default
title: "JavaScript/ES6 快速上手教程（二）：运行环境"
author: 李佶澳
date: "2019-06-19T21:59:48+0800"
last_modified_at: "2019-06-22T19:01:18+0800"
categories: tutorial
tags: 环境
cover: javascript.002.jpg
keywords: javascript,运行环境,node,chrome v8,WebAssembly
description: "服务端运行引擎选用基于Chrome's V8引擎的node,支持ECMAScript6和WebAssembly，客户端运行环境就是浏览器，不同浏览器支持程度不同"
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

准备 javascript 的运行环境。

## 服务端运行环境： Node.js

[Node.js][2] 是服务端的 JavaScript 的运行环境，基于 Chrome's V8 引擎，是最主流的 JavaScript 服务端引擎。[V8][3] 是 Google 开源的高性能 JavaScript 和 WebAssembly 引擎，被用于 Chrome 浏览器，支持 [ECMAScript](https://tc39.es/ecma262/) 和 [WebAssembly](https://webassembly.github.io/spec/core/) 标准。

到 Node.js 的[官网][2]下载安装包，或者在 Mac 上用 brew 安装：

```sh
brew install node 
```

CentOS 和 Ubuntu 分别用 yum 和 apt-get 安装。

在 Mac 上用 brew 安装，如果遇到错误下面的错误：

```sh
Warning: The post-install step did not complete successfully
```

尝试 [解决方法](https://medium.com/@wangyiguo/mac-os-%E9%87%8D%E6%96%B0%E5%AE%89%E8%A3%85-npm-%E5%A4%B1%E8%B4%A5-%E7%B3%BB%E7%BB%9F%E6%8F%90%E7%A4%BA-warning-the-post-install-step-did-not-complete-successfully-504b3c33b213)：

```sh
sudo chown -R $(whoami) $(brew --prefix)/*
```

安装成功后，可以执行 node 命令，这里使用的版本是 v12.4.0：

```sh
$ node --version
v12.4.0
```

用阮一峰提供的 [es-checker][4] 检查一下当前的 node 对 ECMAScript 6 标准的支持情况：

```sh
$ npm install -g es-checker
$ es-checker
...
=========================================
Passes 39 feature Detections
Your runtime supports 92% of ECMAScript 6
=========================================
```

## 浏览器端

用浏览器打开下面的连接，检查当前的浏览器对 ECMAScript 6 的支持情况：

[http://ruanyf.github.io/es-checker/ ](http://ruanyf.github.io/es-checker/)

各大浏览器对 ECMAScript 6 的支持情况：

[https://kangax.github.io/compat-table/es6/ ](https://kangax.github.io/compat-table/es6/)

## ES6 -> ES5 转换器

如果现有的环境不支持 ECMAScript 6 ，可以用转换器将 ES6 的代码转成 ES5 代码。

[ECMAScript 6 入门][5]中给出两个转换器：[Babel](https://babeljs.io/)、[traceur-compiler](https://github.com/google/traceur-compiler)。

## 用 Node 运行 ES6 代码

Node 对 ES6 对支持计划在 [ECMAScript 2015 (ES6) and beyond](https://nodejs.org/en/docs/es6/) 中可以找到，[node.green](https://node.green/) 列出各个 node 版本对 ES6 的支持情况。 


## 参考

1. [李佶澳的博客][1]
2. [Node.js][2]
3. [Google’s open source high-performance JavaScript and WebAssembly engine][3]
4. [es-checker][4]
5. [ECMAScript 6 入门][5]

[1]: https://www.lijiaocn.com "李佶澳的博客"
[2]: https://nodejs.org/en/ "Node.js"
[3]: https://v8.dev/ "Google’s open source high-performance JavaScript and WebAssembly engine"
[4]: https://github.com/ruanyf/es-checker "es-checker"
[5]: https://es6.ruanyifeng.com/#docs/intro "ECMAScript 6 入门"
