;DOS中断例程,都包含在int 21h中
assume  cs:codesg
data segment
	db 'welcome to masm','$'
data ends
codesg segment
	start:
	mov ah,2	;设置光标
	mov bh,0	;第0页
	mov dh,5	;dh放行号
	mov dl,12	;dl放列号
	int 10h
	
	;要显示的字符串要用'$'作为结束符
	;ds:dx指向字符串
	mov ax,data
	mov ds,ax
	mov dx,0
	mov ah,9	;表示在光标位置显示字符串
	int 21h
	
	;调用第21h号中断例程的4ch号子程序
	;功能为程序返回,al为返回值
	mov ax,4c00h	
	int 21h
codesg ends
end start
