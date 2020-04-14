;编写,将一个全是字母,0结尾的字符串,转化大写
assume  cs:codesg
////////
data segment
	db 'conversaion',0
data ends
////////
codesg segment
	////////////
	start mov ax,cs
	mov ds,ax
	mov si,0
	int 7ch
	mov ax,4c00h
	int 21h
	////////////
	start:
	mov ax,cs
	mov ds,ax
	mov si,offset capital
	mov ax,0
	mov es,ax
	mov di,200h
	mov cx,offset capitalend-offset capital
	cld
	rep movsb

	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0

	mov ax,4c00h
	int 21h

	capital:push cx
		push si
	change:
		mov cl,[si]
		mov ch,0
		jcxz ok
		and byte ptr [si],11011111b
		inc si
		jmp short change
	ok:	pop si
		pop cx
		iret
	
	capitalend:nop
codesg ends
end start
