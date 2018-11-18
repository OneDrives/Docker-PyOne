FROM python:2.7.15-jessie
 
WORKDIR /

RUN mkdir -p /root/PyOne
COPY PyOne/ /root/PyOne

WORKDIR /root/PyOne/

RUN pip install -r requirements.txt && \
  cp config.py.sample config.py && \
  cp supervisord.conf.sample supervisord.conf && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
  echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list && \
  apt-get update && \
  apt-get install -y mongodb-org redis-server && \
  rm -rf /var/lib/apt/lists/*
	
COPY start.sh /

EXPOSE 345567

ENTRYPOINT ["/start.sh"]
