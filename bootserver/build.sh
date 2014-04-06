#!/bin/sh


lb clean
lb build

WWW="www"

if ! test -d $WWW; then mkdir $WWW;  fi

VERSION=$(cat $WWW/version)
if test -z "$VERSION"; then echo "oops!"; exit 1; fi
NEXT=$(( $VERSION + 1 ))
PREV=$(( $VERSION - 1 ))
NUMMER=$(printf "%06i" $NEXT)

cp binary/live/filesystem.squashfs ${WWW}/${NUMMER}.img
cd $WWW
zsyncmake -u ${NUMMER}.img ${NUMMER}.img
rm primary-image-*
touch primary-image-${NUMMER} 
if test -f $(printf "%06i.img" $VERSION); then
   rm $(printf "%06i.img*" $VERSION)
fi
echo $NEXT > version
