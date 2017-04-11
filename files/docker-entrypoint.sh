#!/bin/sh

set -e

: ${REDMINE_MYSQL_DATABASE:=database};
: ${REDMINE_MYSQL_HOST:=host};
: ${REDMINE_MYSQL_USER:=user};
: ${REDMINE_MYSQL_PASSWORD:=password};

svn_conf=/usr/local/apache2/conf/extra/svn.conf

mkdir /usr/share/perl/5.20/Apache
# TODO: remove -k
curl -L https://svn.redmine.org/redmine/trunk/extra/svn/Redmine.pm -k > /usr/share/perl/5.20/Apache/Redmine.pm

sed -i "s|RedmineDSN.*$|RedmineDSN \"DBI:mysql:database=redmine;host=${REDMINE_MYSQL_HOST}\"|" ${svn_conf}
sed -i "s|RedmineDbUser.*$|RedmineDbUser \"${REDMINE_MYSQL_USER}\"|" ${svn_conf}
sed -i "s|RedmineDbPass.*$|RedmineDbPass \"${REDMINE_MYSQL_PASSWORD}\"|" ${svn_conf}

/usr/local/bin/httpd-foreground
