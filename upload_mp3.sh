#!/bin/bash

currdir=`dirname $0`
cd ${currdir}
echo "current dir=$currdir"

export LANG="en_US.UTF-8"
fname=`basename $1`
lftp="/usr/local/bin/lftp"
notif="/usr/local/bin/terminal-notifier"

episode=`echo $1 | sed -n 's/.*rt\(.*\)\post.mp3/\1/p'`
${notif} -title PodPrc -message "Radio-T detected #${episode}"
utils/eyeD3.exec -v --remove-all --set-encoding=utf8 --album="Пираты Радио-Т" --add-image=utils/cover-p.png:FRONT_COVER: --artist="Umputun, Bobuk, Gray, Ksenks, Alek.sys" --track=${episode} --title="Пираты Радио-Т ${episode}" --year=$(date +%Y)  --genre="Podcast" $1
${notif} -title PodPrc -message "Пираты tagged"

cd ..

echo "upload to pirates.radio-t.com"
${notif} -title PodPrc -message "upload started"
scp $1 umputun@master.radio-t.com:/srv/master-node/var/media/${fname}
ssh umputun@master.radio-t.com "chmod 666 /srv/master-node/var/media/${fname}"

echo "run ansible tasks"
ssh master.radio-t.com "docker exec -i ansible /srv/deploy_pirates.sh $episode"

echo "copy to hp-usrv archives"
${notif} -title PodPrc -message "copy to hp-usrv archives"
scp -P 2222 $1 umputun@nas.umputun.com:/Podcasts/pirates/

echo "upload to archive site"
scp $1 umputun@master.radio-t.com:/data/archive/pirates/media/${fname}
ssh umputun@master.radio-t.com "chmod 644 /data/archive/pirates/media/${fname}"

echo "all done for $fname"
${notif} -title PodPrc -message "all done for $fname"
