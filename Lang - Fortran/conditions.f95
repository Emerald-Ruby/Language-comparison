program conditions
    implicit none
    character(len=33) :: PROMPT = "Please enter one of the following"
    ! TAB char doesn't seem to exist
    character(len=6) :: TAB = "      "
    ! TYPE or type is a key word in fortran
    character(len=4) :: TYPE_ = "type"
    character(len=10) :: TS = "typescript"
    character(len=10) :: JS = "javascript"
    character(len=12) :: ANYTHING = "Or anything!"

    character(len=64) :: selection

    print *, PROMPT
    print *,TAB, TYPE_
    print *,TAB, TS
    print *,TAB, JS
    print *,TAB, ANYTHING

    ! Will NOT read ""
    read *, selection

    if ( selection == "." ) then
        print *, "That's nothing!"
    endif
    if ( selection == TYPE_) then
        print *, "Safety!"
    end if
    if ( selection == TS .or. selection == JS ) then
        print *, "Ew ew ew ew away!"
    end if
    ! how do you do an else?....
    if (selection .ne. "." .and. selection .ne. TYPE_ .and. selection .ne. TS .and. selection .ne. JS) then
        print *, "Hmm yes I see, ", selection
    end if

end program conditions