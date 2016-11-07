FROM alexellis2/python2-gpio-armhf:2-dev

ENTRYPOINT []
RUN pip install flask

WORKDIR /root/
COPY app.py app.py
EXPOSE 5000

CMD ["python2", "./app.py"]
