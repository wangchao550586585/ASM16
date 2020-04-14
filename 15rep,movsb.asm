;将data段中的第一个字符串复制到它后面的空间中
assume  cs:codesg
data segment
	db 'Welcome to masm!'
	db 16 dup(0)
data ends
codesg segment
	start:
	mov ax,data
	mov ds,ax
	mov si,0	;ds:si传送的原始位置
	mov es,ax	
	mov di,16	;es:di传送的目的地址
	mov cx,16	;rep循环16次
	cld		;设置df=0,正向传送
	rep movsb

	mov ax,4c00h
	int 21h

codesg ends
end start
