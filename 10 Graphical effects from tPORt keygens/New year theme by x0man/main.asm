	.386
	.model flat, stdcall
	option casemap :none

	; ������ ��� ���������� JPG � ��������...
	USE_JPG	=	1
	;^^^^^^^^^^^^^^^^^^
	; determine that we use JPG in recources

	include inc.asm		; ���������� �������
	include about.asm	; ��� ��� ��� �������

.data

.code

start:

	invoke DialogBoxParam, 0, 110, 0, addr DlgProc_About, 0
	invoke ExitProcess,NULL

end start

; #########################################################################
