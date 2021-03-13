;-------------------------------------------------------------------------------
;  Image.inc
;
;  Image file loading routines for the MASM32 library
;
;  This source and assosciated binary code is 
;  Copyright © 2001 by M Stoller Enterprises
;
;  Written by Ernest Murphy
;
;  Not for commercial reproduction. No fee whatsoever may be imposed for 
;  transfering this file. Source files may be coppied only for educational use
;  on a free basis.
;
;  Binary object files may be included in any work be it private, public or
;  a commercial application without payment necessary, however, it would be
;  appreciated to add a note to the effect "certain routines used in this program
;  were produced by Ernest Murphy" in the program documentation. Burried deep in 
;  the help file is just fine.
;
;  There is no 'LZW' code contained in these routines.
;
;-------------------------------------------------------------------------------

BitmapFromFile      PROTO   pszFileName:DWORD
BitmapFromMemory    PROTO   pHeap:DWORD, dwSize:DWORD
BitmapFromResource  PROTO   hModule:DWORD, lpName:DWORD
