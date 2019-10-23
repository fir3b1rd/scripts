
#aliases
alias ll="ls -la"

# rgrep <file> <pattern>
# note: wildcard search requires explicit quotes! (-> e.g. "*")
myfunction() {
grep -rn $1 --exclude="*/target/*" --exclude="*/.git/*" $2
}
alias rgrep=myfunction

export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512m"
export CQ_LICENSE_FILE=~/dev/dhasler/scripts/license.properties
export CM_URL=https://ssg.adobe.io

PATH=${PATH}:~/dev/tools/maven
PATH=${PATH}:~/dev/tools/gitslave
PATH=${PATH}:~/dev/dhasler/scripts/granite
PATH=${PATH}:~/dev/dhasler/scripts/cq
PATH=${PATH}:~/dev/dhasler/scripts
PATH=${PATH}:~/dev/tools/tig
PATH=${PATH}:~/dev/tools/vlt/vault-cli-3.1.6/bin
PATH=${PATH}:~/dev/tools/wsk
git config --global user.email "dhasler@adobe.com"
git config --global user.name "Daniel Hasler"
git config --global push.default upstream

# set java 1.8 as the default
. setjavahome.sh 1.8
