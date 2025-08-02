FC = gfortran

TARGET = example
MODULES = mod_socket

OBJS = $(TARGET:=.o) $(MODULES:=.o)

.SUFFIXES: .f90

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LINK.f) $^ $(LOADLIBES) $(LDLIBS) -o $@

main.o: $(MODULES).mod

run:
	./example

%.o: %.f90
	$(COMPILE.f) $(OUTPUT_OPTION) $<

%.mod: %.f90 %.o
	@:

clean:
	rm -f $(OBJS) $(TARGET) *.mod

.PHONY: clean run