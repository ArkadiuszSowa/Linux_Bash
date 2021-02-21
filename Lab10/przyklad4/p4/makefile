#Oświadczam, że niniejsza praca stanowiąca podstawę do uznania osiągnięcia efektów uczenia się z przedmiotu Użytkowanie systemu UNIX została wykonana przeze mnie samodzielnie.
#Arkadiusz Sowa
#300506


all:
	cd lib;make "CFLAGS=-DZESPOLONE -O -I../headers"
	
	cd src1;make "CFLAGS=-DZESPOLONE -O -I../headers"
	
	cd src2;make "CFLAGS=-DZESPOLONE -O -I../headers"

install:
	mkdir -p ./bin
	
	install ./src1/prog1 ./src2/prog2 ./bin
	
	
clean:
	cd lib; make clean
	
	cd src1; make clean
	
	cd src2; make clean
	
	if [ -d "./bin" ]; then rm -R ./bin; fi
