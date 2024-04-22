.data
output_text:	.string "Max: %d\nMin: %d\n Zera: %d\n"
table:		.long 15, -21, 0, 0, 5, 9, 7, 1, 2, -38, 3, -5, 9, 123, 0
count:		.long 15


.text
.global main


main:
	push	%rbp
	
	xor	%esi, %esi
	xor	%edx, %edx
	xor	%ecx, %ecx

	mov	$-1, %eax

for_loop:
	incl	%eax
	cmp	count, %eax
	je	for_loop_end
	
	mov	table(,%eax,4), %r8d
	cmp	$0, %r8d
	je	handle_zero
handled_zero:
	cmp	%r8d, %esi
	jl	handle_max
handled_max:
	cmp	%r8d, %edx
	jg	handle_min
	jmp	for_loop

handle_max:
	mov	%r8d, %esi
	jmp	handled_max
handle_min:
	mov	%r8d, %edx
	jmp	for_loop
handle_zero:
	inc	%ecx
	jmp	handled_zero

for_loop_end:
	mov	$output_text, %rdi
	xor	%al, %al
	call	printf

end:
	xor	%eax, %eax
	pop	%rbp
	ret
