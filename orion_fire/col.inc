              .data?
              esp_74h_arg_C dd ?
              
              esp_74h_arg_8 dd ?
              
              .data
              off_40296C      dd offset loc_4026F7    ; DATA XREF: sub_401590:loc_40266Br
                              dd offset loc_402672
                              dd offset loc_40268F
                              dd offset loc_4026AC
                              dd offset loc_4026C6
                              dd offset loc_4026E0

              
              .code
              
              loc_4025C9:                             ; CODE XREF: sub_401590+65j
                          
                              
                              mov ebx,[esp+4]
                              push    0             ; lParam
                              push    2               ; wParam
                              push    0A1h            ; Msg
                              push    ebx             ; hWnd
                              call    PostMessageA
                           
                              mov     eax, dword_42053C
                              inc     eax
                              cmp     eax, 5
                              mov     dword_42053C, eax
                              jbe     short loc_40266B
                              xor     eax, eax
                              cmp     eax, 5
                              mov     dword_42053C, eax
                              ja      loc_4026F7

              loc_40266B:                             ; CODE XREF: sub_401590+10C9j
                              jmp     off_40296C[eax*4]

              
              
              ;---------------------init green color:----------
              loc_402672:                             ; DATA XREF: ORN0:00402970o
                              mov     ecx, 19h
                              mov     esi, 64h
                              mov     dword_415098, ecx
                              mov     dword_41509C, esi
                              mov     eax, ecx
                              jmp     loc_402712; jmp to create color
              ; ---------------------init blue color:-----------------------------------------------------

              loc_40268F:                             ; CODE XREF: sub_401590:loc_40266Bj
                                                      ; DATA XREF: ORN0:00402974o
                              mov     ecx, 0Ah
                              mov     esi, 32h
                              mov     dword_415098, ecx
                              mov     dword_41509C, esi
                              mov     eax, 0C8h
                              jmp     short loc_402712
              ; --------------------------etc..-------------------------------------------------

              loc_4026AC:                             ; CODE XREF: sub_401590:loc_40266Bj
                                                      ; DATA XREF: ORN0:00402978o
                              mov     ecx, 96h
                              mov     esi, 32h
                              mov     dword_415098, ecx
                              mov     dword_41509C, esi
                              mov     eax, ecx
                              jmp     short loc_402712
              ; ---------------------------------------------------------------------------

              loc_4026C6:                             ; CODE XREF: sub_401590:loc_40266Bj
                                                      ; DATA XREF: ORN0:0040297Co
                              mov     ecx, 96h
                              mov     eax, 32h
                              mov     esi, ecx
                              mov     dword_415098, ecx
                              mov     dword_41509C, esi
                              jmp     short loc_402712
              ; ---------------------------------------------------------------------------

              loc_4026E0:                             ; CODE XREF: sub_401590:loc_40266Bj
                                                      ; DATA XREF: ORN0:00402980o
                              mov     ecx, 40h
                              mov     esi, ecx
                              mov     dword_415098, ecx
                              mov     dword_41509C, esi
                              mov     eax, ecx
                              jmp     short loc_402712
              ; ---------------------------------------------------------------------------

              loc_4026F7:                             ; CODE XREF: sub_401590+10D5j
                                                      ; sub_401590:loc_40266Bj
                                                      ; DATA XREF: ...
                              mov     ecx, 0C8h
                              mov     esi, 32h
                              mov     dword_415098, ecx
                              mov     dword_41509C, esi
                              mov     eax, 0Ah

              loc_402712:                             ; CODE XREF: sub_401590+10FAj
                                                      ; sub_401590+111Aj ...
                              mov     edx, dword_415094
                              mov     dword_4161BC, ecx
                              xor     ecx, ecx
                              
                              push ebp
                              xor     ebp, ebp
                              xor     edi, edi
                              mov     ebx, esi
                              inc     edx
                              mov     dword_4150A0, eax
                              mov     dword_4161B8, ebx
                              mov     dword_4161B0, eax
                              mov     esi, offset dword_41620C
                              mov     [esp_74h_arg_C], edx

              loc_402743:                             ; CODE XREF: sub_401590+127Dj
                              mov     edx, eax
                              and     edx, 0FFFFFC00h
                              cmp     edx, 3FC00h
                              jnb     short loc_402758
                              shr     eax, 0Ah
                              jmp     short loc_40275D
              ; ---------------------------------------------------------------------------

              loc_402758:                             ; CODE XREF: sub_401590+11C1j
                              mov     eax, 0FFh

              loc_40275D:                             ; CODE XREF: sub_401590+11C6j
                              mov     edx, ebx
                              and     edx, 0FFFFFC00h
                              cmp     edx, 3FC00h
                              jnb     short loc_402779
                              shr     ebx, 0Ah
                              mov     [esp_74h_arg_8], ebx
                              jmp     short loc_402784
              ; ---------------------------------------------------------------------------

              loc_402779:                             ; CODE XREF: sub_401590+11DBj
                              mov     [esp_74h_arg_8], 0FFh

              loc_402784:                             ; CODE XREF: sub_401590+11E7j
                              mov     edx, dword_4161BC
                              mov     ebx, edx
                              and     ebx, 0FFFFFC00h
                              cmp     ebx, 3FC00h
                              jnb     short loc_40279F
                              shr     edx, 0Ah
                              jmp     short loc_4027A4
              ; ---------------------------------------------------------------------------

              loc_40279F:                             ; CODE XREF: sub_401590+1208j
                              mov     edx, 0FFh

              loc_4027A4:                             ; CODE XREF: sub_401590+120Dj
                              xor     ebx, ebx
                              and     eax, 0FFh
                              mov     bh, dl
                              mov     edx, dword_4161BC
                              mov     bl, byte ptr [esp_74h_arg_8]
                              add     edx, edi
                              shl     ebx, 8
                              or      ebx, eax
                              mov     eax, dword_4161B0
                              mov     dword_4161BC, edx
                              mov     edx, dword_415098
                              mov     [esi], ebx
                              mov     ebx, dword_4161B8
                              add     edi, edx
                              mov     edx, dword_41509C
                              add     ebx, ebp
                              add     ebp, edx
                              mov     edx, dword_4150A0
                              add     eax, ecx
                              add     ecx, edx
                              mov     edx, [esp_74h_arg_C]
                              add     esi, 4
                              dec     edx
                              mov     dword_4161B8, ebx
                              mov     dword_4161B0, eax
                              mov     [esp_74h_arg_C], edx
                              jnz     loc_402743

              loc_402813:                             ; CODE XREF: sub_401590+1091j
                                                      ; sub_401590+109Dj ...
                             
                              pop     ebp
                             
                              ret
