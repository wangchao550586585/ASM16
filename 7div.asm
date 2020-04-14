;暂存数据时,推荐栈
assume  cs:codesg,ds:data

data segment
	dd 100001
	dw 100
	dw 0
data ends

codesg segment
  start:
	;100001/100
	;因为被除数>65535,所以用DX+AX存储
	;因为除数<255,可以用8位寄存器存放,
	;但是因为被除数32位,除数应为16位,所以用16位寄存器存放
	mov dx,1
	mov ax,86A1H
	mov bx,100
	div bx

	;1001/100
	;因为1001<65535,所以用ax存放
	;除数<255,同时被除数16位,所以用8位寄存器存储
	mov ax,1001
	mov bl,100
	div bl
	
	;data第一个数是被除数,且32位,所以高低位分别ax/dx存储
	mov ax,data
	mov ds,ax
	mov ax,ds:[0]
	mov dx,ds:[2]
	div word ptr ds:[4]
	mov ds:[6],ax

	
	mov ax,4c00h
	int 21h
codesg ends
end start