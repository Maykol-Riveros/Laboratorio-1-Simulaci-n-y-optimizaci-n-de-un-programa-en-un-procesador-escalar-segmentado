.data
    introMsg: .asciiz "Ingrese la cantidad de números de la serie Fibonacci que desea generar:\n"
    prompt: .asciiz "Ingrese un número: "
    resultMsg: .asciiz "Serie Fibonacci: "
    sumMsg: .asciiz "\nLa suma de la serie es: "
    n: .word 0  # Número de términos a generar

.text
main:
    # Mostrar mensaje introductorio
    li $v0, 4
    la $a0, introMsg
    syscall

    # Leer el número de términos de la serie
    li $v0, 5
    syscall
    sw $v0, n

    # Inicializar variables para Fibonacci
    li $t0, 0  # Primer número de la serie
    li $t1, 1  # Segundo número de la serie
    li $t2, 0  # Contador
    lw $t3, n  # Cargar el número de términos
    li $t4, 0  # Suma total de la serie

    # Mostrar mensaje del resultado
    li $v0, 4
    la $a0, resultMsg
    syscall

fibonacci_loop:
    # Comprobar si hemos generado suficientes términos
    bge $t2, $t3, print_sum

    # Imprimir número actual de Fibonacci
    li $v0, 1
    move $a0, $t0
    syscall

    # Imprimir espacio
    li $v0, 11
    li $a0, 32  # Código ASCII para espacio
    syscall

    # Sumar a la suma total
    add $t4, $t4, $t0

    # Calcular siguiente número de Fibonacci
    add $t5, $t0, $t1
    move $t0, $t1
    move $t1, $t5

    # Incrementar contador
    addi $t2, $t2, 1
    j fibonacci_loop

print_sum:
    # Mostrar mensaje de suma
    li $v0, 4
    la $a0, sumMsg
    syscall

    # Imprimir suma total
    li $v0, 1
    move $a0, $t4
    syscall

    # Salida del programa
    li $v0, 10
    syscall
