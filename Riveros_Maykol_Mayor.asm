.data
    prompt: .asciiz "Ingrese un número: "  # Mensaje para solicitar números
    resultMsg: .asciiz "El número mayor es: "  # Mensaje para el resultado
    num1: .word 0  # Espacio para el primer número
    num2: .word 0  # Espacio para el segundo número
    num3: .word 0  # Espacio para el tercer número
    num4: .word 0  # Espacio para el cuarto número (opcional)
    num5: .word 0  # Espacio para el quinto número (opcional)

.text
main:
    # Leer el primer número
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, num1

    # Leer el segundo número
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, num2

    # Leer el tercer número
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, num3

    # Leer el cuarto número opcional
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, num4

    # Leer el quinto número opcional
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    sw $v0, num5

    # Cargar los números en registros
    lw $t0, num1
    lw $t1, num2
    lw $t2, num3
    lw $t3, num4
    lw $t4, num5

    # Encontrar el número mayor
    move $t5, $t0  # Inicializar el mayor con el primer número
    bgt $t1, $t5, update_max1
    j check2

update_max1:
    move $t5, $t1

check2:
    bgt $t2, $t5, update_max2
    j check3

update_max2:
    move $t5, $t2

check3:
    bgt $t3, $t5, update_max3
    j check4

update_max3:
    move $t5, $t3

check4:
    bgt $t4, $t5, update_max4
    j print_result

update_max4:
    move $t5, $t4

print_result:
    # Mostrar mensaje del resultado
    li $v0, 4
    la $a0, resultMsg
    syscall

    # Imprimir el número mayor
    li $v0, 1
    move $a0, $t5
    syscall

    # Salida del programa
    li $v0, 10
    syscall