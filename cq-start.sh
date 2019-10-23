#!/bin/sh

LICENSE=$CQ_LICENSE_FILE
JAVA_OPTIONS="-Xmx1024m -XX:MaxPermSize=256M"

# parse arguments
DO_HELP=false
DO_DEBUG=false

while [ $# -gt 0 ]
do
case $1 in
    -h|--help) DO_HELP=true ;;
    -p|--port) PORT=$2; shift ;;
    -d|--debug) DO_DEBUG=true ;;
    *) ;;
  esac
shift
done

if $DO_HELP ;
then
echo "Starts quickstart in current directory or in build/quickstart/target"
  echo ""
  echo "Options:"
  echo " -h --help show this help"
  echo " -p --port <port> set http port"
  echo " -d --debug start in debug mode (port 8000)"
  exit
fi

# finds the git root = folder with .git subfolder
function find_git_root() {
  DIR=$(pwd)

  while [ $DIR != "/" ]; do
if [ -d $DIR/.git ]; then
echo $DIR
      return 0
    fi
DIR=$(dirname $DIR)
  done
return -1
}

# first check for crx-quickstart folder or cq jar in current directory
# find any generic jar name, e.g. "cq*.jar"
if [ -d "crx-quickstart" ] || [ -f cq*.jar ]; then
echo ">>>> Found quickstart in current directory"
  JAR=(cq*.jar)
else

echo ">>>> Finding git root and target dir"
  
  ROOT=$( find_git_root $(pwd) )
  if [ "$?" -ne 0 ]; then
echo "Error: Outside the git checkout? Could not detect the git root for $(pwd)"
    exit
fi

cd $ROOT/target || { echo "\nError: Outside the CQ/quickstart git checkout?" >&2; exit 1; }
  
  # standard quickstart jar if built inside target dir
  JAR=cq-quickstart*-SNAPSHOT.jar
fi

echo ">>>> Starting quickstart: $(pwd)/${JAR}..."

# ensure license file is present
if [ ! -f license.properties ]; then
cp $LICENSE license.properties
fi

FORKARG="-fork"
if $DO_DEBUG ; then
echo " DEBUG mode"
  DEBUGARG="-agentlib:jdwp=transport=dt_socket,address=8000,server=y,suspend=n"
  FORKARG="-nofork"
fi

if [[ $PORT ]]; then
echo " HTTP PORT: $PORT"
  PORTARG="-p $PORT"
fi

echo "java $DEBUGARG $JAVA_OPTIONS -jar $JAR $PORTARG -gui $FORKARG >&2 &"

java $DEBUGARG $JAVA_OPTIONS -jar $JAR $PORTARG -gui $FORKARG >&2 &
