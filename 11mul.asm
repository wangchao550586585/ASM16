;用寄存器存储传参和结果
;计算data段中第一组数据的3次方,结果保存在后面一组dword单元中
assume  cs:codesg

data segment
	dw 1,2,3,4,5,6,7,8
	dd 0,0,0,0,0,0,0,0
data ends

codesg segment
  start:mov ax,data
        mov ds,ax
	mov si,0	;ds:si指向第一组word单元
	mov di,16	;dd:si指向第一组dword单元
	 
	mov cx,8
      s:mov bx,[si]
        call cube
	
	;存储结果
	mov [di],ax
	mov [di].2,dx
	
	;转到下一个数
	add si,2
	add di,4
	loop s

	mov ax,4c00h
	int 21h


   ;说明:计算N^3
   ;参数:bx
   ;结果dx:ax=N^3
   cube:mov ax,bx
	mul bx
	mul bx
	ret

codesg ends
end start