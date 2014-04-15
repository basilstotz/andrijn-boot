#!/bin/sh

 lb clean
 lb build

 WWW="www"

 if ! test -d $WWW; then mkdir $WWW;  fi

 THIS=$(cat $WWW/version)
 if test -z "$THIS"; then echo "oops!"; exit 1; fi

 NEXT=$(( $THIS + 1 ))
 

 cp binary.hybrid.iso $WWW/$(printf "%06i.iso" $NEXT)
 cp binary.hybrid.iso $WWW/hybrid.iso

 if cd $WWW; then
   zsyncmake -u $(printf "%06i.iso" $NEXT) $(printf "%06i.iso" $NEXT)
   zsyncmake -u hybrid.iso hybrid.iso


   #remove oldest
   OLDEST=$(( $THIS - 2 ))
   if test -f $(printf "%06i.iso" $OLDEST); then
     rm $(printf "%06i.iso*" $OLDEST)
   fi

   echo $NEXT > version
fi

exit
