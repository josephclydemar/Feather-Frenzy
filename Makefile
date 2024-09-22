CXX = g++
CFLAGS = -Wall -Werror -std=c++20
LFLAGS = -I include/. -I include/raylib/. -fPIC -L build/.
BUILD_MODE =
TARGET_PLATFORM =

MAIN_RUN =

CONFIG_COMMAND =

# Output File Extensions
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
MAIN_DEPS   = -lplayer -lraylib
GAME_DEPS   = -lplayer -lraylib
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
GAME_TARGET  = build/libgame.$(SHARED_TARGET_EXT)
COMMON_TARGET = build/libcommon.$(SHARED_TARGET_EXT)
PLAYER_TARGET = build/libplayer.$(SHARED_TARGET_EXT)


ifeq ($(OS), Windows_NT)
	MAIN_RUN = $(MAIN_TARGET)
else
	MAIN_RUN = LD_LIBRARY_PATH=build/. $(MAIN_TARGET)
endif



all: $(MAIN_TARGET)


$(MAIN_TARGET): $(MAIN_SRC) $(PLAYER_TARGET)
	$(CXX) $(CFLAGS) $(MAIN_SRC) $(LFLAGS) $(MAIN_DEPS) -o $@
	@cp lib/$(TARGET_PLATFORM)/*.$(SHARED_TARGET_EXT)  build/.
	@$(CONFIG_COMMAND)

# $(GAME_TARGET): $(GAME_H) $(GAME_SRC)
# 	$(CXX) $(CFLAGS) $(GAME_SRC) $(LFLAGS) $(GAME_DEPS) -o $@


# $(COMMON_TARGET): $(COMMON_H) $(COMMON_SRC)
# 	$(CXX) $(CFLAGS) $(COMMON_SRC) $(LFLAGS) $(COMMON_DEPS) -o $@


$(PLAYER_TARGET): $(PLAYER_H) $(PLAYER_SRC)
	$(CXX) $(CFLAGS) -shared $(PLAYER_SRC) $(LFLAGS) $(PLAYER_DEPS) -o $@


run: $(MAIN_TARGET)
	$(MAIN_RUN)



clean:
	-rm build/*.$(SHARED_TARGET_EXT) build/*.$(MAIN_TARGET_EXT)
	clear || cls

