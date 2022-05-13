---
layout: default
title: "JavaScript/ES6 快速上手教程（一）：导言"
author: 李佶澳
date: "2019-06-16T19:39:29+0800"
last_modified_at: "2019-06-22T19:02:01+0800"
categories: tutorial
tags: 导言
cover: javascript.001.jpg
keywords: javascript,入门导言,ECMA6,ES6,ES9
description: 对于以前从没有接触过 JavaScript 的初学者，应当一开始就学习最新的、没有那么「奇葩」的用法
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

为了开发微信小程序而学习 JavaScript，快速阅读了阮一峰[《JavaScript 教程》][3]后，大惊失色：JavaScript 太奇葩了！

譬如说：代码块不是作用域，作用域只有顶层和函数内；相等运算符`==`两边的操作数竟然会自动进行类型转换，要使用`===`才靠谱；with 语句中如果使用对象没有的属性，会定义一个全局变量；还有严格模式，以及非常奇葩地构造函数、类、继承的实现......详细情况可以见当时做的笔记：[微信小程序开发学习笔记（二）：JavaScript][2]。

继续阅读阮一峰[《ECMAScript 6 入门》][4]时，又崩溃了：为了修正前面花费大量时间掌握的各种奇葩特性，ECMAScript 6 又定义了一些新的特性，需要再一次阅读 30 多章的内容更新知识。本来计划半天或一天就掌握 JavaScript，结果阅读了整整一天半，都头晕脑胀了还没有学完。我只想快速的上手应用，对这个学习效率相当不满意。

为什么会这样？

后来我想明白了，对于以前从没有接触过 JavaScript 的初学者，应当一开始就学习最新的、没有那么「奇葩」的用法，而不是在那些被人诟病且正在被新用法取代的语法细节上耗费大量时间。重要的是先能用起来！

于是有了这个系列的教程，这个教程源自是我自己的学习过程积攒下来的资料。

## JavaScript 的语言标准

JavaScript 是一个历史负担很重的语言，它本来只是作为一个浏览器的小功能被设计出来，谁也没想到它会伴随着 Web 的发展成为一门举足轻重的语言！它的应用领域也早已超出了前端，开始介入后台开发，并且很多跨平台的 UI 项目也选择 JavaScript 作为接口语言！

现在用 JS 可以写前端、后端，开发各个平台上的 APP，JS 从曾经的小脚本语言发展为最全能的语言了！JavaScript 的语法设计的太简单不够严谨了，导致它有很多奇葩的行为，埋了很多坑，与现在的地位非常不相称。很多人都认识到这一点，陆续有多个组织尝试将其改造的更易用、更不容易出错，先后开发出 CoffeeScript、TypeScript、JSX、HyperScript 等 JS 的超集，但最被广泛认同的是 [ECMA International](http://www.ecma-international.org/) 制定的 [ECMAScript](https://www.ecma-international.org/publications/standards/Ecma-262.htm) 标准。

ECMAScript 第一个重要标准 2015 年出炉的 ES6，现在已经发展到 ES9，但最主要的变化发生在 ES6 中。国内阮一峰编写 [《ECMAScript 6 入门》][4]是最好的学习资料，本教程中的大量内容都来自于它。好吧，我就是看着阮一峰老师的资料学习的，把阮老师的两本书消化吸收后才出了这份教程，这份教程更通俗一些，直接介绍正确的做法，而不讨论各种各样的场景，因此上手更快。

## 参考

1. [李佶澳的博客][1]
2. [微信小程序开发学习笔记（二）：JavaScript][2]
3. [阮一峰：JavaScript 教程][3]
4. [阮一峰：ECMAScript 6 入门][4]

[1]: https://www.lijiaocn.com "李佶澳的博客"
[2]: https://www.lijiaocn.com/%E9%A1%B9%E7%9B%AE/2019/06/12/wx-xcx-dev-02-javascript.html  "微信小程序开发学习笔记（二）：JavaScript"
[3]: https://wangdoc.com/javascript/ "阮一峰：JavaScript 教程"
[4]: https://es6.ruanyifeng.com/ "阮一峰：ECMAScript 6 入门"
