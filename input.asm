    .data
prompt_x1:   .string "Ingresa x1: "
prompt_y1:   .string "Ingresa y1: "
prompt_x2:   .string "Ingresa x2: "
prompt_y2:   .string "Ingresa y2: "
prompt_center_x: .string "Ingresa el centro x: "
prompt_center_y: .string "Ingresa el centro y: "
prompt_radius:   .string "Ingresa el radio: "

	.text
	.globl read_line_input, read_circle_input

read_line_input:
    li a7, 4
    la a0, prompt_x1
    ecall
    li a7, 5
    ecall
    mv t0, a0               # guardar x1

    li a7, 4
    la a0, prompt_y1
    ecall
    li a7, 5
    ecall
    mv t1, a0               # guardar y1

    li a7, 4
    la a0, prompt_x2
    ecall
    li a7, 5
    ecall
    mv t2, a0               # guardar x2

    li a7, 4
    la a0, prompt_y2
    ecall
    li a7, 5
    ecall
    mv t3, a0               # guardar y2

    ret
    
read_circle_input:
    li a7, 4
    la a0, prompt_center_x
    ecall
    li a7, 5
    ecall
    mv t0, a0               # guardar x del centro

    li a7, 4
    la a0, prompt_center_y
    ecall
    li a7, 5
    ecall
    mv t1, a0               # guardar y del centro

    li a7, 4
    la a0, prompt_radius
    ecall
    li a7, 5
    ecall
    mv t2, a0               # guardar radio

    ret