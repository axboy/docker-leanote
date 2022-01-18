# Docker run [leanote](https://leanote.com/ 'Official website')

![Screen shot](./leanote-en.png)

- [简体中文](./README.md)

- [English](./README-EN.md)

Bad english, that's all.

Image based mongo:3.2, data has been initialized, no database version need edit configuration file, then restart container.

## Support tag list

- latest([Dockerfile](https://github.com/axboy/docker-leanote/blob/master/Dockerfile))
- nodb([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb/Dockerfile))
- lite([Dockerfile](https://github.com/axboy/leanote/blob/master/lite/Dockerfile))
- nodb-arm([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb-arm/Dockerfile))
- lite-arm([Dockerfile](https://github.com/axboy/leanote/blob/master/lite-arm/Dockerfile))
- ~~2.5([Dockerfile](https://github.com/axboy/leanote/blob/2.5/Dockerfile))~~
- ~~2.6([Dockerfile](https://github.com/axboy/leanote/blob/2.6/Dockerfile))~~
- ~~2.6.1([Dockerfile](https://github.com/axboy/leanote/blob/2.6.1/Dockerfile))~~

full: full featured, for easy use

nodb: include some tools

lite: include leanote only, not support backup db and export pdf in web

## Configure database(nodb version used)

[Initial MongoDB see here](https://github.com/leanote/leanote/wiki/leanote-binary-installation-on-Mac-and-Linux-(En)#3-import-initial-leanote-data)

After imported data, these configuration should according to real envirmont update.

```conf
# mongdb
db.host=192.168.1.20
db.port=27017
db.dbname=leanote # required
db.username= # if not exists, please leave it blank
db.password= # if not exists, please leave it blank
# or you can set the mongodb url for more complex needs the format is:
# mongodb://myuser:mypass@localhost:40001,otherhost:40001/mydb
# db.url=mongodb://root:root123@localhost:27017/leanote
# db.urlEnv=${MONGODB_URL} # set url from env. eg. mongodb://root:root123@localhost:27017/leanote
```

## Volumes

For easier to back up or migrate, suggest shard these folder.

```
/data/db                # Inner MongoDB data catalog, nodb version not contains this folder.
/data/leanote/conf      # Configuration file in this folder.
/data/leanote/files     # The file or images upload in this folder.
/data/leanote/public/upload     # Head image path
```

## Run

```sh
docker run -d --name leanote \
    -v `pwd`/db:/data/db \
    -v `pwd`/conf/:/data/leanote/conf \
    -v `pwd`/files:/data/leanote/files \
    -p 9000:9000 \
    axboy/leanote
```

## Backup data

- Option one

Back up data by backing up files, not support major version updates

- Option two

Using admin system backup, not support lite version

- Option three

backup db by self

## Edit timezone

Default timezone is Beijing/China(GMT+8), if want to edit, see here.

```sh
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
```

## [Trouble shooting](https://github.com/leanote/leanote/wiki/Leanote-QA-English)

- Cannot visit via ip

please find and update app.conf

```
http.addr=0.0.0.0 # listen on all ip addresses
```

Then restart Leanote

## Other

- The initial accounts:

```
user1 username: admin, password: abc123 (administrator who can manage Leanote)
user2 username: demo@leanote.com, password: demo@leanote.com (just for demonstration)
```

- disable demo account

demo account is a normal account acutally, can operate all resource in this account, It's recommended to disable it, you can deny the URL **/demo**.

```
server { 
    # ignore some config

    location / {
        proxy_pass              http://172.17.0.1:9000;
        proxy_set_header        Host            $host;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-For $remote_addr;
    }
    location /demo {
        deny all;
    }
}

```

- config site.url

Config site.url in conf/app.conf file, it's the url in you browser, if not, you will not be able to logout in homepage, and some resource will not access in blog page.