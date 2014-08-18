
all: 969

LIBS = \
	lib/screen.lua

%: $(LIBS) puzzle/%/*.lua
	cat $^ lib/main.lua > bin/do_$@.lua

