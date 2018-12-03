# Docker运行[蚂蚁笔记](https://leanote.com/ '官网')

![Screen shot](./leanote-cn.png)

- [简体中文](./README.md)

- [English](./README-EN.md)

镜像提供内置数据库和无数据库版，内置数据库基于mongo:3.2构建，蚂蚁笔记所需数据都已初始化完毕，非内置数据库启动后需修改数据配置再重启。

## 提供以下镜像版本

- 2.5([Dockerfile](https://github.com/axboy/leanote/blob/2.5/Dockerfile))
- 2.6([Dockerfile](https://github.com/axboy/leanote/blob/2.6/Dockerfile))
- 2.6.1,latest([Dockerfile](https://github.com/axboy/leanote/blob/2.6.1/Dockerfile))
- nodb([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb/Dockerfile))
- nodb-arm([Dockerfile](https://github.com/axboy/leanote/blob/master/nodb-arm/Dockerfile))

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
    -p 9000:9000 \
    axboy/leanote
```

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

## 补充

- 关于自定义数据库的，可参考[布宝的慕课手记](https://www.imooc.com/article/49225)