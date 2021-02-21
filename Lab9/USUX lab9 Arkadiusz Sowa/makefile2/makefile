#Arkadiusz Sowa
#300506

#OBJECTS = delta.o pierw.o rkw.o
CC= gcc
HDRS = ./include
CFLAGS= -g -DZESPOLONE -I$(HDRS)
LIBS = -lm
AR = ar
LIB_NAME = libusux.a



prog : rkw.o $(LIB_NAME) 
	$(CC) rkw.o $(LIB_NAME) $(LIBS) -L. -o prog
 
 
delta.o : $(HDRS)/fun.h


pierw.o : $(HDRS)/fun.h


rkw.o : $(HDRS)/rkw.h

libusux.a : delta.o pierw.o 
	$(AR) -rv  $(LIB_NAME) $?

clean:
	rm -f *.o prog $(LIB_NAME)  
