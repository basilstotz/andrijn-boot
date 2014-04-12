#!/bin/sh

lb clean
lb build

WWW="www"

if ! test -d $WWW; then mkdir $WWW;  fi

THIS=$(cat $WWW/version)
PPREV=$(( $THIS - 2 ))
PREV=$(( $THIS - 1 ))
NEXT=$(( $THIS + 1 ))

if test -z "$THIS"; then echo "oops!"; exit 1; fi

cp binary/live/filesystem.squashfs $WWW/$(printf "%06i.img" $NEXT)
cp binary.hybrid.iso $WWW/hybrid.iso




if cd $WWW; then
  if ! test -f $(printf "%06i.img" $THIS); then
    THIS=$NEXT
  fi

  if ! test -f $(printf "%06i.img" $PREV); then
    PREV=$THIS
  fi

  zsyncmake -u hybrid.iso hybrid.iso
  zsyncmake -u $(printf "%06i.img" $NEXT) $(printf "%06i.img" $NEXT)


  rm *-image-*
  touch old-image-$(printf "%06i" $PREV)
  touch cur-image-$(printf "%06i" $THIS)
  touch nxt-image-$(printf "%06i" $NEXT)

  #remove oldest
  if test -f $(printf "%06i.img" $PPREV); then
    rm $(printf "%06i.img*" $PPREV)
  fi

  

  echo $NEXT > version
fi

exit
