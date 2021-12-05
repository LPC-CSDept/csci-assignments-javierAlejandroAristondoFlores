# PartOne.asm
#
# Javier A. Alejandro-Flores
# 11/30/21
# Quiz 1 Part 1

.globl main

.data
    string_entryPointPrompt:    .asciiz "Degrees Farenheit: "
    string_resultTextHalfOne:   .asciiz "is "
    float_conversionConstant:   .float  0.555555555555555555555555555555555555

.text
    main:
        # prompt for Farenheit value and store
        la      $a0, string_entryPointPrompt
        li      $v0, 4
        syscall                                 # printString(string_entryPointPrompt)
        li      $v0, 5          
        syscall                                 # v0_input = readInt(cin)
        # convert and calculate
        addi    $a0, $v0, -32                   
        jal     ToFloat                         # a0 = v0 - 32
        nop                                     # f12_convertedInput = ToFloat(a0)
        l.s     $f0, float_conversionConstant   # $f0 = 5/9
        nop
        mul.s   $f2, $f12, $f0                  # f2 = f2_convertedInput * 5/9
        # print and end
        li      $v0, 2                          
        mov.s   $f12, $f2
        syscall                                 # printFloat(f12)
        li      $a0, 'C'
        li      $v0, 11                         
        syscall                                 # print('c')
        li      $v0, 10
        syscall
    ToFloat:    # a0 inputInt, $f12 outputFloat
        # set sign bit and remove negativity
        bgtz    $a0, notNegative            # if(a0_inputInt > 0) goto notNegative
        slt     $s0, $a0, $zero             # if(a0_inputInt < 0) s0_signBit = 1
        abs     $a0, $a0
        notNegative:
        sll     $s0, $s0, 31                # shift the sign bit to the 32nd bit
        # find bit count of input
        li      $s1, 0                      # s1_digits = 0 
        move    $s2, $a0                    # s2_inputCopy = a0_inputInt
        digitCounter:
        beqz    $s2, digitCounterEnd        # if(s2_inputCopy <= 0) goto digitCounterEnd
        srl     $s2, $s2, 1                 # s2_inputCopy >>= 1
        j       digitCounter                # goto digitCounter
        addi    $s1, $s1, 1                 # s1_digits++ 
        digitCounterEnd:
        # make mantissa
        addi    $s3, $s1, -24               # s3_distanceFrom24thBit = s1_digits - 24
        bltz     $s3, shiftLeft             # if(s3_distanceFrom24thBit < 0) goto shiftLeft
        move    $s2, $a0                    # s2_inputCopy = a0_inputInt
        j       endShift                    # goto endShift
        srlv     $s2,  $s2, $s3             # s2 >>= s3_distanceFrom24thBit
        shiftLeft:
        abs     $s3, $s3                    # s3_distanceFrom24thBit = abs(s3_distanceFrom24thBit)
        sllv    $s2, $s2, $s3               # s2_inputCopy <<= s3_distanceFrom24thBit
        endShift:
        # make exponent
        beqz    $s1, denormalized           # if (s1_digits == 0) goto denormalized
        nop
        addi    $s1, $s1, 126               # s1_biasedExponent = (s1_digits - 1) + 127
        denormalized:
        sll     $s1, $s1, 23                # shift exponent into field
        or      $s3, $s1, $s0               # combine exponent and sign
        and     $s2, $s2, 0x007FFFFF        # chop leading one off
        or      $s3, $s3, $s2               # combine exponent and sign with mantissa
        mtc1    $s3, $f12                   # copy result into floating point return register
        jr $ra                              
        nop