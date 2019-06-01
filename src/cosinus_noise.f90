program main

    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    real(kind=16), parameter :: PI_16 = 4*atan(1.0_16)
    type(C_PTR) :: plan, plan_inverse
    real(C_DOUBLE), dimension(1000) :: in
    complex(C_DOUBLE_COMPLEX), dimension(1000) :: complex_in, out, inversed
    integer :: i
    real(kind=16) :: t
    integer,parameter :: seed = 86456
    real :: rand

    call srand(seed)

    open(1, file="../res/cosinus_time_amplitude.txt", action='WRITE')
    open(2, file="../res/cosinus_noise_time_amplitude.txt", action='WRITE')
    open(3, file="../res/cosinus_noise_frequency_amplitude.txt", action='WRITE')
    open(4, file="../res/cosinus_noise_cleaned_frequency_amplitude.txt", action='WRITE')
    open(5, file="../res/cosinus_noise_cleaned_time_amplitude.txt", action='WRITE')



    do i=1,1000
        t = i/1000.0
        in(i) = cos(2*PI_16*t*2)
        write(1,*) t, " ", in(i)
        in(i) = in(i) + ((rand()*2 - 1)*0.01)
        write(2,*) t, " ", in(i)
    end do

    do i=1,1000
        complex_in(i) = cmplx(in(i), 0)
    end do

    plan = fftw_plan_dft_1d(1000, complex_in, out, FFTW_FORWARD, FFTW_ESTIMATE)
    call fftw_execute_dft(plan, complex_in, out)

    do i=1,size(out)
        write(3,*) i, " ", abs(out(i))
    end do

    do i=1,size(out)
        if(abs(out(i)) < 50) out(i) = cmplx(0,0)
        write(4,*) i, " ", abs(out(i))
    end do

    plan_inverse = fftw_plan_dft_1d(1000, out, inversed, FFTW_BACKWARD, FFTW_ESTIMATE)
    call fftw_execute_dft(plan_inverse, out, inversed)

    do i=1,1000
        t = i/1000.0
        write(5,*) t, " ", real(inversed(i))/1000.0
    end do

    call fftw_destroy_plan(plan)
    call fftw_destroy_plan(plan_inverse)

end program main