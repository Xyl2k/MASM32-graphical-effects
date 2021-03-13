mbPlainColor    EQU 01000000h 
mbDarker        EQU 02000000h

mbCreate            PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
mbDestroy           PROTO :DWORD
mbSetFont           PROTO :DWORD, :DWORD
mbSetText           PROTO :DWORD, :DWORD
mbSetTextColor      PROTO :DWORD, :DWORD
mbSetInnerColor     PROTO :DWORD, :DWORD
mbSetBorderColor    PROTO :DWORD, :DWORD
mbSetOuterColor     PROTO :DWORD, :DWORD
mbSetSizeBalls      PROTO :DWORD, :DWORD
mbSetSizeBorders    PROTO :DWORD, :DWORD