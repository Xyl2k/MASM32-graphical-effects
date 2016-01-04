	.386
	.model flat, stdcall
	option casemap :none

	; Укажем что используем JPG в ресурсах...
	USE_JPG	=	1
	;^^^^^^^^^^^^^^^^^^
	; determine that we use JPG in recources

	include inc.asm		; Подключаем файлики
	include about.asm	; Сам код для эффекта

.data

.code

start:

	invoke DialogBoxParam, 0, 110, 0, addr DlgProc_About, 0
	invoke ExitProcess,NULL

end start

; #########################################################################
