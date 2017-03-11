#!/bin/sh -eux
###### Ubuntu Main Repos
echo 'deb http://01.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb-src http://01.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse' >> /etc/apt/sources.list 

###### Ubuntu Update Repos
echo 'deb http://01.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb http://01.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb http://01.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb http://01.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb-src http://01.archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb-src http://01.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb-src http://01.archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse' >> /etc/apt/sources.list 
echo 'deb-src http://01.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse' >> /etc/apt/sources.list 

###### Ubuntu Partner Repo
echo 'deb http://archive.canonical.com/ubuntu trusty partner' >> /etc/apt/sources.list
echo 'deb-src http://archive.canonical.com/ubuntu trusty partner' >> /etc/apt/sources.list
