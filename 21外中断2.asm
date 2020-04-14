;在屏幕中间依次显示a~z,按ESC后,改变颜色
assume  cs:codesg
stack segment
	db 128 dup(0)
stack ends

data segment
	dw 0,0
data ends
codesg segment
	start:
	mov ax,stack
	mov ss,ax
	mov sp,128
	
	mov ax,data 
	mov ds,ax

	mov ax,0
	mov es,ax
	
	;将原来的int 9的入口地址保存ds:0~2单元中
	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]
	
	;在中继向量表中设置新的int9中断例程的入口地址
	mov word ptr es:[9*4],offset int9
	mov es:[9*4+2],cs

	mov ax,0b800h
	mov es,ax
	mov ah,'a'
	
	s:
	mov es:[160*12+40*2],ah
	call delay
	inc ah
	cmp ah,'z'
	jna s
	
	mov ax,0
	mov es,ax
	
	;将中继向量表中int9的入口恢复为原来的地址
	push ds:[0]
	pop es:[9*4]
	push ds:[2]
	pop es:[9*4+2]
	
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

;------------------------------------
	int9:
	push ax
	push bx
	push es

	in al,60h
	
	;模拟int指令执行过程
	pushf	;标志寄存器入栈
	
	;IF=TF=0,在进入中断例程后,IF,TF置0了,所以可以不设置
	pushf
	pop bx
	and bh,11111100b
	push bx
	popf
	;调用原来的int9
	call dword ptr ds:[0]

	cmp al,1
	jne int9ret

	mov ax,0b800h
	mov es,ax
	inc byte ptr es:[160*12+40*2+1]	;将属性+1,改变颜色

	int9ret:
	pop es
	pop bx
	pop ax
	iret
codesg ends
end start
