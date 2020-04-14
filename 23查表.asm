;利用表,在2个数据集合之间建立一种映射关系
;以16进制形式在屏幕中间显示给定的字节型数据
assume  cs:codesg,ds:data

codesg segment
	showbyte:
	jmp short show
	table db '0123456789ABCDEF'	;字符表

	show:
	push bx
	push es
	
	mov ah,al
	shr ah,1
	shr ah,1
	shr ah,1
	shr ah,1
	and al,00001111b

	mov bl,ah
	mov bh,0
	mov ah,table[bx]

	mov bx,0b800h
	mov es,bx
	mov es:[160*12+40*2],ah

	mov bl,al
	mov bh,0
	mov al,table[bx]

	mov es:[160*12+40*2+2],al

	pop es
	pop bx
	ret
	
codesg ends
end start
