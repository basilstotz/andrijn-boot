#!/bin/sh


lb clean
lb build

WWW="www"

VERSION=$(cat $WWW/version)
NEXT=$(( $VERSION + 1 ))
PREV=$(( $VERSION - 1 ))
NUMMER=$(printf "%06i" $NEXT)

cp binary/live/filesystem.squashfs ${WWW}/${NUMMER}.img
cd $WWW
zsyncmake -u ${NUMMER}.img ${NUMMER}.img
rm primary-image-*
touch primary-image-${NUMMER} 
if test -f $(printf "%06i.img" $PREV); then
   rm $(printf "%06i.img*" $PREV)
fi
echo $NEXT > version
