assume  cs:codesg,ds:datasg
datasg segment
	db 'BaSic'
	db 'iNfOr'
datasg end

codesg segment
  start:mov ax,datasg
	mov ds,ax
	
	mov bx,0
	mov cx,5
      s:mov al,[bx]
        and al,11011111B
	mov [bx],al

	mov al,[5+bx]		;[bx+idata]
	or al,00100000B
	mov 5[bx],al

	inc bx
	loop s
	
	mov ax,4c00h
	int 21h
codesg ends
end start