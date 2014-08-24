	.386
	.model flat, stdcall
	option casemap :none

; #########################################################################

	USE_BMP	=	1
	;^^^^^^^^^^^^^^^^^^

	include ..\inc\inc.asm
	include ..\inc\about.asm

.data

.code

start:

	invoke DialogBoxParam, 0, 110, 0, addr DlgProc_About, 0
	invoke ExitProcess,NULL

end start

; #########################################################################
