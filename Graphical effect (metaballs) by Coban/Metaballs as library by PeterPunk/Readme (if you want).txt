Implementation of MetaBalls by PeterPunk [TSRh Team]
----------------------------------------------------

This project is only a library coded in MASM32 to create the famous MetaBalls' effect.

I've got some ideas (and a little of code) from other people:
-FudoWarez (his great implementatation of metaballs was my inspiration)
-Blup and tP (their Delphi codes help me to understand better how metaballs work)

/////////////////////////////////////////////////////////////////////////////////////////
Functions and procedures:
  (stdcall convention)
  (argument MB is a DWORD, and works similar a handler of a window)

mbCreate (ByRef MB, HWND, x, y, Width, Height, NumBalls)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
  Obviously the most important procedure: Create a metaball's panel
  You MUST pass BY REFERENCE a "MB" variable (zeroed DWORD)
  "HWND" is the Handle of the Window parent of our MetaBalls
  "x", "y", "Width" and "Height" work like the same args on the CreateWindow API
  "NumBalls" is the number of balls we'll get on our MetaBall's panel

mbDestroy (ByRef MB)
''''''''''''''''''''
  Destroy our metaball's panel (as expected)
  You MUST pass BY REFERENCE a "MB" variable and it will zero

mbSetFont (MB, ByRef Font) RETURN DWORD
'''''''''''''''''''''''''''''''''''''''
  Change the font of the text on the metaball's panel
  "MB" is like our "handler of MetaBalls"
  "Font" is a window's LOGFONT structure
  If returns 0 something was wrong

mbSetText (MB, lpText)
''''''''''''''''''''''
  Set the text to be displayed on the metaball's panel
  "MB" is like our "handler of MetaBalls"
  "lpText" is a pointer to a null-terminated string

mbSetTextColor (MB, Color) RETURN DWORD
'''''''''''''''''''''''''''''''''''''''
  Change the color of the displayed text
  "MB" is like our "handler of MetaBalls"
  "Color" is a DWORD to control a 24 bit color (Red: 000000FF / Green: 0000FF00 / Blue: 00FF0000)
  In theory if returns 0xFFFFFFFF (-1) something was wrong

mbSetInnerColor (MB, Color)
'''''''''''''''''''''''''''
  Change the color of the balls
  "MB" is like our "handler of MetaBalls"
  "Color" is a DWORD to control a 24 bit color (Red: 000000FF / Green: 0000FF00 / Blue: 00FF0000)

mbSetBorderColor (MB, Color)
''''''''''''''''''''''''''''
  Change the color of the balls' borders
  "MB" is like our "handler of MetaBalls"
  "Color" is a DWORD to control a 24 bit color (Red: 000000FF / Green: 0000FF00 / Blue: 00FF0000)

mbSetOuterColor (MB, Color)
'''''''''''''''''''''''''''
  Change the color of the background
  "MB" is like our "handler of MetaBalls"
  "Color" is a DWORD to control a 24 bit color (Red: 000000FF / Green: 0000FF00 / Blue: 00FF0000)

mbSetSizeBalls (MB, Size)
'''''''''''''''''''''''''
  Change the size of the balls
  "MB" is like our "handler of MetaBalls"
  "Size" is a DWORD to control the size of the balls

mbSetSizeBorders (MB, Size)
'''''''''''''''''''''''''''
  Change the size of the balls' borders
  "MB" is like our "handler of MetaBalls"
  "Size" is a DWORD to control the size of the borders


Constants:

mbPlainColor = 01000000h
''''''''''''''''''''''''
  Only works with Color argument on mbSetInnerColor, mbSetBorderColor and mbSetOuterColor
  It will switch off the TV effect, letting a flat color:
    invoke MBSetOuterColor, MB, 00FF00FFh OR mbPlainText

mbDarker = 02000000h
''''''''''''''''''''
  Only works with COlor argument on mbSetInnerColor
  It will ignore the 24bit color setted as inner color and instead it will acquire a darker
  version of the outer color:
    invoke MBSetInnerColor, MB, mbDarker
/////////////////////////////////////////////////////////////////////////////////////////


I hope that this library will be helpful to someone.

Regards.

PS: Sorry for my english

--------------------------------------------------------------------
 "THE BEER-WARE LICENSE"
 PeterPunk wrote these files. As long as you retain this notice you
 can do whatever you want with this stuff. If we meet some day, and
 you think this stuff is worth it, you can buy me a beer in return.
--------------------------------------------------------------------