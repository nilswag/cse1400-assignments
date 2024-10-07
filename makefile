CC := gcc
# SRCS := $(shell find src/ -name "*.s")
SRCS := src/assignment-3.s
OBJS := $(addprefix bin/, $(SRCS:.s=.o))
TARGET := bin/a.out

ASFLAGS = -Wall
ASFLAGS += -Isrc

LDFLAGS = -no-pie -z noexecstack

# ===========================================================

.PHONY: debug release all run

debug: ASFLAGS += -g
debug: $(TARGET)

release: ASFLAGS += -Os -s
release: $(TARGET)

all: debug

run: debug
	./$(TARGET)

# ===========================================================

$(TARGET): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

bin/%.o: %.s
	@mkdir -p $(@D)
	$(CC) -c $< -o $@ $(ASFLAGS)

# ===========================================================

.PHONY: clean

clean:
	rm -fr bin/src $(TARGET)