	.386
	.model flat, stdcall
	option casemap :none

	; Укажем что используем JPG в ресурсах...
	USE_JPG	=	1
	;^^^^^^^^^^^^^^^^^^

	include ..\inc\inc.asm		; Подключаем файлики
	include ..\inc\about.asm	; Сам код для эффекта

.data

.code

start:

	invoke DialogBoxParam, 0, 110, 0, addr DlgProc_About, 0
	invoke ExitProcess,NULL

end start

; #########################################################################
