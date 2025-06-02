#!/usr/bin/bash

GREEN="\e[32m"
PURPLE="\e[35m"
RESET="\e[0m"

echo -e "${PURPLE}Welcome to AuditApp${RESET}"

while true; do
	echo -e "${PURPLE}1) Successful logins${RESET}"
	echo -e "${PURPLE}2) Failed logins${RESET}"
	echo -e "${PURPLE}3) Logoffs${RESET}"
	echo -e "${PURPLE}4) Display current users${RESET}"
	echo -e "${PURPLE}5) Display added users${RESET}"
	echo -e "${PURPLE}6) User deletions${RESET}"
	echo -e "${PURPLE}7) Show locked accounts${RESET}"
	echo -e "${PURPLE}8) Password changes/Identity changes${RESET}"
	echo -e "${PURPLE}9) Privileged users${RESET}"
	echo -e "${PURPLE}10) Exit app${RESET}"
	read -p "Please select your audit check [1-10]: " choice

	case $choice in
		1)
			echo -e "${GREEN}"
	 		read -p "Enter start date (i.e. 5/15/2025): " date
			ausearch --start $date -m USER_AUTH --success yes | awk '{print $1, $2, $3, $4, $5, $11, $16}'
			echo -e "${RESET}"
			;;
		2)
			echo -e "${GREEN}"
			read -p "Enter start date (i.e. 5/15/2025): " date
			ausearch --start $date -m USER_AUTH --success no | awk '{print $1, $2, $3, $4, $5, $11, $16}'
			echo -e "${RESET}"
			;;
		3)
			echo -e "${GREEN}"
			read -p "Enter start date (i.e. 5/15/2025): " date
			ausearch --start $date -m USER_END | awk '{print $1, $2, $3, $4, $5, $11, $12}'
			echo -e "${RESET}"
			;;
		4)
			echo -e "${GREEN}"
			grep "bash$" /etc/passwd | awk -F ':' '{print $1}'
			echo -e "${RESET}"
			;;
		5)
			echo -e "${GREEN}"
			read -p "Enter start date (i.e. 5/15/2025): " date
			ausearch --start $date -m ADD_USER | awk '{print $1, $2, $3, $4, $5, $10}'
			echo -e "${RESET}"
			;;
		6)
			echo -e "${GREEN}"
			read -p "Enter start date (i.e. 5/15/2025): " date
                        ausearch --start $date -m DEL_USER | awk '{print $1, $2, $3, $4, $5, $10}'
			echo -e "${RESET}"
                        ;;
		7)
			echo -e "${GREEN}"
			for i in `grep "bash$" /etc/passwd | awk -F ':' '{print $1}'`; do
				userData=$(passwd -S $i | awk '{print $2}')
				if [ $userData == "LK" ]; then
					echo "$i is locked."
				fi
			done
			echo -e "${RESET}"
			;;
		8)	
			echo -e "${GREEN}"
			read -p "Enter start date (i.e. 5/15/2025): " date
			ausearch --start $date -k identity
			echo -e "${RESET}"
			;;
		9)
			echo -e "${GREEN}"
			lid -g wheel
			echo -e "${RESET}"
			;;
		10)
			echo -e "${PURPLE}Exiting RAND audit app.${RESET}"
			exit 0
			;;
	esac
done

### MADE BY CODY PASCUAL ###
