.text
.globl main
    main:
        # enable interrupts on receiver 
        li		$t0, 2
        sw		$t0, 0xffff0000
        # enable all interrupts on co-processor zero
        li		$t0, 0xff01
        mtc0	$t0, $12 
        # infiniloop
        here:   j here

.ktext 0x80000180
    # check if q
    lw		$a0, 0xffff0004
	bne		$a0, 'q', print
    # no
    li      $v0, 10
    syscall
    # yes
	print:
    li		$v0, 11
	syscall
    end:
    eret