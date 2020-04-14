;在屏幕中间依次显示a~z,按ESC后,改变颜色
assume  cs:codesg
stack segment
	db 128 dup(0)
stack ends
codesg segment
	start:
	mov ax,stack
	mov ss,ax
	mov sp,128

	mov ax,0b800h
	mov es,ax
	mov ah,'a'
	
	s:
	mov es:[160*12+40*2],ah
	call delay
	inc ah
	cmp ah,'z'
	jna s

	mov ax,4c00h	
	int 21h
	
	;循环延时显示a~z
	delay:
	push ax
	push dx
	mov dx,1000h	;循环次数
	mov ax,0

	s1:
	sub ax,1	;ax和bx存储32位循环次数
	sbb dx,0
	cmp ax,0
	jne s1
	cmp dx,0
	jne s1
	pop dx
	pop ax
	ret
codesg ends
end start
