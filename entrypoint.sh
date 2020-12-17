#!/bin/sh -l

echo "\e[33m\e[1mR session information"
Rscript -e 'sessionInfo()'
echo "\e[33m\e[1mR Location"
pwd

# Check for build only
if [ "$1" = "build" ]; then
    echo "\e[33m\e[1mRunning only build task"
    R CMD INSTALL . -c --build
fi
echo "\e[33m\e[1mR Files generated"
ls
