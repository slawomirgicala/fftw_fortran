all: sin cos

sin: sinus_sum.f90
	ifort -o sin.out sinus_sum.f90 -lfftw3

cos: cosinus_noise.f90
	ifort -o cos.out cosinus_noise.f90 -lfftw3

run:
	./sin.out
	./cos.out

clean:
	rm *.out
