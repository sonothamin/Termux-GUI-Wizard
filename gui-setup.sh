#!/data/data/com.termux/files/usr/bin/bash

export USER=$(whoami)
HEIGHT=0
WIDTH=0
CHOICE_HEIGHT=2
BACKTITLE="Termux GUI Installation"
TITLE="Select GUI options"
MENU="Select an option from below"

OPTIONS=( 1 "Install XFCE4 Desktop Environment" 
          2 "Install MATE Desktop Environment (UNSTABLE)"
          3 "Install LXQt Destop Environment  (UNSTABLE)"
	  4 "Install OpenBox Window manager   (UNSTABLE)")

CHOICE=$(dialog --clear \
	--backtitle "$BACKTITLE" \
	--title "$TITLE" \
	--menu "$MENU" \
	$HEIGHT $WIDTH $CHOICE_HEIGHT \
	"${OPTIONS[@]}" \
	2>&1 >/dev/tty)

clear
case $CHOICE in
	1)
		apt update && apt upgrade -y 
		apt update && apt install x11-repo
		apt update && apt upgrade -y
		apt install tigervnc xfce4 xfce4-goodies cowsay -y
		echo "#!/data/data/com.termux/usr/bin/bash" > gui
		echo "vncserver -kill :1" >> gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'xfce4-session --display=":1"' >> gui
		chmod +x gui
		CP gui $PREFIX/bin
        clear
          	
            ICONOPTIONS=(1 "Papirus Icon Theme" 
                     2 "Fluent Icon Theme")
            
            ICONCHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "Select Icon to install" \
			--menu "$MENU" \
			$HEIGHT $WIDTH "2" \
			"${ICONOPTIONS[@]}" \
			2>&1 >/dev/tty)

		clear
		case $ICONCHOICE in
			1)  clear
                	apt install papirus-icon-theme   -y                   
        		;;

			2)  clear
                	apt install fluent-icon-theme   -y
			;;

		esac      

        THEMEOPTIONS=( 1 "Fluent GTK Theme"
                       2 "Adwaita GTK Theme")
            
            THEMECHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "Select theme to install" \
			--menu "$MENU" \
			$HEIGHT $WIDTH "2" \
			"${THEMEOPTIONS[@]}" \
			2>&1 >/dev/tty)

		clear
		case $THEMECHOICE in
			1)  apt install fluent-gtk-theme -y  
			    cowsay "To change theme run gui and /n xfconf-query -c xsettings -p /Net/ThemeName -s "Greybird""
        		;;

			2)  clear
			    apt install adwaita-icon-theme
               		    cowsay "Adwaita comes pre-installed with xfce4 on Termux."
			    sleep 3             
			;;

		esac   

		cmd=(dialog  --backtitle "$BACKTITLE" --title "Select additional softwares to install" --separate-output --checklist "Select options (multiple options can be selected):" 22 76 16)
                options=(1 "Geany  -  Fast and lightweight IDE" off    
                         2 "HexChat -  A popular and easy to use graphical IRC client" off
						 3 "NetSurf -  A free, open source web browser" off)

                choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                clear
                for choice in $choices
                do
                    case $choice in
                        1) echo "Installing Geany"
                           apt install geany -y
                            ;;
                        2)
                            echo "Installing HexChat"
                            apt install hexchat -y
                            ;;

                        3) echo "NetSurf -  A free, open source web browser"
                           apt install netsurf -y

                    esac
                done   
    
		cowsay 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server if you are running for the first time'
        
        ;;

	2)	#Mate installation        
        apt update && apt upgrade -y && apt update && apt install x11-repo && apt update && apt upgrade -y 
		apt install tigervnc mate-* marco	-y
		echo "#!/data/data/com.termux/usr/bin/bash" > gui
		echo "vncserver -kill :1" >> gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'mate-session --display=":1"' >> gui
		chmod +x gui
		cp gui $PREFIX/bin
        clear && cowsay 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server if you are running for the first time'    
		;;

	3) #LXQt installation
        apt update && apt upgrade -y && apt update && apt install x11-repo && apt update && apt upgrade -y 
		apt install tigervnc lxqt -y
		echo "#!/data/data/com.termux/usr/bin/bash" > gui
		echo "vncserver -kill :1" >> gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'lxqt-session --display=":1"' >> gui
		chmod +x gui
		cp gui $PREFIX/bin
        cmd=(dialog  --backtitle "$BACKTITLE" --title "Select additional softwares to install" --separate-output --checklist "Select options (multiple options can be selected):" 22 76 16)
                options=(1 "Geany  -  Fast and lightweight IDE" off    
                         2 "HexChat -  A popular and easy to use graphical IRC client" off
						 3 "NetSurf -  A free, open source web browser" off)
                         4 "Mate Terminal - Terminal emulator for MATE." on
                choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                clear
                for choice in $choices
                do
                    case $choice in
                        1) echo "Installing Geany"
                           apt install geany -y
                            ;;
                        2)
                            echo "Installing HexChat"
                            apt install hexchat -y
                            ;;

                        3) echo "Installing NetSurf"
                           apt install netsurf -y
                            ;;
                        
                        4) apt install mate-terminal -y
                            ;;

                    esac
                done   
            clear && cowsay 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server if you are running for the first time'    
		
		;;

    4)  echo "working on it"
		apt update && apt upgrade -y 
		apt update && apt install x11-repo
		apt update && apt upgrade -y
		apt install tigervnc openbox pypanel xorg-xsetroot cowsay -y
		echo "#!/data/data/com.termux/usr/bin/bash" > gui
		echo "vncserver -kill :1" >> gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'openbox-session' >> gui
		chmod +x gui
		cp gui $PREFIX/bin
 	        clear && cowsay 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server if you are running for the first time'    
		;;
esac
