;对磁盘读写
;每个扇区大小为512B
;2面*80磁道*18扇区*512B=1440KB
assume  cs:codesg
codesg segment
	;0面,0磁道,1扇区内容写到0:200
	mov ax,0
	mov es,ax	;es:bx指向接收从扇区读入数据的内存区
	mov bx,200h

	mov al,1	;读取的扇区数
	mov ch,0	;磁道号
	mov cl,1	;扇区号
	mov dl,0	;驱动器号,软驱,0:软驱A,1:软驱B
			;硬盘从80H开始,80H硬盘C,81H磁盘B
	mov dh,0	;磁头号(软盘即面号)
	mov ah,2	;2表示读扇区
	int 13h		;访问磁盘
	
	;操作成功,返回ah=0,al=读入的扇区数
	;失败,返回ah=出错代码

	;0:200内容写到0面,0磁道,1扇区
	mov ax,0	
	mov es,ax	;es:bx指向将写入磁盘的数据
	mov bx,200h

	mov al,1
	mov ch,0
	mov cl,1
	mov dl,0
	mov dh,0

	mov ah,3	;写扇区
	int 13h
codesg ends
end start
