---
layout: default
title: "微信小程序开发快速入门教程（二）：项目结构"
author: 李佶澳
date: "2019-06-29T14:58:21+0800"
last_modified_at: "2019-06-30T14:35:34+0800"
categories: tutorial
tags: 微信小程序
cover: wxxiaochengxu.002.jpg
keywords: 微信小程序,小程序项目结构
description: 界面分为左中右三栏，最左侧是小程序预览界面，可以点击操作，中间是小程序项目的树形目录，最右侧是中间选中的文件的内容，可以编辑
---

## 本篇目录

* auto-gen TOC:
{:toc}

## 创建小程序项目

在微信开发者工具中创建一个小程序项目，根据自己需要选择云开发，云开发是微信提供的后台功能，譬如云数据库、云存储、云函数等，现在不收费，2019年8月份后会推出收费计划。

创建小程序项目的时候需要输入 appid，appid 在小程序后台的设置中可以找到：

![微信小程序APPID]({{ site.baseurl }}{{site.img}}/article/xiaochengxu-project-3.png)

下面的示例是一个使用了云开发功能的小程序的，这个示例是微信开发者工具默认给出的。

## 小程序项目结构

微信开发者工具中的小程序项目呈现形式如下，界面分为左中右三栏，最左侧是小程序预览界面，可以点击操作，中间是小程序项目的树形目录，最右侧是中间选中的文件的内容，可以编辑：

[![小程序云开发示例]({{ site.baseurl }}{{ site.img }}/article/xiaochengxu-project-1.png)]({{ site.baseurl }}{{ site.img }}/article/xiaochengxu-project-1.png)
<p style="text-align:center">点击图片查看大图</p>

默认示例代码，由三部分组成：

```sh
├── README.md
├── cloudfunctions
│   ├── login
│   └── openapi
├── miniprogram
│   ├── app.js
│   ├── app.json
│   ├── app.wxss
│   ├── images
│   ├── pages
│   ├── sitemap.json
│   └── style
└── project.config.json
```

**cloudfunctions**：小程序的云开发代码（非必须），需要部署到云端；

**miniprogram**：小程序的页面文件以及交互逻辑代码；

**project.config.json**：项目的配置文件，是微信开发者工具使用的配置文件，可以使用的配置项见 [项目配置文件](https://developers.weixin.qq.com/miniprogram/dev/devtools/projectconfig.html)。

### 部署云函数

第一次使用云开发功能的时候，创建项目时会提示你开通云开发功能，按提示开通即可。上面演示用的小程序用到了云开发功能，在 cloudfunctions 目录中实现了几个云函数，这些云函数是 node.js 项目。

![微信小程序云函数]({{ site.baseurl }}{{site.img}}/article/xiaochengxu-project-2.png)

在云函数目录上`点击鼠标右键-`>`选择上传并部署`，然后预览中的小程序就可以调用云函数。如果调用没有部署的云函数，会提示云函数未部署。

云开发功能不是必须的，后台服务完全可以在自己的服务器上部署。云开发是腾讯提供的函数功能，另外还有云存储、云数据库等，使用云开发能够简化后端服务开发，减少维护工作。

### 预览小程序

微信开发者界面左侧就是小程序的预览界面，另外在工具栏中选择`预览`或者`真机调试`会弹出二维码，用微信扫描二维码就可以在手机上预览小程序。

工具栏中还有很多其它开发工具，譬如`版本管理`、`清缓存`等。

## 小程序配置文件

app.json 是小程序的全局配置，包括了小程序的所有页面、界面表现、超时设置、底部 tab 等。
所有可用配置项以及配置项的含义可以在 [微信小程序的全局配置](https://developers.weixin.qq.com/miniprogram/dev/reference/configuration/app.html) 中找到。其中：

1. **pages** 是小程序的所有页面的路径，每个页面都必须要在这里注册；
2. **window** 定义小程序所有页面顶部的背景颜色、文字颜色等；
3. **tabBar** 小程序的底部 tab 栏；
4. **networkTimeout** 网络超时；
5. **debug** 是否开启 debug 模式；
6. **functionPages** 是否启用插件模式；
7. **subpackage** 分包结构配置；
8. **workers** worker 代码；
9. **requireBackgroundModes** 后台使用的功能；
10. **plugins** 启用的插件；
11. **preloadRule** 分包预下载规则；
12. **resizable** iPad 的屏幕旋转支持；
13. **navigateToMiniProgramAppIdList** 需要跳转的小程序列表；
14. **usingComponents** 全局自定义组建；
15. **permission** 小程序接口权限；
16. **sitemapLocation** sitemap.json 的位置。

sitemap.json 是小程序收录配置，在 sitemap.json 中设置小程序页面是否可以被微信索引，没有该文件默认所有页面都允许被索引，下面是一个允许所有页面被索引的 sitemap.json 文件：

```json
{
  "rules": [{
  "action": "allow",
  "page": "*"
  }]
}
```

## 小程序页面文件

每个小程序页面主要包括 wxml、wxss、js、json 四个文件，另外可以包含一些图片的页面素材文件：

1. wxml 页面文件是小程序页面结构的基础；
2. wxss 文件是独立的样式表；
3. js 文件是页面交互逻辑的实现；
4. json 文件是页面的配置文件。

![微信小程序页面文件]({{ site.baseurl }}{{site.img}}/article/xiaochengxu-project-4.png)


页面文件的内容格式和语法下一节说明。

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
