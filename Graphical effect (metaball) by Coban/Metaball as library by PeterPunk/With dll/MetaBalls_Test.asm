include \masm32\include\masm32rt.inc
include MetaBalls.inc
includelib MetaBalls_dll.lib

WndProc PROTO :DWORD, :DWORD, :DWORD, :DWORD

.data
    szText1 db "Implementation of MetaBalls", 13
            db "by PeterPunk [TSRh Team]", 13, 13
            db "Especially thanks to:", 13
            db "FudoWarez", 13
            db "Blup", 13
            db "tP", 13
            db "for some ideas and code ;)", 13, 13
            db "Use as you want", 13
            db "and enjoy it!!!", 0
    szText2 db "The first panel of MetaBalls", 13
            db "have the default values with", 13
            db "the add of text.", 13, 13
            db "For the second one, we've changed", 13
            db "the size and colors of the balls", 13
            db "and if you click the right button", 13
            db "it will destroy and create itself.", 13, 13
            db "And for the third one (me) we've", 13
            db "changed the size and colors of the", 13
            db "balls and the font and color of the text,", 13
            db "and if you click the left button", 13
            db "it will change to random colors.", 0

    szFontName db "Times New Roman", 0
    szSetFontError db "Something was wrong with the change of font...", 0
    szSetTextColorError db "Something was wrong with the change of color for text...", 0
    szError db "Error!!!", 0
    myFont LOGFONT <20, 0, 0, 0, FW_DONTCARE, FALSE, FALSE, FALSE, ANSI_CHARSET, OUT_DEFAULT_PRECIS, \
                    CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH OR FF_ROMAN, "Times New Roman">

.data?
    hInstance   dd ?
    hWnd        dd ?
    MB          dd ?
    MB2         dd ?
    MB3         dd ?

.code

start:

    invoke GetModuleHandle, NULL
    mov hInstance, eax
    invoke DialogBoxParam, hInstance, 1001, 0, ADDR WndProc, 0
    invoke ExitProcess, eax
    
WndProc proc hWin: DWORD, uMsg: DWORD, wParam: DWORD, lParam: DWORD
LOCAL dwColor: DWORD
	
    .if uMsg == WM_INITDIALOG
        push hWin
        pop hWnd
        invoke GetTickCount
        invoke nseed, eax

        ;Create a window with 5 MetaBalls at pos 0, 0 with a size of 200x200
        invoke mbCreate, ADDR MB, hWin, 0, 0, 200, 200, 5
        
        ;Add the text to show
        invoke mbSetText, MB, ADDR szText1
        
        ;Procedure to create the second panel of MetaBalls
        call Create2nd
        
        ;Create another window with 6 MetaBalls at pos 0, 200 with a size of 400x150
        invoke mbCreate, ADDR MB3, hWin, 0, 200, 400, 150, 6
        
        ;Change font to Times New Roman with Height = 20
        invoke mbSetFont, MB3, ADDR myFont
        .if eax == 0
            invoke MessageBox, hWin, ADDR szSetFontError, 0, ADDR szError 
        .endif
        
        ;Change text's color to Yellow
        invoke mbSetTextColor, MB3, Yellow
        .if eax == -1
            invoke MessageBox, hWin, ADDR szSetTextColorError, 0, ADDR szError 
        .endif

        ;Add the text to show
        invoke mbSetText, MB3, ADDR szText2

        ;Change InnerColor to Orange
        invoke mbSetInnerColor, MB3, 000080FFh

        ;Change OuterColor to Purple
        invoke mbSetOuterColor, MB3, 00800080h

        ;Change the size of the Balls to 1500
        invoke mbSetSizeBalls, MB3, 1500

        ;Change the size of the Borders to 250
        invoke mbSetSizeBorders, MB3, 250
    .elseif uMsg == WM_CLOSE
        invoke mbDestroy, ADDR MB
        invoke mbDestroy, ADDR MB2
        invoke mbDestroy, ADDR MB3
        invoke EndDialog, hWin, 0
    .elseif uMsg == WM_LBUTTONDOWN
        invoke nrandom, 1000000h
        mov dwColor, eax
        invoke nrandom, 2
        .if eax == 0
            add dwColor, mbPlainColor
        .endif
        invoke mbSetOuterColor, MB3, dwColor

        invoke nrandom, 1000000h
        mov dwColor, eax
        invoke nrandom, 2
        .if eax == 0
            add dwColor, mbPlainColor
        .endif
        invoke mbSetBorderColor, MB3, dwColor

        mov dwColor, 0
        invoke nrandom, 2
        .if eax == 0
            mov dwColor, mbPlainColor
        .endif
        invoke nrandom, 2
        .if eax == 0
            add dwColor, mbDarker
        .else
            invoke nrandom, 1000000h
            add dwColor, eax
        .endif
        invoke mbSetInnerColor, MB3, dwColor

    .elseif uMsg == WM_RBUTTONDOWN
        .if MB2 == 0
            call Create2nd
        .else
            invoke mbDestroy, ADDR MB2
        .endif
    .endif
    xor eax, eax
    ret

WndProc endp

Create2nd proc
    ;Create another window with 8 MetaBalls at pos 200, 0 with a size of 200x200
    invoke mbCreate, ADDR MB2, hWnd, 200, 0, 200, 200, 8

    ;Change the size of the balls to 400
    invoke mbSetSizeBalls, MB2, 400

    ;Change the size of the borders to 100
    invoke mbSetSizeBorders, MB2, 100

    ;Change inner color to ???(but I like it)
    invoke mbSetInnerColor, MB2, 006E6E00h

    ;Change outer color to Blue
    invoke mbSetOuterColor, MB2, Blue
	ret
Create2nd endp

end start