;将用BCD码表示的月份以十进制的形式显示到屏幕上
assume  cs:codesg

codesg segment
	start:
	mov al,8
	out 70h,al	;访问8号单元数据
	in al,71h	;从数据端口71h取得指定单元中数据

	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b

	add ah,30h	;30H=48
	add al,30h

	mov bx,0b800h
	mov es,bx
	mov byte ptr es:[160*12+40*2],ah ;显示月份的十位数码
	mov byte ptr es:[160*12+40*2+2],al ;显示月份的个位数码

	mov ax,4c00h	
	int 21h
codesg ends
end start
