---
layout: default
title: "JavaScript/ES6 快速上手教程（三）：项目结构"
author: 李佶澳
date: "2019-06-20T21:52:37+0800"
last_modified_at: "2019-06-22T19:01:33+0800"
categories: tutorial
tags: 项目
cover: javascript.003.jpg
keywords: javascript,module,代码结构,项目结构
description: "首先掌握ES6的模块用法，知道如何将一个大程序拆分相对独立的小文件，要承接大型的工程项目，module功能是必不可少的"
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

[ECMAScript 6 入门：Module 的语法][2]中介绍，JavaScript 一直是没有 module 功能的，大型项目无法分拆成多个模块实现。在 ES6 之前，CommonJS 和 AMD 分别实现了服务端的模块加载方案和浏览器端的模块加载方案。ES6 在语言标准上支持的模块功能，是浏览器和服务端通用的模块解决方案。

## 模块

ECMAScript 6 中，一个模块就是一个 js 文件。

需要特别注意的是：ES6 的模块全部都是严格模式，无论是否在文件头添加了“use strict”。

严格模式是 ES5 引进的，主要有以下限制：

1. 变量必须声明后再使用
2. 函数的参数不能有同名属性，否则报错
3. 不能使用with语句
4. 不能对只读属性赋值，否则报错
5. 不能使用前缀 0 表示八进制数，否则报错
6. 不能删除不可删除的属性，否则报错
7. 不能删除变量delete prop，会报错，只能删除属性delete global[prop]
8. eval不会在它的外层作用域引入变量
9. eval和arguments不能被重新赋值
10. arguments不会自动反映函数参数的变化
11. 不能使用arguments.callee
12. 不能使用arguments.caller
13. 禁止this指向全局对象
14. 不能使用fn.caller和fn.arguments获取函数调用的堆栈
15. 增加了保留字（比如protected、static和interface）

export、import 用于模块的导出导入，这两个指令最先执行，是静态加载，必须在模块的顶层。

Node 中的 require 方法是动态加载，和 export、import 不同：

```js
const path = './' + fileName;
const myModual = require(path);
````

ECMAScript 6 有一个提案，用 [import()](https://es6.ruanyifeng.com/#docs/module#import) 实现动态加载。

## export 指令

export 在模块内指定可以导出的变量，只有用 export 指定的变量可以在模块外使用。

export 可以在`模块顶层`的任何位置使用，不能在块级作用域（函数内部、条件代码块中等）中。

### 两种写法

export 写法1：

```js
export var firstName = 'Michael';
export var lastName = 'Jackson';
export var year = 1958;
```

export 写法2：

```js
var firstName = 'Michael';
var lastName = 'Jackson';
var year = 1958;

export { firstName, lastName, year };
```

### 函数和类的导出

函数的导出：

```js
export function multiply(x, y) {
  return x * y;
};
```

### 重命名导出

可以用 `as` 将变量重命名，导出为其它的名字：

```js
function v1() { ... }
function v2() { ... }

export {
  v1 as streamV1,
  v2 as streamV2,
  v2 as streamLatestVersion
};
```

### 导出值是动态绑定的

这一点需要特别注意：export 导出的变量，从模块外获取的是它在模块的内的实时值。

例如下面的模块，导出的变量 foo 的初始值是 `bar`，在模块内用 setTimeout 设置超时处理，500 毫秒后，编程 `baz`：

```js
export var foo = 'bar';
setTimeout(() => foo = 'baz', 500);
```

在模块外使用的 foo，拥有同样的特性，即在 500 毫秒后，值变为 `baz`。

## import 指令

import 用于在当前模块中导入另外一个模块，导入的变量可以在当前模块中直接使用。

```js
import { firstName, lastName, year } from './profile.js';
```

可以用 as 重命名导入的变量：

```js
import { lastName as surname } from './profile.js';
```

from 后面的模块文件，可使用相对路径和绝对路径，后缀 `.js` 可以省略。

也可以不带路径，直接使用模块名，但是这样需要提前在配置文件告知 JavaScript 的模块的位置：

```js
import {myMethod} from 'util';
```

### 导入的变量都是只读的

不能修改导入的变量的值，即使导入变量的属性能够修改，也不应修改。

直接修改导入的变量是语法错误：

```js
import {a} from './xxx.js';

a = {}; // Syntax Error : 'a' is read-only;
```

导入变量的属性是可以修改的，但是非常危险！因为其它导入了这个模块的模块，也会看到修改后的属性！这样会使被导入的模块的实现不可控、不可靠！

```js
import {a} from './xxx.js';

a.foo = 'hello'; // 合法操作，但不应该这样做！
```

### 只加载执行

可以只加载执行导入的模块：

```js
import 'lodash';
```

一个模块如果被重复导入多次，只会加载执行一次。

## export、import 混合使用

在一些场景下，export 和 import 可以混合使用。

### 模块整体导入

可以将一个模块整体加载，然后用 `.` 操作符引用模块的导出变量。

例如下面这个模块：

```js
// circle.js

export function area(radius) {
  return Math.PI * radius * radius;
}

export function circumference(radius) {
  return 2 * Math.PI * radius;
}
```

整体导入的使用方式：

```js
import * as circle from './circle';

console.log('圆面积：' + circle.area(4));
console.log('圆周长：' + circle.circumference(14));
```

导入的变量同样是只读的，不能改变。

### 模块的默认导出

`export default` 指定模块的默认导出，一个模块只能有一个默认导出，因此 export default 在模块内只能用一次。

export default 的真实含义是定义了名为 default 的变量，并将其导出。

设置了默认导出的模块：

```js
// export-default.js
export default function () {
  console.log('foo');
}

```

导入方法，customName 默认导出的 default 变量的新名字，不需要包含在 `{}` 中：

```js
// import-default.js
import customName from './export-default';
customName(); // 'foo'
```

### 将另一个模块中的变量导出

可以在当前模块中导入另一个模块中的变量，然后作为本模块的导出：

```js
export { foo, bar } from 'my_module';
```

等同于：

```js
import { foo, bar } from 'my_module';
export { foo, bar };
```

默认导出的再次导出：

```js
export { default } from 'foo';
```

还可以将一个模块整体导入后，再整体导出，形成类似继承的关系，被继承的模块的默认导出被 `export *` 忽略：

```js
// circleplus.js

export * from 'circle';
export var e = 2.71828182846;
export default function(x) {
  return Math.exp(x);
}
```

## 在 Node 中使用 import 

Node 12 对 import 还不是默认支持的，直接用 node 运行使用了 import 的 js 文件会报下面的错误：

```js
import module1 from './module1.js'
       ^^^^^^^

SyntaxError: Unexpected identifier
    at Module._compile (internal/modules/cjs/loader.js:718:23)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:785:10)
    at Module.load (internal/modules/cjs/loader.js:641:32)
    at Function.Module._load (internal/modules/cjs/loader.js:556:12)
    at Function.Module.runMain (internal/modules/cjs/loader.js:837:10)
    at internal/main/run_main_module.js:17:11
```

要解决这个问题，可以用 bazel 引导启用，或者使用 node 9 引入的在 node 12 时依然是实验状态的特性：`--experimental-modules`，这两种方法都有额外影响，如非必须直接使用 node 的 [require](https://nodejs.org/en/docs/guides/getting-started-guide/) 方法。

### 方法1: 用 bazel 引导

安装 babel 包：

```js
npm install babel-register babel-preset-env --D
```

然后编写一个新的 js 文件作为程序的执行入口，用下面的方法加载要运行的模块：

```js
require('babel-register') ({
    presets: [ 'env' ]
})

module.exports = require('./app.js')
```

文件结构如下：

```sh
├── app.js
├── install.sh
├── module1.js
├── run.sh
└── start.js
```

运行：

```sh
node ./start.js
```

### 方法2: --experimental-modules

截止 Node 12，--experimental-modules 是 node 的试验特性，需要在 node 运行的时候指定，并且 js 文件的后缀要修改成 .mjs：

```sh
.
├── app.mjs
├── module1.mjs
└── run.sh
```

引用时也要使用 .mjs 后缀：

```js
import module1 from './module1.mjs'
```

运行时，指定参数：

```sh
node --experimental-modules ./app.mjs
```

## 参考

1. [李佶澳的博客][1]
2. [ECMAScript 6 入门：Module 的语法][2]

[1]: https://www.lijiaocn.com "李佶澳的博客"
[2]: https://es6.ruanyifeng.com/#docs/module "ECMAScript 6 入门：Module 的语法"
