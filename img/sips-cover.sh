#! /bin/sh
#
# sips-cover.sh
# Copyright (C) 2019 lijiaocn <lijiaocn@foxmail.com>
#
# Distributed under terms of the GPL license.
#

file=$1
name=`basename $1 .png`
name=`basename $name .jpg`
name=`basename $name .jpeg`

echo $name
set -x
sips -s format jpeg --resampleHeightWidth 600 600 $file --out ./cover/1x1/$name.jpg
sips -s format jpeg --resampleHeightWidth 600 800 $file --out ./cover/4x3/$name.jpg
sips -s format jpeg --resampleHeightWidth 540 960 $file --out ./cover/16x9/$name.jpg
