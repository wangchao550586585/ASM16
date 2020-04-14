;一般将数据定义其他段中
;在代码段中直接用数据标记访问数据,需要assume将标号所在的段和一个段寄存器联系一起
;这是编译器工作需要知道的,实际中需要代码段地址赋值给ds
assume  cs:codesg,ds:data

data segment
	a db 1,2,3,4,5,6,7,8
	b dw 0
	c dw a,b	;<==>c dw offset a,offset b
	d dd a,b	;<==>d dw offset a,seg a,offset b,seg b存储的2个双字型数据为标号的偏移地址&段地址
data ends

codesg segment
	start:
	;设置ds指向data段
	mov ax,data
	mov ds,ax

	mov si,0
	mov cx,8

	s:
	mov al,a[si]	;编译mov al,[si+0]
	mov ah,0
	add b,ax	;编译add [8],ax
	inc si
	loop s

	mov ax,4c00h
	int 21h
	
codesg ends
end start
