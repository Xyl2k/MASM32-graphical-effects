XM_RESOURCE EQU 0
XM_MEMORY   EQU 1
XM_FILE     EQU 2

; The uFMOD_PlaySong function starts playing an XM song
; --------------
; HWAVEOUT* uFMOD_PlaySong(
;   LPVOID lpXM,
;   DWORD  param,
;   DWORD  fdwSong
; );
; Parameters:
;   lpXM
;      Specifies the song to play. If this parameter is NULL,
;      any currently playing song is stopped. In such a case, function
;      does not return a meaningful value
;      fdwSong parameter determines whether this value is interpreted
;      as a filename, as a resource identifier or a pointer to an image
;      of the song in memory
;   param
;      Handle to the executable file that contains the resource to be
;      loaded or size of the image of the song in memory. This parameter
;      is ignored unless XM_RESOURCE or XM_MEMORY is specified in fdwSong
;   fdwSong
;      Flags for playing the song. The following values are defined
;      Value        Meaning
;      XM_FILE      lpXM points to filename
;                   param is ignored
;      XM_MEMORY    lpXM points to an image of a song in memory
;                   param is the image size
;      XM_RESOURCE  lpXM Specifies the name of the resource
;                   param identifies the module whose executable file
;                   contains the resource
;                   The resource type must be RT_RCDATA
; Return Values:
;    Returns a pointer to HWAVEOUT on success or NULL otherwise
uFMOD_PlaySong PROTO :DWORD,:DWORD,:DWORD

; The uFMOD_GetRowOrder function returns the song's current row and order
; --------------
; unsigned short uFMOD_GetRowOrder();
; Return Values:
;    Returns the song's current row in high-order byte and order
;    in low-order byte
uFMOD_GetRowOrder PROTO

; The uFMOD_GetTime function returns the time in milliseconds since the
; song was started. This is useful for synchronizing purposes.
; upon starting the song
; --------------
; unsigned int uFMOD_GetTime();
; Return Values:
;    Returns the time in milliseconds since the song was started
uFMOD_GetTime PROTO