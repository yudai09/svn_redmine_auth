# Subversion auth by Redmine

## How to use

* create or migrate subversion repo data into /usr/local/svn/, the directory is just example.
* mount host's directory (/usr/local/svn/) on container's directory (/var/svn)
* mysql variables should be passed through environment variables.
* below is an example of running `svn_redmine_auth` in swarm mode.
```
sudo docker service create --name sv_subversion \
-p 80:80 \
--mount type=bind,src=/usr/local/svn,dst=/var/svn \
--replicas 1 \
--network nw_incmng \
--env "REDMINE_MYSQL_DATABASE=redmine" \
--env "REDMINE_MYSQL_HOST=mydb" \
--env "REDMINE_MYSQL_USER=redmine" \
--env "REDMINE_MYSQL_PASSWORD=mypassword" \
grandeur09/svn_redmine_auth
```

## TODO

* support postgres
* support SQLite3