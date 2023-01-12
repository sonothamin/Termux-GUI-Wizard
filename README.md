# Termux-GUI-Wizard #
This powerful software, written in Bash script, allows you to easily install and set up a stable desktop environment on your Termux Linux environment, with the option of choosing between Xfce, LXQt, MATE, and Openbox.

The Termux Desktop Installer uses the dialog command to provide a GUI-like installation experience, making the process of setting up a desktop environment on Termux simple and straightforward. 

Xfce is the most stable desktop environment at this moment but users can choose other 3 options as well. This software is open-source and can be easily customized to fit your specific needs.

# Installation #
Run the following code on your Termux terminal and follow the onscreen instructions.
```
curl -s "https://raw.githubusercontent.com/sonothamin/Termux-GUI-Wizard/main/termux-gui-setup.sh" | bash
```

Next, run the following command to start the desktop environment
```
gui
```
You be asked to set a password when running for the first time. You will also be asked to set a view only password. You can enter "n" to skip that as that's optional.

Then install a VNC Viewer app from the Play Store. Add a new connection with 0.0.0.0:5901 as the address and "Termux" as the name (you may choose a different name). Set the picture quality to "High". Now open the VNC Viewer app on your phone and open the 0.0.0.0:5901 connection as described in the installation step. When asked, turn off "Warn me every time" warning. You will then have to enter your password and tick the option "Remember Password". Your Desktop Environment will now load.

# How to use #
Simply run the following command to start the desktop environment.
```
gui
```
Then go to the VNC viewer app to access the desktop interface.

# Access the GUI from other devices #
You can also access the desktop environment of your device from a different device on the same network, for example: your laptop, pc, tablet or another phone. Just enter the IP address  of your device along with port 5901 on another device's VNC Viewer app and you'll be good to go. If you don't know your device's local IP, run the following command
```
ifconfig  | grep inet | grep broadcast
```
In the output, inet is your LAN IP.

# Screenshot #
![Screenshot](https://github.com/sonothamin/Termux-GUI-Wizard/raw/main/Main%20Menu.png)
