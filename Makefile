all :
	gcc -c -I /usr/include/libusb-1.0 test.c
	gcc test.o -L. -L/usr/lib/arm-linux-gnueabihf/ -lusb-1.0 -o test
clean :
	rm -rf *.o test
