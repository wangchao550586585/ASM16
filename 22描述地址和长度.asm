;a描述地址,以及从这个地址开始,以后的内存单元都是字节单元
assume  cs:codesg
codesg segment
	a db 1,2,3,4,5,6,7,8
	b dw 0
	start:
	mov si,0
	mov cx,8

	s:
	mov al,a[si]
	mov ah,0
	add b,ax
	inc si
	loop s

	mov ax,4c00h
	int 21h
	
codesg ends
end start
