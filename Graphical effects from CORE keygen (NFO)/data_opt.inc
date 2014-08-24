.data
dword_4100AC    dd 0FF2CE1h 
 
 
lpszDiskFile db "TMX.NFO",0 
 
 ; LOGFONTA stru_407C77
              stru_407C77 LOGFONTA  <8,4,0,0,FW_NORMAL,0,0,0,DEFAULT_CHARSET,0,0,0,0,'Terminal'>     
              
              
              
              
              dd 8;0Ah                  ; lfHeight ; DATA XREF: sub_40159B+1o
                              dd 4                    ; lfWidth
                              dd 0                    ; lfEscapement
                              dd 0                    ; lfOrientation
                              dd 190h                 ; lfWeight
                              db 0                    ; lfItalic
                              db 0                    ; lfUnderline
                              db 0                    ; lfStrikeOut
                              db 0FFh                 ; lfCharSet
                              db 1                    ; lfOutPrecision
                              db 2                    ; lfClipPrecision
                              db 1                    ; lfQuality
                              db 31h                  ; lfPitchAndFamily
  lfFaceName                  db 'Terminal',0;54h, 65h, 72h, 6Dh, 69h, 6Eh, 61h, 6Ch, 0
  
 
 ifdef INTERNAL_NFO
 include nfo.inc
 endif
 
ClassName db  "Static",0
byte_407FE9     db 1                    ; DATA XREF: sub_40159B+25w
                                                      ; TimerFunc+8r ...
 ; RECT rc
              rc              RECT <0, 0, 100h, 100h> ; DATA XREF: sub_40161E+73o

 dword_408036    dd 1                    ; DATA XREF: sub_40161E+134w
                                                      ; sub_40161E+1B9r ...
              byte_40803A     db 1                    ; DATA XREF: sub_40161E+1D5r
                                                      ; sub_40161E+1EDw ...
              ; COLORREF dword_40803B
              dword_40803B    dd 6F6F00h              ; DATA XREF: sub_40161E+99w
                                                      ; sub_40161E+9Fr ...
              dword_40803F    dd 32h                  ; DATA XREF: TimerFunc+17r
 
dword_4080BE    dd 21h                  ; DATA XREF: sub_40288F+18r

 ; COLORREF dword_4100B9
              dword_4100B9    dd 12FFFFh              ; DATA XREF: DialogFunc+34Dr
                                                      ; sub_40208A+BB

 ; LPCSTR lpString
              lpString        dd 0                    ; DATA XREF: sub_40161E:loc_401722r
                                                      ; sub_40161E:loc_401771r ...
                              align 4
                              db 0
              byte_4100D9     db 0                    ; DATA XREF: DialogFunc:loc_401BCAw
                                                      ; sub_40208A+39Dw ...
                              align 4
                              dd 65540000h, 6E696D72h
                              db 61h, 6Ch, 0
              ; DWORD dwSize
              dwSize          dd 0          



 .data?
 
byte_4100B0 db ?

hDlg dd ?



        tagSIZE STRUCT
        _cx   dd ?
        cy    dd ?
        tagSIZE ENDS     

 ; struct tagRECT Rect
             tagRECT STRUCT
             left    dd ?
             top     dd ?
             right   dd ?
             bottom  dd ?
             tagRECT ENDS



              ; struct tagRECT stru_40FF78
              stru_40FF78     tagRECT <?>             ; DATA XREF: DialogFunc+680o
                                                      ; DialogFunc+69Fr ...
              dword_40FF88    dd ?                    ; DATA XREF: sub_402017+3Ew
                                                      ; sub_402017+57r
              dword_40FF8C    dd ?                    ; DATA XREF: sub_402017+2Dw
                                                      ; sub_402017+49r
              ; struct tagRECT stru_40FF90
              stru_40FF90     tagRECT <?>             ; DATA XREF: sub_402017+15o
                                                      ; sub_402017+52r ...
              ; HWND dword_40FFA0
              dword_40FFA0    dd ?                    ; DATA XREF: sub_402017w
                                                      ; sub_402017+60r ...
              ; HGDIOBJ dword_40FFA4
              dword_40FFA4    dd ?                    ; DATA XREF: sub_40161E+48w
                                                      ; sub_40161E+4Dr ...
              ; HRSRC hResInfo
              hResInfo        dd ?                    ; DATA XREF: DialogFunc+638w
                                                      ; DialogFunc+64Er ...
              ; DWORD dword_40FFAC
              dword_40FFAC    dd ?                    ; DATA XREF: DialogFunc+65Fw
                                                      ; DialogFunc+704r ...
              ; HGLOBAL hResData
              hResData        dd ?                    ; DATA XREF: DialogFunc+649w
                                                      ; DialogFunc+664r ...
                              ;align 8
              ; char TemplateName[]
              ;TemplateName    db 'TAM',0              ; DATA XREF: start+2Ao
              ; LPARAM dword_40FFBC
              dword_40FFBC    dd ?          


              dword_406FD4    dd ?                    ; DATA XREF: sub_40208A+4w
                                                      ; sub_40208A+8Fr ...
              dword_406FD8    dd ?                    ; DATA XREF: sub_40208A+Aw
                                                      ; sub_40208A+95r ...
              dword_406FDC    dd ?                    ; DATA XREF: sub_40208A+10w
                                                      ; sub_40208A+9Br ...
              dword_406FE0    dd ?                    ; DATA XREF: sub_40208A+16w
                                                      ; sub_40208A+A1r ...
              dword_406FE4    dd ?                    ; DATA XREF: sub_40208A+1Cw
                                                      ; sub_40208A+A7r ...
              dword_406FE8    dd ?                    ; DATA XREF: code:00401516r
              dword_406FEC    dd ?                    ; DATA XREF: code:0040151Cr
              dword_406FF0    dd ?                    ; DATA XREF: 





 byte_410206     db ?                    ; DA
 byte_4101A7     db ?         

           
 
 
 
             
              ; HGDIOBJ dword_407FE5
              dword_407FE5    dd ?                    ; DATA XREF: sub_401571+14r
                                                      ; sub_40159B+Bw ...
              
              ; HDC dword_407FEA
              dword_407FEA    dd ?                    ; DATA XREF: sub_40161E+12w
                                                      ; sub_40161E+17r ...
              ; struct tagPOINT Point

              tagPOINT struct
              x dd ?
              y dd ?
              tagPOINT ends





              Point           tagPOINT <?>            ; DATA XREF: sub_40161E+19Eo
                                                      ; sub_40161E+1AEr ...
             



              Rect            tagRECT <?>             ; DATA XREF: sub_40159B+10o
                                                      ; sub_40161E+27r ...
              ; HDC dword_408006
              dword_408006    dd ?                    ; DATA XREF: sub_40161E+22w
                                                      ; sub_40161E+53r ...
              ; HWND hWnd
              hWnd            dd ?                    ; DATA XREF: sub_40159B+15r
                                                      ; sub_40161E+7r ...
              ; HGDIOBJ dword_40800E
              dword_40800E    dd ?                    ; DATA XREF: sub_40161E+5Ew
                                                      ; sub_40161E+216r ...
              dword_408012    dd ?                    ; DATA XREF: sub_40208A+16Aw
                                                      ; sub_4024C6+16Aw
              ; HGDIOBJ dword_408016
              dword_408016    dd ?                    ; DATA XREF: sub_40161E+6Dw
                                                      ; sub_40161E+232r ...
             
                                                      ; sub_40161E+10Eo ...
              dword_40802A    dd ?                    ; DATA XREF: sub_40208A+17Ew
                                                      ; sub_4024C6+17Ew
              dword_40802E    dd ?                    ; DATA XREF: sub_40208A+188w
                                                      ; sub_4024C6+188w
              ; int dword_408032
              dword_408032    dd ?                    ; DATA XREF: sub_40161E+175r
                                                      ; sub_40161E+1C2r ...
             
                                                      ; TimerFunc+30w ...
              byte_408043     db ?                    ; DATA XREF: sub_40161E+90r
                                                      ; sub_40161E+ABw ...
              dword_408044    dd ?                    ; DATA XREF: sub_40288F+4w
                                                      ; sub_40288F+4Ao
              dword_408048    dd ?                    ; DATA XREF: sub_40288F+23w
              dword_40804C    dd ?                    ; DATA XREF: sub_40288F+2Bw
              dword_408050    dd ?                    ; DATA XREF: sub_40288F+38w
              dword_408054    dd ?                    ; DATA XREF: sub_40288F+33w
              dword_408058    dd ?                    ; DATA XREF: sub_40288F+45w
              dword_40805C    dd 10h dup(?)           ; DATA XREF: sub_40288F+Eo
              ;aBlackSquadronO db 'bLACK sQUADRON OWnZ  Ze  SCeNE =)',0
                                                      ; DATA XREF: sub_40288F+13o
              

              byte_41022F     db ? ;start flag                   ; DATA XREF: sub_40161E+F4r
                                                      ; sub_40161E+143r ...
                              dd ?
              ; HANDLE hThread
              hThread         dd ?                    ; DATA XREF: DialogFunc+80r
                                                      ; DialogFunc:loc_4019E8r
              ; HANDLE hEvent
              hEvent          dd ?        

             







             
