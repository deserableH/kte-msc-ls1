#!/bin/bash

login=$1

echo "---Affichage des cartes clientes---"

for id in $(sqlite3 ./card_manager.db "SELECT id FROM card WHERE login = \"$login\";")
do
	echo "-Carte numero : $id -"
	nom=`sqlite3 ./card_manager.db "SELECT name FROM card WHERE id = \"$id\";"`
	echo "Nom : $nom"
	entr=`sqlite3 ./card_manager.db "SELECT company FROM card WHERE id = \"$id\";"`
 	echo "Entreprise : $entr"
	mail=`sqlite3 ./card_manager.db "SELECT email FROM card WHERE id = \"$id\";"`
	echo "E-mail : $mail"
	tel=`sqlite3 ./card_manager.db "SELECT telephone FROM card WHERE id = \"$id\";"`
	echo "Telephone : $tel"
       	echo "---"	
done
exit 0

