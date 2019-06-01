program main

    use, intrinsic :: iso_c_binding
    implicit none
    include 'fftw3.f03'
    real(kind=16), parameter :: PI_16 = 4*atan(1.0_16)
    type(C_PTR) :: plan
    real(C_DOUBLE), dimension(10000) :: in
    complex(C_DOUBLE_COMPLEX), dimension(10000) :: out
    integer :: i
    real(kind=16) :: t


    open(1, file="../res/sinus_sum_time_amplitude.txt", action='WRITE')
    open(2, file="../res/sinus_sum_frequency_amplitude.txt", action='WRITE')

    do i=1,10000
        t = i/10000.0
        in(i) = sin(2*PI_16*t*200)+2*sin(2*PI_16*t*400)
        write(1,*) t, " ", in(i)
    end do

    plan = fftw_plan_dft_r2c_1d(10000, in, out, FFTW_FORWARD + FFTW_ESTIMATE)
    call fftw_execute_dft_r2c(plan, in, out)

    do i=1,size(out)
        write(2,*) i, " ", abs(out(i))
    end do

    call fftw_destroy_plan(plan)

end program main