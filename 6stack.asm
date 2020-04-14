;暂存数据时,推荐栈
assume  cs:codesg,ds:datasg,ss:stacksg
datasg segment
	db 'ibm             '
	db 'dec             '
	db 'dos		    '
	db 'vax		    '
datasg end

stacksg segment
	dw 0,0,0,0,0,0,0,0	;定义一个段,用来做栈段,容量16字节
stacksg ends

codesg segment
  start:mov ax,stacks
	mov ss,ax
	mov sp,16

	mov ax,datasg
	mov ds,ax
	
	mov bx,0
	mov cx,4

      s:push cx		
        mov si,0
	mov cx,3

      s0:mov al,[bx+si]
        and al,11011111B
	mov [bx+si],al
	inc si;
        loop s0
        
	add bx,16
	pop cx
	loop s
			
	mov ax,4c00h
	int 21h
codesg ends
end start