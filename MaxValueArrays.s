.data
array:     .word 10, 3, 7, 15, 8  # Array of integers
array_size: .word 5               # Size of the array

.text
main:
    # Initialize registers

    # Load the base address of the array into $s0
    la $s0, array

    # Load the size of the array into $t7
    lw $t7, array_size

    # $t2 = Size of an integer in bytes
    li $t2, 4

    # Initialize variables to keep track of the largest integer and its index

    # $t3 = Largest integer (initialize to 0)
    li $t3, 0

    # $t4 = Index of largest integer (initialize to 0)
    li $t4, 0

add_loop:
    # Load the current integer from the array into $t0

    # Load the current integer from memory into $t0
    lw $t0, 0($s0)

    # Compare the current integer with the largest integer
    bgt $t0, $t3, update_largest

    # If not larger, continue to the next element
    j continue_loop

update_largest:
    # Update the largest integer and its index

    # $t3 = $t0 (current integer)
    move $t3, $t0

    # Calculate the index of the largest integer
    sub $t4, $s0, $s0  # $t4 = Index (calculate the offset)
    div $t4, $t2       # $t4 = Index / Size of an integer

continue_loop:
    # Move to the next element in the array
    addi $s0, $s0, 4

    # Decrement the loop counter and check for the end of the array
    subi $t7, $t7, 1
    beqz $t7, exit_loop  # If $t7 (loop counter) is zero, exit the loop

    # Continue the loop
    j add_loop

exit_loop:
    # Print the largest integer and its index

    # Print the largest integer (system call)
    li $v0, 1
    move $a0, $t3
    syscall

    # Exit program (system call)
    li $v0, 10
    syscall

# Data section
.data

# End of program

