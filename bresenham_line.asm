	# t0 = x1
	# t1 = y1
	# t2 = x2
	# t3 = y2
	# t4 = dx
	# t5 = dy
	# t6 = dp
	# s0 = slope
	# s1 = 1

    .text

bresenham_line:
	addi sp, sp, -16     # Reservar espacio en la pila
    sw ra, 12(sp)        # Guardar ra en la pila
    
	li s1, 1
	
    # Calcular dx = abs(x2 - x1) = t4
    sub t4, t2, t0      		# t4 = x2 - x1
    bge t4, zero, x1_less_x2  	# Si t4 >= 0, saltar a x1_less_x2
    neg t4, t4          		# Si t4 < 0, t4 = -t4
    
x1_less_x2:
    # Calcular dy = abs(y2 - y1) = t5
    sub t5, t3, t1      		# t5 = y2 - y1
    bge t5, zero, y1_less_y2  	# Si t5 >= 0, saltar a y1_less_y2
    neg t5, t5          		# Si t5 < 0, t5 = -t5
    
y1_less_y2:
    # Inicializar dp = 2 * dy - dx = t6
	slli t6, t5, 1				# 2 * dy
	sub t6, t6, t4				# 2 * dy - dx
	
	# Calcular pendiente
	div s0, t5, t4

line_loop:
    # plot(x1, y1)
    jal plot_pixel
    add t0, t0, s1			# x1 += 1
	bge t6, zero, adjust_y1
	j check_end

adjust_y1:
    add t1, t1, s1         		# y1 += 1

check_end:
    # while x1 != x2 o y1 != y2
    bne t0, t2, line_loop  # Si x1 != x2, continuar
    bne t1, t3, line_loop  # Si y1 != y2, continuar
    
    # plot(x2, y2)
    jal plot_pixel

	lw ra, 12(sp)        # Restaurar ra desde la pila
    addi sp, sp, 16      # Liberar espacio en la pila
    ret
