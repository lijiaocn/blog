---
layout: default
title: "Chrome 浏览器强行导入不可信任的证书（添加证书例外）"
author: 李佶澳
date: "2020-02-14T17:31:34+0800"
last_modified_at: "2020-02-14T17:31:34+0800"
categories: skill
cover:
tags: chrome
keywords:
description: Chrome 现在对于使用不信任证书的网页直接拒绝，不能在页面上点击添加例外，添加证书例外比较折腾
---

## 说明

Chrome 现在对于使用不信任证书的网页直接拒绝，不能在页面上点击添加例外：

![证书无效，chrome禁止访问]({{ site.article}}/chrome-cert-1.png)

下面是在 mac 上添加例外的方法，其它系统可能有区别。

打开 setting：

![证书无效，chrome禁止访问]({{ site.article}}/chrome-cert-2.png)

搜索 cert ，找到证书管理：

![证书无效，chrome禁止访问]({{ site.article}}/chrome-cert-3.png)

将目标网站使用的证书导入：

![证书无效，chrome禁止访问]({{ site.article}}/chrome-cert-4.png)

点击刚刚导入的证书->点击 trust，设置为 always：

![证书无效，chrome禁止访问]({{ site.article}}/chrome-cert-5.png)

点击 “X" 关闭时，提示输入系统密码，然后就可以了。

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
