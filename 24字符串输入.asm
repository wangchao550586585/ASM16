;1:输入同时显示这个字符串
	;从字符栈的栈底到栈顶显示所有字符
;2:输入回车后,字符串输入结束
	;输入回车后,字符串中加入0，表示字符串结束
;3:能删除已经输入的字符
	;输入删除按照栈进行的
;ds:si指向字符串的存储空间,以0为结尾符

assume  cs:codesg
codesg segment
	;字符串的入栈,出栈,显示
	;ah=功能号
	;0入栈,al=入栈字符
	;1出栈,al=返回字符
	;2显示,dh,dl=字符串在屏幕显示行,列


getstr:push ax

getstrs:mov ah,0
	int 16h
	cmp al,20h
	jb nochar	;ASCII码<20H,说明不是字符
	mov ah,0	
	call charstack	;字符入栈
	mov ah,2
	call charstack	;显示栈中字符
	jmp getstrs

nochar:cmp ah,0eh	;退格键的扫描码
	je backspace
	cmp ah,1ch	;enter键的扫描码
	je enter
	jmp getstrs

backspace:mov ah,1
	call charstack
	mov ah,2
	call charstack
	jmp getstrs

enter:mov al,0
	mov ah,0
	call charstack
	mov ah,2
	call charstack
	pop ax
	ret

charstack:jmp short charstart
	table	dw charpush,charpop,charshow
	top	dw 0	;栈顶

charstart:push bx
	push dx
	push di
	push es

	cmp ah,2
	ja sret
	mov bl,ah
	mov bh,0
	add bx,bx
	jmp word ptr table[bx]
	
charpush:mov bx,top
	mov [si][bx],al
	inc top
	jmp sret

charpop:cmp top,0
	je sret
	dec top
	mov bx,top
	mov al,[si][bx]
	jmp sret

charshow:mov bx,0b800h
	mov es,bx
	mov al,160
	mov ah,0
	mul dh
	mov di,ax
	add dl,dl
	mov dh,0
	add di,dx

	mov bx,0

charshows:cmp bx,top
	jne noempty
	mov byte ptr es:[di],' '
	jmp sret

noempty:mov al,[si][bx]
	mov es:[di],al
	mov byte ptr es:[di+2],' '
	inc bx
	add di,2
	jmp charshows

sret:pop es
	pop di
	pop dx
	pop bx
	ret



codesg ends
end 
