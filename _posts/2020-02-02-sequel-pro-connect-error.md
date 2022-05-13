---
layout: default
title: "MySQL said: Authentication plugin 'caching_sha2_password' cannot be loaded" 
author: 李佶澳
date: "2020-02-02T20:44:32+0800"
last_modified_at: "2020-02-02T20:44:32+0800"
categories: skill
cover:
tags: mysql
keywords: mysql, caching_sha2_password
description:  "MySQL said: Authentication plugin caching_sha2_password cannot be loaded: dlopen(/usr/local/lib/plugin/caching_sha2_password.so, 2): image not found"
---

## 说明

在命令行可以用 mysql 登陆，但是用 Sequel Pro 连接 mysql 时出现下面的错误：

```sh
Unable to connect to host 127.0.0.1, or the request timed out.

Be sure that the address is correct and that you have the necessary privileges, or try increasing the connection timeout (currently 10 seconds).

MySQL said: Authentication plugin 'caching_sha2_password' cannot be loaded: dlopen(/usr/local/lib/plugin/caching_sha2_password.so, 2): image not found
```

[文章][2] 中说，mysql8 将密码加密机制由 mysql_native_password 改成了 caching_sha2_password。

最简单的方法是修改加密规则：

```mysql
ALTER USER 'gorm'@'%' IDENTIFIED WITH mysql_native_password BY 'password123';  
```

## 参考

1. [李佶澳的博客][1]

[1]: https://www.lijiaocn.com "李佶澳的博客"
[2]: https://www.cnblogs.com/zhurong/p/9898675.html "MySQL 连接出现 Authentication plugin 'caching_sha2_password' cannot be loaded"
