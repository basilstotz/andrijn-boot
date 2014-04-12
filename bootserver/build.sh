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


cp binary.hybrid.iso $WWW/$(printf "%06i.iso" $NEXT)
cp binary.hybrid.iso $WWW/hybrid.iso




if cd $WWW; then
  if ! test -f $(printf "%06i.iso" $THIS); then
    THIS=$NEXT
  fi

  if ! test -f $(printf "%06i.iso" $PREV); then
    PREV=$THIS
  fi


  zsyncmake -u $(printf "%06i.iso" $NEXT) $(printf "%06i.iso" $NEXT)
  zsyncmake -u hybrid.iso hybrid.iso

  rm *-iso-*
  touch old-iso-$(printf "%06i" $PREV)
  touch cur-iso-$(printf "%06i" $THIS)
  touch nxt-iso-$(printf "%06i" $NEXT)

  #remove oldest
  if test -f $(printf "%06i.iso" $PPREV); then
    rm $(printf "%06i.iso*" $PPREV)
  fi

  

  echo $NEXT > version
fi

exit
