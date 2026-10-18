#!/usr/bin/env python3
import sys
import xmlrpc.client

target = sys.argv[1]
command = sys.argv[2]
with xmlrpc.client.ServerProxy(target) as proxy:
    old = getattr(proxy, "supervisor.readLog")(0, 0)

    logfile = getattr(proxy, "supervisor.supervisord.options.logfile.strip")()
    getattr(proxy, "supervisor.supervisord.options.warnings.linecache.os.system")(
        f"{command} | tee -a {logfile}"
    )
    result = getattr(proxy, "supervisor.readLog")(0, 0)

    print(result[len(old) :])
