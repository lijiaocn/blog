---
layout: default
title: "微信小程序开发快速入门教程（八）：开发实践1"
author: 李佶澳
date: "2019-06-30T21:10:45+0800"
last_modified_at: "2019-07-04T22:53:48+0800"
categories: tutorial
tags: 微信小程序
cover: wxxiaochengxu.008.jpg
keywords: 微信小程序,开发实践,小程序开发
description: 全局默认窗口设置、底部 tab 栏设置
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

## 全局默认窗口设置

全局默认窗口可以设置的地方有三部分，在 app.json 的 [window](https://developers.weixin.qq.com/miniprogram/dev/reference/configuration/app.html#window) 中设置：

**导航栏**：背景颜色 navigationBarBackgroundColor、标题颜色 navigationBarTextStyle、标题 navigationBarTitleText、导航栏样式 navigationStyle。

**主窗口**：背景颜色 backgroundColor、下拉加载样式 backgroundTextStyle。

**动作设置**：开启全局下拉刷新 enablePullDownRefresh、上拉触底距离 onReachBottomDistance、屏幕旋转设置 pageOrientation。

需要注意的是，主窗口的背景颜色和下载加载样式，只有在开启下拉刷新后（ "enablePullDownRefresh": true），在下拉页面时才会显现。下面是导航栏和窗口设置示例，图片中显示的是页面下拉状态：

[![小程序导航栏、窗口背景设置]({{ site.baseurl }}{{ site.img}}/article/xiaochengxu-shijian-1-1.png)]({{ site.baseurl }}{{ site.img}}/article/xiaochengxu-shijian-1-1.png)
<p style="text-align:center">点击图片查看大图</p>

## 底部 tab 栏设置

tab 栏在 app.json 的 [tabBar](https://developers.weixin.qq.com/miniprogram/dev/reference/configuration/app.html#tabBar) 中设置：

**颜色设置**：文字颜色 color、文字选中时颜色 selectedColor、背景色 backgroundColor、边框颜色 borderStyle；

**菜单列表**：菜单列表 list、菜单栏位置 position。

菜单列表是一个数组，数组中的每一项是一个菜单，最少 2 项，最多 5 项，每一项有四个属性：pagePath 连接的小程序页面、text 按钮文字、iconPath 图片 81px\*81px、selectedIconPath 选中时的图片 81px\*81px。

一个只有两个选项的菜单：

[![小程序TAB栏目设置]({{ site.baseurl }}{{ site.img}}/article/xiaochengxu-shijian-1-2.png)]({{ site.baseurl }}{{ site.img}}/article/xiaochengxu-shijian-1-2.png)
<p style="text-align:center">点击图片查看大图</p>

在微信中的展示效果比开发者工具中的预览效果好：

[![小程序TAB栏目设置]({{ site.baseurl }}{{ site.img}}/article/xiaochengxu-shijian-1-3.png)]({{ site.baseurl }}{{ site.img}}/article/xiaochengxu-shijian-1-3.png)

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"


