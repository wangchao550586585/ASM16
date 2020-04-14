;算出1EF000H+201000H结果
assume  cs:codesg

codesg segment

  start:Mov ax,001EH
	Mov bx,0F000H
	Add bx,1000H
	Adc ax,0020H

	mov ax,4c00h
	int 21h

codesg ends
end start
