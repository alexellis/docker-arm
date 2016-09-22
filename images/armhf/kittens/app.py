import os
import json
import socket

from flask import Flask, request, render_template, send_from_directory

app = Flask(__name__)

@app.route('/', methods=['GET'])
def sensors():
    host = socket.getfqdn()

    props = {"hostname": host, "host_hostname": host_hostname}
    print(props)
    return render_template("kittens.html", props = props)

if __name__ == '__main__':
    f = open("/etc/host.hostname")
    host_hostname = f.read()
    f.close()
    print("0.0.0.0")
    app.run(debug=True, host='0.0.0.0')
