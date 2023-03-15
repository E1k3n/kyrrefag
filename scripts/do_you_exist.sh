#!/bin/bash

ls "$1"

if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi