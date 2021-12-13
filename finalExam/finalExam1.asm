.text
.globl main
    main:
        # take in chars sequentially and save
        jal     GetChar
        addi	$t0, $v0, -48
        jal     GetChar
        addi	$t1, $v0, -48   
        jal     GetChar
        addi	$t2, $v0, -48
        li      $t3, 10
        mul    $t1, $t1, $t3
        add     $t2, $t2, $t1
        mul    $t3, $t3, $t3
        mul    $t0, $t0, $t3
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
        