CC := gcc
#SRCS := $(shell find src/ -name "*.s")
SRCS := src/assignment-1.s
OBJS := $(addprefix bin/, $(SRCS:.s=.o))
TARGET := bin/a.out

.PHONY: all run
all: $(TARGET)
run: $(TARGET)
	./$<

$(TARGET): $(OBJS)
	$(CC) $^ -o $@ -no-pie

bin/%.o: %.s
	@mkdir -p $(@D)
	$(CC) -c $< -o $@ -g

.PHONY: clean
clean:
	rm -fr $(OBJS) $(TARGET)
