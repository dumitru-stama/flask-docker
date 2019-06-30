from flask import Flask
import os
import socket

app = Flask(__name__)

@app.route("/")
def root():
    return "<h3>Flask Docker test</h3><b>Host:</b> {host}<br/>".format(host=socket.gethostname())

if __name__ == "__main__":
    app.run()

