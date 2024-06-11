	.eqv RES_H 512
	.eqv RES_V 256
	.eqv DISPLAY 0x10040000  # Posicion de memoria donde inicia la visualizacion bitmap
    
	.data
# Color del pixel
px_rgb: .word 0x0000ff  # Color amarillo

newline: .string "\n"
comma: .string ", "
x_label: .string "x: "
y_label: .string " y: "

    .text

plot_pixel:
    # Info de la pantalla
	li	s2, RES_H
	li	s4, DISPLAY
	
	# mover la información de la posición x e y a los registros correspondientes
	mv a0, t0  # x
	mv a1, t1  # y
	
	# cargamos la información del color del pixel 
	la	s5, px_rgb
	lw	a2, 0(s5)  # color
	j pintarPixel  # Llamamos a la subrutina que pinta el pixel
	
pintarPixel:
	# a0 = x; a1 = y; a2 = color  		
	mul	s6, s2, a1  # t0 = RES_H * y
	add	s6, s6, a0  # t0 += x
	slli s6, s6, 2   # 4 bytes por pixel		
	add	s6, s6, s4  # Display
	sw	a2, 0(s6) # Color
	
	# Imprimir "x: "
    la a0, x_label
    li a7, 4       # syscall para print_string
    ecall

    # Imprimir x1 (t0)
    mv a0, t0
    li a7, 1       # syscall para print_int
    ecall

    # Imprimir ", "
    la a0, comma
    li a7, 4       # syscall para print_string
    ecall

    # Imprimir "y: "
    la a0, y_label
    li a7, 4       # syscall para print_string
    ecall

    # Imprimir y1 (t1)
    mv a0, t1
    li a7, 1       # syscall para print_int
    ecall

    # Imprimir nueva línea
    la a0, newline
    li a7, 4       # syscall para print_string
    ecall

	ret
