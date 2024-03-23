FC=gfortran
FFLAGS=-Wall


.PHONY: all clean

all: a b

a: a.f90
	$(FC) $(FFLAGS) -o $@ $<

b: b.f90
	$(FC) $(FFLAGS) -o $@ $<

clean:
	rm -f *.o *.mod