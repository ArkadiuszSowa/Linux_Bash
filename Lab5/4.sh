#!/bin/bash
# Arkadiusz Sowa
# 300506
# Kalkulator

# z przyczyn dla mnie nie zrozumiałych 
# mój klakulator nie potrafi obsłużyć znaku *
# Pomino zapisu operatora jako \* 
# Warunek odpowiedzialny za to znajduje się w linii 35 i 36


rownanie=" $* "
nr_znaku=1;
poprawne="Poprawne wywolanie: $0 arg1 op /( arg2 op arg3 /) ..."
isInt=0;
isOp=0;

#sprawdzamy czy znak jest liczbą całkowitą
int() {
if [ "$1" -eq "$1" 2>/dev/null ]
then
	#echo "Liczba całkowita $1"
	return 0
else
	#echo "Błąd! Tylko liczby całkowite"
	#exit 2
	return 1
fi
}


#sprawdzamy czy znak jest operatorem
op(){
	# tutaj * nie spełnia warunku if, przez co mój klakulator nie działa w pełni sprawnie
	#if [ "$1" = "+" ] || [ "$1" = "-" ] || [ "$1" = "/" ] || [ "$1" = '*' ]
	if [[ "$1" = "+" || "$1" = "-" || "$1" = "/" || "$1" = "*" ]];
	then
		#echo "Operator $1"
		return 0
	else
		return 1 
	fi
}

nawias(){
if [ "$1" = "(" ]
then
	return 0
elif [ "$1" = ")" ]
then
	return 0
else
	return 1
fi
}




#zaczynamy od sprawdzenia czy wyrażenie posiada więcej niż minimalna ilość znaków
if [ $# -lt 3 ]
then
	echo "Wyrażenie za krótkie"
	echo $poprawne
	exit 1
fi 


#sprawdzamy poprawność pierwszego argumentu
if [ "$1" = "(" ]
then
	echo "numer znaku: $nr_znaku"
	echo "Równanie rozpoczyna się od nawiasu"
elif int $1
then
	echo "numer znaku: $nr_znaku"
	echo "Równanie rozpoczyna się od liczby całkowitej"
else 
	echo "Błąd! Niepoprawny pierwszy argument."
	echo $poprawne
	exit 2
fi

tmp=$rownanie
naw=0; #liczba nawiasów, lewy nawias +1, prawy -1
#sprawdzamy czy nie ma błędy związanego z nawiasami
for (( i=0; i<${#tmp}; i++ )); do
    char="${tmp:$i:3}"
    if [ "$char" = " ( " ]
    then
        naw=$((naw+1))
    fi
#    echo "nawiasy1: $naw"
    if [ "$char" = " ) " ]
    then
        naw=$((naw-1))
    fi
#   echo "nawiasy2: $naw"
    if [ "$naw" -gt 1 ]
    then
        echo "Błąd! Obsługiwany tylko jeden poziom nawiasów"
        exit 3
    fi
#    echo "nawiasy3: $naw"
    if [ "$naw" -lt 0 ]
    then
        echo "Błąd! Prawy nawias nie domknięty"
        exit 3
    fi
done
#echo "nawiasy po petli: $naw"

#sprawdzamy jeszcze dodatkowo, czy nie występuje nie domknięty lewy nawias
if [ "$naw" -gt 0 ]
then
    echo "Błąd! Lewy nawias nie domknięty"
    exit 3
fi

#pierwszy znak już jest sprawdzony, więc przewijamy


shift
nr_znaku=$((nr_znaku+1))


while [[ $1 ]] ;
do
echo "numer znaku: $nr_znaku"

#sprawdzam każdy znak, czy jest liczbą całkowitą, operatorem lub nawiasem 
if int $1; then
	echo "Liczba całkowita $1"
elif op $1; then
	echo "Operator $1"
elif nawias $1; then
	echo "Nawias $1"
else 
	echo "Błąd! Niepoprawny znak"
	echo $poprawne
	exit 4
fi

#sprawdzamy czy po operatorze występuje cyfra lub nawias
if op $1; then
	if op $2; then
		echo "Błąd! Po operatorze musi wystąpić liczba całkowita lub nawias"
		echo $poprawne
		exit 5
	fi
fi

#sprawdzmy czy dwie liczby nie występują po sobie
if int $1; then
	if int $2; then
		echo "Błąd! Liczba występuje po liczbie"
		echo $poprawne
		exit 5
	fi
fi

#sprawdzamy czy po nawiasie otwierajacym jest liczba
if [ "$1" = "(" ]; then
	if nawias $2; then
		echo "Błąd! Nawias występuje po nawiasie otwierającym"
		echo $poprawne
		exit 5
	fi
	
	if op $2; then
		echo "Błąd! Operator występuje po nawiasie otwierającym"
		echo $poprawne
		exit 5
	fi	
fi

#sprawdzamy czy po nawiasie zamykającym jest operator
if [ "$1" = ")" ]; then
	if nawias $2; then
		echo "Błąd! Nawias występuje po nawiasie zamykającym"
		echo $poprawne
		exit 5
	fi
	
	if int $2; then
		echo "Błąd! Liczba występuje po nawiasie zamykającym"
		echo $poprawne
		exit 5
	fi	
fi

#rozpatrujemy kolejny znak 
shift
nr_znaku=$((nr_znaku+1))
done

#wyświetlamy wynik i równanie na ekran
wynik=`expr $rownanie`
echo "$rownanie = $wynik"

#exit 1: Zbyt krótkie wyrażenie
#exit 2: Błędny pierwszy znak
#exit 3: Błąd związany z nawiasami
#exit 4: Użycie błędnego znaku
#exit 5: Zła kolejność znaków
