#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "no post number passed"
    exit
fi

today=$(date +%Y-%m-%d)
hhmmss=$(date +%H:%M:%S)
post=$1

if [ "$#" -eq 2 ]; then
    echo "date defined as $2"
    today=$2
fi

currdir=`dirname $0`
cd ${currdir}
echo "current dir=$currdir"

echo "new post number=$post"
cd hugo

outfile="./content/posts/${today}-podcast-${post}.markdown"

echo '---' > ${outfile}
echo "title: \"После РТ $post\"" >> ${outfile}
echo "date: ${today}T${hhmmss}-05:00" >> ${outfile}
echo "slug: \"podcast-${post}\"" >> ${outfile}
echo "comments: true" >> ${outfile}
echo "categories: podcast" >> ${outfile}
echo "filename: rt${post}post" >> ${outfile}
echo '---' >> ${outfile}
echo ""  >> ${outfile}

echo "[аудио](http://cdn.radio-t.com/rt${post}post.mp3) ● [лог чата](http://chat.radio-t.com/logs/radio-t-$post.html)" >> ${outfile}
echo "<audio src=\"http://cdn.radio-t.com/rt${post}post.mp3\" preload=\"none\"></audio>" >> ${outfile}

echo "deploy"
cd ..
git commit -a -m "auto commit new episode #${post}" && git push
ssh master.radio-t.com "cd /srv/pirates && git pull && docker-compose run hugo"

echo "all done for ${post}"
