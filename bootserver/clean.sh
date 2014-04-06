#!/bin/sh

lb clean
rm -r cache
rm www/*
touch www/version
echo "0" > www/version

exit
