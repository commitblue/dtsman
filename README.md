# dtsman
your tool to automatically generate a .d.ts file into your localsystem for
roblox-ts
# Why
Currently, plugins to generate .d.ts code on an object exists, whats wrong with it?
1. It dosen't directly sync it to the file system
2. you will have to smash that generate button, copy paste it to your file system,
So i wanted something more automatic. Here it is.
# How do we use it?
very easily. firstly, you should install the .zip at releases
and unpack it,
it should look like this when you unpack it
![screenshot](/readmeimages/Screenshot_1.png)
now open your search bar and type in "edit the system environment variables" or if you
dont have administrator rights, "edit environment variables for your account"
copy the directory path to your dtsman file
e.g.
"C:\Users\You\Downloads\dtsman\"
(NOT THE EXE FILE ITSELF)
now open that env vars window, and open path and then click "new"
and add your dir path to dtsman
![screenshot2](/readmeimages/Screenshot_2.png)
![screenshot3](/readmeimages/Screenshot_3.png)
Click Ok.
Click Ok.
now open your main terminal and then to verify that dtsman works,
type in "dtsman" and press enter.
![screenshot4](/readmeimages/Screenshot_4.png)
It should say something like this.
now that you completely verified dtsman is installed + works,
we start running it in our terminal
We should type something like this
![screenshot5](/readmeimages/Screenshot_5.png)
Hit enter
The first argument is the path to your .d.ts file, the second is the port for the server.
If a popup like "Windows defender has prevented your program from etc etc", Just allow
access or ignore it.
