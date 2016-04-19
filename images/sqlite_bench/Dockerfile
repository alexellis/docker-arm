FROM alexellis2/node4.x-arm

RUN useradd bench -G adm -m -s /bin/bash
WORKDIR /home/bench/
USER bench
RUN mkdir -p /home/bench/sqlite_bench
RUN /bin/bash -c "time (npm init -y && npm install --save sqlite3)"

CMD ["/bin/bash"]
