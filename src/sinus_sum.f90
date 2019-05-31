program test

    use, intrinsic :: iso_c_binding
    include 'fftw3.f03'
    real(kind=16), parameter :: PI_16 = 4*atan(1.0_16)
    type(C_PTR) :: plan
    complex(C_DOUBLE_COMPLEX), dimension(1000) :: in, out



    do i=1,1000
        t = i/1000.0
        in(i) = sin(2*PI_16*t*200)+2*sin(2*PI_16*t*400)
        write(*,*) in(i)
    end do



    plan = fftw_plan_dft_1d(1000, in, out, FFTW_FORWARD, FFTW_ESTIMATE)
    call fftw_execute_dft(plan, in, out)


    write(*,*) out



    do i=1,1000
        write(*,*) abs(out(i))
    end do



    call fftw_destroy_plan(plan)




end program test