;双层循环改变字母为大写,缺点寄存器使用过多
assume  cs:codesg,ds:datasg
datasg segment
	db 'ibm'
	db 'dec'
	db 'dos'
	db 'vax'
datasg end

codesg segment
  start:mov ax,datasg
	mov ds,ax
	
	mov bx,0
	mov cx,4

      s:mov dx,cx	;将外层循环的cx存储在dx
        mov si,0
	mov cx,3

      s0:mov al,[bx+si]
        and al,11011111B
	mov [bx+si],al
	inc si;
        loop s0
        
	add bx,16
	mov cx,dx
	loop s
			
	mov ax,4c00h
	int 21h
codesg ends
end start