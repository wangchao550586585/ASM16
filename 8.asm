assume  cs:codesg


codesg segment
	;offset:取得标号的偏移地址
  start:mov ax,offset start ; <==>mov ax,0因为start是代码段中的标号,标记的是第一条指令,所以地址为0
      s:mov ax,offset s     ; <==>mov ax,3因为第一条指令字节为3
	

	;s处一条指令复制到s0
	s:mov ax,bx	;对应机器码占2字节
	mov si,offset s
	mov di,offset s0
	mov ax,cs:[si]
	mov cs:[di],ax
	s0:nop		;nop机器码占1字节
	   nop

	;段内短转移:jmp short 标号(所以ip修改地址范围为-128~127,标号为CS:IP指向的地址)
	start:mov ax,0
	mov bx,0
	jmp short s
	add ax,1
	s:inc ax

	;段内近转移:Jmp near ptr 标号
	;段间转移:jmp far ptr 标号
	

	mov ax,4c00h
	int 21h
codesg ends
end start