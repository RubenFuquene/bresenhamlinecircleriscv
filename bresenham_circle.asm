# t0 = x pixel
# t1 = y pixel
# t2 = r
# t4 = xc
# t5 = yc
# s0 = x
# s1 = y
# s3 = p
# s4 = old p
	
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
	mv t4, t0			# xc = x pixel
	mv t5, t1			# yc = y pixel
	mv s0, x0			# x = 0
	mv s1, t2			# t = r
    
    slli s3, t2, 1		# p = 2 * r
    li a2, THREE
	sub s3, a2, s3		# p = 3 - 2 * r
	
# Bucle principal
circle_loop:

	# plot(xc + x, yc + y)
    add t0, t4, s0          # xc + x
    add t1, t5, s1          # yc + y
    jal plot_pixel

    # plot(xc - x, yc + y)
    sub t0, t4, s0          # xc - x
    add t1, t5, s1          # yc + y
    jal plot_pixel

    # plot(xc + x, yc - y)
    add t0, t4, s0          # xc + x 
    sub t1, t5, s1          # yc - y
    jal plot_pixel

    # plot(xc - x, yc - y)
    sub t0, t4, s0          # xc - x
    sub t1, t5, s1          # yc - y
    jal plot_pixel

    # plot(xc + y, yc + x)
    add t0, t4, s1          # xc + y
    add t1, t5, s0          # yc + x
    jal plot_pixel

    # plot(xc - y, yc + x)
    sub t0, t4, s1          # xc - y
    add t1, t5, s0          # yc + x
    jal plot_pixel

    # plot(xc + y, yc - x)
    add t0, t4, s1          # xc + y
    sub t1, t5, s0          # yc - x
    jal plot_pixel

    # plot(xc - y, yc - x)
    sub t0, t4, s1          # xc - y
    sub t1, t5, s0          # yc - x
    jal plot_pixel
	
    # Incrementar x
    addi s0, s0, 1
	mv s4, s3				# old p = p

    # Decidir y ajustar y cal basado en p
    bge s3, zero, adjust_y  # Si p >= 0, ajustar y
    j no_adjust_y
    
adjust_y:
	li a3, ONE
    sub s1, s1, a3          # y -= 1
    
    sub s3, s0, s1			# p = x - y
   	li a3, FOUR
    mul s3, s3, a3			# p = 4 * p
    add s3, s3, s4			# p = old p + p
   	li a3, TEN
    add s3, s3, a3			# p = p + 10

    j continue_loop

no_adjust_y:
   	li a3, FOUR
    mul s3, s0, a3			# p = 4 * x
    add s3, s3, s4			# p = old p + p
   	li a3, SIX
    add s3, s3, a3			# p = p + 6
    
continue_loop:
    # Condición de finalización
    bge s0, s1, circle_end  # Si x >= y, terminar el bucle

    j circle_loop

circle_end:

	# plot(xc + x, yc + y)
    add t0, t4, s0          # xc + x
    add t1, t5, s1          # yc + y
    jal plot_pixel

    # plot(xc - x, yc + y)
    sub t0, t4, s0          # xc - x
    add t1, t5, s1          # yc + y
    jal plot_pixel

    # plot(xc + x, yc - y)
    add t0, t4, s0          # xc + x 
    sub t1, t5, s1          # yc - y
    jal plot_pixel

    # plot(xc - x, yc - y)
    sub t0, t4, s0          # xc - x
    sub t1, t5, s1          # yc - y
    jal plot_pixel

    # plot(xc + y, yc + x)
    add t0, t4, s1          # xc + y
    add t1, t5, s0          # yc + x
    jal plot_pixel

    # plot(xc - y, yc + x)
    sub t0, t4, s1          # xc - y
    add t1, t5, s0          # yc + x
    jal plot_pixel

    # plot(xc + y, yc - x)
    add t0, t4, s1          # xc + y
    sub t1, t5, s0          # yc - x
    jal plot_pixel

    # plot(xc - y, yc - x)
    sub t0, t4, s1          # xc - y
    sub t1, t5, s0          # yc - x
    jal plot_pixel

	lw ra, 12(sp)        # Restaurar ra desde la pila
    addi sp, sp, 16      # Liberar espacio en la pila
    ret
