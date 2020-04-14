;将循环计数器放在内存单元中,缺点变量过多需要记住每个存储内存地址
assume  cs:codesg,ds:datasg
datasg segment
	db 'ibm             '
	db 'dec             '
	db 'dos		    '
	db 'vax		    '
	dw 0			;暂存cx
datasg end

codesg segment
  start:mov ax,datasg
	mov ds,ax
	
	mov bx,0
	mov cx,4

      s:mov dx:[40H],cx	;cx存储在内存
        mov si,0
	mov cx,3

      s0:mov al,[bx+si]
        and al,11011111B
	mov [bx+si],al
	inc si;
        loop s0
        
	add bx,16
	mov cx,dx:[40H]
	loop s
			
	mov ax,4c00h
	int 21h
codesg ends
end start