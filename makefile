CC := gcc
#SRCS := $(shell find src/ -name "*.s")
SRCS := src/hello_world.s
OBJS := $(addprefix bin/, $(SRCS:.s=.o))
TARGET := bin/a.out

.PHONY: all run
all: $(TARGET)
run: $(TARGET)
	./$<

$(TARGET): $(OBJS)
	$(CC) $^ -o $@ -nostdlib

bin/%.o: %.s
	@mkdir -p $(@D)
	$(CC) -c $< -o $@ -g -no-pie

.PHONY: clean
clean:
	rm -fr $(OBJS) $(TARGET)
