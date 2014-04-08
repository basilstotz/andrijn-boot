#!/bin/sh

#lb clean
#lb build

WWW="www"

if ! test -d $WWW; then mkdir $WWW;  fi

THIS=$(cat $WWW/version)
PPREV=$(( $THIS - 2 ))
PREV=$(( $THIS - 1 ))
NEXT=$(( $THIS + 1 ))

if test -z "$THIS"; then echo "oops!"; exit 1; fi

if ! test -f $WWW/$(printf "%06i.img" $THIS); then
 THIS=$NEXT
fi

if ! test -f $WWW/$(printf "%06i.img" $PREV); then
  PREV=$THIS
fi


cp binary/live/filesystem.squashfs ${WWW}/$(printf "%06i.img" $NEXT)

if cd $WWW; then
  zsyncmake -u $(printf "%06i.img" $NEXT) $(printf "%06i.img" $NEXT)

  rm *-image-*
  touch old-image-$(printf "%06i" $PREV)
  touch stable-image-$(printf "%06i" $THIS)
  touch next-image-$(printf "%06i" $NEXT)

  #remove oldest
  if test -f $(printf "%06i.img" $PPREV); then
    rm $(printf "%06i.img*" $PPREV)
  fi
  echo $NEXT > version
fi

exit
