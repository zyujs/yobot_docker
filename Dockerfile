FROM python:slim-buster
LABEL maintainer="zy"

ARG PUID=1000
ENV PYTHONIOENCODING=utf-8
RUN set -x \ 
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo 'Asia/Shanghai' >/etc/timezone \
        && { \
                echo "deb https://mirrors.aliyun.com/debian/ buster main contrib non-free"; \
                echo "deb https://mirrors.aliyun.com/debian/ buster-updates main contrib non-free"; \
                echo "deb https://mirrors.aliyun.com/debian/ buster-backports main contrib non-free"; \
                echo "deb https://mirrors.aliyun.com/debian-security/ buster/updates main contrib non-free"; \
        } > /etc/apt/sources.list \
        && apt-get update \
        && apt-get install git -y --no-install-recommends --no-install-suggests \
        && useradd -u $PUID -m bot \
        && su bot -c \
                "mkdir -p /home/bot \
                && { \
                        echo '#!/bin/sh'; \
                        echo 'cd /home/bot/yobot/src/client'; \
                        echo 'python3 main.py'; \
                        echo 'sh yobotg.sh &'; \
                        echo 'cd /home/bot/go-cqhttp'; \
                        echo './go-cqhttp'; \
                } > /home/bot/entry.sh \
		&& chmod 755 /home/bot/entry.sh \
		&& chmod +x /home/bot/entry.sh"
COPY ./yobot/src/client/requirements.txt /home/bot/
RUN set -x \
        && pip3 install --no-cache-dir -r /home/bot/requirements.txt -i https://mirrors.aliyun.com/pypi/simple

USER bot

WORKDIR /home/bot

ENTRYPOINT /home/bot/entry.sh
