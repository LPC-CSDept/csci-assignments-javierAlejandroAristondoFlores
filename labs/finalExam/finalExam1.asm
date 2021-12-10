# program to take 3 character digits 

.data

.text
.globl main
    main:
        # take in chars sequentially and save
        jal     GetChar
        move    $t0, $v0
        jal     GetChar
        move    $t1, $v0
        jal     GetChar
        move    $t2, $v0

        # make chars digits and sum

        


        # print digits

    li  $v0, 10
    syscall


    GetChar:

        jr  $ra