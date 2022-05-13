---
layout: default
title: "微信小程序开发快速入门教程（三）：页面文件 wxml"
author: 李佶澳
date: "2019-06-30T10:01:08+0800"
last_modified_at: "2019-06-30T16:26:59+0800"
categories: tutorial
tags: 微信小程序
cover: wxxiaochengxu.003.jpg
keywords: 微信小程序,页面设计,wxml文件语法,wxssw文件语法,小程序页面组件
description: "小程序使用的是 MVVM 开发模式，页面文件是模版，{{ 和 }}包裹可以用 js 设置值的变量（即数据绑定），xss是独立样式表，js提供交互逻辑"
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

小程序使用的是 MVVM 开发模式，wxml 页面文件是`模版`文件，wxss 文件是独立样式表，js 文件提供交互逻辑。

## wxml 文件

wxml 文件类似于 html 文件，但使用的微信小程序定义的组件标签，不是标准的 html 标签，小程序的组件数量较少，在 [组件页面](https://developers.weixin.qq.com/miniprogram/dev/component/) 可以看到所有支持的组件。 

### 页面布局

视图容器是包含其它组件的组件，有点类似于 html 中的 div，用视图容器安排小程序页面的布局。

示例代码中小程序首页 pages/index/index.wxml 的内容如下：

```html
<!--index.wxml-->
<view class="container">

  <!-- 用户 openid -->
  <view class="userinfo">
    <button 
      open-type="getUserInfo" 
      bindgetuserinfo="onGetUserInfo"
      class="userinfo-avatar"
      style="background-image: url({{avatarUrl}})"
    ></button>
    <view>
      <button class="userinfo-nickname" bindtap="onGetOpenid">点击获取 openid</button>
    </view>
  </view>


  <!-- 上传图片 -->
  <view class="uploader">
    <view class="uploader-text" bindtap="doUpload">
      <text>上传图片</text>
    </view>
    <view class="uploader-container" wx:if="{{imgUrl}}">
      <image class="uploader-image" src="{{imgUrl}}" mode="aspectFit" bindtap="previewImg"></image>
    </view>
  </view>


  <!-- 操作数据库 -->
  <view class="uploader">
    <navigator url="../databaseGuide/databaseGuide" open-type="navigate" class="uploader-text">
      <text>前端操作数据库</text>
    </navigator>
  </view>

  <!-- 新建云函数 -->
  <view class="uploader">
    <navigator url="../addFunction/addFunction" open-type="navigate" class="uploader-text">
      <text>快速新建云函数</text>
    </navigator>
  </view>

  <!-- 云调用 -->
  <view class="uploader">
    <navigator url="../openapi/openapi" open-type="navigate" class="uploader-text">
      <text>云调用</text>
    </navigator>
  </view>


</view>
```

呈现效果如下：

![微信小程序页面效果]({{ site.baseurl }}{{site.img}}/article/xiaochengxu-page-1.png)

### 数据绑定

小程序使用的是 MVVM 开发模式，页面文件实质上是`模版`文件，页面文件中用 \{\{ 和 \}\} 包裹可以用 js 设置值的变量（即数据绑定），如下：

{% raw %}
```html
<view> {{ message }} </view>
```
{% endraw %}

然后可以在对应的 js 文件中设置变量的值，js 文件的格式和用途在下一节：

```js
Page({
  data: {
    message: 'Hello MINA!'
  }
})
```

在组件的属性中也可以使用数据绑定：

{% raw %}
```html
<view id="item-{{id}}"> </view>
<checkbox checked="{{false}}"> </checkbox>
```
{% endraw %}

支持 if 控制显示，需要使用 wx:if 属性：

{% raw %}
```html
<view wx:if="{{condition}}"> </view>
```
{% endraw %}


可以使用运算符：

{% raw %}
```html
<view hidden="{{flag ? true : false}}"> Hidden </view>

<view> {{a + b}} + {{c}} + d </view>

<view>{{"hello" + name}}</view>

<view>{{object.key}} {{array[0]}}</view>

<!-- 数组遍历 -->
<view wx:for="{{[zero, 1, 2, 3, 4]}}"> {{item}} </view>

<!-- 用组合成一个新的对象，key 分别为 for、bar，value 分别为 a、b 绑定的值 -->
<template is="objectCombine" data="{{for: a, bar: b}}"></template>

<!-- 将 obj1 和 obj2 绑定的 object 变量展开后，组合成一个新的 object 变量 -->
<template is="objectCombine" data="{{...obj1, ...obj2, e: 5}}"></template>
```
{% endraw %}

### 列表渲染 wx:for

wx:for 遍历数组，进行列表渲染，当前列表项的下标变量默认为 index，当前列表项为 item：

{% raw %}
```html
<view wx:for="{{array}}">
  {{index}}: {{item.message}}
</view>
```
{% endraw %}

可以用 wx:for-index 和 wx:for-item 分别修改下标变量和当前列表项变量的名称：

{% raw %}
```html
<view wx:for="{{array}}" wx:for-index="idx" wx:for-item="itemName">
  {{idx}}: {{itemName.message}}
</view>
```
{% endraw %}

如果列表是动态变化的，需要用 wx:key 指定每个列表项中唯一标识属性：

{% raw %}
```html
<switch wx:for="{{objectArray}}" wx:key="unique" style="display: block;"> {{item.id}} </switch>

<switch wx:for="{{numberArray}}" wx:key="*this" style="display: block;"> {{item}} </switch>
```
{% endraw %}

unique 是每个列表项都不同的属性，如果列表项本身就是唯一的字符串或者数字，wx:key 可以是 `*this`：

```js
  data: {
    objectArray: [
      {id: 5, unique: 'unique_5'},
      {id: 4, unique: 'unique_4'},
      {id: 3, unique: 'unique_3'},
      {id: 2, unique: 'unique_2'},
      {id: 1, unique: 'unique_1'},
      {id: 0, unique: 'unique_0'},
    ],
    numberArray: [1, 2, 3, 4]
  },
```

### 条件渲染 wx:if、wx:elif、wx:else

wx:if 用来控制组件是否显示，相比 hidden 属性，wx:if 的切换消耗更高，适合运行时不经常改变的组件：

{% raw %}
```html
<view wx:if="{{length > 5}}"> 1 </view>
<view wx:elif="{{length > 2}}"> 2 </view>
<view wx:else> 3 </view>
```
{% endraw %}

### 子模版

可以把会在多个页面中用到的内容做成一个单独的子模版文件，子模版用 \<template\> 定义：

{% raw %}
```html
<template name="msgItem">
  <view>
    <text> {{index}}: {{msg}} </text>
    <text> Time: {{time}} </text>
  </view>
</template>
```
{% endraw %}

模版文件用 import 或者 include 引用，import 只导入目标文件中定义的 template，include 则同时将目标文件中 template 和 wxs 之外的内容完整复制到当前文件中：

{% raw %}
```html
<import src="item.wxml"/>

<include src="header.wxml"/>
```
{% endraw %}

使用模版文件中的模版时，用 template 标签，用 is 属性指定要使用的模版，用 data 指定模版中的变量的值，例如下面引用 item.wxml 中的 item 模版：

{% raw %}
```html
<import src="item.wxml"/>
<template is="item" data="{{text: 'forbar'}}"/>
```
{% endraw %}

item 模版的定义如下：

{% raw %}
```html
<!-- item.wxml -->
<template name="item">
  <text>{{text}}</text>
</template>
```
{% endraw %}


## 用于包裹视图组件的 block

如果 wx:for、wx:if 要渲染视图容器，可以用 block 标签包裹，block 标签不是一个组件，只是一个用于包装的元素，不会被渲染，并且只接受 `wx:..` 控制属性。

block 和 wx:if：

{% raw %}
```html
<block wx:if="{{true}}">
  <view> view1 </view>
  <view> view2 </view>
</block>
```
{% endraw %}

block 和 wx:for：

{% raw %}
```html
<block wx:for="{{[1, 2, 3]}}">
  <view> {{index}}: </view>
  <view> {{item}} </view>
</block>
```
{% endraw %}

## 小程序页面组件

小程序页面组件见：[微信小程序开发快速入门教程（六）：组件属性与 API](https://www.lijiaocn.com/tutorial/xiaochengxu/2019/06/30/wx-xiaochengxu-06-api/)。

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
