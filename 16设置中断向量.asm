;当发生除法溢出时,在屏幕中间显示"overflow!",返回到dos
;设置中断向量
;mov ax,0
;mov es,ax
;mov word ptr es:[0*4],200h
;mov word ptr es:[0*4+2],0
assume  cs:codesg
codesg segment
	start:
	;do0安装程序
	;1.设置ds:si指向源地址
	mov ax,cs		
	mov ds,ax
	mov si,offset do0	
	
	;2.设置es:di指向目的地址
	mov ax,0
	mov es,ax
	mov di,200h
	
	;3.设置cx为传输长度,+-*/是编译器识别的运算符号
	mov cx,offset do0end-offset do0
	
	;4.设置传输方向为正
	cld
	
	;5.复制
	rep movsb
	
	;6.设置中断向量表
	mov ax,4c00h
	int 21h

	do0:
	jmp short do0start
	db "overflow!"	;防止被覆盖,所以在do0声明
			;因为这放在开始处不是可以执行的代码,所以前面添加jmp


	;2.显示字符串"overflow!"
	do0start:

	;2.1设置ds:si指向字符串,jmp short do0start占2字节
	mov ax,cs
	mov ds,ax
	mov si,202h		

	;2.2设置es:di指向显存空间的中间位置
	mov ax,0b800h
	mov es,ax
	mov di,12*160+36*2	
	
	mov cx,9
	s:
	mov al,[si]
	mov es:[di],al
	inc si
	add di,2
	loop s

	;2.3.返回到dos			
	mov ax,4c00h
	int 21h

	do0end:nop
codesg ends
end start
