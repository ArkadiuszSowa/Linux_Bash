#!/bin/zsh
#Oświadczam, że niniejsza praca stanowiąca podstawę do uznania osiągnięcia efektów uczenia się z przedmiotu Użytkowanie systemu UNIX została wykonana przeze mnie samodzielnie.
#Arkadiusz Sowa
#300506

poprawne="Poprawne wywołanie: $0 plik tekst1 tekst2"
i=1

#sprawdzamy czy instrukcja została prawodiłowo wywyołana
if [[ $# -ne 3 ]] ;
then
	echo "Błędna liczba argumentów"
	echo $poprawne
	exit 1
fi

#Sprawdzamy czy podany plik istnieje oraz czy nie jest to katalog
if [[ -f "$1" ]] ;
then 
	echo "Podany plik istnieje"
else
    echo "Plik nie istnieje"
    echo $poprawne
    exit 2
fi

#Sprawdzamy uprawnienia katalogu
if [ ! -w $pwd ] ;
then
	echo "Brak uprawnienia do pisania w katalogu"
	echo $poprawne
	exit 3
elif [ ! -x $pwd ] ;
then 
	echo "Brak uprawnienia do wykonywania katalogu"
	echo $poprawne
	exit 4
else 
	echo "Odpowiednie uprawnienia katalogu"
fi


if [[ -r "$1" ]] ;
then 
	echo "Plik zostaje odczytany"
else
    echo "Brak uprawenień do odczytu pliku"
    echo $poprawne
    exit 3
fi

#szukamy numeru dla nowego pliku
while [[ -f "$1.$i" ]] ;
do
	i=$((i+1))
done

sed -e "s/$2/$3/g" $1 > $1.$i
echo "Nowy plik $1.$i"



