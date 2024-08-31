CC = gcc
CFLAGS = -Wall -Werror -std=c99 -O3
LFLAGS = -I include/. -I include/raylib/. -L lib/.
TARGET_PLATFORM =
EXEC_COMMAND =
RENAME_COMMAND = 

# Source files
MAIN_SRC = src/main.c
QUEUE_SRC = src/queue.c
STACK_SRC = src/stack.c
LLIST_SRC = src/llist.c

QUEUE_H = include/queue.h
STACK_H = include/stack.h
LLIST_H = include/llist.h

# Linked libraries
MAIN_DEPS = -lllist -lqueue -lstack -lraylib

# Output files
SHARED_TARGET_EXT = 
MAIN_TARGET_EXT = 

MAIN_TARGET = build/main
QUEUE_TARGET = lib/libqueue
STACK_TARGET = lib/libstack
LLIST_TARGET = lib/libllist


ifeq ($(OS),Windows_NT)
	TARGET_PLATFORM = windows
	SHARED_TARGET_EXT = dll
	MAIN_TARGET_EXT = exe
	EXEC_COMMAND = $(MAIN_TARGET).$(MAIN_TARGET_EXT)
else
	TARGET_PLATFORM = linux
	SHARED_TARGET_EXT = so
	MAIN_TARGET_EXT = out
	RENAME_COMMAND = mv build/libraylib.so build/libraylib.so.500
	EXEC_COMMAND = LD_LIBRARY_PATH=build/. $(MAIN_TARGET).$(MAIN_TARGET_EXT)
endif

LFLAGS += -L lib/$(TARGET_PLATFORM)/.


all: $(MAIN_SRC) libqueue.$(SHARED_TARGET_EXT) libstack.$(SHARED_TARGET_EXT) libllist.$(SHARED_TARGET_EXT)
	-@mkdir build
	$(CC) $(CFLAGS) $(MAIN_SRC) $(LFLAGS) $(MAIN_DEPS) -o $(MAIN_TARGET).$(MAIN_TARGET_EXT)
	@cp lib/*.$(SHARED_TARGET_EXT) lib/$(TARGET_PLATFORM)/*.$(SHARED_TARGET_EXT)  build/.
	@$(RENAME_COMMAND)
	@strip $(MAIN_TARGET).$(MAIN_TARGET_EXT)

libqueue.$(SHARED_TARGET_EXT): $(QUEUE_H) $(QUEUE_SRC)
	$(CC) $(CFLAGS) -shared $(QUEUE_SRC) $(LFLAGS) -o $(QUEUE_TARGET).$(SHARED_TARGET_EXT)

libstack.$(SHARED_TARGET_EXT): $(STACK_H) $(STACK_SRC)
	$(CC) $(CFLAGS) -shared $(STACK_SRC) $(LFLAGS) -o $(STACK_TARGET).$(SHARED_TARGET_EXT)

libllist.$(SHARED_TARGET_EXT): $(LLIST_H) $(LLIST_SRC)
	$(CC) $(CFLAGS) -shared $(LLIST_SRC) $(LFLAGS) -o $(LLIST_TARGET).$(SHARED_TARGET_EXT)

open: $(MAIN_TARGET).$(MAIN_TARGET_EXT)
	$(EXEC_COMMAND)

clean:
	-rm -rf build || rmdir build
	-rm lib/lib*
	clear || cls


