;将当前屏幕的内容保存到磁盘上
;一屏的内容占4000字节,需要8个扇区
;每个扇区大小为512B
;2面*80磁道*18扇区*512B=1440KB
assume  cs:codesg
codesg segment
	start:
	mov ax,0b800h
	mov es,ax
	mov bx,0

	mov al,8	;用8个扇区数
	mov ch,0
	mov cl,1
	mov dl,0
	mov dh,0
	mov ah,3
	int 13h

	mov ah,4c00h
	mov 21h

codesg ends
end start
