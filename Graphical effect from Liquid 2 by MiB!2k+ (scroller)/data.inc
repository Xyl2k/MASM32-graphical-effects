.data

rest_flag db 0
              ; RECT Rect
               Rect            RECT <0, 1Eh, 111h, 3Ch> ; DATA XREF: sub_4018DA+932o
               dword_404010    dd 0                    ; DATA XREF: sub_401602:loc_4016A5r
                                                   


               byte_40B811     db 0  



              dword_40B900    dd 0                    ; DATA XREF: DialogFunc+7Fw
                                                       ; DialogFunc+CFr
               ; HGDIOBJ dword_40B904
               dword_40B904    dd 0                    ; DATA XREF: DialogFunc+74w
                                                       ; DialogFunc+84r ...
               ; HDC dword_40B908
               dword_40B908    dd 0                    ; DATA XREF: DialogFunc+A2w
                                                       ; DialogFunc+C4r ...
               ; int dword_40B90C
               dword_40B90C    dd 0                    ; DATA XREF: DialogFunc+194w
                                                       ; sub_4018DA+6w ...
               ; int dword_40B910
               dword_40B910    dd 0                    ; DATA XREF: DialogFunc+180w
                                                       ; sub_4018DA+65w ...
               dword_40B914    dd 0                    ; DATA XREF: sub_4018DA:loc_401936r
                                                       ; sub_4018DA+78w ...
               dword_40B918    dd 0                    ; DATA XREF: DialogFunc+18Aw
                                                       ; sub_4018DA+Dw ...
               dword_40B91C    dd 0                    ; DATA XREF: sub_4018DA:loc_401981r
                                                       ; sub_4018DA+C0w ...
               dword_40B920    dd 0                    ; DATA XREF: sub_4018DA+14r
                                               



               ; LOGFONTA stru_40B66D
               stru_40B66D     dd 0Eh                  ; lfHeight
                                                       ; DATA XREF: DialogFunc+FEo
                               dd 0Ah                  ; lfWidth
                               dd 0                    ; lfEscapement
                               dd 0                    ; lfOrientation
                               dd 0                    ; lfWeight
                               db 0                    ; lfItalic
                               db 0                    ; lfUnderline
                               db 0                    ; lfStrikeOut
                               db 0                    ; lfCharSet
                               db 0                    ; lfOutPrecision
                               db 0                    ; lfClipPrecision
                               db 0                    ; lfQuality
                               db 0                    ; lfPitchAndFamily
                               db 74h, 61h, 68h, 6Fh, 6Dh, 61h, 1Ah dup(0); lfFaceName
               



              ; char String[]
               String          db 'MiSSiNG iN ByTES present: Liquid 2 -- your favorite crack ge'
                                                       ; DATA XREF: sub_4018DA+146o
                                                       ; sub_4018DA+151o ...
                               db 'nerator! Credits: code = MiB!2k+           http://missinginb'
                               db 'ytes.cjb.net ; missing.in.bytes@mail.bg ENJOY!....    ',0

