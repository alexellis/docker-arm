import os
import json
import socket
import os.path

from flask import Flask, request, render_template, send_from_directory

app = Flask(__name__)

@app.route('/', methods=['GET'])
def sensors():
    props = {"hostname": host, "host_hostname": host_hostname}
    print(props)
    return render_template("kittens.html", props = props)

if( __name__ == '__main__'):

    host = socket.getfqdn()
    if(os.path.isfile("/etc/host.hostname")):
        f = open("/etc/host.hostname")
        host_hostname = f.read()
        f.close()
    else:
       host_hostname = host

    print("0.0.0.0")
    app.run(debug=True, host='0.0.0.0')
