#!/bin/zsh
#Arkadiusz Sowa
#300506

typ() {
	case $1 in
		b ) return 0 ;; 
		d ) return 0 ;; 
		f ) return 0 ;;
		l ) return 0 ;; 
		p ) return 0 ;; 
		* ) return 1 ;;
	esac
}

poprawne="Poprawne wywołanie $0 [-R] katalog [typ]"
typ="Typy:
d - katalogi
f - pliki zwykłe
l - dowiązania
p - FIFO
b - blok specjalny
"

if [[ $# -lt 1 || $# -gt 3 ]]
then
    echo $poprawne
    echo $typ
    exit 1
fi

R=0
kat="$1"
typ="brak"

if [ "$1" = "R" ]
then
	#jeżeli pierwszy argument "R" to instrukcja musi mieć minimum dwa argumenty 
	if [ $# -lt 2 ] 
	then 
	    echo $poprawne
		exit 1
	fi
	
	R=1
	kat="$2"
	
	#jeżeli mamy 3 argumenty, i wiemy już że 1 to R, to trzecim argumentem musi być typ
	if [ $# -eq 3 ]
	then
		if typ() $3; then 
		typ="$3"
		else
		echo $typ
		exit 1
		fi
	fi

#jeżeli są 2 arg i nie ma R to drugi arg musi być typem
elif [ $# -eq 2 ]
then 
	if typ() $2; then 
		typ="$2"
		else
		echo $typ
		exit 1
	fi
fi
		
#Sprawdzamy czy podany katalog istnieje oraz czy nie jest to katalog
if [[ -d "$kat" ]] ;
then 
	echo "Podany katalog istnieje"
else
    echo "Katalog nie istnieje"
#    echo $poprawne
    exit 2
fi

#Sprawdzamy uprawnienia katalogu
if [ ! -r "$kat" ] ;
then
	echo "Brak uprawnienia do czytania katalogu"
	echo $poprawne
	exit 3
elif [ ! -x "$kat" ] ;
then 
	echo "Brak uprawnienia do wykonywania katalogu"
	echo $poprawne
	exit 4
else 
	echo "Odpowiednie uprawnienia katalogu"
fi


if [ $# -eq 1 ]
then
wynik=`ls -Al $kat 2>/dev/null | grep "^[bcdflps-]" | wc -l`
#echo "[ $# -eq 1 ] "
fi

if [[ $R -eq 1 && $typ = "brak" ]]
then
wynik=`ls -AlR $kat 2>/dev/null | grep "^[bcdflps-]" | wc -l`
#echo " $R -eq 1 && $typ = brak"
fi

if [[ $R -eq 1 && $typ != "brak" ]]
then
wynik=`ls -AlR $kat 2>/dev/null | grep "^$typ" | wc -l`
#echo " $R -eq 1 && $typ != "brak" "
fi

if [[ $R -eq 0 && $typ != "brak" ]]
then
wynik=`ls -Al $kat 2>/dev/null | grep "^$typ" | wc -l`
#echo " $R -eq 0 && $typ != "brak""
fi

echo "Liczba plików: $wynik"
