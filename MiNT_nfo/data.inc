      .data?     
           
                  ; HWND dword_457D00
                  dword_457D00    dd ?                   ; DATA XREF: start+1BEw
                                                          ; start+1E0r ...
                  ; LPARAM dword_457D04
                  dword_457D04    dd ?                    ; DATA XREF: start+1D3w
                                                          ; start+498r ...
                  ; LPARAM dword_457D08
                  dword_457D08    dd ?                    ; DATA XREF: start+1FBw
                                                          ; sub_401874+9Dr
                  ; HWND dword_457D0C
                  dword_457D0C    dd ?                    ; DATA XREF: start+248w
                                                          ; start+26Ar ...
                  ; LPARAM dword_457D10
                  dword_457D10    dd ?                    ; DATA XREF: start+25Dw
                                                          ; start+4B0r ...
                  ; LPARAM dword_457D14
                  dword_457D14    dd ?                    ; DATA XREF: start+285w
                                                          ; sub_401874+10Er

                     ; struct tagPAINTSTRUCT stru_4BD89C
                  stru_4BD89C     PAINTSTRUCT <?>         ; DAT
                  
               
                  
                  ; HWND dword_457D18
                  dword_457D18    dd ?                    ; DATA XREF: sub_401874:loc_40199Er
                                                          ; sub_401874+144r ...
                  ; LPARAM dword_457D1C
                  dword_457D1C    dd ?     
                  ; LPARAM dword_457D20
                  dword_457D20    dd ?                    ; DATA XREF: sub_401874+137r
                                                          ; DialogFunc+9Fw
                  ; WNDPROC lpPrevWndFunc
                  lpPrevWndFunc   dd ?                    ; DATA XREF: start+188w
                                                          ; start+212w ...
                  dword_457D28    dd ?                    ; DATA XREF: start+43w
                                                          ; DialogFunc+338r
                  ; HDC dword_457D2C
                  dword_457D2C    dd ?                    ; DATA XREF: start+2A9w
                                                          ; start+2C3r ...
                  ; HDC dword_457D30
                  dword_457D30    dd ?                    ; DATA XREF: start+2B4w
                                                          ; start+2D4r ...
                  ; HBITMAP dword_457D34
                  dword_457D34    dd ?                    ; DATA XREF: start+2CEw
                                                          ; start+797r ...
                  ; HDC dword_457D38
                  dword_457D38    dd ?                    ; DATA XREF: DialogFunc+127w
                                                          ; DialogFunc+148r ...
                  ; HGDIOBJ dword_457D3C
                  dword_457D3C    dd ?                    ; DATA XREF: DialogFunc+142w
                                                          ; DialogFunc+2E4r
                  ; HWND dword_457D40
                  dword_457D40    dd ?                    ; DATA XREF: DialogFunc+FFw
                                                          ; DialogFunc+10Dr ...
                  dword_457D44    dd ?                    ; DATA XREF: DialogFunc+EFw
                                                          ; DialogFunc:loc_401D67r ...
                  dword_457D48    dd ?                    ; DATA XREF: start:loc_401469r
                                                          ; start+476w ...
                  ; DWORD dwProcessId
                  dwProcessId     dd ?                    ; DATA XREF: sub_401E3D+Fo
                                                          ; sub_401E3D+1Ar ...
                  ; HANDLE hProcess
                  hProcess        dd ?                    ; DATA XREF: start+502r
                                                          ; start+51Br ...
                  dword_457D54    dd ?                    ; DATA XREF: Unpacker:00401E79w
                                                     


                  ; void *dword_457D7C
                  dword_457D7C    dd ?                    ; DATA XREF: DialogFunc+130o
                                                          ; DialogFunc+15Dr

                             
                              
                              

                 ; LPARAM dword_457CFC
                  dword_457CFC    dd ?     

                   
                   
                   
                   
                   .data
                   aStatic db 'STATIC',0   

                  stru_406060     BITMAPINFO <<28h, 280h, 0, 1, 4, 0, 0, 0, 0, 0, 0>, <0>>
                                                          ; DATA XREF: DialogFunc+137o
                                                          ; DialogFunc+EAw
                                  
                                  dd 0FFFFFFh,NFO_COLOR ;<--- COLOR NFO 
                  
                  
                  
                  ; RECT rcUpdate


                  rcUpdate        RECT <0, 18h, 280h, 118h> ; DATA XREF: DialogFunc+3B1o
                  ; const SCROLLINFO stru_4060A4
                  stru_4060A4     SCROLLINFO <1Ch, 17h, 0, 0, 100h, 0, 0>


               
                 IF RES_NFO

                 word_4066EE dd ?
                ELSE

                  word_4066EE  =$;    dw 0A0Dh ;nfo start    
                  
                  
                  include nfo.inc

                 ENDIF

                  byte_44CE03     db 0                    ; DATA XREF: DialogFunc:loc_401B67r
                                                          ; sub_4020CF+4Br
                  byte_44CE04     db 0                    ; DATA XREF: DialogFunc+193r
                  byte_44CE05     db 0                    ; DATA XREF: DialogFunc+1A5r
                  byte_44CE06     db 0                    ; DATA XREF: DialogFunc+1B7r
                  byte_44CE07     db 0                    ; DATA XREF: DialogFunc+1C9r
                  byte_44CE08     db 0                    ; DATA XREF: DialogFunc+1DBr
                  byte_44CE09     db 0                    ; DATA XREF: DialogFunc+1EDr
                  byte_44CE0A     db 0                    ; DATA XREF: DialogFunc+1FFr
                                  db 7Eh
                                  dd 0BD81A581h, 7E7E8199h, 0C3FFDBFFh, 6C7EFFE7h, 7CFEFEFEh
                                  dd 10001038h, 7CFE7C38h, 38001038h, 0FEFE387Ch, 107C387Ch
                                  dd 0FE7C3810h, 7C387Ch, 3C3C1800h, 0FF000018h, 0C3C3E7FFh
                                  dd 0FFFFE7h, 4242663Ch, 0FF003C66h, 0BDBD99C3h, 0FFFC399h
                                  dd 0CC7D0F07h, 3C78CCCCh, 3C666666h, 3F187E18h, 30303F33h
                                  dd 7FE0F070h, 63637F63h, 99C0E667h, 0E7E73C5Ah, 80995A3Ch
                                  dd 0F8FEF8E0h, 20080E0h, 3EFE3E0Eh, 1800020Eh, 18187E3Ch
                                  dd 66183C7Eh, 66666666h, 7F006600h, 1B7BDBDBh, 3E001B1Bh
                                  dd 6C6C3863h, 78CC38h, 7E000000h, 18007E7Eh, 7E187E3Ch
                                  dd 18FF183Ch, 18187E3Ch, 18001818h, 7E181818h, 183Ch, 0CFE0C18h
                                  dd 18h, 60FE6030h, 30h, 0C0C0C000h, 0FEh, 66FF6624h, 24h
                                  dd 0FF7E3C18h, 0FFh, 3C7EFFFFh, 18h, 0
                                  dd 30000000h, 30307878h, 6C003000h, 6C6Ch, 6C000000h, 0FE6CFE6Ch
                                  dd 30006C6Ch, 0C78C07Ch, 30F8h, 3018CCC6h, 3800C666h, 0DC76386Ch
                                  dd 600076CCh, 0C060h, 18000000h, 60606030h, 60001830h
                                  dd 18181830h, 6030h, 3CFF3C66h, 66h, 30FC3030h, 30h, 0
                                  dd 603030h, 0FC0000h, 2 dup(0)
                                  dd 6003030h, 6030180Ch, 7C0080C0h, 0F6DECEC6h, 30007CE6h
                                  dd 30303070h, 7800FC30h, 60380CCCh, 7800FCCCh, 0C380CCCh
                                  dd 1C0078CCh, 0FECC6C3Ch, 0FC001E0Ch, 0C0CF8C0h, 380078CCh
                                  dd 0CCF8C060h, 0FC0078CCh, 30180CCCh, 78003030h, 0CC78CCCCh
                                  dd 780078CCh, 0C7CCCCCh, 7018h, 3 dup(3030h), 18603030h
                                  dd 60C06030h, 1830h, 0FC00h, 600000FCh, 180C1830h, 78006030h
                                  dd 30180CCCh, 7C003000h, 0DEDEDEC6h, 300078C0h, 0FCCCCC78h
                                  dd 0FC00CCCCh, 667C6666h, 3C00FC66h, 0C0C0C066h, 0F8003C66h
                                  dd 6666666Ch, 0FE00F86Ch, 68786862h, 0FE00FE62h, 68786862h
                                  dd 3C00F060h, 0CEC0C066h, 0CC003E66h, 0CCFCCCCCh, 7800CCCCh
                                  dd 30303030h, 1E007830h, 0CC0C0C0Ch, 0E60078CCh, 6C786C66h
                                  dd 0F000E666h, 62606060h, 0C600FE66h, 0D6FEFEEEh, 0C600C6C6h
                                  dd 0CEDEF6E6h, 3800C6C6h, 0C6C6C66Ch, 0FC00386Ch, 607C6666h
                                  dd 7800F060h, 0DCCCCCCCh, 0FC001C78h, 6C7C6666h, 7800E666h
                                  dd 1C70E0CCh, 0FC0078CCh, 303030B4h, 0CC007830h, 0CCCCCCCCh
                                  dd 0CC00FCCCh, 0CCCCCCCCh, 0C6003078h, 0FED6C6C6h, 0C600C6EEh
                                  dd 38386CC6h, 0CC00C66Ch, 3078CCCCh, 0FE007830h, 32188CC6h
                                  dd 7800FE66h, 60606060h, 0C0007860h, 0C183060h, 78000206h
                                  dd 18181818h, 10007818h, 0C66C38h, 2 dup(0)
                                  dd 30FF0000h, 1830h, 0
                                  dd 7C0C7800h, 0E00076CCh, 667C6060h, 0DC66h, 0C0CC7800h
                                  dd 1C0078CCh, 0CC7C0C0Ch, 76CCh, 0FCCC7800h, 380078C0h
                                  dd 60F0606Ch, 0F060h, 0CCCC7600h, 0E0F80C7Ch, 66766C60h
                                  dd 3000E666h, 30307000h, 0C007830h, 0C0C0C00h, 0E078CCCCh
                                  dd 786C6660h, 7000E66Ch, 30303030h, 7830h, 0FEFECC00h
                                  dd 0C6D6h, 0CCCCF800h, 0CCCCh, 0CCCC7800h, 78CCh, 6666DC00h
                                  dd 0F0607Ch, 0CCCC7600h, 1E0C7Ch, 6676DC00h, 0F060h, 78C07C00h
                                  dd 1000F80Ch, 30307C30h, 1834h, 0CCCCCC00h, 76CCh, 0CCCCCC00h
                                  dd 3078h, 0FED6C600h, 6CFEh, 386CC600h, 0C66Ch, 0CCCCCC00h
                                  dd 0F80C7Ch, 3098FC00h, 1C00FC64h, 30E03030h, 18001C30h
                                  dd 18001818h, 0E0001818h, 301C3030h, 7600E030h, 0DCh, 0
                                  dd 0C66C3810h, 7800FEC6h, 78CCC0CCh, 780C18h, 0CCCC00CCh
                                  dd 1C007ECCh, 0FCCC7800h, 7E0078C0h, 3E063CC3h, 0CC003F66h
                                  dd 7C0C7800h, 0E0007ECCh, 7C0C7800h, 30007ECCh, 7C0C7830h
                                  dd 7ECCh, 0C0C07800h, 7E380C78h, 7E663CC3h, 0CC003C60h
                                  dd 0FCCC7800h, 0E00078C0h, 0FCCC7800h, 0CC0078C0h, 30307000h
                                  dd 7C007830h, 181838C6h, 0E0003C18h, 30307000h, 0C6007830h
                                  dd 0FEC66C38h, 3000C6C6h, 0CC780030h, 1C00CCFCh, 7860FC00h
                                  dd 0FC60h, 7F0C7F00h, 3E007FCCh, 0CCFECC6Ch, 7800CECCh
                                  dd 0CC7800CCh, 78CCh, 0CC7800CCh, 78CCh, 0CC7800E0h, 780078CCh
                                  dd 0CCCC00CCh, 7ECCh, 0CCCC00E0h, 7ECCh, 0CCCC00CCh, 0C3F80C7Ch
                                  dd 66663C18h, 0CC00183Ch, 0CCCCCC00h, 180078CCh, 0C0C07E18h
                                  dd 3818187Eh, 60F0646Ch, 0CC00FCE6h, 30FC78CCh, 0F83030FCh
                                  dd 0C6FACCCCh, 0EC7C6CFh, 183C181Bh, 1C70D818h, 7C0C7800h
                                  dd 38007ECCh, 30307000h, 7830h, 0CC78001Ch, 78CCh, 0CCCC001Ch
                                  dd 7ECCh, 0CCF800F8h, 0FC00CCCCh, 0FCECCC00h, 3C00CCDCh
                                  dd 3E6C6Ch, 3800007Eh, 386C6Ch, 3000007Ch, 0C0603000h
                                  dd 78CCh, 0C0FC0000h, 0C0h, 0CFC0000h, 0C300000Ch, 33DECCC6h
                                  dd 0C30FCC66h, 37DBCCC6h, 1803CF6Fh, 18180018h, 1818h
                                  dd 66CC6633h, 33h, 663366CCh, 220000CCh, 22882288h, 55882288h
                                  dd 55AA55AAh, 0DBAA55AAh, 0DBEEDB77h, 18EEDB77h, 2 dup(18181818h)
                                  dd 0F8181818h, 18181818h, 0F818F818h, 36181818h, 0F6363636h
                                  dd 363636h, 0FE000000h, 363636h, 0F818F800h, 36181818h
                                  dd 0F606F636h, 2 dup(36363636h), 363636h, 0F606FE00h, 36363636h
                                  dd 0FE06F636h, 36000000h, 0FE363636h, 18000000h, 0F818F818h
                                  dd 0
                                  dd 0F8000000h, 18181818h, 1F181818h, 18000000h, 0FF181818h
                                  dd 0
                                  dd 0FF000000h, 18181818h, 1F181818h, 181818h, 0FF000000h
                                  dd 18000000h, 0FF181818h, 18181818h, 1F181F18h, 36181818h
                                  dd 37363636h, 36363636h, 3F303736h, 0
                                  dd 37303F00h, 36363636h, 0FF00F736h, 0
                                  dd 0F700FF00h, 36363636h, 37303736h, 363636h, 0FF00FF00h
                                  dd 36000000h, 0F700F736h, 18363636h, 0FF00FF18h, 36000000h
                                  dd 0FF363636h, 0
                                  dd 0FF00FF00h, 181818h, 0FF000000h, 36363636h, 3F363636h
                                  dd 18000000h, 1F181F18h, 0
                                  dd 1F181F00h, 181818h, 3F000000h, 36363636h, 0FF363636h
                                  dd 18363636h, 0FF18FF18h, 18181818h, 0F8181818h, 0
                                  dd 1F000000h, 0FF181818h, 0FFFFFFFFh, 0FFFFFFh, 0FF000000h
                                  dd 0F0FFFFFFh, 0F0F0F0F0h, 0FF0F0F0h, 0F0F0F0Fh, 0FF0F0F0Fh
                                  dd 0FFFFFFh, 0
                                  dd 0C8DC7600h, 76DCh, 0CCF8CC78h, 0C0C0F8h, 0C0C0CCFCh
                                  dd 0C0C0h, 6C6C6CFEh, 0FC006C6Ch, 603060CCh, 0FCCCh, 0D8D87E00h
                                  dd 70D8h, 66666666h, 0C0607Ch, 1818DC76h, 0FC001818h, 0CCCC7830h
                                  dd 38FC3078h, 0C6FEC66Ch, 3800386Ch, 6CC6C66Ch, 1C00EE6Ch
                                  dd 0CC7C1830h, 78CCh, 0DBDB7E00h, 600007Eh, 0DBDB7E0Ch
                                  dd 38C0607Eh, 0C0F8C060h, 78003860h, 0CCCCCCCCh, 0CCCCh
                                  dd 0FC00FCh, 300000FCh, 3030FC30h, 6000FC00h, 60301830h
                                  dd 1800FC00h, 18306030h, 0E00FC00h, 18181B1Bh, 2 dup(18181818h)
                                  dd 3070D8D8h, 0FC0030h, 3030h, 7600DC76h, 380000DCh, 386C6Ch
                                  dd 0
                                  dd 18180000h, 0
                                  dd 18000000h, 0F000000h, 0EC0C0C0Ch, 781C3C6Ch, 6C6C6C6Ch
                                  dd 70000000h, 78603018h, 0
                                  dd 3C3C3C00h, 3Ch, 2 dup(0)
                  
                