##
## EPITECH PROJECT, 2025
## Makefile
## File description:
## Makefile for the compilation of the lib
##

CC := gcc

TARGET := libmy.a
BUILD_DIR := .obj

W := -W -Wall -Wextra -Wpedantic -Wunused-parameter -Wshadow
W += -Wuninitialized -Wmaybe-uninitialized

DEBUG := -g -ggdb3

CPPFLAGS := -I ../../include/
LDFLAGS := -lm
CFLAGS := $(W)

ifeq ($(d), t)
	CFLAGS := $(DEBUG)
else ifeq ($(d), o)
	CFLAGS += -O1
endif

MEMORY :=	memory/my_calloc.c \
			memory/my_realloc.c \
			memory/my_malloc.c \
			memory/my_swap.c \
         	memory/my_strdup.c \
         	memory/my_strndup.c \
			memory/my_memeset.c

MATH := 	math/find_prime_sup.c \
			math/is_prime.c \
			math/trigo/my_cos.c \
			math/trigo/my_sin.c \
			math/trigo/my_tan.c \
			math/trigo/rad_degree.c \
			math/trigo/degree_rad.c \
			math/function/my_exp.c \
			math/function/my_ln.c \
			math/function/my_log.c \
			math/function/my_round.c \
			math/operator/my_binomial.c \
			math/operator/my_gamma.c \
			math/operator/my_factorial.c \
			math/operator/my_pow.c \
			math/operator/my_sqrt.c

STRING := 	string/cmp/my_strncmp.c \
			string/cmp/my_strcmp.c \
			string/cmp/my_str_isalpha.c \
			string/cmp/my_str_islower.c \
			string/cmp/my_str_isnumber.c \
			string/cmp/my_str_isnum.c \
			string/cmp/my_str_isprintable.c \
			string/cmp/my_str_isupper.c \
			string/cmp/my_str_is.c \
			string/edit/my_strcat.c \
			string/edit/my_strcpy.c \
			string/edit/my_strncat.c \
			string/edit/my_strncpy.c \
			string/edit/my_revstr.c \
			string/edit/my_strcapitalize.c \
			string/edit/my_strlowcase.c \
			string/edit/my_strupcase.c \
			string/retrive/count_occurence.c \
			string/retrive/my_get_index.c \
			string/retrive/my_strlen.c \
			string/retrive/my_strlen_stop_at.c \
			string/retrive/my_strstr.c \
			string/retrive/my_strfind.c \
			string/transformation/convertnbr_base.c \
			string/transformation/concat_params.c \
			string/transformation/get_fullpath.c \
			string/transformation/str_to_str_array.c \
			string/transformation/my_itoa.c \
			string/transformation/my_ftoa.c \
			string/transformation/my_atoi.c \
			string/transformation/my_atof.c \
			string/transformation/cut_str.c

WRITE := 	write/my_putchar.c \
			write/my_putstr.c \
        	write/my_putnbr.c \
			write/my_putnbr_base.c \
			write/dump/array_dump.c \
			write/dump/ht_dump.c \
			write/dump/str_array_dump.c \
			write/dump/linked_dump.c \
			write/edit_ouput/color/back_color.c \
			write/edit_ouput/color/back_color_rgb.c \
			write/edit_ouput/color/color_rgb.c \
			write/edit_ouput/color/color.c \
			write/edit_ouput/style/italic.c \
			write/edit_ouput/style/reversed.c \
			write/edit_ouput/style/strong.c \
			write/edit_ouput/style/underlined.c \
			write/edit_ouput/style/flashing_slow.c \
			write/edit_ouput/style/flashing_fast.c \
			write/edit_ouput/style/hide.c \
			write/edit_ouput/style/bar.c \
			write/edit_ouput/style/dark.c \
			write/edit_ouput/reset.c \
			write/edit_ouput/cursor/up.c \
			write/edit_ouput/cursor/down.c \
			write/edit_ouput/cursor/left.c \
			write/edit_ouput/cursor/right.c \
			write/edit_ouput/cursor/next_line.c \
			write/edit_ouput/cursor/previous_line.c \
			write/edit_ouput/cursor/column.c \
			write/edit_ouput/cursor/co.c \
			write/edit_ouput/cursor/save.c \
			write/edit_ouput/cursor/load.c \
			write/edit_ouput/cursor/hide.c \
			write/edit_ouput/cursor/show.c \
			write/edit_ouput/erase/line.c \
			write/edit_ouput/erase/line_end.c \
			write/edit_ouput/erase/line_start.c \
			write/edit_ouput/erase/screen_end.c \
			write/edit_ouput/erase/screen_start.c \
			write/edit_ouput/erase/screen.c

ARRAY := 	array/new_array.c \
			array/add_array.c \
			array/pop_array.c \
			array/delete_array.c

LINKED := 	linked/linked_add.c \
			linked/linked_add_at.c \
			linked/linked_pop.c \
			linked/linked_pop_at.c \
			linked/linked_pop_this.c \
			linked/delete_linked.c \
			linked/update_mid.c \
			linked/linked_get_data.c

HASH :=		hashtable/hash.c \
			hashtable/new_hashtable.c \
			hashtable/delete_hashtable.c \
			hashtable/ht_search.c \
			hashtable/ht_delete.c \
			hashtable/ht_insert.c \
			hashtable/ht_keys.c

PRINTF :=	printf/printf.c \
			printf/identifier.c \
			printf/dispatch.c \
			printf/specifiers/null.c \
			printf/specifiers/identifier.c \
			printf/specifiers/ouput.c \
			printf/specifiers/boolean.c \
			printf/specifiers/reset.c \
			printf/specifiers/strong.c \
			printf/specifiers/color.c \
			printf/specifiers/i.c \
			printf/specifiers/base.c \
			printf/specifiers/c.c \
			printf/specifiers/s.c \
			printf/specifiers/p.c

FILE := 	file/get_file.c

ERROR :=	error/error_dispatch.c \
			error/error_print.c \
			error/error_prog.c \
			error/error_custom.c \
			error/error_system.c

SRC := $(MEMORY) $(MATH) $(STRING) $(WRITE)
SRC += $(ARRAY) $(LINKED) $(HASH) $(PRINTF) $(FILE)
SRC += $(ERROR)
OBJ := $(SRC:%.c=$(BUILD_DIR)/%.o)

all: $(TARGET)

$(TARGET): $(OBJ)
	@ar rc $@ $^
	@mv $@ ../

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -c -o $@ $^

clean:
	@rm -rf $(BUILD_DIR)

fclean: clean
	@rm -f ../$(TARGET)

.NOTPARALLEL:
re: fclean $(TARGET)

get_unregistered_files:
	@find . -name "*.c" | sed "s/\.\///g" | while read file; do \
        	echo "$(SRC)" | grep -q "$$file" || \
		echo "$$file" >> new_files_detected.txt; \
        done
	@if [ -f new_files_detected.txt ]; then \
                cat new_files_detected.txt;\
                rm -f new_files_detected.txt; \
        fi

get_unknow_files:
	@for file in $(SRC); do \
            if [ ! -f "$$file" ]; then \
                echo "$$file" >> missing_files.txt; \
            fi; \
        done
	@if [ -f missing_files.txt ]; then \
                cat missing_files.txt | sed "s/src\///g"; \
                rm -f missing_files.txt; \
        fi

.PHONY: all clean fclean re get_unregistered_files get_unknow_files
