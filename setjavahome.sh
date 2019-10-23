#!/bin/sh

if [[ "$0" != -* ]] ; then
        echo "Script must be sourced into the shell for" >&2
        echo "export to have an effect" >&2
        exit 1
fi

if [[ "$1" = "" ]]
then
        unset JAVA_HOME
        echo "Clearing JAVA_HOME"
else
        export JAVA_HOME=`/usr/libexec/java_home -v $1`
        echo "Setting JAVA_HOME=${JAVA_HOME}"
fi

echo "java -version:"
java -version 2>&1 |
        while read LINE ; do
                echo "    ${LINE}"
        done

