.data
    KERNEL_TEMP_BUFFER:  .space  8

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
        here: j here

.ktext 0x80000180
    # check if exception was an interrupt
    mfc0	$k0, $13
    andi	$k0, $k0, 0x7c
    bnez	$k0, end
    # check if q
    lw		$a0, 0xffff0004
	bneq		$a0, 'q', quit
    # no
    quit:
    li      $v0, 10
    syscall
    # yes
    li		$v0, 11
	syscall
    end:
    eret