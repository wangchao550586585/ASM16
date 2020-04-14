;ah传递功能号
;0:清屏,显存中当前屏幕中的字符设为空格符
;1:设置前景色,设置显存中当前屏幕中处于奇地址的属性字节0,1,2位
;2:设置背景色,设置显存的4,5,6位
;3:向上滚动一行,将n+1行的内容复制到n行处,最后一行为空
;对于1,2al传送颜色值0~7
assume  cs:codesg,ds:data

codesg segment
   sub1:push bx
	push cx
	push es
	mov bx,0b800h
	mov es,bx
	mov bx,0
	mov cx,2000
	
  sub1s:mov byte ptr es:[bx],' '
	add bx,2
	loop sub1s
	pop es
	pop cx
	pop bx
	ret
	
   sub2:push bx
	push cx
	push es

	mov bx,0b800h
	mov es,bx
	mov bx,1
	mov cx,2000

  sub2s:and byte ptr es:[bx]
	or es:[bx],al
	add bx,2
	loop sub2s

	pop es
	pop cx
	pop bx
	ret

   sub3:push bx
	push cx
	push es
	mov cl,4
	shl al,cl
	mov bx,0b800h
	mov es,bx
	mov bx,1
	mov cx,2000

  sub3s:and byte ptr es:[bx],10001111b
	or es:[bx],al
	add bx,2
	loop sub3s
	pop es
	pop cx
	pop bx
	ret

   sub4:push cx
	push si
	push di
	push es
	push ds
	
	mov si,0b800h
	mov es,si
	mov ds,si	
	mov si,160	;ds:si指向n+1行
	mov di,0	;es:di指向n行
	cld
	mov cx,24	;复制24行
	
  sub4s:push cx
	mov cx,160
	rep movsb
	pop cx
	loop sub4s
	
	mov cx,80
	mov si,0
 sub4s1:mov byte ptr [160*24+si],' '	;最后一行清空
	add si,2
	loop sub4s1
	
	pop ds
	pop es
	pop di
	pop si
	pop cx
	ret

	;将子程序入口地址存储在表中
	;功能号*2=对应的功能子程序在地址表中的偏移
setscreen:jmp short set
	
	table dw sub1,sub2,sub3,sub4
	
    set:push bx
	
	cmp ah,3
	ja sret
	mov bl,ah
	mov bh,0
	add bx,bx

	call word ptr table[bx]

   sret:pop bx
	ret
	
	;---------实现方式二---------
setscreen:cmp ah,0
	je do1
	cmp ah,1
	je do2
	cmp ah,2
	je do3
	cmp ah,3
	je do4
	jmp short sret

    do1:call sub1
	jmp short sret
    do2:call sub2
	jmp short sret
    do3:call sub3
	jmp short sret
    do4:call sub4

   sret:ret
codesg ends
end start
