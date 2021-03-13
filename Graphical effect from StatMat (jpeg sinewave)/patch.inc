.data
; App details
szProgName   db "Game Jackal v2.6.9.262",0
szFileName   db "Maplom.exe",0
TargetSize   dd 3444736
szDownLoad   db "http://www.gamejackal.com/download.asp",0
; Target's CRC32 before patching
BeforeCRC32  dd 005C2048CEh
; Target's CRC32 after patching
AfterCRC32   dd 00F56966EEh
szScrollText db "***  STATMAT PRESENTS GAME JACKAL V2.6.9.262 - THIS PATCH REMOVES THE 30-DAY TRIAL.  ***  "
             db "GREETS GO OUT TO: GIBBERGIBB, LEETY, BLACK-EYE, TRSH, FAIRLIGHT, ORION, THE NEMESIS, BIW REVERSING AND ALL THE OTHERS!  ***  "
             db "DEVELOPER BLURB - PLAY ALL YOUR FAVORITE GAMES WITHOUT INSERTING A SINGLE CD! GAME JACKAL, "
             db "THE ULTIMATE ""MUST HAVE"" KILLER APP FOR THE PC GAMER, ALLOWS YOU TO PLAY ALL YOUR FAVORITE "
             db "GAMES WITHOUT INSERTING THE ORIGINAL CD-ROM. GAME JACKAL ACHIEVES THIS WITHOUT MODIFYING ANY "
             db "PART OF THE GAME INSTALLED ON YOUR COMPUTER, NOR DOES IT CREATE LARGE IMAGE FILES THAT REQUIRE "
             db "A VIRTUAL DRIVE.  ***",0
; Patch/restore positions (must end with a "dd -1" to terminate list)
PRPos        dd 0000192AE7h
             dd -1
; Patches
szPatch      db 0E9h,09Dh,000h,000h,000h,090h,090h
; Restores
szRestore    db 074h,010h,0A1h,0F4h,040h,05Ah,000h
; Patch/restore lengths (bytes)
PRLen        dd 007h
