;BIOS中断例程
;一个中断例程有多个子程序
;ah传递内部子程序的编号
assume  cs:codesg
codesg segment
	start:
	mov ah,2	;放置光标
	mov bh,0	;第0页
	mov dh,5	;dh放行号
	mov dl,12	;列号
	int 10h		;包含多个和屏幕输出的子程序

	mov ah,9	;光标位置显示字符
	mov al,'a'	;字符
	mov bl,1101010b	;颜色属性
	mov bh,0	;第0页
	mov cx,2	;字符重复个数
	int 10h

	mov ax,4c00h
	int 21h
codesg ends
end start
