.data
	ca_values:		.ascii	"42"

.text
.globl 				main
    main:
		la			$t0, ca_values
		lb			$a0, ($t0)
		lb			$t1, 1($t0)	
		jal 		PutChar
		move		$a0, $t1
		jal			PutChar
		li			$v0, 10
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
