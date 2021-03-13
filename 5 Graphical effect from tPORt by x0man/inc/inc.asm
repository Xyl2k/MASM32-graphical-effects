      include \masm32\include\windows.inc
      include \masm32\include\masm32.inc
      include \masm32\include\gdi32.inc
      include \masm32\include\user32.inc
      include \masm32\include\kernel32.inc

      includelib \masm32\lib\masm32.lib
      includelib \masm32\lib\gdi32.lib
      includelib \masm32\lib\user32.lib
      includelib \masm32\lib\kernel32.lib
      
	includelib \masm32\lib\oleaut32.lib	; Вообщем в ранней версии был гон... 
      includelib \masm32\lib\ole32.lib		; при использовании JPG... 
      							; Надо было подключать эти библы
      							; вообщем гона теперь нет ! ;)
      							; Юзайте ))