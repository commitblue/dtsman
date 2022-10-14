import sys
args = str(sys.argv)
args.pop(0)
print(args)
if (args == []):
    print("\nWelcome to dts man\nTo start, the arguments for this program are\n1. dts path file to create\n2.http server link to host at\nexample: dtsman C:\\myrobloxproject\\objects.d.ts localhost://8080")