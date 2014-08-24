
                sub_401940      proc near               ; CODE XREF: sub_401184+26p
                                mov     ecx, 163h
                                imul    eax, ecx, 89h
                                lea     eax, ds:28h[eax*4]
                                push    eax             ; dwBytes
                                push    40h             ; uFlags
                                call    GlobalAlloc
                                mov     dword_404578, eax
                                push    dword_404578    ; hMem
                                call    GlobalLock
                                mov     hMem, eax
                                
                                
                                ;BiTMAP
                                ;INFORMATION HEADER :
                                mov     edx, hMem
                                mov     dword ptr [edx], 28h;Size of information header (4 bytes) =40 
                                push    0FFh;<----------- widht(181 dec)
                                pop     dword ptr [edx+4];Image width (4 bytes)
                                push    25h;<------ height(72 dec)
                                pop     dword ptr [edx+8];Image height(4 bytes)
                                mov     word ptr [edx+0Ch], 1;Number of color planes (2 bytes) =1
                                mov     word ptr [edx+0Eh], 20h;Number of bits per pixel (2 bytes)
                                mov     dword ptr [edx+10h], 0;Compression method used (4 bytes)
                                mov     dword ptr [edx+14h], 0;Number of bytes of bitmap data (4 bytes)
                                mov     dword ptr [edx+18h], 0;Horizontal screen resolution (4 bytes)
                                mov     dword ptr [edx+1Ch], 0;Vertical screen resolution (4 bytes) 
                                mov     dword ptr [edx+20h], 0;Number of colors used in the image (4 bytes) =0
                                mov     dword ptr [edx+24h], 0;Number of important colors (4 bytes)
                                add     edx, 28h
                                mov     dword_404574, edx
                                retn
                sub_401940      endp


                
                sub_401ADD      proc near               ; CODE XREF: sub_401133+2Bp
                                mov     ecx, 32h
                                mov     edi, offset dword_404588

                loc_401AE7:                             ; CODE XREF: sub_401ADD+33j
                                push    0FAh
                                call    sub_401BDC
                                mov     [edi], eax
                                mov     [edi+8], eax
                                push    22h
                                call    sub_401BDC
                                mov     [edi+4], eax
                                mov     [edi+0Ch], eax
                                push    3
                                call    sub_401BDC
                                mov     [edi+10h], eax
                                add     edi, 14h
                                loop    loc_401AE7
                                retn
                sub_401ADD      endp
                
                
