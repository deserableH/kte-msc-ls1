#!/bin/bash

echo "---Creation d'un nouvelle utilsiateur---"
echo "login :"
read login
log_db=`sqlite3 ./card_manager.db "SELECT login FROM Profile where login = \"$login\""`
while [ "$login" == "$log_db" ]
do
	echo "Login deja utilise, Entrez un nouveau login :"
	read login
done
echo "mot de passe :"
read mdp
while [ -z $mdp ]
do
	echo "mot de passe :"
	read mdp
done
echo "Nom :"
read nom
echo "Entreprise :"
read entr
echo "e-mail :"
read mail
echo "Telephone :"
read tel

if `sqlite3 ./card_manager.db "INSERT INTO Profile (login, mdp, name, company, email, telephone) VALUES (\"$login\",\"$mdp\",\"$nom\",\"$entr\",\"$mail\",\"$tel\");"`
then	
	echo "Creation de l'utilsateur avec succes."
	exit 0
else
	echo "Erreur lors de la creation de l'utilisateur, veuiller recomencer"
	exit 1
fi
exit 0
