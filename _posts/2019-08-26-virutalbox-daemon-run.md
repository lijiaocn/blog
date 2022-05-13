---
layout: default
title: "关闭VirtualBox虚拟机界面时，虚拟机继续保持运行的方法"
author: 李佶澳
date: "2019-08-26 18:11:11 +0800"
last_modified_at: "2022-05-12 23:08:46 +0800"
categories: skill
cover: vbox.jpg
tags: virtualbox
keywords: virtualbox,后台运行,无界面运行
description: virtualbox的虚拟机支持无界面启动，如果点开虚拟机了界面，也可以在保持虚拟机运行的情况下关闭界面
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 说明

VirtualBox 的虚拟机支持无界面启动，如果点开虚拟机了界面，也可以在保持虚拟机运行的情况下关闭界面

## 无界面启动

无界面启动很简单，用下面的方式启动即可，点击启动->选择无界面启动：

![virtualbox无界面启动]({{site.baseurl }}{{ site.img }}/skill/vbox.png)

## 关闭界面时虚拟机保持运行

如果双击使用无界面方式启动的虚拟机时，会重新弹出界面。 这时候直接点击“X”时，会提示关闭虚拟机。

如果不想关闭虚拟机，只关闭界面，虚拟机继续在后台运行，用 "detach GUI"：

![virtualbox无界面启动]({{site.baseurl }}{{ site.img }}/skill/vbox2.png)

上图是 mac 版的 virtualbox，在 windows 版也有相应方法。

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
