
              aZKeygen        db 'z=[ keygen ]=',0    ; DATA XREF: UPX0:off_4064B0o
                             
              aScarebyteUcf   db '* ScareByte/uCF *',0 ; DATA XREF: UPX0:004064B4o
                              dw 0
              unk_404714      db    0                 ; DATA XREF: UPX0:004064B8o
                                                      ; UPX0:004064BCo ...
                              db    0
                              db    0
                              db    0
              a010Memorizer   db '010 Memorizer',0    ; DATA XREF: UPX0:004064C4o
                              align 4
              aVersion1_1     db 'Version 1.1',0      ; DATA XREF: UPX0:004064C8o
              a20031215       db '2003-12-15',0       ; DATA XREF: UPX0:004064CCo
                             
              aProtectionNice db 'Protection: nice',0 ; DATA XREF: UPX0:004064D8o
                              align 4
              aZGreets        db 'z---= Greets: =---',0 ; DATA XREF: UPX0:004064E8o
                              align 4
              aExcelEodFiguge db 'Excel,EOD,figugegl,fuss,GanJaMaN,',0
                                                      ; DATA XREF: UPX0:004064F0o
                              align 4
              aHasherJaxiecha db 'Hasher,JaxieChan,link,mac,MackT,',0
                                                      ; DATA XREF: UPX0:004064F4o
                             ; align 10h
              aLise_grimNarci db 'Lise_Grim,nARCi,NUKEM,Quantico,roy,',0
                                                      ; DATA XREF: UPX0:004064F8o
              aSeirSnackerSta db 'seir,snacker,StatMan,tam,tE!,WiteG,',0
                                                      ; DATA XREF: UPX0:004064FCo
              aW00tzZigdAndAl db 'w00tz,ZigD and all in #a********e',0
                                                      ; DATA XREF: UPX0:00406500o
                              align 4
              aZSomeWords     db 'z---= some words =---',0 ; DATA XREF: UPX0:00406518o
                              align 4
              aInHisLoveAndIn db 'In His love and in His mercy He',0
                                                      ; DATA XREF: UPX0:00406520o
              aRedeemedThemAn db 'redeemed them, And He lifted',0
                                                      ; DATA XREF: UPX0:00406524o
                              align 4
              aThemAndCarried db 'them and carried them all the',0
                                                      ; DATA XREF: UPX0:00406528o
                              align 4
              aDaysOfOld_Isai db 'days of old. (Isaiah 63:9)',0 ; DATA XREF: UPX0:0040652Co
                              ;align 10h
              aZCredz         db 'z=[ credz ]=',0     ; DATA XREF: UPX0:00406548o
                              ;align 10h
              aCrackerScareby db 'cracker: ScareByte',0 ; DATA XREF: UPX0:00406550o
                              align 4
              aTemplateZigd   db 'template: ZigD',0   ; DATA XREF: UPX0:00406554o
                              align 4
              aGfxRia         db 'gfx: Ria',0         ; DATA XREF: UPX0:00406558o
                              ;align 10h
              aMusicGemini    db 'music: gemini',0    ; DATA XREF: UPX0:0040655Co
                             
              aAaAaAaaaAaaaa  db '** ** **** *****',0 ; DATA XREF: UPX0:00406570o
                              align 4
              aAaAaAaAaaa     db '** ** **   **** ',0 ; DATA XREF: UPX0:00406574o
                              align 4
              aAaaaaAaaaAa    db '***** **** **   ',0 ; DATA XREF: UPX0:00406578o
                              align 4




              ; ---------------------------------------------------------------------------
                              align 4
              tbyte_404D4C    dt 1.7453292519943295769e-2 ; DATA XREF: sub_404BA4+39r
                                                      ; sub_404BA4+7Br
                              align 4
              flt_404D58      dd 1.2e2                ; DATA XREF: sub_404BA4+4Er
                                                      ; sub_404BA4+90r
              flt_404D5C      dd 9.6e1                ; DATA XREF: sub_404BA4+54r
              flt_404D60      dd 1.06e2               ; DATA XREF: sub_404BA4+5Ar
              flt_404D64      dd 7.6e1                ; DATA XREF: sub_404BA4+96r
              flt_404D68      dd 9.0e1                ; DATA XREF: sub_404BA4+9Cr
              tbyte_404D6C    dt 7.5999999999999999999e-1 ; DATA XREF: sub_404BA4+F3r
                              align 4
              flt_404D78      dd 9.0e2                ; DATA XREF: sub_404BA4+13Cr

              flt_404B9C      dd 6.0                  ; DATA XREF: sub_404A10+56r
              flt_404BA0      dd 3.0e1                ; DATA XREF: sub_404A10+61r


           ds_Paint PAINTSTRUCT <>   
              
              aCourierNew     db 'Courier New',0      ; DATA XREF: sub_404F70+D2o              
              off_4064B0      dd offset aZKeygen      ; DATA XREF: sub_404A10+24o
                                                      ; "z=[ keygen ]="
                              dd offset aScarebyteUcf ; "* ScareByte/uCF *"
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset a010Memorizer ; "010 Memorizer"
                              dd offset aVersion1_1   ; "Version 1.1"
                              dd offset a20031215     ; "2003-12-15"
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset aProtectionNice ; "Protection: nice"
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset aZGreets      ; "z---= Greets: =---"
                              dd offset unk_404714
                              dd offset aExcelEodFiguge ; "Excel,EOD,figugegl,fuss,GanJaMaN,"
                              dd offset aHasherJaxiecha ; "Hasher,JaxieChan,link,mac,MackT,"
                              dd offset aLise_grimNarci ; "Lise_Grim,nARCi,NUKEM,Quantico,roy,"
                              dd offset aSeirSnackerSta ; "seir,snacker,StatMan,tam,tE!,WiteG,"
                              dd offset aW00tzZigdAndAl ; "w00tz,ZigD and all in #a********e"
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset aZSomeWords   ; "z---= some words =---"
                              dd offset unk_404714
                              dd offset aInHisLoveAndIn ; "In His love and in His mercy He"
                              dd offset aRedeemedThemAn ; "redeemed them, And He lifted"
                              dd offset aThemAndCarried ; "them and carried them all the"
                              dd offset aDaysOfOld_Isai ; "days of old. (Isaiah 63:9)"
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset aZCredz       ; "z=[ credz ]="
                              dd offset unk_404714
                              dd offset aCrackerScareby ; "cracker: ScareByte"
                              dd offset aTemplateZigd ; "template: ZigD"
                              dd offset aGfxRia       ; "gfx: Ria"
                              dd offset aMusicGemini  ; "music: gemini"
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset unk_404714
                              dd offset aAaAaAaaaAaaaa ; "нн нн нннн ннннн"
                              dd offset aAaAaAaAaaa   ; "нн нн нн   нннн "
                              dd offset aAaaaaAaaaAa  ; "ннннн нннн нн   "
             
                              dd 0
       dword_407BE8    dd 8Bh       
            
.data?
              
               dword_4074E8    dd 1C0h dup(?)          ; DATA XREF: sub_404D7C+12o
              
              
               byte_4074DC     db ?                    ; DATA XREF: sub_404E7C+5D
              
             ; dword_407BE8    dd ?                    ; DATA XREF: sub_404A10+2Er
                                                      ; sub_404A10+4Ar ...
              dword_407BEC    dd ?                    ; DATA XREF: sub_404BA4:loc_404D3Cw
                                                      ; sub_404E7C+66r ...
              ; HGDIOBJ dword_407BF0
              dword_407BF0    dd ?                    ; DATA XREF: sub_404E7C+7Ar
                                                      ; sub_404F70+F9w ...
              ; HGDIOBJ dword_407BF4
              dword_407BF4    dd ?                    ; DATA XREF: sub_404F70+7Cw
                                                      ; sub_404F70+9Cr
              ; HDC dword_407BF8
              dword_407BF8    dd ?                    ; DATA XREF: sub_404E7C+43r
                                                      ; sub_404F70+97w ...
              ; HDC dword_407BFC
              dword_407BFC    dd ?                    ; DATA XREF: sub_404F70+87w
                                                      ; sub_404F70+8Cr
              ; HWND hWnd
              ds_hWnd            dd ?                    ; DATA XREF: sub_404554+1Fr
                                                      ; sub_404554+5Cr ...
              ; HWND dword_407C04
              dword_407C04    dd ?                    ; DATA XREF: sub_404554+2Cr
                                                      ; sub_404554+76r ...
              ; HWND dword_407C08
              dword_407C08    dd ?                    ; DATA XREF: sub_404554+9Ar
                                                      ; sub_404554+CAr 
.data