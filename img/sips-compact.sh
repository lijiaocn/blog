#! /bin/sh
#
# sips-compact.sh
# Copyright (C) 2019 lijiaocn <lijiaocn@foxmail.com>
#
# Distributed under terms of the GPL license.
#

for d in `find . -type d`;do
	echo $d
	pushd $d;
	
	for i in `ls *.png`;do
		echo "compress $i"
		name=`basename $i .png`
		sips -s format jpeg -s formatOptions default $i --out ${name}.jpg
		rm $i
	done

	for i in `ls *.jp*`;do
		echo "compress $i"
		sips -s format jpeg -s formatOptions default $i --out tmp.$i
		mv tmp.$i $i
	done
	
	popd
done
git checkout bg.png
