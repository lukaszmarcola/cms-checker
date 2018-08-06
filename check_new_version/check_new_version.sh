#!/bin/bash
path='/home/lukaszxm/domains/ip.ayz.pl/public_html/wersje/wersje.txt'
path2='/home/lukaszxm/domains/ip.ayz.pl/public_html/wersje/wersja'

R=`openssl rand -hex 3`
temp="/tmp/temp"`echo $R`
tp="/tmp/tp"`echo $R`
e="/tmp/e"`echo $R`

if [ -a $path ]
then
        mv $path $path2`date +%d`.txt
fi
touch $path

curl -s https://installatron.com/wordpress > $temp
sed -i -e 's/}/}\n/g' $temp
sed -i -e 's/,/, /g' $temp
sed -i -e 's/"/ " /g' $temp


echo -n "#wordpress ">$path
cat $temp |grep "wordpress" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


echo -n "#joomla ">>$path
cat $temp |grep "joomla" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


echo -n "#phpbb ">>$path
cat $temp |grep "phpbb" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


echo -n "#prestashop ">>$path
cat $temp |grep "prestashop" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


echo -n "#owncloud ">>$path
cat $temp |grep "owncloud" |grep "version:" | awk '{print $4}'>>$path

echo -n "#drupal ">>$path
cat $temp |grep "drupal" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


echo -n "#piwik/matomo ">>$path
cat $temp |grep "piwik" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


echo -n "#dolibarr ">>$path
cat $temp |grep "dolibarr" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


echo -n "#magento ">>$path
cat $temp |grep "magento" |grep "version:" | awk '{print $4}'>>$path
echo -e ''>>$path


sed -i '/^\ *$/d' $path;
cat $path>$temp


while read line
do
echo "$line"| awk '{print $2}'>$tp

         if [[ ! `cat $tp` =~ ^[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}.*$ ]]; then

         echo 'error'>> $path
         echo '--ERROR--'
         echo ''
         fi

done < $temp

cat $path
rm $temp
rm $tp

echo '*** ***'
echo '*** ***' >>$path
echo last check CMS version: `date`>>$path
echo last check CMS version: `date`

cat $path >$e

       if [[ `cat $e |grep error` = error* ]]

then
       echo "plik zawiera bledy"
       echo "plik zawiera bledy">>$path
       echo -e "Problem z lista nowych wersji CMS. Sprawdz 
http://ip.ayz.pl/wersje/wersje.txt\n`cat $path` " | mail -s "Problem z CMS" 
20.marcola.lukasz@gmail.com

else
        echo "done"
        echo 'done'>>$path
fi

rm $e

