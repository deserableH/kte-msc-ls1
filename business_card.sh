#!/bin/bash

#Creation de la base de donn√es si elle n'exixste pas
cd ${0%business_card.sh}
if [ ! -e ./card_manager.db ]
then
	if ! `sqlite3 ./card_manager.db < ./init_db.sql`
	then
		echo "Erreur lors de l'initialisation de la base de donnees"
		exit 1
	else
		echo "Creation de la base de donnees"
	fi
fi
	
#affichage du premier menu pour creer un utilisateur ou ce connecter
echo "---Bienvenue dans le business card manager !---"
echo "1 - Nouveau utilisateur (creation de compte)"
echo "2 - Connexion"
echo "3 - Quitter"
echo "Entrez le numero du menu :"

read menu1

case $menu1 in
	1) ./new_utilisateur.sh;;
	2) echo "---Connexion---"
	#demmande de conexion avec login et mot de passe
	echo "Entrez votre login :"  
	read login
	echo "Entrez votre mot de passe"
	read mdp
	log_db=`sqlite3 ./card_manager.db "SELECT login FROM Profile where login = \"$login\""`
	mdp_db=`sqlite3 ./card_manager.db "SELECT mdp FROM Profile where login = \"$login\""`
	#verification des informations donnes
	if [ "$login" != "$log_db" ] || [ "$mdp" != "$mdp_db" ]
	then
		echo "login ou mot de passe incorrect"
		exit 1
	else
		echo "Connexion reussie"
		echo ""
		menu2="0"	
		
		#Affichage du deuxieme menu
		while [ "$menu2" != "5" ]
		do
			echo ""
			echo "---Menu---"
			echo "1 - Afficher Information"
			echo "2 - Ajouter un client"
			echo "3 - Ajouter un utilisateur comme client"
			echo "4 - Afficher les infos d'un client"
			echo "5 - Deconexion"
			read menu2
	
			case $menu2 in
				1) echo "---Affichage de vos information---"
				name=`sqlite3 ./card_manager.db "SELECT name FROM Profile where login = \"$login\""`
				echo "Nom : $name"
				entr=`sqlite3 ./card_manager.db "SELECT company FROM Profile where login = \"$login\""`
				echo "Entreprise : $entr"
				mail=`sqlite3 ./card_manager.db "SELECT email FROM Profile where login = \"$login\""`
 				echo "E-mail : $mail"
				tel=`sqlite3 ./card_manager.db "SELECT telephone FROM Profile where login = \"$login\""`
				echo "Telephne : $telephone"
				echo "";;
				2) ./ajout_client.sh $login;;
				3) echo "---Ajout d'un utilisateur comme client---"
				echo "Entrez le login de l'utilisateur :"
				read user
				./ajout_client.sh $login $user;;
				4) ./afficher_fiches_clients.sh $login;;
				5) exit 0;;
				*) echo "Erreur de saisie";;	
			esac
		done

	fi;;	
	3) exit 0;;
	*) echo "Erreur de saisie";;
esac
exit 0
