include \masm32\include\masm32rt.inc

WindowCallback PROTO :HWND, :UINT, :WPARAM, :LPARAM

.data
    bitmapinfo BITMAPINFO <>
    iteration dd 0
.data?
    hDCData HDC ?
    hBitmap HBITMAP ?
    pixeldata db 196608 dup(?)
.code

start:
invoke DialogBoxParam, rv(GetModuleHandle, 0), 1, 0, ADDR WindowCallback, 0
invoke ExitProcess, 0

WindowCallback proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    LOCAL hFile:HANDLE
    LOCAL hDC:HDC
    mov eax, uMsg
    .if     eax == WM_CLOSE         
         invoke DeleteObject, hBitmap
         invoke ReleaseDC,    hWnd, hDCData
         invoke EndDialog,    hWnd, 0     
    .elseif eax == WM_INITDIALOG
         mov hDC,     rv(GetDC, hWnd)
         mov hDCData, rv(CreateCompatibleDC, hDC)
         mov hBitmap, rv(CreateCompatibleBitmap, hDC, 256, 256)
         invoke SelectObject, hDCData, hBitmap
         ;fill bitmap structure
         mov   bitmapinfo.bmiHeader.biSize, sizeof BITMAPINFOHEADER
         mov   bitmapinfo.bmiHeader.biPlanes, 1
         mov   bitmapinfo.bmiHeader.biBitCount, 24
         mov   bitmapinfo.bmiHeader.biWidth, 256
         mov   bitmapinfo.bmiHeader.biHeight, 256
         mov    esi, 256
         xor    edi, edi
         mov    ebx, offset pixeldata
         .while esi > 0      
             .while edi < 256
                 mov  eax, edi
                 mul  esi
                 mov [ebx], eax
                 inc edi
                 add ebx, 3
              .endw
              xor edi, edi
              dec esi
         .endw                  
         invoke SetDIBits,hDCData,hBitmap,0,256,offset pixeldata, offset bitmapinfo, DIB_RGB_COLORS
         invoke ReleaseDC, hWnd, hDC
    .elseif eax == WM_PAINT         
         mov    esi, 256
         xor    edi, edi
         mov    ebx, offset pixeldata
         inc    iteration
         .while esi > 0      
             .while edi < 256
                 mov  eax, edi
                 add  eax, iteration
                 mul  esi
                 mov [ebx], eax
                 inc edi
                 add ebx, 3
              .endw
              xor edi, edi
              dec esi
         .endw      
         invoke SetDIBits,hDCData,hBitmap,0,256,offset pixeldata, offset bitmapinfo, DIB_RGB_COLORS            
         mov    hDC, rv(GetDC, hWnd)
         invoke BitBlt, hDC, 0, 0, 256, 256, hDCData, 0, 0, SRCCOPY
         invoke ReleaseDC, hWnd, hDC    
    .else
        mov eax, 0 
    .endif
    ret
WindowCallback endp 
end start