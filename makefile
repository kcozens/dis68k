CC=gcc
#DEBUG = -g

dis68k: dis68k.c
	$(CC) $(DEBUG) -o dis68k dis68k.c

clean:
	rm dis68k
