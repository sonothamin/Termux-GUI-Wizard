#!/data/data/com.termux/files/usr/bin/bash

export USER=$(whoami)
HEIGHT=0
WIDTH=400
CHOICE_HEIGHT=2
BACKTITLE="Termux GUI Installation"
TITLE="Select GUI options"
MENU="Select an option from below"

x11(){     
           apt update && apt upgrade -y
	   if dialog --stdout --title "Do you want to switch to a faster mirror?" --backtitle "$BACKTITLE" --yesno "Switching to a faster mirror will speed up the installation process and might make your apt download faster. This program will use the built in pkg tool for this process. Allthough, it is optional" 10 70 ;
			then clear && pkg --check-mirror update 
			else echo "OK, See ya sucker." && clear
	   fi
	   apt update && apt upgrade -y
	   apt install x11-repo -y && apt update -y
	   apt install tigervnc -y
	   }
	   
softwares(){
			 cmd=(dialog  --backtitle "$BACKTITLE" --title "Select additional softwares to install" \
	                      --separate-output --checklist "Select options (multiple options can be selected):" 22 90 16)
             
             options=(1 "Geany  -  Fast and lightweight IDE" off    \
                         2 "HexChat -  A popular and easy to use graphical IRC client" off\
						 3 "NetSurf -  A free, open source web browser" off\
                         4 "Mate Terminal - Terminal emulator for MATE." off\
                         5 "Firefox - A Modern Web Browser" off\
                         6 "DOSBox - MS-DOS Emulator" off
                         7 "Parole Media Player" off)
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
						5) apt install firefox -y
							;;
						6) apt install dosbox -y 
							;;
						7) apt install parole -y
                    esac
                 done
			}
			
endscreen(){
			dialog --title "$TITLE" --msgbox 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server when you are running for the first time.' 10 40
			}

theme(){
	    THEMEOPTIONS=( 1 "Fluent GTK Theme"
                       2 "Adwaita GTK Theme")
            
            THEMECHOICE=$(dialog --clear \
			--backtitle "$BACKTITLE" \
			--title "Select theme to install" \
			--menu "$MENU" \
			$HEIGHT $WIDTH "2" \
			"${THEMEOPTIONS[@]}" \
			2>&1 >/dev/tty)

		case $THEMECHOICE in
			1)  apt install fluent-gtk-theme -y  
			    dialog --title "$TITLE" --msgbox "To change theme launch gui and go to Applications>>Settings>>Appearance" 10 30
        		;;

			2)  clear
			    apt install adwaita-icon-theme
                dialog --title "$TITLE" --msgbox "Adwaita comes pre-installed with xfce4 on Termux." 10 30
			;;

		esac   

	    }

icons(){
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
           		    dialog --title "$TITLE" --msgbox "To change icon theme launch xfce4 and go to Applications>>Settings>>Appearance" 10 30
        		;;

			2)  clear
                            apt install fluent-icon-theme   -y
			    dialog --title "$TITLE" --msgbox  "To change icon theme launch xfce4 and go to Applications>>Settings>>Appearance" 10 30
        		;;

		esac
		}

xfce(){ 
		echo "Installing Xfce4"
		x11
		apt install xfce4 xfce4-goodies -y
		echo "vncserver -kill :1" > gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'xfce4-session --display=":1"' >> gui
		chmod +x gui
		cp gui $PREFIX/bin/
        clear
	   }

mate(){
	    echo "Mate installation"
	    x11
		apt install mate-* marco	-y
		echo "vncserver -kill :1" > gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'mate-session --display=":1"' >> gui
		chmod +x gui
		cp gui $PREFIX/bin
        dialog --title "$TITLE" --msgbox 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server if you are running for the first time'   
	   }

LXQT(){ 
		x11
		apt install lxqt -y
		echo "vncserver -kill :1" > gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'lxqt-session --display=":1"' >> gui
		chmod +x gui
		cp gui $PREFIX/bin
		dialog --title "$TITLE" --msgbox 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server if you are running for the first time'   
	   }

openbox(){
		echo "Installing OpenBOX"
		apt install tigervnc openbox pypanel xorg-xsetroot cowsay -y
		echo "#!/data/data/com.termux/usr/bin/bash" > gui
		echo "vncserver -kill :1" >> gui
		echo "vncserver :1" >> gui
		echo 'export DISPLAY=":1"' >> gui
		echo 'openbox-session' >> gui
		chmod +x gui
		cp gui $PREFIX/bin	
		dialog --title "$TITLE" --msgbox 'Use "gui" command to start a GUI Session. You will have to set a password for the VNC server if you are running for the first time'     
		  }

main(){
		OPTIONS=(               1 "Install XFCE4 Desktop Environment" \
					2 "Install MATE Desktop Environment (UNSTABLE)"\
					3 "Install LXQt Destop Environment  (UNSTABLE)"\
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
		                1) xfce ;;
				2) mate ;;
				3) LXQT ;;
				4) openbox ;;
		esac
	}
main
icons
theme
softwares
endscreen
clear
