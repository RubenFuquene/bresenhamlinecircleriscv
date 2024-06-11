# t0 = xc
# t1 = yc
# t2 = r
# t4 = x cal
# t5 = y cal
# a1 = p
# a2 = old p
	
	.eqv ONE 1
	.eqv THREE 3
	.eqv FOUR 4
	.eqv SIX 6
	.eqv TEN 10

    .text

bresenham_circle:
	addi sp, sp, -16	# Reservar espacio en la pila
    sw ra, 12(sp)		# Guardar ra en la pila
    
	# Inicializar variables
    add t1, t1, t2		# yc = r
    mv t4, t0
    mv t5, t1
    
    slli a1, t2, 1		# p = 2 * r
    li a2, THREE
	sub a1, a2, a1		# p = 3 - 2 * r
	
# Bucle principal
circle_loop:
	j plot_circle_points	# Llamar a la función para plotear cuadrantes 1 y 3
	
	# Ajuste para la segunda parte del cuadrante
	mv t0, t5
	mv t1, t4
	
	j plot_circle_points	# Llamar a la función para plotear cuadrantes 2 y 4
	
    # Incrementar x cal
    addi t4, t4, 1
	mv a2, a1				# old p = p

    # Decidir y ajustar y cal basado en p
    bge a1, zero, adjust_y  # Si p >= 0, ajustar y
    j no_adjust_y
    
adjust_y:
	li a3, ONE
    sub t5, t5, a2          # y cal -= 1
    
    sub a1, t4, t5			# p = x cal - y cal
   	li a3, FOUR
    mul a1, a1, a3			# p = 4 * p
    add a1, a1, a2			# p = old p + p
   	li a3, TEN
    add a1, a1, a3			# p = p + 10

    j continue_loop

no_adjust_y:
   	li a3, FOUR
    mul a1, t4, a3			# p = 4 * x cal
    add a1, a1, a2			# p = old p + p
   	li a3, SIX
    add a1, a1, a3			# p = p + 6
    
continue_loop:
    # Condición de finalización
    bge t4, t5, check_circle_end  # Si x >= y, terminar el bucle

    j circle_loop
	
plot_circle_points:
    # plot(xc, yc)
    jal plot_pixel

    # plot(-xc, yc)
	neg t0, t0
    jal plot_pixel

    # plot(xc, -yc)
    neg t0, t0
    neg t1, t1
    jal plot_pixel

    # plot(-xc, -yc)
    neg t0, t0
    jal plot_pixel
    
    ret

check_circle_end:

	lw ra, 12(sp)        # Restaurar ra desde la pila
    addi sp, sp, 16      # Liberar espacio en la pila
    ret
