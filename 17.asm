;屏幕中间显示80个!
;cx:循环次数
;bx:存放位移
assume  cs:codesg
codesg segment
	start:
	mov ax,0b800h
	mov es,ax
	mov di,160*12

	mov bx,offset s-offset se
	mov cx,80
	
	s:mov byte ptr es:[di],'!'
	add di,2
	int 7ch		;如果cx!=0,转移到标号s处

	se:nop
	
	mov ax,4c00h
	int 21h


	lp:
	push bp
	mov bp,sp
	dec cx
	jcxz lpret
	add [bp+2],bx	;bp为栈顶元素
			;se的偏移地址为(ss*16)+bp+2

	lpret:
	pop bp
	iret
codesg ends
end start
