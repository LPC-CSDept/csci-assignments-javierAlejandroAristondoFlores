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
        mul    $t1, $t1, $t3
        add     $t0, $t0, $t1
        mul    $t3, $t3, $t3
        mul    $t2, $t2, $t3
        add     $t0, $t0, $t2 
        # make chars digits and sum
        move    $a0, $t0
        li      $v0, 1
        syscall         
        # print digits
    li  $v0, 10
    syscall
    GetChar:
        lw		$v0, 0xffff0000
        andi	$v0, $v0, 1
        beqz    $v0, GetChar
        lw		$v0, 0xffff000c
		jr		$ra    
        