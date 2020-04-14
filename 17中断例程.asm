;编写,实现求平方功能的程序
;安装在0:200处
;程序入口地址在7ch
assume  cs:codesg
codesg segment
	///////////
	;编写,安装中断7CH的中断例程
	;功能:求1word型数据的平方
	;参数:ax=要计算的数据
	;返回值:dx,ax存放结果高/低16位
	start:
	mov ax,3456
	int 7ch	;调用中断7ch的中断例程,计算ax^2
	add ax,ax
	adc dx,dx
	mov ax,4c00h
	int 21h
	////////////

	start:
	mov ax,cs
	mov ds,ax
	mov si,offset sqr
	mov ax,0
	mov es,ax
	mov di,200h
	mov cx,offset sqrend-offset sqr
	cld
	rep movsb

	mov ax,0
	mov es,ax
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0

	mov ax,4c00h
	int 21h

	sqr:mul ax
	iret
	
	sqrend:nop
codesg ends
end start
