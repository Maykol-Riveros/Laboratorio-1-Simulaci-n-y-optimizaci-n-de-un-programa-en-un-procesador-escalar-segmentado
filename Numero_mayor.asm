.data
    prompt_n: .asciiz "Ingrese la cantidad de números a comparar (mínimo 3, máximo 5): "
    prompt_val: .asciiz "Ingrese un número: "
    result_msg: .asciiz "El número mayor es: "
    newline: .asciiz "\n"

.text
.globl main
main:
    # Solicitar la cantidad de números
    li $v0, 4
    la $a0, prompt_n
    syscall

    li $v0, 5  # Leer un número entero
    syscall
    move $t0, $v0  # Guardar cantidad de números en $t0

    li $t1, 3   # Valor mínimo permitido
    li $t2, 5   # Valor máximo permitido
    blt $t0, $t1, exit  # Si es menor que 3, salir
    bgt $t0, $t2, exit  # Si es mayor que 5, salir

    li $t3, 0   # Contador de números ingresados
    li $t4, -2147483648  # Inicializar el mayor con el mínimo posible

input_loop:
    # Solicitar un número
    li $v0, 4
    la $a0, prompt_val
    syscall

    # Leer número
    li $v0, 5
    syscall
    move $t5, $v0  # Guardar el número ingresado

    # Comparar con el mayor actual
    bgt $t5, $t4, update_max
    j continue_loop

update_max:
    move $t4, $t5  # Actualizar el mayor

continue_loop:
    addi $t3, $t3, 1  # Incrementar el contador
    blt $t3, $t0, input_loop  # Si quedan números, repetir

    # Mostrar mensaje del resultado
    li $v0, 4
    la $a0, result_msg
    syscall

    # Imprimir el número mayor
    li $v0, 1
    move $a0, $t4
    syscall

    # Nueva línea
    li $v0, 4
    la $a0, newline
    syscall

exit:
    li $v0, 10  # Salir del programa
    syscall