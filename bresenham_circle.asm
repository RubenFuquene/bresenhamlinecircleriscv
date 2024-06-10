.text

bresenham_circle:
    # Reservar espacio en la pila
    addi sp, sp, -20

    # Guardar ra en la pila
    sw ra, 16(sp)

    # Cargar el radio del círculo
    mv t3, t2  # t3 = radio

    # Inicializar variables
    li t0, 0  # x = 0
    li t1, 0  # y = 0
    li t4, 0  # e = radio
    li t5, t3  # dy = radio

    # Calcular el primer punto
    jal plot_pixel

    # Bucle principal
circle_loop:
        # Calcular el siguiente valor de x
        add t0, t0, s1  # x += 1

        # Calcular el error acumulado
        sub t6, t5, t4  # e2 - 2dx

        # Determinar si se debe incrementar y
        bge t6, zero, increment_y
        j continue_x

increment_y:
            # Incrementar y
            add t1, t1, s1  # y += 1

            # Calcular el nuevo valor de dy
            sub t5, t5, t4  # dy -= dx

continue_x:
            # Recalcular el error acumulado
            add t4, t4, s2  # dx += 2

            # Calcular el nuevo valor de e
            add t3, t3, s2  # e += 2

            # Ajustar las coordenadas con respecto al centro
            add t0, t0, t2  # x += centro_x
            add t1, t1, t2  # y += centro_y

            # Plotar el punto
            jal plot_pixel

            # Comprobar si se ha completado el círculo
            bne t0, t2, circle_loop

            # Plotar el último punto
            jal plot_pixel

            # Restaurar ra desde la pila
            lw ra, 16(sp)

            # Liberar espacio en la pila
            addi sp, sp, 20

            # Retornar
            ret

.include "plot_pixel.asm"
