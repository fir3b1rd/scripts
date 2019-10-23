#!/bin/bash

if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    echo "no java"
    exit 1
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" < "1.8" ]]; then
        echo version is smaller than 1.8 - which is good 
    else
        echo version is 1.8 or greater - not supported in AEM 6.0 GA
        exit 2
    fi
fi

java -Xmx1024M -XX:MaxPermSize=512M -jar aem-6.0.0.20140515-generic.jar -p 4502 -r author -gui -nofork
