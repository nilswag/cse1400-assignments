CC := gcc
# SRCS := $(shell find src/ -name "*.s")
SRCS := src/assignment-1.s
OBJS := $(addprefix bin/, $(SRCS:.s=.o))
TARGET := bin/a.out

ASFLAGS = -Wall
LDFLAGS = -no-pie

# ===========================================================

.PHONY: all run debug release

debug: ASFLAGS += -g
debug: all

release: ASFLAGS += -Os -s
release: all

all: $(debug) $(TARGET)

# ===========================================================

$(TARGET): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

bin/%.o: %.s
	@mkdir $(@D)
	$(CC) -c $< -o $@ $(ASFLAGS)

# ===========================================================

.PHONY: clean

clean:
	rm -fr bin/src $(TARGET)