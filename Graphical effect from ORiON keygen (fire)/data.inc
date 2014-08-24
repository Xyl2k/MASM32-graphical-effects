.data  
               
               dword_4152EC    dd 1    
              
              dword_41508C    dd 14Ah                 ; DATA XREF: StartAddress+127r
              ; int dword_415090
              dword_415090    dd 64h                  ; DATA XREF: StartAddress+13Er
              dword_415094    dd 9Fh ; fire height     
              dword_415098    dd 0C8h                 ; DATA XREF: sub_4010F0+DBr
                                                      ; sub_4010F0+17Dr ...
              dword_41509C    dd 32h                  ; DATA XREF: sub_4010F0+C1r
                                                      ; sub_4010F0+18Dr ...
              dword_4150A0    dd 0Ah      

.data?

              dword_41620C    dd ?                    ; DATA XREF: sub_4010F0+F4o
                                                      ; StartAddress+93r ...
                              dd 0FFh dup(?)
              dword_41660C    dd 52h dup(?)           ; DATA XREF: sub_4010F0+CEo
                              db 2 dup(?)
              word_416756     dw ?                    ; DATA XREF: StartAddress+2Eo
                              dd 0B1Eh dup(?)
              dword_4193D0    dd 151Bh dup(?)         ; CODE XREF: ORN0:00415308j
                              db 2 dup(?)
              word_41E83E     dw ?              
                              dd 57Ah dup(?)

              dword_41FE28    dd 52h dup(?)           ; DATA XREF: StartAddress+116o
                              db 2 dup(?)
              byte_41FF72     db ?   
              
                              align 4
                              dd 0F7h dup(?)





              dword_420358    dd ?                    ; DATA XREF: sub_4010F0+9Bw
                                                      ; StartAddress:loc_401319o
              dword_42035C    dd 63h dup(?)           ; DATA XREF: sub_4010F0+A0o
              ; BITMAPINFO stru_4204E8
              stru_4204E8     BITMAPINFO <>          ; DATA XREF: sub_4010F0+1Bo
                                                      ; sub_4010F0+29w ...
              dword_420514    dd ?             

              ; HDC dword_420538
              dword_420538    dd ?                    ; DATA XREF: sub_4010F0+73w
                                                      ; sub_4010F0+7Er ...
              dword_42053C    dd ?                    ; DATA XREF: sub_401590+10BBr
                                                      ; sub_401590+10C4w ...
              ; char byte_420540[]
              byte_420540     db 4 dup(?)    

              
              
              ; void *dword_420350
              dword_420350    dd ?                    ; DATA XREF: sub_4010F0+67o
                                                      ; sub_4010F0+91r
              dword_420354    dd ?                    ; DATA XREF: sub_4010F0+96w
              

              dword_4161B0    dd ?                    ; DATA XREF: sub_4010F0+EFw
                                                      ; sub_4010F0+172r ...
              ; HGDIOBJ dword_4161B4
              dword_4161B4    dd ?                    ; DATA XREF: sub_401590+3E8w
                                                      ; sub_401590:loc_401985w ...
              dword_4161B8    dd ?                    ; DATA XREF: sub_4010F0+D3w
                                                      ; sub_4010F0+185r ...
              dword_4161BC    dd ?                    ; DATA XREF: sub_4010F0+E2w
                                                      ; sub_4010F0:loc_401228r ...
              dword_4161C0    dd ?                    ; DATA XREF: sub_401590+3C9w
                                                      ; sub_401590+425r ...
              dword_4161C4    dd ?                    ; DATA XREF: sub_401590+3A2w
                                                      ; sub_401590:loc_401973r ...
              dword_4161C8    dd ?                   ; DATA XREF: sub_401500+58w
                                           
               dword_420528    dd ?
               
               ; DWORD ThreadId
              ThreadId        dd ?   
     