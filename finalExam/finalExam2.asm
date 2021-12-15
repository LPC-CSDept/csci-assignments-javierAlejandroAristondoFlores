.text
.globl main
    main:
        # enable interrupts on receiver 
        li		$t0, 2
        sw		$t0, 0xffff0000

        # enable all interrupts
        li		$t0, 0xff01
        mtc0	$t0, $12 

        # infiniloop
        here: j here

    .ktext
        # read data
        lw      $k0, 0xffff0004

        # check if input was q
        bneq    $k0, 'q', notEqual

        # yes
        li      

        # no
        notEqual:


