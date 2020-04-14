;将批量数据放到内存中,
;然后将它们所在内存空间的首地址放在寄存器中
;传递给需要的子程序,对于具有批量数据的返回结果,同样

;将一个全是字母的字符串转化大写
assume  cs:codesg

data segment
	db 'conversation'
data ends

codesg segment
  start:mov ax,data
	mov ds,ax
	mov si,0
	mov cx,12
	call capital

	mov ax,4c00h
	int 21h

capital:and byte ptr [si],11011111b
	inc si
	loop capital
	ret

codesg ends
end start