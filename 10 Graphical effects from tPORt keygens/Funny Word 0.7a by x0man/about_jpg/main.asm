	.386
	.model flat, stdcall
	option casemap :none

	; ������ ��� ���������� JPG � ��������...
	USE_JPG	=	1
	;^^^^^^^^^^^^^^^^^^

	include ..\inc\inc.asm		; ���������� �������
	include ..\inc\about.asm	; ��� ��� ��� �������

.data

.code

start:

	invoke DialogBoxParam, 0, 110, 0, addr DlgProc_About, 0
	invoke ExitProcess,NULL

end start

; #########################################################################
