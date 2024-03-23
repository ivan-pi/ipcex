FC=gfortran
FFLAGS=-Wall

CXX=g++

.PHONY: all
all: test_spawn repeat

test_spawn: test_spawn.f90 spawn.o f_spawn.o
	$(FC) $(FFLAGS) -o $@ $^ -lstdc++

repeat: repeat.f90
	$(FC) $(FFLAGS) -o $@ $<


# The Fortran wrapper module
spawn.o spawn.mod: spawn.f90
	$(FC) $(FFLAGS) -c $<

# Spawn library (implemented in C++)
f_spawn.o: f_spawn.cpp spawn.hpp
	$(CXX) -std=c++17 -c $<


.PHONY: clean
clean:
	rm -f *.o *.mod