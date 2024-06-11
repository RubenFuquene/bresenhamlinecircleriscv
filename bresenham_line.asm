	# t0 = x1
	# t1 = y1
	# t2 = x2
	# t3 = y2
	# t4 = dx
	# t5 = dy
	# t6 = dp
	# s7 = Old dp
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
    
    # For draw the line from left to right
    mv a1, t0
    mv a2, t1
    mv t0, t2
    mv t1, t3
    mv t2, a1
    mv t3, a2
    
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
	sub a0 t3, t1
	sub a1 t2, t0
	div s0, a0, a1

line_loop:
    # plot(x1, y1)
    jal plot_pixel
    
  	mv s7, t6					# Old dp = dp
  	slli t6, t5, 1				# 2 * dy
  	add t6, t6, s7				# dp = dp + 2 * dy
    
    add t0, t0, s1			# x1 += 1
	bge s7, zero, adjust_y1
	j check_end

adjust_y1:
	slli a1, t4, 1				# 2 * dx
	slli a2, t5, 1				# 2 * dy
	sub t6, a2, a1				# 2 * dy - 2 * dx
	add t6, t6, s7				# dp + 2 * dy - 2 * dx
	sub a1, t3, t1				# a1 = y2 - y1
	blt a1, x0, negative_slope	# jump to negative traetment if slope is negative
    add t1, t1, s1         		# y1 += 1
    j check_end
    
negative_slope:
	sub t1, t1, s1				# y1 -= 1

check_end:
    # while x1 <= x2
    ble t0, t2, line_loop  # Si x1 <= x2, continuar

	lw ra, 12(sp)        # Restaurar ra desde la pila
    addi sp, sp, 16      # Liberar espacio en la pila
    ret
