FROM python:2.7.15-jessie
 
WORKDIR /

RUN mkdir -p /root/PyOne /data/db /data/log
COPY PyOne/ /root/PyOne

WORKDIR /root/PyOne/

RUN pip install -r requirements.txt && \
  pip install supervisor && \
  cp config.py.sample config.py && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
  echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list && \
  apt-get update && \
  apt-get install -y mongodb-org redis-server && \
  rm -rf /var/lib/apt/lists/*
	
COPY supervisord.conf /

EXPOSE 34567

CMD ["supervisord" "-c" "supervisord.conf"]
