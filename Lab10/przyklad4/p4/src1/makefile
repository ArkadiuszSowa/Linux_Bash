CC = gcc
HDRS = ../headers
OBJECTS = rkw.o
LIB_NAME = libusux.a
LIBS = -lm

prog1: $(OBJECTS) ../lib/$(LIB_NAME)
	$(CC) $(CFLAGS) $(OBJECTS) -L../lib -o $@ -lusux -lm

rkw.o: $(HDRS)/rkw.h
	$(CC) $(CFLAGS) rkw.c -c -o $@
	
clean:
	rm -f *.o prog1;
