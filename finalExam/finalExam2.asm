.text
.globl main
    main:
        # enable interrupts on receiver 
        li		$t0, 2
        sw		$t0, 0xffff0000

        # enable all interrupts
        li		$t0, 0xff01
        mtc0	$t0, $12 

        # infiniloopa
        here: j here

    .ktext
        