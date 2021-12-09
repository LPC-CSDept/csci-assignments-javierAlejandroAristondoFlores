# PartTwo.asm
#
# Javier A. Alejandro-Flores
# 11/30/21
# Quiz 1 Part 2

.globl main

.data
    string_entryPointPrompt:    .asciiz "solve ax^2+bx+c for:\n"
    string_exitText:            .asciiz "ax^2+bx+c = "
    charArray_variableNames:    .ascii "abcx"
    int32Array_variableValues:  .word  0:40

.text
    main:
        # print entry point prompt
        li      $v0, 4
        la      $a0, string_entryPointPrompt
        syscall
        # populating the equation
        li      $t0, 0                              # t0 = 0
        li      $t2, 4
        populatingLoop:
        lb      $a0, charArray_variableNames($t0)   # a0 = charArray_variableNames[t0]
        li      $v0, 11
        syscall                                     # printChar(a0)
        li      $a0, '='
        syscall                                     # printChar('=')
        li      $v0, 5
        syscall                                     # v0 = readInt(cin)
        sll     $t1, $t0, 2                         # t1 = t0*4
        sw      $v0, int32Array_variableValues($t1) # int32Array_variableValues(t1) = v0
        addiu   $t0, $t0, 1                         # t0++
        blt     $t0, $t2, populatingLoop              # if(t0 < 4) goto populatingLoop
        nop
        # evauluate and print the equation
        la  $a0, int32Array_variableValues
        lw  $t1, 4($a0)
        lw  $t2, 8($a0)
        lw  $t3, 12($a0)
        lw  $t0, 0($a0)
        mul $t1, $t1, $t3
        mul $t3, $t3, $t3
        mul $t0, $t0, $t3
        add $t3, $t3, $t1
        add $t3, $t3, $t2
        li  $v0, 4
        la  $a0, string_exitText
        syscall
        li      $v0, 1
        move    $a0, $t3
        syscall
        li  $v0, 10
        syscall