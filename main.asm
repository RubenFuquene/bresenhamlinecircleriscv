 	.data
prompt_draw: .string "¿Qué deseas dibujar (l: línea, c: círculo)? "

    .text
    .globl main

main:
    # Pedir qué dibujar
    li a7, 4				 # syscall for print_string
    la a0, prompt_draw
    ecall

    # Leer la entrada del usuario (línea o círculo)
    li a7, 12                # syscall for read_char
    ecall
    
    li t0, 108               # Cargar el valor ASCII de 'l' en t0
    li t1, 99                # Cargar el valor ASCII de 'c' en t1
   
    beq a0, t0, draw_line
    beq a0, t1, draw_circle
    # Si no es 'l' ni 'c', finalizar el programa
    j end
    
draw_line:
	jal salto_linea
    jal read_line_input    	# Leer entrada para la línea
    jal bresenham_line    	# Dibujar la línea
    j end
    
draw_circle:
    jal salto_linea
    jal read_circle_input  	# Leer entrada para la línea
    jal bresenham_circle    # Dibujar la línea
    j end
    
end:
    li a7, 10               # Finalizar el programa
    ecall
    
    .include "macros.asm"
	.include "input.asm"
	.include "bresenham_line.asm"
	.include "bresenham_circle.asm"
	.include "plot_pixel.asm"
