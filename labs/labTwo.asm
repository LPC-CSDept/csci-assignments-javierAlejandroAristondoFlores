.data
	i32_inputs:		.space	2

.text
.globl 				main
    main:
		jal 	GetChar
		move	$t0, $v0
		jal		GetChar
		move	$t1, $v0
		addi	$t0, $t0, -48
		addi	$t1, $t1, -48
		li		$t2, 10
		mul		$t0, $t0, $t2
		add		$t0, $t0, $t1
		move	$a0, $t0
		li		$v0, 1
		syscall
		li		$v0, 10
		syscall
	PutChar:
		sw			$ra, ($sp)
		addi		$sp, -4
		tpollingLoopBegin:
			jal		isTransmitterReady
			beqz	$v0, tpollingLoopBegin
		sw			$a0, 0xffff000c
		addiu		$sp, 4
		lw			$ra, ($sp)
		jr			$ra
	GetChar:
		sw			$ra, ($sp)
		addi		$sp, -4
		rpollingLoopBegin:
			jal		isReceiverReady
			beqz	$v0, rpollingLoopBegin
		lw			$v0, 0xffff0004
		addiu		$sp, 4
		lw			$ra, ($sp)
		jr			$ra
	isReceiverReady:
		lw			$v0, 0xffff0000
		andi		$v0, $v0, 1
		jr			$ra
	isTransmitterReady:
		lw			$v0, 0xffff0008
		andi		$v0, $v0, 1
		jr			$ra
