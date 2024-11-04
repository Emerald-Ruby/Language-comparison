program guess_number
    implicit none
    real :: u
    integer :: random_num
    integer :: user_guess

    call random_number(u)
    random_num = u*10.0

    do while(user_guess .ne. random_num) 
        read (*,*) user_guess
        if (user_guess == random_num) then
            print *, "That's correct! Well done!"
        else if ( user_guess > random_num ) then
            print *, "That's a little too high"
        else if ( user_guess < random_num ) then
            print *, "That's a little too low"
        end if            
    end do

end program guess_number