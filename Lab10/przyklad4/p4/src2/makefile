CC = gcc
HEADERS = ../headers
OBJECTS = rlin.o input.o

prog2: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $@

input.o: $(HEADERS)/rlin.h
	$(CC) $(CFLAGS) input.c -c -o $@
	
rlin.o: $(HEADERS)/rlin.h
	$(CC) $(CFLAGS) rlin.c -c -o $@
	
clean:
	rm -f *.o prog2;
