#!/bin/zsh
#Oświadczam, że niniejsza praca stanowiąca podstawę do uznania osiągnięcia efektów uczenia się z przedmiotu Użytkowanie systemu UNIX została wykonana przeze mnie samodzielnie.
#Arkadiusz Sowa
#300506

poprawne="Poprawne wywołanie: $0 [-a] plik kolumna1 kolumna2..."
opcja_a=0
plik=0

if [ $# -gt 0 ] ;
then
	plik="$1"
else
	echo "Za mało argumentów"
	echo $poprawne
	exit 1
fi

if [ $# -gt 1 ] ; 
then
	if [ "$1" = "-a" ] ;
	then
		opcja_a=1 #wybrano opcje -a oraz występuje nazwa pliku
		plik="$2"
		shift
	fi
fi 

shift
#teraz od @1 do końca mamy tylko numery kolumn

#Sprawdzamy czy podany plik istnieje oraz czy nie jest to katalog
if [[ ! -f "$plik" ]] ;
then 
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
fi

#sprawdzamy poprawność wpisanych kolumn
for i in "$@"
do
    if ! [ "$i" -eq "$i" 2>/dev/null ]
    then
    	echo "Błąd! Kolumny mogą być tylko liczbami całkowitymi"
        echo $poprawne
        exit 2
    fi
done


columny="$@"
#echo $columns
awk -F " |\t" -v a="$opcja_a" -v col="$columny" \
'BEGIN {
    s_all = 0;
    split(col, tablica, " ");
}
{ 
    s = 0;
    
    if (length (col) == 0)
    {
        for(i = 1; i <= NF; ++i) { 
            s += $i
        };
 
    }
    else {
		tab=1;
		# length (col) liczy także spacje jako znak więc długość będzie liczbą nie parzystą
		# natomiast elementy tablicy tablica to koljne liczby
		# które chcemy sumować, dlatego trzeba je iterować co 1
        for(i = 1; i <= length (col); i=i+2) {
				#print $tablica[tab];
				#print "UP"
				s += $tablica[tab];
				tab++
        };
    }
    s_all += s;
    print s;
} 
END {
    if (a==1){
		printf "Suma liczb z kolumny wynikowej: ";
        print s_all;
	}
}' "$plik"


