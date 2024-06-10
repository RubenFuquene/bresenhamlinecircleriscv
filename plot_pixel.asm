	.eqv RES_H 512
	.eqv RES_V 512
	.eqv DISPLAY 0x10040000  # Posicion de memoria donde inicia la visualizacion bitmap
    
	.data
# Color del pixel
px_rgb: .word 0x0000ff  # Color amarillo

    .text

plot_pixel:
    # Info de la pantalla
	li	s2, RES_H
	li	s3, RES_V
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
	ret
