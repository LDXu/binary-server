# 
FROM node:8.15-alpine

# 设置时区
RUN apk --update add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata
RUN rm -rf /usr/src/app 
# 这个是容器中的文件目录
RUN mkdir -p /usr/src/app 

# 设置工作目录
WORKDIR /usr/src/app

COPY package.json /usr/src/app/package.json

# 安装npm依赖(使用淘宝的镜像源)
# 如果使用的境外服务器，无需使用淘宝的镜像源，即改为`RUN npm i`。
RUN npm i --production --registry=https://registry.npm.taobao.org

# 拷贝所有源代码到工作目
COPY . /usr/src/app

EXPOSE 8080

CMD BUILD_ENV=docker npm start