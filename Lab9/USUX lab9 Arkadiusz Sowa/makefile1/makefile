#Arkadiusz Sowa
#300506

OBJECTS = delta.o pierw.o rkw.o
CC= gcc
HDRS = ./include
CFLAGS= -g -DZESPOLONE -I$(HDRS)
LIBS = -lm

prog : $(OBJECTS)
	$(CC) $(OBJECTS) $(LIBS) -o prog
 
 
delta.o : $(HDRS)/fun.h


pierw.o : $(HDRS)/fun.h


rkw.o : $(HDRS)/rkw.h $(HDRS)/fun.h


clean:
	rm -f *.o prog
