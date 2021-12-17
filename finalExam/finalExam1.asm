.text
.globl main
    main:
        # take in chars sequentially and save
        jal     GetChar                 # v0_return = GetChar()
        addi	$t0, $v0, -48           # t0_100sPlace = v0_return - '0'
        jal     GetChar                 # v0_return = GetChar()
        addi	$t1, $v0, -48           # t1_10sPlace = v0 _return- '0'
        jal     GetChar                 # v0_return = GetChar()
        addi	$t2, $v0, -48           # t2_1sPlace = v0 -_return '0'
        li      $t3, 10                 # t3_placeValue = 10
        mul     $t1, $t1, $t3           # t1_10sPlace *= 10
        add     $t2, $t2, $t1           # t2_1sPlace += t1_10sPlace
        mul     $t3, $t3, $t3           # t3_placeValue *= t3_placeValue
        mul     $t0, $t0, $t3           # t0_100sPlace *= t3_placeValue
        add     $t0, $t0, $t2           # t0_100sPlace += t2_10sPlace
        # make chars digits and sum
        move    $a0, $t0                
        li      $v0, 1
        syscall                         # printInt(t0_100sPlace)
        # print digits
        li      $v0, 10
        syscall
    GetChar:
        lw		$v0, 0xffff0000         # v0_return = receiverStatus
        andi	$v0, $v0, 1             # v0_return &= 1
        beqz    $v0, GetChar            # if(!v0_return) goto GetChar
        lw		$v0, 0xffff0004         # v0_return = receiverData
		jr		$ra    
        