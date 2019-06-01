## Wykorzystanie biblioteki FFTW w Fortranie

Zadanie wykonane w ramach zajęć z programowania w języku Fortran.

Do poprawnego działania niezbędne jest zainstalowanie pakietu 
[FFTW](http://www.fftw.org/), w przypadku wykresów wykorzystany został [gnuplot](http://www.gnuplot.info/), 
a do kompilacji [ifort](https://software.intel.com/en-us/fortran-compilers).

Kompilacja jest możliwa za pomocą pliku Makefile, poprzez wykonanie 'make all' z katalogu 'src'.
Wykonanie programów - 'make run', który generuje wyniki w katalogu 'res', 
stworzenie wykresów - 'plots.sh' z katalogu 'res'

#### Wyniki

Wykres fali będącej sumą dwóch sinusoid o wzorze x = sin(2\*pi\*t\*200)+2sin(2\*pi\*t\*400) przedstawia się w czasie następująco:


![](https://github.com/slawomirgicala/fftw_fortran/blob/master/res/sin_sum_time_amplitude.pdf)


Zastosowanie transformacji Fouriera pozwala przekształcić wynik do wykresu zależności amplitudy od częstotliwości:


![](https://github.com/slawomirgicala/fftw_fortran/blob/master/res/sin_sum_frequency_amplitude.pdf)


Jesteśmy w stanie zaobserwować wysoką amplitudę dla częstotliwości równej 200Hz, która odpowiada pierwszemu sinusowi, oraz dla częstotliwości 400Hz, która odpowiada drugiemu składnikowi sumy, 
jego amplituda jest 2 razy większa ze względu na przemnożenie tego składnika przez 2.
Amplitudy przy częstotliwościach 600Hz oraz 800Hz są odbiciem lustrzanym wspomnianych.


Drugą częścią zadania było wykorzystanie FFT do odszumienia sygnału cosinus.
Wykres funkcji cos(2\*pi\*t\*2):


![](https://github.com/slawomirgicala/fftw_fortran/blob/master/res/cos_time_amplitude.pdf)


Po zaszumieniu (dodaniu do każdego punktu wykresu pewnej niewielkiej, losowej wartości):


![](https://github.com/slawomirgicala/fftw_fortran/blob/master/res/cos_noise_time_amplitude.pdf)


Po zastosowaniu FFT na zaszumionej funkcji:


![](https://github.com/slawomirgicala/fftw_fortran/blob/master/res/cos_noise_frequency_amplitude.pdf)


Obserwujemy tutaj wyraźnie "wiodącą" częstotliwość - najwyższy słupek blisko zera, który odpowiada fali cosinus. Wszystkie pozostałe częstotliwości 
o niewielkich amplitudach to słabe szumy (losowo dodane zaburzenia). Zatem można je po prostu wyciąć 
zerując wszystkie częstotliwości nie przekraczające pewnej granicznej wartości.


![](https://github.com/slawomirgicala/fftw_fortran/blob/master/res/cos_noise_cleaned_frequency_amplitude.pdf)


Po zastosoaniu takiej operacji widać wyraźnie, że sygnał składa się z jednej fali o częstotliwości podanego na początku cosinusa.
Możemy na nim zastosować tranformację odwrotną.


![](https://github.com/slawomirgicala/fftw_fortran/blob/master/res/cos_cleaned_inversed_time_amplitude.pdf)


Dzięki temu zabiegowi dostajemy początkowy sygnał cosinus bez żadnych zaburzeń.