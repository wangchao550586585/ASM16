;使用call&ret实现子程序机制
assume  cs:codesg
codesg segment
   main:
	...
	call sub1
	...
	mov ax,4c00h
	int 21h
   sub1:
	...
	call sub2
	...
	ret
   sub2:
	...
	ret

codesg ends
end start