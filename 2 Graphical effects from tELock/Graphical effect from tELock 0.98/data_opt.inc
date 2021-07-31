  .data            
              ; int dword_409A52
              dword_409A52    dd 5                    ; DATA XREF: sub_402D44w
                                                      ; sub_402F0C+50w ...
              ; int dword_409A56
              dword_409A56    dd 14h                  ; DATA XREF: sub_402D44+Aw
                                                      ; sub_402F0C+63w ...
              dword_409A5A    dd 1                    ; DATA XREF: sub_402F0C+1Bw
                                                      ; sub_402F0C:loc_402F90w
              dword_409A5E    dd 0                    ; DATA XREF: sub_402D44+28w
                                                      ; sub_402F0C+12r ...
              dword_409A62    dd 0                    ; DATA XREF: sub_402D44+14w
                                                      ; sub_402F0C+93r ...
              dword_409A66    dd 0                    ; DATA XREF: sub_402D44+1Ew
                                                      ; sub_402F0C+5Ar ...
              dword_409A6A    dd 3                    ; DATA XREF: sub_402D44+32w
                                                      ; sub_402F0C:loc_402F34w ...
              ; char aTetickerclass[]
              aTetickerclass  db 'tETickerClass',0    ; DATA XREF: sub_4018B8+48o

              unk_409A7C db "   The CyberDoom Systems",0dh,0ch      
                         db "           Presents:",0dh,0ch
                         db "      nice graphical effect",0dh,0ch
                         db "         ripped from:",0dh,0ch
                         db "       tE Lock v0.98",0dh,0ch
                         db "    Enjoy this good work!",0dh,0ch
                         db "           It's All.",0dh,64h;0e1h;< wite before restart
                         db 0dh,1,0dh,1,0dh,1,0,0,87h,0dbh,90h
              
  
             byte_409B1C     db 55h                  ; DATA XREF: sub_4013D8+3Fo
                                                      ; sub_4013D8+4Ao .. 
 ;================================================================================ 
  
 .data?            

             
        tagSIZE STRUCT
        _cx   dd ?
        cy    dd ?
        tagSIZE ENDS     
             
             
             
              ; struct tagSIZE stru_409B04
              stru_409B04     tagSIZE <?>             ; DATA XREF: sub_402F0C+C9o
                                                      ; sub_402F0C+EDr ...
              ; RECT rc
              rc              RECT <?>                ; DATA XREF: sub_402D44+3Cw
                                                      ; sub_402D44+6Ao ...
             
              ; HDC dword_40EEF0
              dword_40EEF0    dd ? 
              ; HDC dword_40EEF4
              dword_40EEF4    dd ?                    ; DATA XREF: sub_401CA7+484r
                                                      ; sub_402D44+6Fr ...
              dword_40EEF8    dd ?                    ; DATA XREF: sub_402DBF+5Dw
                              ;align 10h
              ; HWND dword_40EF00
              dword_40EF00    dd ?                   ; DATA XREF: sub_403051+4w
                                                      ; sub_403051+Er 

              ; HBRUSH dword_40EEEC
              dword_40EEEC    dd ?                    ; DATA XREF: sub_4018B8+39w
                                                      ; sub_402D44+64r ...
              dword_40EEE0 dd ?
              dword_40EFB4 dd ?


             ; HDC dword_40EF08
              dword_40EF08    dd ?                    ; DATA XREF: sub_401CA7+479r
                                                      ; sub_402DBF+CEw ...
              dword_40EF0C    dd ?                    ; DATA XREF: sub_402DBF+DFw
              dword_40EF10    dd ?                    ; DATA XREF: sub_402DBF+6Ew
              ; LPARAM lParam
              _lParam          dd ?                    ; DATA XREF: sub_4018B8+C4w
                                                      ; sub_40359D+8r
              ; HMODULE hModule
              hModule         dd ?                    ; DATA XREF: sub_401096+49w




