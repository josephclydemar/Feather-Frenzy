CXX = g++
CFLAGS = -Wall -Werror -std=c++20
LFLAGS = -I include/. -I include/raylib/. -fPIC -L build/.
BUILD_MODE =
TARGET_PLATFORM =

MAIN_RUN =

CONFIG_COMMAND =

# Output File Extensions
OBJ_TARGET_EXT = o
SHARED_TARGET_EXT =
MAIN_TARGET_EXT =

# Source Files
MAIN_SRC   = src/main.cpp
GAME_SRC  = src/game.cpp
COMMON_SRC = src/common.cpp
PLAYER_SRC = src/player.cpp

GAME_H  = include/game.hpp
COMMON_H = include/common.hpp
PLAYER_H = include/player.hpp

# Linked libraries
MAIN_DEPS   = -lraylib
GAME_DEPS   = -lraylib
COMMON_DEPS = -lraylib
PLAYER_DEPS = -lraylib


ifeq ($(OS),Windows_NT)
	TARGET_PLATFORM = windows
	MAIN_TARGET_EXT = exe
	SHARED_TARGET_EXT = dll
else
	TARGET_PLATFORM = linux
	MAIN_TARGET_EXT = out
	SHARED_TARGET_EXT = so
	CONFIG_COMMAND = mv build/libraylib.so build/libraylib.so.500
endif

ifeq ($(BUILD_MODE),DEBUG)
	CFLAGS += -g
else
	CFLAGS += -O3 -s
endif

LFLAGS += -L lib/$(TARGET_PLATFORM)/.


MAIN_TARGET   = build/feather-frenzy.$(MAIN_TARGET_EXT)
GAME_TARGET  = build/game.$(OBJ_TARGET_EXT)
COMMON_TARGET = build/common.$(OBJ_TARGET_EXT)
PLAYER_TARGET = build/player.$(OBJ_TARGET_EXT)


ifeq ($(OS), Windows_NT)
	MAIN_RUN = $(MAIN_TARGET)
else
	MAIN_RUN = LD_LIBRARY_PATH=build/. $(MAIN_TARGET)
endif



all: $(MAIN_TARGET)


$(MAIN_TARGET): $(MAIN_SRC)
	$(CXX) $(CFLAGS) $(MAIN_SRC) $(LFLAGS) $(MAIN_DEPS) -o $@
	@cp lib/$(TARGET_PLATFORM)/*.$(SHARED_TARGET_EXT)  build/.
	@$(CONFIG_COMMAND)


run: $(MAIN_TARGET)
	$(MAIN_RUN)



clean:
	-rm build/*.$(OBJ_TARGET_EXT) build/*.$(SHARED_TARGET_EXT) build/*.$(MAIN_TARGET_EXT)
	clear || cls

