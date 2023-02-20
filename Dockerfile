FROM python:3.8-slim
LABEL 维护者="佰阅 2894049053@qq.com"

# 备选数据库Sqlite \Mysql \ PostgreSQL
ENV DB_TYPE='Sqlite'
ENV DB_HOST='127.0.0.1'  
ENV DB_PORT='3306'  
ENV DB_USER='KAMIFKA'  
ENV DB_PASSWORD='PASSWORD'  
ENV DB_DATABASE='KAMIFKA'  

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN sed -i s@/deb.debian.org/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
    && apt-get clean && apt-get update \
    && apt-get -y install gcc && apt-get clean \
    && pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

COPY . .
RUN chmod +x docker-entrypoint.sh

EXPOSE 8000

ENTRYPOINT [ "/usr/src/app/docker-entrypoint.sh" ]

# ENTRYPOINT ["gunicorn","-k", "gevent", "--bind", "0.0.0.0:8000", "--workers", "8", "app:app"]


