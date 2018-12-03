# Docker run [leanote](https://leanote.com/ 'Official website')

![Screen shot](./leanote-en.png)

- [简体中文](./README.md)

- [English](./README-EN.md)

I'm so sorry, my English is poor.

Image based mongo:3.2, data has been initialized, no database version need edit configuration file, then restart container.

## Support tag list

- 2.5([Dockerfile](https://github.com/axboy/leanote/blob/2.5/Dockerfile))
- 2.6([Dockerfile](https://github.com/axboy/leanote/blob/2.6/Dockerfile))
- 2.6.1,latest([Dockerfile](https://github.com/axboy/leanote/blob/2.6.1/Dockerfile))
- nodb([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb/Dockerfile))
- nodb-arm([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb-arm/Dockerfile))

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

The initial users table has two accounts:

```
user1 username: admin, password: abc123 (administrator who can manage Leanote)
user2 username: demo@leanote.com, password: demo@leanote.com (just for demonstration)
```