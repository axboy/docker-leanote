# Docker运行[蚂蚁笔记](https://leanote.com/ '官网')

本镜像基于mongo:3.2构建，实际就是添加一个run.sh脚本，初始化蚂蚁笔记的所需的数据库。

## 概况

tag     |remark
--------|--------------
2.5     |
2.6     |需修改为http.addr=0.0.0.0
2.6.1   |
nodb    |目前第一次启动会失败，创建容器后需修改配置重启
nodb-arm|Test by raspberry PI 3b+
latest  |The same as 2.6.1

## 获取镜像

```sh
docker pull axboy/leanote
```

## 构建镜像

首先克隆本仓库，在项目根目录下执行以下代码

```sh
docker build . -t axboy/leanote
```

## 运行

为方便迁移，建议映射mongo db的数据卷、leanote的conf和files文件夹。
容器内的mongodb为免密码的，若需密码自行修改镜像。以下是参考运行代码。

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