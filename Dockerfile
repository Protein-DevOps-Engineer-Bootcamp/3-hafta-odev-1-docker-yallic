FROM python:3.8

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY app/. /usr/src/app/
COPY requirements.txt /usr/src/app/


RUN pip3 install -r requirements.txt

EXPOSE 5000

CMD [ "python3", "./app.py"]
