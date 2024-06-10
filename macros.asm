	.data
salto_linea_str: .string "\n"

	.text
salto_linea:
	li a7, 4                  # syscall for print_string
    la a0, salto_linea_str
    ecall
	ret                       # Regresar al punto de llamada