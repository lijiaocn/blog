#! /bin/sh
#
# push.sh
# Copyright (C) 2019 lijiaocn <lijiaocn@foxmail.com>
#
# Distributed under terms of the GPL license.
#


curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://www.lijiaocn.com&token=1KiZ1dZUtPx4SmGh" 
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?appid=1584040578470474&token=EVFCmRqp1r3IDzBV&type=realtime" 
echo ""
