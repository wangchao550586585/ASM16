;如果ah=bh则ah=ah+ah,否则ah=ah+bh
assume  cs:codesg
codesg segment
	start:
	cmp ah,bh
	je s
	add ah,bh
	jmp short ok
	
	s:
	add ah,ah

	ok:
	mov ax,4c00h
	int 21h

codesg ends
end start
