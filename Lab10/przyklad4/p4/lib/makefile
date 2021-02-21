CC = gcc
OBJECTS = pierw.o delta.o
LIB_NAME = libusux.a
HDRS = ../headers
AR = ar

$(LIB_NAME): $(OBJECTS)
	$(AR) -rv $(LIB_NAME) $(OBJECTS) $?

delta.o: $(HDRS)/fun.h
	$(CC) $(CFLAGS) delta.c -c -o $@
	
pierw.o: $(HDRS)/fun.h
	$(CC) $(CFLAGS) pierw.c -c -o $@

clean:
	rm -f *o $(LIB_NAME)
