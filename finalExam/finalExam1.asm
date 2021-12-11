# program to take 3 character digits and transform

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
        li      $t3, 10
        mult    $t1, $t1, $t3
        add     $t0, $t0, $t1
        mult    $t3, $t3, $t3
        mult    $t2, $t2, $t3
        add     $t0, $t0, $t2 
        # make chars digits and sum
        move    $a0, $t0
        li      $v0, 1
        syscall         
        # print digits

    li  $v0, 10
    syscall


    GetChar:

        # poll for receiver ready
        
        jr  $ra