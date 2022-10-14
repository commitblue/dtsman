import sys
args = sys.argv
args.pop(0)
if (args == []):
    print("\nWelcome to dts man\nTo start, the arguments for this program are\n1. dts path file to create\n2.http server link to host at\nexample: dtsman C:\\myrobloxproject\\objects.d.ts localhost://8080")
else:
    path = args[0]
    httpServer = args[1]
    print("Hosting at {0} and waiting for response to write {1}\nUse the roblox plugin and type in the http link and select the object you want to convert into .d.ts and tada\npress ctrl + C to stop\n".format(httpServer, path))