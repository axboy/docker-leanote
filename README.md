**注意：本仓库已删除大文件并强制提交。**

**Attention: this repo has removed big file and force commited.**

---

# Docker运行[蚂蚁笔记](https://leanote.com/ '官网')

![Screen shot](./leanote-cn.png)

- [简体中文](./README.md)

- [English](./README-EN.md)

镜像提供内置数据库和无数据库版，内置数据库基于mongo:3.2构建，蚂蚁笔记所需数据都已初始化完毕，非内置数据库启动后需修改数据配置再重启。

_内置数据库，容器内多进程非Docker推荐做法，只为方便。_

## 版本选择

full: 完整功能，内置数据库
nodb: 完整功能，不包含数据库
lite: 仅有leanote程序，网页版不支持导出pdf和备份数据库，供客户端用户使用

具体如下

- latest([Dockerfile](https://github.com/axboy/docker-leanote/blob/master/Dockerfile))
- nodb([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb/Dockerfile))
- lite([Dockerfile](https://github.com/axboy/leanote/blob/master/lite/Dockerfile))
- nodb-arm([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb-arm/Dockerfile))
- lite-arm([Dockerfile](https://github.com/axboy/leanote/blob/master/lite-arm/Dockerfile))
- ~~2.5([Dockerfile](https://github.com/axboy/leanote/blob/2.5/Dockerfile))~~
- ~~2.6([Dockerfile](https://github.com/axboy/leanote/blob/2.6/Dockerfile))~~
- ~~2.6.1([Dockerfile](https://github.com/axboy/leanote/blob/2.6.1/Dockerfile))~~

## 数据库配置(nodb版使用)

[初始化数据库看这里](https://github.com/leanote/leanote/wiki/Leanote-二进制版详细安装教程----Mac-and-Linux#3-导入初始数据)

导入数据库后，以下配置根据实际环境修改

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

## 数据目录简介

为方便修改配置和迁移数据，建议映射如下文件夹。

```
/data/db                # 内置mongodb的数据目录，nodb版无此目录
/data/leanote/conf      # 笔记的配置文件目录
/data/leanote/files     # 笔记内上传的图片、文件存放目录
/data/leanote/public/upload     # 头像上传路径
```

## 运行

```sh
docker run -d --name leanote \
    -v `pwd`/db:/data/db \
    -v `pwd`/conf/:/data/leanote/conf \
    -v `pwd`/files:/data/leanote/files \
    -v `pwd`/upload:/data/leanote/public/upload \
    -p 9000:9000 \
    axboy/leanote
```

## 备份数据

- 方案一

通过备份文件来备份数据，数据库版本大更时不兼容，比如mongo:3.2到mongo:3.4

- 方案二

使用admin账号到管理后台备份，lite版不支持

- 方案三

自行通过mongodump备份

个人更倾向于方案一，因为数据库不包含上传的文件，不是仅仅备份数据库就行

## 修改时区

默认为北京时间，如需修改，参考如下命令。

```sh
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
```

## [常见问题](https://github.com/leanote/leanote/wiki/QA)

- 2.6版启动后不能访问

2.6版默认绑定localhost, 不能通过ip访问Leanote,
请修改 app.conf

```
http.addr=0.0.0.0 # listen on all ip addresses
```

重启Leanote

## 其它

初始用户

```
user1 username: admin, password: abc123 (管理员, 只有该用户才有权管理后台, 请及时修改密码)
user2 username: demo@leanote.com, password: demo@leanote.com (仅供体验使用)
```

## mongodb升级

原有2.6.1的版本，mongodb为3.2，现有的latest的mongodb版本为4.2.7，直接映射文件会导致启动失败。
可使用浏览器登录管理账号，在后台备份数据库，下载到本地并启动一个新版本容器，参考命令如下

```sh
# 将下载的文件拷贝到新容器
docker cp ~/download/backup_leanote_1602120903 new_leanote:/

# 进入容器
docker exec -it new_leanote bash

# 恢复备份的数据库
mongorestore -h localhost -d leanote --dir /backup_leanote_1602120903/  --drop
```

## 补充

- 关于自定义数据库的，可参考[布宝的慕课手记](https://www.imooc.com/article/49225)
