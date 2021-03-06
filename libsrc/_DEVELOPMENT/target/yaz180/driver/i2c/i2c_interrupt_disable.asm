;==============================================================================
; Contents of this file are copyright Phillip Stevens
;
; You have permission to use this for NON COMMERCIAL USE ONLY
; If you wish to use it elsewhere, please include an acknowledgement to myself.
;
; https://github.com/feilipu/
;
; https://feilipu.me/
;
;
; This work was authored in Marrakech, Morocco during May/June 2017.

    INCLUDE "config_private.inc"

    SECTION code_driver

    PUBLIC __i2c_interrupt_disable

    ;Disable the I2C interrupt for each PCA9665 device
    ;Configuring the interrupt is done in the i2c_interrupt_attach function
    ;input A  =  device address, __IO_I2C1_PORT_MSB or __IO_I2C2_PORT_MSB

__i2c_interrupt_disable:
    push af             ;preserve device address
    cp __IO_I2C2_PORT_MSB
    jr Z, i2c_int_dis2
    cp __IO_I2C1_PORT_MSB
    jr NZ, i2c_int_exit ;no device address match, so exit

    in0 a, (ITC)        ;get INT/TRAP Control Register (ITC)
    and ~ITC_ITE1       ;mask out INT1
    jr i2c_int_dis1

i2c_int_dis2:
    in0 a, (ITC)        ;get INT/TRAP Control Register (ITC)
    and  ~ITC_ITE2      ;mask out INT2

i2c_int_dis1:
    out0 (ITC), a       ;disable external interrupt

i2c_int_exit:
    pop af
    ret

