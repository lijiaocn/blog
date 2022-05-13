---
layout: default
title: "微信小程序开发快速入门教程（四）：页面文件 wxss"
author: 李佶澳
date: "2019-06-30T12:04:49+0800"
last_modified_at: "2019-06-30T16:14:21+0800"
categories: tutorial
tags: 微信小程序
cover: wxxiaochengxu.004.jpg
keywords: wxss,微信小程序,小程序样式文件
description: 微信的小程序使用的 wxss 文件是 wxml 组件的样式文件，支持 CSS 大部分特性，扩展了尺寸单位和样式导入，页面的局部样式覆盖全局样式
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

微信的小程序使用的 wxss 文件是 wxml 组件的样式文件，支持 CSS 大部分特性，扩展了尺寸单位和样式导入。

## 尺寸单位

尺寸单位 rpx，是可以根据屏幕宽度自适应的尺寸单位，无论屏幕的分辨率是多少，屏幕宽度固定为 750 rpx。对于 iphone6 而言， 1rpx 等于 0.5 px。

## 样式导入

使用 `@import` 导入其它样式文件，使用相对路径：

```css
/** app.wxss **/
@import "common.wxss";
.middle-p {
  padding:15px;
}
```

## 选择器

支持 6 种选择器：`.class`、`#id`、`element`、`element,element`、`::after`、`::before`。

![微信小程序云函数]({{ site.baseurl }}{{site.img}}/article/xiaochengxu-wxss-1.png)

## 样式覆盖

app.wxss 是全局样式表，作用于每一个页面，每个页面目录中的 wxss 是局部样式表，在当前页面中覆盖全局样式。

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
