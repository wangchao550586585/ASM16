assume  cs:codesg

codesg segment

	;算出1EF000H+201000H结果
  start:Mov ax,001EH
	Mov bx,0F000H
	Add bx,1000H
	Adc ax,0020H
	
	;2个128位数据进行相加
	
	;因为数据为128位,所以需要8个字单元
	add128:push ax
	push cx
	push si		;ds:si指向存储第一个数的内存空间
	push di		;指向存储第二个数的内存空间
	
	sub ax,ax	;CF设置0
	mov cx,8

	s:mov ax,[si]
	adc ax,[di]
	mov [si],ax
	inc si
	inc si
	inc di
	inc di
	loop s

	pop ax
	pop cx
	pop si
	pop di
	ret
	
	mov ax,4c00h
	int 21h

codesg ends
end start
