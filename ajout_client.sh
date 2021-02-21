#!/bin/bash

login=$1
user=$2
if [ -z "$user" ]
then
	echo "---Creation d'une nouvelle carte cliente---"
	echo "Nom :"
	read nom
	echo "Entreprise :"
	read entr
	echo "e-mail :"
	read mail
	echo "Telephone :"
	read tel
else
	user_db=`sqlite3 ./card_manager.db "SELECT login FROM Profile where login = \"$user\""`
	if [ "$user" == "$user_db" ]
	then
		nom=`sqlite3 ./card_manager.db "SELECT name FROM Profile where login = \"$user\""`
		entr=`sqlite3 ./card_manager.db "SELECT company FROM Profile where login = \"$user\""`
		mail=`sqlite3 ./card_manager.db "SELECT email FROM Profile where login = \"$user\""`
		tel=`sqlite3 ./card_manager.db "SELECT telephone FROM Profile where login = \"$user\""`
	else
		echo "Utilisateur non existant, abandon de l'ajout du client"
		exit 1
	fi
fi
id=`sqlite3 ./card_manager.db "SELECT MAX(id) FROM card;"`
if [ -z $id ]
then
	id=0
else
	id=$(($id+1))
fi

if `sqlite3 ./card_manager.db "INSERT INTO card (id, name, company, email, telephone, login) VALUES (\"$id\",\"$nom\",\"$entr\",\"$mail\",\"$tel\",\"$login\");"`
then	
	echo "Creation de la carte cliente avec succes."
	exit 0
else
	echo "Erreur lors de la creation de la carte cliente, veuiller recomencer"
	exit 2
fi
exit 0
