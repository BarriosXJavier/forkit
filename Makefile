# Compiler and flags
CC = gcc
CFLAGS_DEBUG = -Wall -Wextra -Werror -g -DDEBUG -std=c99
CFLAGS_RELEASE = -Wall -Wextra -O2 -std=c99
INCLUDES = -Iinclude

# Directories
SRC_DIR = src
OBJ_DIR = obj
BIN = forkit

# Source files and object files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Colors
GREEN  = \033[0;32m
YELLOW = \033[1;33m
RED    = \033[0;31m
RESET  = \033[0m

# Default target
all: mode-release

# ===== BUILD MODES =====

mode-debug:
	@echo "$(YELLOW)Building in DEBUG mode...$(RESET)"
	$(MAKE) build CFLAGS="$(CFLAGS_DEBUG)"

mode-release:
	@echo "$(GREEN)Building in RELEASE mode...$(RESET)"
	$(MAKE) build CFLAGS="$(CFLAGS_RELEASE)"

# ===== BUILD RULES =====

build: $(OBJ_DIR) $(BIN)

$(BIN): $(OBJS)
	@echo "$(GREEN)Linking: $@$(RESET)"
	$(CC) $(CFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "$(YELLOW)Compiling: $<$(RESET)"
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# ===== UTIL =====

clean:
	@echo "$(RED)Cleaning up...$(RESET)"
	@rm -rf $(OBJ_DIR) $(BIN)

re: clean all

.PHONY: all build clean re mode-debug mode-release

# ======= USAGE =========

# make               # release build
# make mode-debug    # debug build (-g, -DDEBUG)
# make clean         # remove artifacts
# make re            # clean + rebuild

