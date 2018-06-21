# Docker运行[蚂蚁笔记](https://leanote.com/ '官网')

本镜像基于mongo:3.2构建，实际就是添加一个run.sh脚本，初始化蚂蚁笔记的所需的数据库。

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

为方便迁移，建议映射mongo db的数据卷和leanote的conf文件夹。容器内的mongodb为免密码的，若需密码自行修改镜像。以下是参考运行代码。

```sh
docker run -d --name leanote \
    -v `pwd`/db:/data/db \
    -v `pwd`/conf/:/data/leanote/conf \
    -p 9000:9000 \
    axboy/leanote
```

## 修改时区

默认为北京时间，如需修改，参考如下命令。

```sh
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
```

## 其它

初始用户

```
user1 username: admin, password: abc123 (管理员, 只有该用户才有权管理后台, 请及时修改密码)
user2 username: demo@leanote.com, password: demo@leanote.com (仅供体验使用)
```
