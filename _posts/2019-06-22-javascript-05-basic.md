---
layout: default
title: "JavaScript/ES6 快速上手教程（五）： 语言基础"
author: 李佶澳
date: "2019-06-22T19:16:33+0800"
last_modified_at: "2019-06-23T21:04:26+0800"
categories: tutorial
tags: 语法
cover: javascript.005.jpg
keywords: nodejs,js语法,语法基础
description: 了解最基础的 JS 语法，譬如变量、字符串、表达式，函数的定义和调用方法等，z掌握最基本的语法，为后面更复杂的知识做铺垫
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

了解最基础的 JS 语法，譬如变量、字符串、表达式，函数的定义和调用方法等，掌握最基本的语法，为后面做铺垫。

JavaScript 的最大特点就是语法细节非常多！很多比较底层的属性也都暴露了出来，各种细节、各种场景的下各种情况铺天盖地涌来，学习的时候会比较痛苦。
细节需要在使用过程中逐渐掌握，如果一开始就试图掌握全部，会步履维艰。

本篇只涉及最基础、最常用的语法，不对语法细节进行全面覆盖，看完本篇的内容后，就能看懂绝大多数的 JS 代码，并能够编写 JS 代码。Promise、async 等异步编程方法放在下一篇，本篇不涉及。

## 变量

ES6 增加了 `let` 命令，用于声明在当前代码块有效的变量（即块级作用域）。

### 变量的初始赋值

有些赋值方式纯粹是语法糖、编码技巧，类似于`茴`字有几种写法。知道、能看懂就行，写代码的时候使用常规写法才是值得被表扬的做法。

ES6 支持变量的解构（Destructuring）赋值，即等号左右两边进行匹配（注意多个变量是数组的形式）：

```js
let [a, b, c] = [1, 2, 3];
```

没有找到对应值的变量的值是 `undefined`。

```js
let [foo] = [];         // foo 是 undefined
let [bar, foo] = [1];   // foo 是 undefined
```

可以在解构的时候设置默认值，只有在等号右边找不到对应值的时候，才会使用默认值：

```js
let [foo = true] = [];  // foo 是 true
```

等号右边多出来的值被忽略：

```js
let [x, y] = [1, 2, 3];  // 3 被忽略
```

将剩余的参数全部接收为一个数组中的成员： 

```js
let [x, ...y] = [1, 2, 3];  // y = [2,3]
```

解构可以嵌套：

```js
let [a, [b], d] = [1, [2, 3], 4];    // b = 2 
```

解构也可以用对象赋值，这时候等号左右两边都要用 `{ }`，并且顺序无关，按照属性名称取值：

```js
let { bar, foo } = { foo: 'aaa', bar: 'bbb' };
foo // "aaa"
bar // "bbb"
```

这方面还有很多细节，不一一列举了，[变量的解构赋值](https://es6.ruanyifeng.com/#docs/destructuring) 中能够找到。

一个赋值操作有非常多的细节，不是好事！记住这些鸡毛蒜皮浪费大量精力，非特殊情况，不要使用需要让人动脑思考的写法。

解构赋值主要是提供函数多值返回的功能：

```js
// 返回一个数组

function example() {
  return [1, 2, 3];
}
let [a, b, c] = example();

// 返回一个对象

function example() {
  return {
    foo: 1,
    bar: 2
  };
}
let { foo, bar } = example();
```

以及默认参数：

```js
jQuery.ajax = function (url, {
  async = true,
  beforeSend = function () {},
  cache = true,
  complete = function () {},
  crossDomain = false,
  global = true,
  // ... more config
} = {}) {
  // ... do stuff
};
```

以及在遍历和导入模块时使用：

```js
const map = new Map();
map.set('first', 'hello');
map.set('second', 'world');

for (let [key, value] of map) {
  console.log(key + " is " + value);
}
// first is hello
// second is world


// 获取键名
for (let [key] of map) {
  // ...
}

// 获取键值
for (let [,value] of map) {
  // ...
}
```

导入模块时使用对象解构：

```js
const { SourceMapConsumer, SourceNode } = require("source-map");
```

### 变量的作用域

作用域有三个：顶级作用域、函数作用域、块级作用域。JavaScript 在 ES6 之前是没有的块级作用域的，因此会一些奇葩的行为，ES6 引入块级作用域后，js 的作用域和其它语言相似。

块级作用域必须用 `{ }` 包裹，如果没有 `{ }` ，就不是块级作用域。let 指令和严格模式下的变量和函数，只能在当前作用域的顶层声明，因此如果省略了 if 后面的大括号，会有奇怪的行为：

```js
// 第一种写法，报错，let 不在新的块级作用域中，也不在当前作用顶层，所以报错
if (true) let x = 1;

// 第二种写法，不报错，let 在新的块级作用域中，且在顶层，所以不报错
if (true) {
  let x = 1;
}
```

下面的代码中，变量 a 能被打印出来， 变量 b 会触发错误：

```js
{
  var a = 1;
  let b = 2;
}

console.log("a is defined: %d",a)
console.log("b is not defined: %d",b)
```

执行结果如下：

```sh
$ node ./app.js
a is defined: 1
/Users/lijiao/Work/workspace/javascript/05-ES6-Basic-Var/app.js:14
console.log("b is not defined: %d",b)

ReferenceError: b is not defined
```

用 `let` 声明的变量和其它语言中的变量的作用域基本相似，不是特殊情况就不要用 let 之外的变量声明方式了，否则会带来麻烦。
譬如下面的这段代码，因为在 for 循环内用 var 声明的 i 在 for 之外也有效且是同一个变量，a\[*\]() 的输出结果都是 i 最后的值 10：

```js
//错误用法演示！
var array1 = [];
for (var i = 0; i < 10; i++) {
  array1[i] = function () {
    console.log(i);
  };
}
array1[6](); // 10
array1[7](); // 10
```

把 for 中的 var 换成 let 才会得到预期的结果，需要注意换成 let 后，每次 for 循转都是声明一个新的 i，但是 JS 的 for 语句会根据上一次循环的值设置新的 i 的值，所有数组中的每个函数都打印的是不同的数值：

```js
//正确用法演示！
var array2 = [];
for (let i = 0; i < 10; i++) {
  array2[i] = function () {
    console.log(i);
  };
}
array2[6](); // 6
array2[7](); // 7
```

使用 let 后，变量提升这个奇怪的特性也没有了，变量必须先声明后使用、且不能重复声明同名变量，这也和其它语言的做法一致。


## 常量

常量用 `const` 声明，作用域行为与用 let 声明的变量相同，常量必须在声明时初始化值，声明后不可以再改变。

```js
const PI=3.1415;
PI = 3;         // 修改常量值，报错
const foo;      // 常量声明时没有初始化，报错
```

需要特别注意，不能改变的是`常量指向的内存地址`！如果常量指向了一个对象，常量的指向是不能修改，被常量所指的对象是可以修改的：

```js
array = [];       //更改常量的指向，报错
array[0] = 1;       //更改常量所指的对象的值，不报错
```

如果要让一个对象的值不可修改，在`严格模式`中使用 `Object.freeze` 方法冻结对象，注意必须是严格模式：

```js
'use strict';
const array2 = Object.freeze([]);
array2= 1;      //报错，对象被冻结不能修改
```

冻结了对象不等于冻结了对象的属性，对象的属性需要单独冻结，例如下面的函数 constantize 冻结了对象 obj 和它的所有属性：

```js
let author = {}

author.name = "lijiaocn"
author.age = 30

var constantize = (obj) => {
  Object.freeze(obj);
  Object.keys(obj).forEach( (key, i) => {
    if ( typeof obj[key] === 'object' ) {
      constantize( obj[key] );
    }
  });
};

constantize(author)
author.age = 32     // 修改不生效
author.grade= 3     // 修改不生效
console.log(author)
```

## 字符串

字符串都是 utf-8 编码，可以直接使用编码，例如 `'\uDF06\uD834'`。

字符串遍历：

```js
for(let c of 'foo中国') {
  console.log(c)
}
```

运行输出：

```
f
o
o
中
国
```

ES6 引入了模版字符串，支持多行，以及嵌入变量，使用的是反引号：

```js
let author = "lijiaocn"
let info = `author is ${author}
@ 2019-06-20`
console.log(info)
```

运行输出：

```sh
author is lijiaocn
@ 2019-06-20
```

## 数组

数组用 `[ ]` 包裹。

数组可以用扩展运算符 `...` 拆开，注意扩展运算符位于数组的前面：

```js
console.log([1,2,3])
console.log(...[1,2,3])
```

输出为：

```sh
[ 1, 2, 3 ]
1 2 3
```

数组变量指向的是数组的地址，因此将数组变量赋值给另一个变量，两个变量是指向了同一个数组。扩展运算符可以用来复制数组：

```js
let a1 = [1, 2];
let a2 = a1          // 指向同一个数组
a2[1] = 22

let a3 = [...a1];    // 复制数组，写法1
a3[0] = 21

let [...a4] = a1;    // 复制数组，写法2
a4[0] = 31

console.log(a1)
console.log(a2)
console.log(a3)
console.log(a4)
```

输出结果为：

```js
[ 1, 22 ]
[ 1, 22 ]
[ 21, 22 ]
[ 31, 22 ]
```

## 函数

ES6 的函数的声明方式没有变换，增加了对默认值、变长参数的支持，提供了一种新的声明方法：箭头函数。

### 函数声明

支持默认参数，默认参数的值可以表达式，是惰性求值的，即用到的时候重新计算：

```js
// 参数默认值
function log(x, y = 'World') {
  console.log(x, y);
}
log('hello')
```

函数的参数可以解构赋值：

```js
//解构赋值
function foo({x, y = 5}) {
  console.log(x, y);
}
foo({x: 1, y: 2})
```

函数的 length 属性返回指定的默认值的参数个数：

```js
function foo({x, y = 5}) {
  console.log(x, y);
}
console.log(foo.length)    // 1 
```

需要特别注意如果参数默认值是表达式，且用到了其它的函数参数，这些函数参数会覆盖函数外部的同名变量，例如：

```js
var x = 1;

function f(x, y = x) {
  console.log(y);
}

f(2) // 输出结果是 2，因为函数内的 x = 2，y = x
```

可以为不可缺省的参数设置一个抛出异常的默认值，从而在参数被缺省时报错：

```js
//不可缺省的参数
function throwIfMissing() {
  throw new Error('Missing parameter');
}
function mustFunc(mustBeProvided = throwIfMissing()) {
  return mustBeProvided;
}

mustFunc()   // 没有传入不可缺省的参数，报错
```

ES6 支持不定长参数（rest 参数），不定长参数是一个数组，且必须是最后一个参数，函数的 length 属性中不包含不定长参数：

```js
//不定长参数
function restFunc(...values) {
  let sum = 0;

  for (var val of values) {
    sum += val;
  }

  return sum;
}

console.log(restFunc(2, 5, 3)) // 10
```

### 箭头式声明

ES6 提供了箭头式声明函数的方法，箭头函数是一个语法糖，箭头 `=>` 前面是函数的输入参数，后面是函数体或函数的返回值：

```js
//箭头函数
var arrowFunc1 = v => v;
var arrowFunc2 = () => 5;
var arrowFunc3 = (num1, num2) => num1 + num2;
var arrowFunc4 = (num1, num2) => { let i = 10; return i + num1 + num2};

console.log(arrowFunc1("Func1"))
console.log(arrowFunc2())
console.log(arrowFunc3(1, 2))
console.log(arrowFunc4(1, 2))
```

如果 => 后面的返回值是一个对象，需要用 `( )` 包裹，防止对象的 `{ }` 被当作代码块：

```js
let getTempItem = id => ({ id: id, name: "Temp" });
```

箭头函数几个特点：

1. 函数体内的this对象，就是定义时所在的对象，而不是使用时所在的对象；
2. 箭头函数不能被作为构造函数使用，不能使用 new；
3. 函数体内不能使用 agruments 对象；
4. 不能使用 yield 命令，箭头函数不能被用作 Generator 函数。

在箭头函数内部， this 对象的指向是固定的，即定义时所在的对象，这一点不同于非箭头函数。因此包含 this 对象的方法等需要动态绑定 this 的函数不能是箭头函数。

### 函数的实现

ES6 中如果函数参数使用了默认值、解构赋值、扩展运算符，函数内部不能在设定为严格模式：

```js
function cannotStrictFunc(a, b = a) {
  'use strict';
  // code
}
```

运行时会报错：

```sh
  'use strict';
  ^^^^^^^^^^^^

SyntaxError: Illegal 'use strict' directive in function with non-simple parameter list
```

这是因为 `use strict` 必须在作用域的最开始处，如果函数参数使用了上述特性，那么就会在 use strict 之前进行变量操作，所以不合法。

### 尾递归的效率极高

如果一个函数要实现成递归形式的，那么一定做成尾递归，即在函数最后返回函数自身的调用：

```js
function Fibonacci2 (n , ac1 = 1 , ac2 = 1) {
  if( n <= 1 ) {return ac2};

  return Fibonacci2 (n - 1, ac2, ac1 + ac2);
}
```

因为函数最后又是回到自身，之前保留的堆栈信息可以直接丢弃，大量节省内存，这就是“尾调用优化”（Tail call optimization）。

尾调用优化只在 ES6 的严格模式下开启。

### 特殊调用形式

函数有一种特殊的调用形式：函数名+模版字符串（[标签模版](https://es6.ruanyifeng.com/#docs/string#%E6%A0%87%E7%AD%BE%E6%A8%A1%E6%9D%BF)）。

例如：

```js
alert`123`
```
等同于：

```js
alert(123)
```

模版字符串会被展开作为多个参数传入函数：

```js
let a = 5;
let b = 10;

tag`Hello ${ a + b } world ${ a * b }`;
// 等同于
tag(['Hello ', ' world ', ''], 15, 50);
```

这种调用方式通常用来对模版字符串做特殊处理，譬如过滤 HTML 字符串、多语言转换等。

对字符串进行过滤处理：

```sh
let message =
  SaferHTML`<p>${sender} has sent you a message.</p>`;

function SaferHTML(templateData) {
  let s = templateData[0];
  for (let i = 1; i < arguments.length; i++) {
    let arg = String(arguments[i]);

    // Escape special characters in the substitution.
    s += arg.replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;");

    // Don't escape special characters in the template.
    s += templateData[i];
  }
  return s;
}
```

### 函数作用域

函数自身也是变量，ES5 规定函数只能在顶层和函数作用域中声明，浏览器为了兼容旧代码都没有遵守，ES6 引入了块级作用域，明确允许在块级作用域中声明函数。但是：

**不要在块级作用域中声明函数！不要给自己找麻烦。**

ES6 规定在块级作用域中声明的函数，类似于用 let 声明的变量，仅在当前作用域有效。但实际情况比这复杂，浏览器的 ES6 块级作用域内的函数相当于用 var 申明，在 node 中又是一种情况！

下面代码用 node 运行的时候，会提示 f 类型不是函数：

```js
function f() { console.log('I am outside!'); }

(function () {
  if (false) {
    // 重复声明一次函数f
    function f() { console.log('I am inside!'); }
  }
  console.log("typeof f is %s", typeof f)
  f();
}());
````

输出如下， f 的类型是 undefined：

```sh
$ node ./app.js
typeof f is undefined
/Users/lijiao/Work/workspace/javascript/06-ES6-Basic-Func/app.js:16
  f();
  ^
TypeError: f is not a function
...
```

但是将在函数的 if 语句中声明的函数的名字改一下，例如：

```js
function f() { console.log('I am outside!'); }

(function () {
  if (false) {
    // 改一下函数名
    function f1() { console.log('I am inside!'); }
  }

  console.log("typeof f is %s", typeof f)
  f();
}());
```

运行结果不相同了，f 是在函数外部声明的函数：

```sh
$ node ./app.js
typeof f is function
I am outside!
```

## 对象

对象用 `{ }` 包裹，是 key-value 对的组合，值可以是函数。

定义方式如下：

```js
let object1 = {
  x: 1,
  y: 2,
  sum: function(){
    return this.x + this.y
  }
}
console.log(object1.sum())
```

属性名称可以省略，变量的名称或者函数名称将被用作属性名：

```js
let [x, y]  = [11, 12]
let object2 = {
  x,
  y,
  sum(){
    return this.x + this.y
  }
}
console.log(object2.sum())
```

属性名可以用 `[表达式]` 的形式表示，如果表达式是一个对象，就被认为是字符串 `[object OBject]`：

```js
// 属性表达式
const keyA = {a: 1};
const keyB = {b: 2};

const object3 = {
  [keyA]: 'valueA',
  [keyB]: 'valueB'
};

console.log(object3[keyA])   // 输出 valueB
console.log(object3[keyB])   // 输出 valueB
```

object3[keyA] 和 object3[keyB]` 的值都是 valueB ，因为它们都被转换成了 `[object Object]`。

对象的方法中 `this` 关键字指向函数所在的对象，ES6 增加的 `super` 关键字指向对象的原型对象。

```js
// super
const proto = {
  foo: 'hello'
};

const obj = {
  foo: 'world',
  find() {
    return super.foo;
  }
};

Object.setPrototypeOf(obj, proto);
console.log(obj.find()) // "hello"
```

扩展运算符用于对象是取出对象的所有可遍历属性，并复制到当前对象中：

```js
let z = { a:3, b:4 }
let n = { ...z };
console.log(n)  // { a: 3, b: 4 }
```

## Symbol

Symbol 是 ES6 引入的新的原始类型，用 `Symbol()` 函数生成的唯一字符串。

无论 Symbol() 函数的输入参数是否相等，Symbol() 返回的值都是不等的，因此用 Symbol 做标志符，确保不会同名。

```js
let s1 = Symbol();
let s2 = Symbol();
if (s1 === s2) {
  console.log("equal");
}else{
  console.log("not equal");  // 输出 not equal
}
```

Symbol() 的输入的参数是对 Symbol 的描述，影响字符串转换的结果：

```js
let s3 = Symbol('this is symbol3')
console.log(s3.description)
console.log(typeof s3)
console.log(String(s3))
```

运行输出为：

```
this is symbol3
symbol
Symbol(this is symbol3)
```

## Class

ES6 增加了 Class 语法糖，constructor() 是类的默认方法，用 new 生成对象的时候调用：

```js
class Point {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  toString() {
    return '(' + this.x + ', ' + this.y + ')';
  }
}

let obj = new Point(1,3)
console.log(obj)
console.log(obj.toString())
```

运行输出如下：

```js
Point { x: 1, y: 3 }
(1, 3)
```

在类内部可以用 `get` 和 `set` 设置属性的取存方法， get 和 set 后面的函数名就是属性名，读取、设置属性时，对应的 get 和 set 方法会被调用：

```js
class GetSet {
  constructor(){}
  get A(){
    console.log('get for A is called');
    return 'This is A';
  }
  set A(value){
    console.log('set for A is called, value is %s', value);
  }
}

ins = new GetSet();
ins.A               // get A() 被调用
ins.A = "abc"       // set A() 被调用
```

运行输出如下：

```js
get for A is called
set for A is called, value is abc
```

类的 Generator 方法在方法名称前加上 `*`，如果没有加星号，在方法中使用 yield 会被报错：

```sh
class Iter {
  constructor(num){
    this.num = num;
  }
  * next() {
    for (let i = 0; i < this.num ; i++) {
      yield i;
    }
  }
}

ins3 = new Iter(4)
console.log(ins3.next())
for (let x of ins3.next()) {
  console.log(x)
}
```

方法名前加上 `static` ，该方法成为类的静态方法，该方法不被类的实例继承，而是直接用类名调用，静态方法中的 this 指向的类不是实例。

```js
//类的静态方法
class Static {
  constructor (){}
  static staticFunc(){
    return 'Static';
  }
}

let ins4 = new Static()
console.log(Static.staticFunc())
console.log(ins4.staticFunc())   //报错: TypeError: ins4.staticFunc is not a function
```

类可以继承，使用 `extends` 关键字，父类的静态方法被子类继承，子类可以覆盖父类的静态方法，并用 super 调用父类的静态方法：

```js
// 类的继承
class Father {
  constructor (){}
  static classMethod1(){
    return 'Father class method 1';
  }
  static classMethod2(){
    return 'Father class method 2';
  }
}

class Child extends Father {
  constructor(){
    super()       // 子类的构造函数必须调用 super()
  }
  static classMethod2(){
    return super.classMethod2() + ', Child class method 2';
  }
}

console.log(Child.classMethod1())
console.log(Child.classMethod2())
```

运行输出如下：

```js
Father class method 1
Father class method 2, Child class method 2
```

属性既可以在 constructor() 中用 this 设置，也可以直接在类定义的最上方定义，加上 static 关键字的属性是类的属性：

```js
// 类的属性
class Page{
  static classAttr = 'This is class Page'
  name = 'lijiaocn';
  constructor(title){
    this.title = title
  }
}

let ins5 = new Page('First Page')
console.log(ins5)
console.log(Page.classAttr)
```

运行输出如下：

```js
Page { name: 'lijiaocn', title: 'First Page' }
This is class Page
```

ES6 的类不支持私有方法和属性。

## 顶层对象

JS 中存在顶层对象，在浏览器中顶层对象名称是 window，在 node 中顶层对象名称是 global。在 ES5 以及之前，顶层对象的属性就是全局变量，ES6 改变了这一点，开始将顶层对象与全局变量分离。

为了保持兼容，ES6 中：

1. var 和 function 声明的全局变量，依旧是顶层对象的属性；
2. let、const、class 声明的全局变量，不是顶层对象的属性。

`在 node 12 中观察不到该现象，此处存疑！`

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
