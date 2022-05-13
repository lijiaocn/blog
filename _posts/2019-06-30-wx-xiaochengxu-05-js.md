---
layout: default
title: "微信小程序开发快速入门教程（五）：页面文件 js"
author: 李佶澳
date: "2019-06-30T14:35:43+0800"
last_modified_at: "2019-06-30T16:28:59+0800"
categories: tutorial
tags: 微信小程序
cover: wxxiaochengxu.005.jpg
keywords: 微信小程序,js,微信小程序启动,回调函数
description: 页面目录中的 js 文件定义小程序的交互逻辑，js 文件中的回调函数在小程序加载完成之后被调用，一个 APP 实例和每个页面的 Page 实例
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

页面目录中的 js 文件用于定义小程序的交互、操作逻辑，支持 es6 。

## js 语言标准

小程序 [运行环境](https://developers.weixin.qq.com/miniprogram/dev/framework/runtime/env.html) 有 ios、android 旧版本、androind 新版本和开发者工具，小程序使用的 js 标准是 ES6，为了应对不同运行环境对 ES6 的支持不同的情况，可以在开发者工具中开启 ES6 转换成 ES5 的功能，在项目配置文件 `project.config.json` 中开启：

```json
"setting": {
    "urlCheck": true,
    "es6": true,
    "postcss": true,
    "minified": true,
    "newFeature": true
},
```

## js 文件的执行时机

打开小程序时，微信客户端将小程序代码下载之后，根据 app.json 中 pages 字段加载页面，pages 的第一行指定的页面就是默认的首页。渲染页面时，微信客户端首先根据页面的 .json 配置文件生成界面，顶部颜色和文字都在页面配置中定义，然后装载页面的 wxml 和 wxss 文件，最后加载页面的 js 文件。

js 文件的三个执行时机：

1. 小程序启动后， app.js 中定义的 App 实例的 onLaunch 回调函数被调用；
2. 每个页面渲染完成之后，页面 js 文件中 Page 实例的 onLoad 回调函数被调用；
3. 点击小程序页面组件时，组件绑定的 js 函数（在页面的 js 文件中定义）被调用。

App 实例中可以定义多个回调函数，分别在不同时机调用，见下面的 app.js。

Page 实例中也可以定义多个回调函数，分别在不同时机调用，见 页面的 js 文件。

## app.js 与 App 实例

app.js 中定义一个 App 实例，它的 onLaunch 函数在小程序启动后执行，在这个进行小程序运行环境检查、初始化设置等：

```js
//app.js
App({
  onLaunch: function () {

    if (!wx.cloud) {
      console.error('请使用 2.2.3 或以上的基础库以使用云能力')
    } else {
      wx.cloud.init({
        traceUser: true,
      })
    }

    this.globalData = {}
  }
  })
```

App 实例包含以下属性，可以在 [App Object](https://developers.weixin.qq.com/miniprogram/dev/reference/api/App.html) 中找到相关说明：

```js
App({
  onLaunch (options) {
    // Do something initial when launch.
  },
  onShow (options) {
    // Do something when show.
  },
  onHide () {
    // Do something when hide.
  },
  onError (msg) {
    console.log(msg)
  },
  onPageNotFound (msg) {
    console.log(msg)
  },
  globalData: 'I am global data'
})
```

整个小程序只有一个 App 实例，全部页面共享，在页面的 js 文件中用 getApp() 获取小程序的 app 实例：

```js
const appInstance = getApp()
console.log(appInstance.globalData) // I am global data
```

App 实例的属性除了文档中明确定义的，还可以自由添加不重名的属性，自由添加的属性用 this 访问。

## 页面的 js 文件 与 Page 实例

页面的 js 文件主要用途就是创建 Page 实例，Page 实例中定义会在不同时机调用的回调函数，当前页面的组件绑定的函数和事件处理函数等，例如：

```js
//index.js
const app = getApp()

Page({
  data: {
    avatarUrl: './user-unlogin.png',
    userInfo: {},
    logged: false,
    takeSession: false,
    requestResult: ''
  },

  onLoad: function() {
    if (!wx.cloud) {
      wx.redirectTo({
        url: '../chooseLib/chooseLib',
      })
      return
    }

    // 获取用户信息
    wx.getSetting({
      success: res => {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
          wx.getUserInfo({
            success: res => {
              this.setData({
                avatarUrl: res.userInfo.avatarUrl,
                userInfo: res.userInfo
              })
            }
          })
        }
      }
    })
  },

  onGetUserInfo: function(e) {
    if (!this.logged && e.detail.userInfo) {
      this.setData({
        logged: true,
        avatarUrl: e.detail.userInfo.avatarUrl,
        userInfo: e.detail.userInfo
      })
    }
  },
  /* ... 省略 ...*/
})
```

`onGetUserInfo` 在页面的 wxml 文件中绑定到了一个 button 组件：

```html
<button 
  open-type="getUserInfo" 
  bindgetuserinfo="onGetUserInfo"
  class="userinfo-avatar"
  style="background-image: url({{avatarUrl}})"
></button>
```

Page 实例的属性比较多，可以在 [Page Object](https://developers.weixin.qq.com/miniprogram/dev/reference/api/Page.html) 中找到：

```js
//index.js
Page({
  data: {
    text: "This is page data."
  },
  onLoad: function(options) {
    // Do some initialize when page load.
  },
  onReady: function() {
    // Do something when page ready.
  },
  onShow: function() {
    // Do something when page show.
  },
  onHide: function() {
    // Do something when page hide.
  },
  onUnload: function() {
    // Do something when page close.
  },
  onPullDownRefresh: function() {
    // Do something when pull down.
  },
  onReachBottom: function() {
    // Do something when page reach bottom.
  },
  onShareAppMessage: function () {
    // return custom share data when user share.
  },
  onPageScroll: function() {
    // Do something when page scroll
  },
  onResize: function() {
    // Do something when page resize
  },
  onTabItemTap(item) {
    console.log(item.index)
    console.log(item.pagePath)
    console.log(item.text)
  },
  // Event handler.
  viewTap: function() {
    this.setData({
      text: 'Set some data for updating view.'
    }, function() {
      // this is setData callback
    })
  },
  customData: {
    hi: 'MINA'
  }
})
```

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
