---
layout: default
title: "Intelli Idea 设置 go mod 代理，加快从国内拉取 go module 的速度"
author: 李佶澳
date: "2020-02-14T09:40:39+0800"
last_modified_at: "2020-02-14T09:40:39+0800"
categories: skill
cover:
tags:  idea
keywords: idea,go mod,goproxy
description: 在 Intelli Idea 中为 go module 项目设置代理，解决依赖代码无法拉取、拉取慢的问题
---

## 说明

因为国内的网络环境，go mod tidy 获取依赖的 go module 要么经常失败，要么龟速。可以通过设置 go module 代理解决这个问题：[https://goproxy.io/ ](https://goproxy.io/)

**通过环境变量设置**：

```sh
export GOPROXY=https://goproxy.io
```

**在 Intelli Idea 中设置**：

Intelli Idea -> Preferences -> Languages & Frameworks -> Go -> Go Modules(vgo)，在 Proxy 中输入 https://goproxy.io：

![Intelli Idea 设置 gorpxy]({{ site.article }}/goproxy.png)

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
