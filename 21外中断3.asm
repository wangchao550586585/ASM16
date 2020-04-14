;按F1后改变当前屏幕的显示颜色
assume  cs:codesg
stack segment
	db 128 dup(0)
stack ends

codesg segment
	start:
	mov ax,stack
	mov ss,ax
	mov sp,128
	
	push cs
	pop ds

	mov ax,0
	mov es,ax

	mov si,offset int9	;ds:si指向源地址
	mov di,204h		;es:di指向目的地址
	mov cx,offset int9end-offset int9
	cld
	rep movsb

	push es:[9*4]
	pop es:[200h]
	push es:[9*4+2]
	pop es:[202h]

	cli
	mov word ptr es:[9*4],204h
	mov word ptr es:[9*4+2],0
	sti


codesg ends
end start
