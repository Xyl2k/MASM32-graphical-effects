      tagSIZE STRUCT
        _cx   dd ?
        cy    dd ?
        tagSIZE ENDS           
              
          tagRECT STRUCT
             left    dd ?
             top     dd ?
             right   dd ?
             bottom  dd ?
             tagRECT ENDS      
              
              
               tagPOINT struct
              x dd ?
              y dd ?
              tagPOINT ends
              
              
              
              
      .data                         
                                                      
              aAbout___       db 'About...',0         
              
              unk_409839      db 0FFh,0;=smile 1  
                                                      
                              
                              db "The CyberDoom Systems",0
                              db "       Presents:     ",0
                              db 0ffh,78h;=smile 9
                              
                              db " Code Ripped   ",0
                              db "    From:      ",0
                              db "   tElock     ",0
                              db "    by tE!    ",0
                              db "    [TMG]     ",0
                              
                              db 0ffh,086h;=smile 10
                              
                              db "Special thanks:   ",0
                              db "        me           ",0
                              
                              db 0ffh,2dh;=smile 4
                              db "iT's AlL!!!!",0
                              
                              db 0ffh,0fh;=smile 2
                              
                              db 0ffh,3ch;smile 5
                              db 0ffh,3ch+0fh;=smile 6
                              db 0ffh,3ch+0fh+0fh;=smile 7
                              
                              db 0ffh,3ch+0fh+0fh+0fh;=smile 8 etc.....
                              
                              db 0
                              
                              db 0
                              
                              db 0
                              db 0feh;end message.
             
     
              stru_40AB04     dd 0FFFFFFF4h           ; lfHeight
                                                      ; DATA XREF: sub_40359D+102o
                              dd 0                    ; lfWidth
                              dd 0                    ; lfEscapement
                              dd 0                    ; lfOrientation
                              dd 2BCh                 ; lfWeight
                              db 0                    ; lfItalic
                              db 0                    ; lfUnderline
                              db 0                    ; lfStrikeOut
                              db 1                    ; lfCharSet
                              db 0                    ; lfOutPrecision
                              db 0                    ; lfClipPrecision
                              db 0                    ; lfQuality
                              db 0                    ; lfPitchAndFamily
                              db "Arial",0;
     
     
     
          
            
   .data?  
     
              ; struct tagPOINT Point
              Point           tagPOINT <?>            
                                                      
              ; struct tagRECT stru_40981C
              stru_40981C     tagRECT <?>             
                                                      
              dword_40982C    dd ?           
             
            

         unk_40EADC      db    1000 dup (?)             
              
            

            
                
         ; struct tagPOINT stru_40AA0C
         stru_40AA0C     tagPOINT <?>           
   

            ifdef LUNA
            hLuna dd ?
            lunaDC dd ?
            endif
            
            
            
              
               dword_40EE60    dd ?                    ; DATA XREF: sub_402528+3F
              
              ; HGDIOBJ dword_40EE64
              dword_40EE64    dd ?                    ; DATA XREF: sub_401CA7+4E7r
                                                      ; sub_4025E0+100r ...
              ; HGDIOBJ dword_40EE68
              dword_40EE68    dd ?                    ; DATA XREF: sub_401CA7+4F2r
                                                      ; DialogFunc+1D7r ...
              ; UINT dword_40EE6C
              dword_40EE6C    dd ?                    ; DATA XREF: DialogFunc:loc_402345r
                                                      ; DialogFunc+A2w ...
              ; HGDIOBJ dword_40EE70
              dword_40EE70    dd ?                     ; DATA XREF: DialogFunc+BFr
                                                      ; sub_4025E0+C3w
              ; HGDIOBJ dword_40EE74
              dword_40EE74    dd ?                     ; DATA XREF: DialogFunc+CAr
                                                      ; sub_4025E0+EFw
              dword_40EE78    dd ?                     ; DATA XREF: sub_4025E0+1A4w
              dword_40EE7C    dd ?                     ; DATA XREF: sub_4025E0+1ABw
                                                      ; sub_402854+15w ...
              dword_40EE80    dd ?                     ; DATA XREF: sub_4025E0+1B5w
                                                      ; sub_402854:loc_402884r ...
              ; int dword_40EE84
              dword_40EE84    dd ?                     ; DATA XREF: DialogFunc+179r
                                                      ; DialogFunc+19Cr ...
              ; int dword_40EE88
              dword_40EE88    dd ?                     ; DATA XREF: DialogFunc+17Fr
                                                      ; DialogFunc+196r
              dword_40EE8C    dd ?                     ; DATA XREF: DialogFunc+16Er
              dword_40EE90    dd ?                     ; DATA XREF: DialogFunc+173r

              dword_40EE94    dd ?                     ; DATA XREF: DialogFunc+A9r
                                                      ; sub_4025E0+AEw ...
              ; HDC dword_40EE98
              dword_40EE98    dd ?                     ; DATA XREF: DialogFunc+B4r
                                                      ; DialogFunc+18Er ...
              ; HGDIOBJ dword_40EE9C
              dword_40EE9C    dd ?                     ; DATA XREF: sub_401CA7+513r
                                                      ; sub_4025E0+40r ...
              ; HGDIOBJ dword_40EEA0
              dword_40EEA0    dd ?                     ; DATA XREF: sub_401CA7+51Er
                                                      ; sub_4025E0+57r ...
              ; HGDIOBJ dword_40EEA4
              dword_40EEA4    dd ?                     ; DATA XREF: sub_401CA7+529r
                                                      ; sub_4025E0+6Er ...
              ; HDC dword_40EEA8
              dword_40EEA8    dd ?                     ; DATA XREF: DialogFunc+EBr
                                                      ; sub_4025E0+69w ...
              ; HDC dword_40EEAC
              dword_40EEAC    dd ?                     ; DATA XREF: DialogFunc+E0r
                                                      ; sub_4025E0+52w ...
              ; HDC dword_40EEB0
              dword_40EEB0    dd ?                     ; DATA XREF: DialogFunc+D5r
                                                      ; sub_4025E0+3Bw ...
              ; HGDIOBJ dword_40EEB4
              dword_40EEB4    dd ?                     ; DATA XREF: sub_401CA7+534r
                                                      ; sub_4025E0+85r ...
              ; HDC dword_40EEB8
              dword_40EEB8    dd ?                     ; DATA XREF: DialogFunc+F6r
                                                      ; sub_4025E0+80w ...
              ; HGDIOBJ dword_40EEBC
              dword_40EEBC    dd ?                     ; DATA XREF: sub_401CA7+53Fr
                                                      ; sub_4025E0+9Cr ...
              ; HDC dword_40EEC0
              dword_40EEC0    dd ?                     ; DATA XREF: DialogFunc+101r
                                                      ; sub_4025E0+97w ...
              ; HGDIOBJ dword_40EEC4
              dword_40EEC4    dd ?                     ; DATA XREF: sub_401CA7+4FDr
                                                      ; sub_402CD6:loc_402D09r ...
              ; HGDIOBJ dword_40EEC8
              dword_40EEC8    dd ?                     ; DATA XREF: sub_401CA7+508r
                                                      ; sub_402CD6+23r ...
              ; HBRUSH hbr
              hbr             dd ?                     ; DATA XREF: sub_4025E0+13Cr
                                                      ; sub_4025E0+16Cr ...
              ; HGDIOBJ dword_40EED0
              dword_40EED0    dd ?                     ; DATA XREF: sub_401CA7+4D1r
                                                      ; CODE:00402C37r ...
              ; HGDIOBJ dword_40EED4
              dword_40EED4    dd ?                     ; DATA XREF: sub_401CA7+4DCr
                                                      ; DialogFunc+15Br ...
              ; HGDIOBJ dword_40EED8
              dword_40EED8    dd ?                     ; DATA XREF: sub_401CA7+4C6r
                                                      ; DialogFunc:loc_402513r ...
              ; HWND dword_40EEDC
              dword_40EEDC    dd ?                     ; DATA XREF: DialogFunc+1D0w
                                                      ; sub_402854+7r ...
             
            
              ; HMODULE hModule
              hModule         dd ?                     ; DATA XREF: sub_401096+49w
                                                      ; sub_401096+298r ...
            
  .data           
             
             
                                                      
