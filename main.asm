INCLUDE Irvine32.inc
includelib winmm.lib

.data
    filename BYTE "pacman.txt", 0
    fileHandle HANDLE ?
    stringLength DWORD ?
;Boundry of Game
ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0
;Title of Game
title1 byte "############################################################################", 0ah, 0
title2 byte "*    _______    _______    _______                     _______             *", 0ah, 0
title3 byte "*   |       |  |       |  |                |\      /| |       |  |\    |   *", 0ah, 0
title4 byte "*   |_______|  |_______|  |         ====   | \    / | |       |  | \   |   *", 0ah, 0
title5 byte "*   |          |       |  |         ====   |  \  /  | |-------|  |  \  |   *", 0ah, 0
title6 byte "*   |          |       |  |                |   \/   | |       |  |   \ |   *", 0ah, 0
title7 byte "*   |          |       |  |_______         |        | |       |  |    \|   *", 0ah, 0
title8 byte "*                                                                          *", 0ah, 0
title9 byte "############################################################################", 0ah, 0

wel1 byte "           _____           ",0ah,0
wel2 byte "|      |  |       |        ",0ah,0
wel3 byte "|  /\  |  |_____  |        ",0ah,0
wel4 byte "| /  \ |  |       |        ",0ah,0
wel5 byte "|/    \|  |_____  |______  ",0ah,0
wel6 byte "                           ",0ah,0

cel1 byte " ______   ______              _____  ",0ah,0
cel2 byte "|        |      |  |\    /|  |       ",0ah,0
cel3 byte "|        |      |  | \  / |  |_____  ",0ah,0
cel4 byte "|        |      |  |  \/  |  |       ",0ah,0
cel5 byte "|______  |______|  |      |  |_____  ",0ah,0
cel6 byte "                                     ",0ah,0

Load byte "LOADING ",0
Load1 byte "* ",0

M1 byte "           ______                    ",0ah,0
M2 BYTE "|\    /|  |        |\   |  |      |  ",0ah,0
M3 BYTE "| \  / |  |______  | \  |  |      |  ",0ah,0
M4 BYTE "|  \/  |  |        |  \ |  |      |  ",0ah,0
M5 BYTE "|      |  |______  |   \|  |______|  ",0ah,0

menu1 byte "( 1 )     START GAME   ",0
menu2 byte "( 2 )    INSTRUCTIONS  ",0
menu3 byte "( 3 )     HIGH SCORE   ",0
menu4 byte "( 4 )       LEVELS     ",0
menu5 byte "( 5 )      END GAME    ",0

delayMaze DD 0
name1 byte 100 DUP(0)  ;Name of player
namestr byte "Player's Name : ",0
nameprompt byte "Enter the Player's Name : ",0
temp byte ?

Ins1 byte "************ INSTRUCTIONS ***************",0
Ins2 byte "                    Welcome to Pac-Man!                                             ",0
Ins3 byte"       Navigate through the maze, eat all pellets, and avoid ghosts                  ",0
Ins4 byte"Use arrow keys to control Pac-Man: ^ for up, \/ for down, <- for left, and -> for right.",0
Ins5 byte"          Eat all pellets to complete each level and progress.                         ",0
Ins6 byte "     Avoid ghosts to stay alive and aim for the highest score.                        ",0
Ins7 byte"Enjoy the classic Pac-Man experience! Have fun and aim for the top of the leaderboard!",0


pacman byte "X",0
strScore BYTE "Your score is: ",0
score BYTE 0

xPos BYTE 40
yPos BYTE 19
;mazecordinate byte 500 DUP(100)
boundxpos byte 100 DUP(100)
boundxpos1 byte 100 DUP(100)
boundypos byte 50 DUP(100)
boundypos1 byte 50 DUP(100)

bound3xpos byte 100 DUP(100)
bound3xpos1 byte 100 DUP(100)
bound3ypos byte 50 DUP(100)
bound3ypos1 byte 50 DUP(100)

foodxpos byte 5,20,60,75
foodypos byte 3,8,13,18,23

xGhostPos BYTE 40
yGhostPos BYTE 8

xGhost1Pos BYTE 20
yGhost1Pos BYTE 8

xGhost2Pos BYTE 60
yGhost2Pos BYTE 8

xGhost3Pos BYTE 40
yGhost3Pos BYTE 8

enemyDelay DD 100

xtemp BYTE ?
ytemp BYTE ?

level byte 1
level1 byte " 1---LEVEL",0
level2 byte " 2---LEVEL",0
level3 byte " 3---LEVEL",0
levelstr byte "LEVEL : ",0

livestr byte "Remaining Lives : ",0
lives byte 3

telePath db 8 dup(100)

inputChar BYTE 0

SND_FILENAME DWORD 00020000h
SND_LOOP DWORD  00000008h
SND_ASYNC DWORD 00000001h
file BYTE "t.wav",0

.code

sound PROC 

        PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

    mov eax, SND_FILENAME  ;; pszSound is a file name
    or eax, SND_LOOP       ;; Play in a loop
    or eax, SND_ASYNC      ;; Play in the background
    invoke PlaySound,addr file,0,eax
    ;invoke PlaySound, addr file, 0, eax
   
RET 
sound Endp
;------------------------------------------------------DISPLAY TITLE PROC --------------------------------------------------- 
DisplayTitle PROC 
mov  eax,yellow+(black*16)
call SetTextColor
call clrscr

mov eax,500
call delay
mov  dl,25   ;column
mov  dh,5    ;row
mov bh,dh              
call Gotoxy
mov edx,offset title1 
call writestring 

mov eax,500
call delay

mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset title2 
call writestring 
mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset title3  
call writestring 
mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset title4  
call writestring 
mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset title5 
call writestring 
mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset title6 
call writestring 
mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset title7 
call writestring 
mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset title8 
call writestring 
mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov eax,500
call delay

mov edx,offset title9 
call writestring 

RET 
DisplayTitle Endp
;--------------------------------------------------------WELCOME PROC------------------------------------
DisplayWelcome proc 

mov eax,2000
call Delay
mov  dl,30   ;column
mov  dh,17    ;row
mov bh,dh              
call Gotoxy
mov edx,offset wel1 
call writestring 
mov dl,30
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset wel2 
call writestring 
mov dl,30
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset wel3  
call writestring 
mov dl,30
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset wel4  
call writestring 
mov dl,30
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset wel5  
call writestring 
mov dl,30
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset wel6  
call writestring 

mov eax,1000
call Delay
mov  dl,57   ;column
mov  dh,17    ;row
mov bh,dh              
call Gotoxy
mov edx,offset cel1 
call writestring 
mov dl,57
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset cel2 
call writestring 
mov dl,57
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset cel3  
call writestring 
mov dl,57
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset cel4  
call writestring 
mov dl,57
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset cel5  
call writestring 
mov dl,57
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset cel6  
call writestring 
call DisplayLoad

RET 
DisplayWelcome Endp
;-------------------------------------------LOAD PROC------------------------------------------------------
DisplayLoad PROC 
mov ecx,2000
call Delay
mov dl,57
mov dh,25
call gotoxy
mov edx,offset load  
call writestring

mov ecx,1000
call Delay
mov edx,offset load1  
call writestring

mov ecx,1500
call Delay
mov edx,offset load1  
call writestring

mov ecx,1500
call Delay
mov edx,offset load1  
call writestring


mov ecx,2000
call Delay 

call clrscr
RET 
DisplayLoad Endp
;------------------------------------------------------MENU PROC --------------------------------------------------
MENU PROC
mov  eax,yellow+(black*16)
call SetTextColor
call sound 

mov bh,0

mov eax,500
call Delay
vertical:
mov al,'|'
mov dl,0
mov dh,bh
call gotoxy 
call WriteChar
inc bh 
cmp bh,25 
JLE vertical

mov eax,500
call Delay

mov bh,0
Horizontal: 
mov  al,'='
mov dl,bh
mov dh,25
call gotoxy 
call WriteChar
inc bh 
cmp bh,79 
JLE horizontal

mov eax,500
call Delay

mov bh,25
vertical1:
mov al,'|'
mov dl,79
mov dh,bh
call gotoxy 
call WriteChar
dec bh 
cmp bh,0 
JGE vertical1

mov eax,500
call Delay

mov bh,79
horizontal1:
mov al,'='
mov dl,bh
mov dh,0
call gotoxy 
call WriteChar
dec bh 
cmp bh,0 
JGE horizontal1

mov eax,1000
call Delay

mov  dl,20   ;column
mov  dh,3    ;row
mov bh,dh              
call Gotoxy
mov edx,offset M1 
call writestring 

mov eax,500
call delay

mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset M2 
call writestring 

mov eax,500
call delay
mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset M3  
call writestring 

mov eax,500
call delay
mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset M4  
call writestring 

mov eax,500
call delay
mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset M5  
call writestring 

mov  dl,20   ;column
mov  dh,12    ;row
mov bh,dh              
call Gotoxy
mov edx,offset Menu1 
call writestring 

mov eax,500
call delay

mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset Menu2 
call writestring 

mov eax,500
call delay

mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset Menu3 
call writestring 

mov eax,500
call delay

mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset Menu4  
call writestring 

mov eax,500
call delay

mov dl,20
mov dh,bh
inc dh
inc bh
call gotoxy
mov edx,offset Menu5 
call writestring 

mov dl,25
mov dh,bh
inc dh
inc bh
call gotoxy
mov eax,0
call readInt

cmp eax,1 
JE startGame

cmp eax,2
JE Instruction

cmp eax,4
JE AssignLevel
;call startGame

cmp eax,5
JE EndGame

RET
MENU Endp
;-----------------------------------------ASSIGN LEVEL PROC----------------------------------------------
AssignLevel PROC 
call clrscr 
mov  eax,blue+(black*16)
call SetTextColor

mov  dl,40   ;column
mov  dh,10    ;row
mov bh,dh              
call Gotoxy
mov edx,offset level1 
call writestring 

mov  eax,green+(black*16)
call SetTextColor
mov  dl,40   ;column
mov  dh,15    ;row
mov bh,dh              
call Gotoxy
mov edx,offset level2 
call writestring

mov  eax,red+(black*16)
call SetTextColor
mov  dl,40   ;column
mov  dh,20    ;row
mov bh,dh              
call Gotoxy
mov edx,offset level3 
call writestring

call readInt
mov level,al
call startGame
RET
AssignLevel Endp
;-------------------------------------------CREATEMAZE PROC-----------------------------------------------
creatMaze PROC 

mov  eax,blue+(black*16)
call SetTextColor
call clrscr
mov esi,offset boundxpos
mov edi,offset boundypos
mov bh,0
mov ebx,0
mov delayMaze,10
vertical:
mov eax,0
mov al,219
mov dl,0
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,25 
JLE vertical

mov bh,0
mov ebx,0
Horizontal: 
mov  al,219
mov dl,bh
mov dh,25
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,79 
JLE horizontal

mov ebx,0
mov bh,25
vertical1:
mov al,219
mov dl,79
mov dh,bh
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
dec bh 
cmp bh,0 
JGE vertical1

mov bh,79
horizontal1:
mov al,219
mov dl,bh
mov dh,0
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
dec bh 
cmp bh,0 
JGE horizontal1

mov bh,0
vertical2:
mov eax,0
mov al,219
mov dl,40
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
inc bh
cmp bh,5 
JLE vertical2

mov bh,25
vertical3:
mov eax,0
mov al,219
mov dl,40
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
dec bh
cmp bh,20 
JGE vertical3

mov edi,offset boundypos1
mov bh,10
vertical4:
mov eax,0
mov al,219
mov dl,10
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
inc bh 
cmp bh,20 
JLE vertical4

mov bh,10
vertical5:
mov eax,0
mov al,219
mov dl,70
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,20 
JLE vertical5

mov bh,10
Horizontal2: 
mov  al,219
mov dl,bh
mov dh,5
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
mov [esi],bh
inc esi
cmp bh,30 
JLE horizontal2

mov bh,10
Horizontal3: 
mov  al,219
mov dl,bh
mov dh,10
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,30 
JLE horizontal3

mov bh,10
Horizontal4: 
mov  al,219
mov dl,bh
mov dh,20
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,30 
JLE horizontal4

mov bh,50
Horizontal5: 
mov  al,219
mov dl,bh
mov dh,20
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
mov [esi],bh
inc esi
cmp bh,70 
JLE horizontal5

mov bh,50
Horizontal6: 
mov  al,219
mov dl,bh
mov dh,10
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,70 
JLE horizontal6

mov bh,50
Horizontal7: 
mov  al,219
mov dl,bh
mov dh,5
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,70 
JLE horizontal7

mov bh,30
Horizontal8: 
mov  al,219
mov dl,bh
mov dh,13
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh

cmp bh,38 
JLE horizontal8

mov bh,42
Horizontal9: 
mov  al,219
mov dl,bh
mov dh,13
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh

cmp bh,50 
JLE horizontal9

mov esi,offset boundxpos1
mov bh,30
Horizontal10: 
mov  al,219
mov dl,bh
mov dh,17
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [esi],bh
inc esi
inc bh 
cmp bh,50 
JLE horizontal10

mov bh,13
vertical6:
mov eax,0
mov al,219
mov dl,30
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,17 
JLE vertical6

mov bh,13
vertical7:
mov eax,0
mov al,219
mov dl,50
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,17 
JLE vertical7

RET 
creatMaze Endp 
;--------------------------------------------START GAME PROC-------------------------------------------------------
startGame PROC
call sound
cmp level,1 
JE level1maze

cmp level,2 
JE level2maze

cmp level,3 
JE level3maze

level1maze:
call Instruction
call creatMaze
call DRAWFOOD
call drawplayer
call gamestart

level2maze:
call clrscr
mov eax,100
call delay 
mov dl,40 
mov dh,12
call gotoxy
mov eax,green 
call SetTextcolor
mov edx,offset level2
call writestring
mov eax,1000 
call delay 
call clrscr
call creatMaze2
call DRAWFOOD
mov xpos,40 
mov ypos,19
mov xGhostpos,40 
mov yGhostpos,8
mov lives,3
mov enemyDelay,10
call drawplayer
call gamestart

level3maze:
call clrscr
;call TeleportationPath
mov eax,100
call delay 
mov dl,40 
mov dh,12
call gotoxy
mov eax,red 
call SetTextcolor
mov edx,offset level3
call writestring
mov eax,1000 
call delay 
call clrscr
call creatMaze3
call DRAWFOOD
mov xpos,40 
mov ypos,19
mov xGhostpos,40 
mov yGhostpos,8
mov lives,3
mov enemyDelay,10
call drawplayer
call gamestart3

RET 
startGame Endp
;----------------------------------------DRAW FOOD PROC------------------------------------------------------------
DRAWFOOD PROC 
    mov eax,yellow ;(blue*16)
    call SetTextColor    
   
    mov bh,3
    mov ecx,5
    printfoodH1:
    mov dl,5
    mov dh,bh
    call Gotoxy
    mov al,"*"
    call WriteChar

    mov dl,20
    mov dh,bh
    call Gotoxy
    mov al,"*"
    call WriteChar

    mov dl,60
    mov dh,bh
    call Gotoxy
    mov al,"*"
    call WriteChar

    mov dl,75
    mov dh,bh
    call Gotoxy
    mov al,"*"
    call WriteChar
    add bh,5
    loop printfoodH1
RET
DRAWFOOD Endp
;---------------------------------------INSTRUCTION PROC------------------------------------------------------------
Instruction PROC 
call clrscr
mov dl,20
mov dh,3
call gotoxy
mov edx,offset ins1
call writestring 


mov dl,5
mov dh,6
call gotoxy
mov edx,offset ins2 
call writestring 

mov dl,5
mov dh,8
call gotoxy
mov edx,offset ins3 
call writestring 
mov dl,5
mov dh,10
call gotoxy
mov edx,offset ins4 
call writestring 
mov dl,5
mov dh,12
call gotoxy
mov edx,offset ins5 
call writestring 
mov dl,5
mov dh,14
call gotoxy
mov edx,offset ins6 
call writestring

mov dl,5
mov dh,16
call gotoxy
mov edx,offset ins7 
call writestring

call readchar 
call clrscr 
;call menu
RET 
Instruction Endp 
;-----------------------------------------------HIGH SCORE PROC----------------------------------------------------
HighScore PROC 


RET 
HighScore Endp

;------------------------------------------------DRAW PLAYER PROC -------------------------------------------------
DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP
;-----------------------------------------------UPDATE PLAYER PROC ---------------------------------------------------
UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP
;----------------------------------------------Update Ghost PROC----------------------------------------------------------
UpdateGhost PROC
    mov dl,xGhostPos
    mov dh,yGhostPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdateGhost ENDP
;----------------------------------------------DRAW GHOST PROC--------------------------------------------------------------
DrawGhost PROC
    ; draw player at (xPos,yPos):
    mov eax,red ;(blue*16)
    call SetTextColor
    mov dl,xGhostPos
    mov dh,yGhostPos
    call Gotoxy
    mov al,234
    call WriteChar
    ret
DrawGhost ENDP

moveLeftEnemy PROC
    moveLeft:
        cmp xGhostpos,1
        JLE outleftloop
        cmp xGhostpos,11
        JE checkboundLeft1
        cmp xGhostpos,71
        JE checkboundLeft1
         cmp xGhostpos,41
        JE checkboundLeft
        JMP moveleft1
        checkboundLeft1:
        mov edi,offset boundypos1
        mov ecx,20
        JMP ycheck
        checkboundLeft:
         mov edi,offset boundypos 
         mov ecx,20
         ycheck:
        mov bl,[edi]
        cmp yGhostpos,bl
        JE outleftloop 
        inc edi
        loop ycheck
        moveleft1:
      ; push ax
        call UpdateGhost
        dec xGhostPos
        call DrawGhost
       ; call ScoreCount
         mov eax,100
         call Delay

        outleftloop:
	RET
	moveLeftEnemy ENDP
;;;;;;;;;;;;;;;;;;;;
moveRightEnemy PROC
   
    moveRight:
         cmp xGhostpos,78
        JGE outRightloop
        cmp xGhostpos,9
        JE checkboundRight1
        cmp xGhostpos,69
        JE checkboundRight1
        cmp xGhostpos,39
        JE checkboundRight
        JMP moveRight1
        checkboundRight1:
        mov edi,offset boundypos1
        mov ecx,20
        JMP ycheck1
        checkboundRight:
        mov edi,offset boundypos 
        mov ecx,20
        ycheck1:
        mov bl,[edi]
        cmp yGhostpos,bl
        JE outRightloop 
        inc edi
        loop ycheck1
       moveRight1:
     ;  push ax
        call UpdateGhost
        inc xGhostPos
        call DrawGhost
    ;    call ScoreCount
         mov eax,100
         call Delay

       outRightloop:
	RET
	moveRightEnemy ENDP
;;;;;;;;;;;;;;;;;;;;
moveUpEnemy PROC

 moveUp:
       
        cmp yGhostpos,1
        JLE outUploop
        cmp yGhostpos,6
        JE checkboundUp
         cmp yGhostpos,8 
        JE checkboundUp1
        cmp yGhostpos,11 
        JE checkboundUp
        cmp yGhostpos,18 
        JE checkboundUp1
        cmp yGhostpos,21 
        JE checkboundUp
         cmp yGhostpos,23 
        JE checkboundUp1
        JMP moveUp1

        checkboundUp1:
        mov esi,offset boundxpos1 
        mov ecx,100
        JMP xcheck
        checkboundUp:
        mov esi,offset boundxpos 
        mov ecx,80
        xcheck:
        mov bl,[esi]
        cmp xGhostpos,bl
        JE outUploop 
        inc esi
        loop xcheck
        moveUp1:
       ; push eax
            call UpdateGhost
            dec yGhostPos
            
            call DrawGhost
          ;  call ScoreCount
            mov eax,100
            call Delay

      outUploop:
	RET
	moveUpEnemy ENDP
;;;;;;;;;;;;;;;;;;;;
moveDownEnemy PROC

 moveDown:
        cmp yGhostpos,24
        JGE outDownloop
        cmp yGhostpos,4
        JE checkboundDown
         cmp yGhostpos,6
        JE checkboundDown1
        cmp yGhostpos,9
        JE checkboundDown
        cmp yGhostpos,12
        JE checkboundDown1
        cmp yGhostpos,19
        JE checkboundDown
         cmp yGhostpos,21
        JE checkboundDown1
        JMP moveDown1
        checkboundDown1:
         mov esi,offset boundxpos1 
        mov ecx,80 
        JMP xcheck1
        checkboundDown:
       mov esi,offset boundxpos 
        mov ecx,80  
        xcheck1:
        mov bl,[esi]
        cmp xGhostpos,bl
        JE outDownloop 
        inc esi
        loop xcheck1
        
        moveDown1:
       ; push ax
        call UpdateGhost
        inc yGhostPos
        call DrawGhost
       ; call ScoreCount
         mov eax,100
            call Delay

     outDownloop:
     
	RET
	moveDownEnemy ENDP

EnemyMov PROC
	
L0:
	mov eax,enemyDelay
	call delay
	call randomize
	mov eax,5 
	call RandomRange
	inc eax
	mov xtemp,dl
	mov ytemp,dh

	mov dl,xGhostpos
	mov dh,yGhostPos

	cmp eax,1
	je L1
	cmp eax,2
	je L2
	cmp eax,3
	je L3
    cmp eax,4
	je L4

	L1:

		call moveLeftEnemy
		jmp L5
	L2:

		call moveRightEnemy
		jmp L5
	L3:

		call moveUpEnemy
		jmp L5
	L4:

		call moveDownEnemy
		jmp L5
	L5:
		mov xGhostpos,dl
		mov yGhostPos,dh

	L6:
		call readkey

		mov dl,xtemp
		mov dh,ytemp

		JZ L0
        mov inputChar,al
	RET
EnemyMov ENDP

;-------------------------------------------------------SCORE COUNT PROC ---------------------------------------------
ScoreCount PROC
        mov dl,82
        mov dh,3
        call Gotoxy
        mov edx,OFFSET namestr
        call WriteString
        mov edx,OFFSET name1
        call WriteString

        mov dl,82
        mov dh,5
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov al,score
        call WriteInt

        mov dl,82
        mov dh,7
        call Gotoxy
        mov edx,OFFSET levelstr
        call WriteString
        mov al,level
        call WriteInt

        cmp xpos,42
        JE fruity 
        JMP foodtemp

        fruity:
        cmp ypos,1
        JNE foodtemp 
        add score,10
        
        foodtemp:
mov esi,offset foodxpos
mov edi,offset foodypos

mov ecx,4
checkfoodx:
mov al,[esi]
cmp xpos,al 
JE checky 
inc esi
loop checkfoodx
JMP quit

checky:
mov ecx,5
checkfoody:
mov bl,[edi]
cmp ypos,bl 
JE count
inc edi
loop checkfoody
JMP quit

count:
inc score
cmp score,20
JE IncLevel
cmp score,50
JE IncLevel
cmp score,25
JE fruit
cmp score,52
JE fruit
cmp score,80
JE Endgame
JMP quit
IncLevel:
inc level
call startGame

fruit:
mov xtemp,dh 
mov ytemp,dl 
mov dl,42
mov dh,1 
call gotoxy
mov al,148
call writechar 
mov dh,xtemp 
mov dl,ytemp
JMP quit


quit: 

RET 
ScoreCount Endp

LivesCount PROC 
        mov dl,82
        mov dh,9
        call Gotoxy
        mov edx,OFFSET livestr
        call WriteString
        mov al,lives
        call WriteInt

        mov al,xGhostPos 
        cmp xpos,al 
        JE checky 
        JMP quit 

        checky:
        mov bl,yGhostPos 
        cmp ypos,bl
        JE diclives 
        JMP quit

        diclives:
        dec lives
        mov xpos,40
        mov ypos,19
        cmp lives,0 
        JE EndGame
        quit:

RET
LivesCount Endp
;---------------------------------------------------------GAMESTART PROC -----------------------------------------------
Gamestart PROC 
; get user key input:

gameloop:

        call Enemymov
        
        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        cmp inputChar,"p"
        je Gamepause

        moveUp:
       
        cmp ypos,1
        JLE gameloop
        cmp ypos,6
        JE checkboundUp
         cmp ypos,8 
        JE checkboundUp1
        cmp ypos,11 
        JE checkboundUp
        cmp ypos,18 
        JE checkboundUp1
        cmp ypos,21 
        JE checkboundUp
         cmp ypos,23 
        JE checkboundUp1
        JMP moveUp1

        checkboundUp1:
        mov esi,offset boundxpos1 
        mov ecx,100
        JMP xcheck
        checkboundUp:
        mov esi,offset boundxpos 
        mov ecx,80
        xcheck:
        mov bl,[esi]
        cmp xpos,bl
        JE gameloop 
        inc esi
        loop xcheck
        moveUp1:
            call UpdatePlayer
            dec yPos
            
            call DrawPlayer
            call ScoreCount
            call LivesCount
            ; mov eax,100
           ; call Delay
        JMP gameloop

        moveDown:
        cmp ypos,24
        JGE gameloop
        cmp ypos,4
        JE checkboundDown
         cmp ypos,6
        JE checkboundDown1
        cmp ypos,9
        JE checkboundDown
        cmp ypos,12
        JE checkboundDown1
        cmp ypos,19
        JE checkboundDown
         cmp ypos,21
        JE checkboundDown1
        JMP moveDown1
        checkboundDown1:
         mov esi,offset boundxpos1 
        mov ecx,80 
        JMP xcheck1
        checkboundDown:
       mov esi,offset boundxpos 
        mov ecx,80  
        xcheck1:
        mov bl,[esi]
        cmp xpos,bl
        JE gameloop 
        inc esi
        loop xcheck1
        
        moveDown1:
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        call ScoreCount
        call LivesCount
       ; mov eax,100
       ; call Delay
        JMP gameloop

        moveLeft:
        cmp xpos,1
        JLE gameloop
        cmp xpos,11
        JE checkboundLeft1
        cmp xpos,71
        JE checkboundLeft1
         cmp xpos,41
        JE checkboundLeft
        JMP moveleft1
        checkboundLeft1:
        mov edi,offset boundypos1
         mov ecx,20
        JMP ycheck
        checkboundLeft:
       mov edi,offset boundypos 
       mov ecx,20
       ycheck:
        mov bl,[edi]
        cmp ypos,bl
        JE gameloop 
        inc edi
        loop ycheck
       moveleft1:
       call UpdatePlayer
       dec xPos
       call DrawPlayer
       call ScoreCount
       call LivesCount
       jmp gameLoop

        moveRight:
         cmp xpos,78
        JGE gameloop
        cmp xpos,9
        JE checkboundRight1
        cmp xpos,69
        JE checkboundRight1
        cmp xpos,39
        JE checkboundRight
        JMP moveRight1
        checkboundRight1:
        mov edi,offset boundypos1
        mov ecx,20
        JMP ycheck1
        checkboundRight:
       mov edi,offset boundypos 
       mov ecx,20
       ycheck1:
        mov bl,[edi]
        cmp ypos,bl
        JE gameloop 
        inc edi
        loop ycheck1
       moveRight1:
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        call ScoreCount
        call LivesCount
        jmp gameLoop

        Gamepause:
        call Readkey 
        jz Gamepause

    jmp gameLoop
    

RET 
gamestart Endp
;=========================================== LEVEL # 02 ====================================================

;-------------------------------------------CREATEMAZE 2 PROC-----------------------------------------------
creatMaze2 PROC 
mov  eax,green+(black*16)
call SetTextColor
call clrscr
mov esi,offset boundxpos
mov edi,offset boundypos
mov bh,0
mov ebx,0
mov delayMaze,10
vertical:
mov eax,0
mov al,219
mov dl,0
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,25 
JLE vertical

mov bh,0
mov ebx,0
Horizontal: 
mov  al,219
mov dl,bh
mov dh,25
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,79 
JLE horizontal

mov ebx,0
mov bh,25
vertical1:
mov al,219
mov dl,79
mov dh,bh
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
dec bh 
cmp bh,0 
JGE vertical1

mov bh,79
horizontal1:
mov al,219
mov dl,bh
mov dh,0
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
dec bh 
cmp bh,0 
JGE horizontal1

mov bh,0
vertical2:
mov eax,0
mov al,219
mov dl,40
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
inc bh
cmp bh,7 
JLE vertical2

mov bh,25
vertical3:
mov eax,0
mov al,219
mov dl,40
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
dec bh
cmp bh,22 
JGE vertical3

mov edi,offset boundypos1
mov bh,10
vertical4:
mov eax,0
mov al,219
mov dl,10
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
inc bh 
cmp bh,20 
JLE vertical4

mov bh,10
vertical5:
mov eax,0
mov al,219
mov dl,70
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,20 
JLE vertical5

mov bh,10
Horizontal2: 
mov  al,219
mov dl,bh
mov dh,5
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
mov [esi],bh
inc esi
cmp bh,30 
JLE horizontal2

mov bh,10
Horizontal3: 
mov  al,219
mov dl,bh
mov dh,10
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,30 
JLE horizontal3

mov bh,10
Horizontal4: 
mov  al,219
mov dl,bh
mov dh,20
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,30 
JLE horizontal4

mov bh,50
Horizontal5: 
mov  al,219
mov dl,bh
mov dh,20
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
mov [esi],bh
inc esi
cmp bh,70 
JLE horizontal5

mov bh,50
Horizontal6: 
mov  al,219
mov dl,bh
mov dh,10
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,70 
JLE horizontal6

mov bh,50
Horizontal7: 
mov  al,219
mov dl,bh
mov dh,5
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,70 
JLE horizontal7

mov bh,30
Horizontal8: 
mov  al,219
mov dl,bh
mov dh,13
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh

cmp bh,38 
JLE horizontal8

mov bh,42
Horizontal9: 
mov  al,219
mov dl,bh
mov dh,13
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh
cmp bh,50 
JLE horizontal9

mov esi,offset boundxpos1
mov bh,30
Horizontal10: 
mov  al,219
mov dl,bh
mov dh,17
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [esi],bh
inc esi
inc bh 
cmp bh,50 
JLE horizontal10

mov bh,30
Horizontal11: 
mov  al,219
mov dl,bh
mov dh,7
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,50 
JLE horizontal11

mov bh,30
Horizontal12: 
mov  al,219
mov dl,bh
mov dh,22
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,50 
JLE horizontal12

mov bh,13
vertical6:
mov eax,0
mov al,219
mov dl,30
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,17 
JLE vertical6

mov bh,13
vertical7:
mov eax,0
mov al,219
mov dl,50
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,17 
JLE vertical7

RET 
creatMaze2 Endp 
;================================================LEVEL 3 ==================================================
;-------------------------------------------CREATEMAZE 3 PROC-----------------------------------------------
creatMaze3 PROC 
mov  eax,red+(black*16)
call SetTextColor
call clrscr
mov esi,offset bound3xpos
mov edi,offset bound3ypos
mov bh,0
mov ebx,0
mov delayMaze,10
vertical:
mov eax,0
mov al,219
mov dl,0
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,25 
JLE vertical

mov bh,0
mov ebx,0
Horizontal: 
mov  al,219
mov dl,bh
mov dh,25
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,79 
JLE horizontal

mov ebx,0
mov bh,25
vertical1:
mov al,219
mov dl,79
mov dh,bh
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
dec bh 
cmp bh,0 
JGE vertical1

mov bh,79
horizontal1:
mov al,219
mov dl,bh
mov dh,0
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
dec bh 
cmp bh,0 
JGE horizontal1

mov bh,0
vertical2:
mov eax,0
mov al,219
mov dl,40
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
inc bh
cmp bh,6 
JLE vertical2

mov bh,0
vertical2l:
mov eax,0
mov al,219
mov dl,21
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
;mov [edi],bh
;inc edi
inc bh
cmp bh,5 
JLE vertical2l

mov bh,0
vertical2r:
mov eax,0
mov al,219
mov dl,59
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
;mov [edi],bh
;inc edi
inc bh
cmp bh,5 
JLE vertical2r

mov bh,25
vertical3:
mov eax,0
mov al,219
mov dl,40
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
dec bh
cmp bh,22 
JGE vertical3

mov bh,25
vertical3l:
mov eax,0
mov al,219
mov dl,21
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
;mov [edi],bh
;inc edi
dec bh
cmp bh,20 
JGE vertical3l

mov bh,25
vertical3r:
mov eax,0
mov al,219
mov dl,59
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
;mov [edi],bh
;inc edi
dec bh
cmp bh,20 
JGE vertical3r

mov edi,offset bound3ypos1
mov bh,10
vertical4:
mov eax,0
mov al,219
mov dl,10
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [edi],bh
inc edi
inc bh 
cmp bh,20 
JLE vertical4

mov bh,10
vertical5:
mov eax,0
mov al,219
mov dl,70
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,20 
JLE vertical5

mov bh,10
Horizontal2: 
mov  al,219
mov dl,bh
mov dh,5
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
mov [esi],bh
inc esi
cmp bh,30 
JLE horizontal2

mov bh,10
Horizontal3: 
mov  al,219
mov dl,bh
mov dh,10
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,30 
JLE horizontal3

mov bh,10
Horizontal4: 
mov  al,219
mov dl,bh
mov dh,20
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,30 
JLE horizontal4

mov bh,50
Horizontal5: 
mov  al,219
mov dl,bh
mov dh,20
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
mov [esi],bh
inc esi
cmp bh,70 
JLE horizontal5

mov bh,50
Horizontal6: 
mov  al,219
mov dl,bh
mov dh,10
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,70 
JLE horizontal6

mov bh,50
Horizontal7: 
mov  al,219
mov dl,bh
mov dh,5
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,70 
JLE horizontal7

mov bh,30
Horizontal8: 
mov  al,219
mov dl,bh
mov dh,13
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh

cmp bh,38 
JLE horizontal8

mov bh,42
Horizontal9: 
mov  al,219
mov dl,bh
mov dh,13
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh
cmp bh,50 
JLE horizontal9

mov esi,offset bound3xpos1
mov bh,30
Horizontal10: 
mov  al,219
mov dl,bh
mov dh,17
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
mov [esi],bh
inc esi
inc bh 
cmp bh,50 
JLE horizontal10

mov bh,30
Horizontal11: 
mov  al,219
mov dl,bh
mov dh,7
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,50 
JLE horizontal11

mov bh,30
Horizontal12: 
mov  al,219
mov dl,bh
mov dh,22
call gotoxy 
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,50 
JLE horizontal12

mov bh,13
vertical6:
mov eax,0
mov al,219
mov dl,30
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,17 
JLE vertical6

mov bh,13
vertical7:
mov eax,0
mov al,219
mov dl,50
mov dh,bh
call gotoxy
call WriteChar
mov eax,0
mov eax,delayMaze
call Delay
inc bh 
cmp bh,17 
JLE vertical7

RET 
creatMaze3 Endp
;----------------------------------------Enemy lEFT RIGHT UP DOWN-------------------------------------------------------
moveLeftEnemy3 PROC
    moveLeft:
        cmp xGhostpos,1
        JLE outleftloop
        cmp xGhostpos,11
        JE checkboundLeft1
        cmp xGhostpos,71
        JE checkboundLeft1
         cmp xGhostpos,41
        JE checkboundLeft
        cmp xGhostpos,23
        JE checkboundLeft
        cmp xGhostpos,60
        JE checkboundLeft
        JMP moveleft1
        checkboundLeft1:
        mov edi,offset bound3ypos1
        mov ecx,20
        JMP ycheck
        checkboundLeft:
         mov edi,offset bound3ypos 
         mov ecx,20
         ycheck:
        mov bl,[edi]
        cmp yGhostpos,bl
        JE outleftloop 
        inc edi
        loop ycheck
        moveleft1:
        call UpdateGhost
        dec xGhostPos
        call DrawGhost
       ; call ScoreCount
         mov eax,100
         call Delay

        outleftloop:
	RET
	moveLeftEnemy3 ENDP
;;;;;;;;;;;;;;;;;;;;
moveRightEnemy3 PROC
   
    moveRight:
         cmp xGhostpos,78
        JGE outRightloop
        cmp xGhostpos,9
        JE checkboundRight1
        cmp xGhostpos,69
        JE checkboundRight1
        cmp xGhostpos,39
        JE checkboundRight
        cmp xGhostpos,20
        JE checkboundRight
        cmp xGhostpos,58
        JE checkboundRight
        JMP moveRight1
        checkboundRight1:
        mov edi,offset bound3ypos1
        mov ecx,20
        JMP ycheck1
        checkboundRight:
        mov edi,offset bound3ypos 
        mov ecx,20
        ycheck1:
        mov bl,[edi]
        cmp yGhostpos,bl
        JE outRightloop 
        inc edi
        loop ycheck1
       moveRight1:
        call UpdateGhost
        inc xGhostPos
        call DrawGhost
    ;    call ScoreCount
         mov eax,100
         call Delay

       outRightloop:
	RET
	moveRightEnemy3 ENDP
;;;;;;;;;;;;;;;;;;;;
moveUpEnemy3 PROC
 moveUp:
       
        cmp yGhostpos,1
        JLE outUploop
        cmp yGhostpos,6
        JE checkboundUp
         cmp yGhostpos,8 
        JE checkboundUp1
        cmp yGhostpos,11 
        JE checkboundUp
        cmp yGhostpos,18 
        JE checkboundUp1
        cmp yGhostpos,21 
        JE checkboundUp
         cmp yGhostpos,23 
        JE checkboundUp1
        JMP moveUp1

        checkboundUp1:
        mov esi,offset bound3xpos1 
        mov ecx,100
        JMP xcheck
        checkboundUp:
        mov esi,offset bound3xpos 
        mov ecx,80
        xcheck:
        mov bl,[esi]
        cmp xGhostpos,bl
        JE outUploop 
        inc esi
        loop xcheck
        moveUp1:
            call UpdateGhost
            dec yGhostPos
            call DrawGhost
            mov eax,100
            call Delay
      outUploop:
	RET
	moveUpEnemy3 ENDP
;;;;;;;;;;;;;;;;;;;;
moveDownEnemy3 PROC
 moveDown:
        cmp yGhostpos,24
        JGE outDownloop
        cmp yGhostpos,4
        JE checkboundDown
         cmp yGhostpos,6
        JE checkboundDown1
        cmp yGhostpos,9
        JE checkboundDown
        cmp yGhostpos,12
        JE checkboundDown1
        cmp yGhostpos,19
        JE checkboundDown
         cmp yGhostpos,21
        JE checkboundDown1
        JMP moveDown1
        checkboundDown1:
         mov esi,offset bound3xpos1 
        mov ecx,80 
        JMP xcheck1
        checkboundDown:
       mov esi,offset bound3xpos 
        mov ecx,80  
        xcheck1:
        mov bl,[esi]
        cmp xGhostpos,bl
        JE outDownloop 
        inc esi
        loop xcheck1
        
        moveDown1:
        call UpdateGhost
        inc yGhostPos
        call DrawGhost
       ; call ScoreCount
         mov eax,100
            call Delay

     outDownloop:
     
	RET
	moveDownEnemy3 ENDP

    LivesCount3 PROC 
        mov xtemp,dh 
        mov ytemp,dl
        mov dl,82
        mov dh,9
        call Gotoxy
        mov edx,OFFSET livestr
        call WriteString
        mov al,lives
        call WriteInt

        mov al,xGhostPos 
        cmp xpos,al 
        JE checky 
        JMP quit 

        checky:
        mov bl,yGhostPos 
        cmp ypos,bl
        JE diclives 
        JMP quit

        diclives:
        dec lives
        mov xpos,40
        mov ypos,19
        cmp lives,0 
        JE EndGame
        quit:
        mov dh,xtemp 
        mov dl,ytemp
RET
LivesCount3 Endp

EnemyMov3 PROC
	
L0:
	mov eax,1;enemyDelay
	call delay
	call randomize
	mov eax,5 
	call RandomRange
	inc eax
	mov xtemp,dl
	mov ytemp,dh

	mov dl,xGhost1pos
	mov dh,yGhost1Pos
   
    mov bl,xGhost1pos
    mov xGhostpos,bl
    mov bl,yGhost1pos
    mov yGhostpos,bl
	
    cmp eax,1
	je L1
	cmp eax,2
	je L2
	cmp eax,3
	je L3
    cmp eax,4
	je L4

	L1:
	
		call moveLeftEnemy3
        call livescount3
		jmp L5
	L2:
	
		call moveRightEnemy3
		call livescount3
        jmp L5
	L3:

		call moveUpEnemy3
		call livescount3
        jmp L5
	L4:

		call moveDownEnemy3
		call livescount3
        jmp L5
	L5:
		mov xGhost1pos,dl
		mov yGhost1Pos,dh

	
        mov dl,xGhost2pos
	    mov dh,yGhost2Pos

    call randomize
	mov eax,5 
	call RandomRange
	inc eax
    mov bl,xGhost2pos
    mov xGhostpos,bl
    
    mov bl,yGhost2pos
    mov yGhostpos,bl

	cmp eax,1
	je L11
	cmp eax,2
	je L22
	cmp eax,3
	je L33
    cmp eax,4
	je L44

	L11:
	
		call moveLeftEnemy3
		call livescount3
        jmp L55
	L22:
	
		call moveRightEnemy3
		call livescount3
        jmp L55
	L33:

		call moveUpEnemy3
		call livescount3
        jmp L55
	L44:

		call moveDownEnemy3
		call livescount3
        jmp L55
	L55:
		mov xGhost2pos,dl
		mov yGhost2Pos,dh

        mov dl,xGhost3pos
	    mov dh,yGhost3Pos
        mov bl,xGhost3pos
        mov xGhostpos,bl
    
        mov bl,yGhost3pos
        mov yGhostpos,bl
    
    call randomize
	mov eax,5 
	call RandomRange
	inc eax
   

	cmp eax,1
	je L111
	cmp eax,2
	je L222
	cmp eax,3
	je L333
    cmp eax,4
	je L444

	L111:
	
		call moveLeftEnemy3
		call livescount3
        jmp L555
	L222:
	
		call moveRightEnemy3
		call livescount3
        jmp L555
	L333:

		call moveUpEnemy3
		call livescount3
        jmp L555
	L444:

		call moveDownEnemy3
		call livescount3
        jmp L555
	L555:
		mov xGhost3pos,dl
		mov yGhost3Pos,dh
	L6:	
        call readkey

		mov dl,xtemp
		mov dh,ytemp

		JZ L0
        mov inputChar,al
	RET
EnemyMov3 ENDP
;----------------------------------------teleport------------------------------

;;;;;;;;;;;;;;;;;;;;
;---------------------------------------------------------GAMESTART 3 PROC--------------------------------------------------
Gamestart3 PROC 
; get user key input:

gameloop:

        call Enemymov3
       ; call teleport
        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        cmp inputChar,"p"
        je Gamepause

        moveUp:
       
        cmp ypos,1
        JLE gameloop
        cmp ypos,6
        JE checkboundUp
         cmp ypos,8 
        JE checkboundUp1
        cmp ypos,11 
        JE checkboundUp
        cmp ypos,18 
        JE checkboundUp1
        cmp ypos,21 
        JE checkboundUp
         cmp ypos,23 
        JE checkboundUp1
        JMP moveUp1

        checkboundUp1:
        mov esi,offset bound3xpos1 
        mov ecx,100
        JMP xcheck
        checkboundUp:
        mov esi,offset bound3xpos 
        mov ecx,80
        xcheck:
        mov bl,[esi]
        cmp xpos,bl
        JE gameloop 
        inc esi
        loop xcheck
        moveUp1:
            call UpdatePlayer
            dec yPos
            
            call DrawPlayer
            call ScoreCount
            call LivesCount
            ; mov eax,100
           ; call Delay
        JMP gameloop

        moveDown:
        cmp ypos,24
        JGE gameloop
        cmp ypos,4
        JE checkboundDown
         cmp ypos,6
        JE checkboundDown1
        cmp ypos,9
        JE checkboundDown
        cmp ypos,12
        JE checkboundDown1
        cmp ypos,19
        JE checkboundDown
         cmp ypos,21
        JE checkboundDown1
        JMP moveDown1
        checkboundDown1:
         mov esi,offset bound3xpos1 
        mov ecx,80 
        JMP xcheck1
        checkboundDown:
       mov esi,offset bound3xpos 
        mov ecx,80  
        xcheck1:
        mov bl,[esi]
        cmp xpos,bl
        JE gameloop 
        inc esi
        loop xcheck1
        
        moveDown1:
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        call ScoreCount
        call LivesCount
       ; mov eax,100
       ; call Delay
        JMP gameloop

        moveLeft:
        cmp xpos,1
        JLE gameloop
        cmp xpos,11
        JE checkboundLeft1
        cmp xpos,22
        JE checkboundLeft
        cmp xpos,60
        JE checkboundLeft
        cmp xpos,71
        JE checkboundLeft1
         cmp xpos,41
        JE checkboundLeft
        JMP moveleft1
        checkboundLeft1:
        mov edi,offset bound3ypos1
         mov ecx,20
        JMP ycheck
        checkboundLeft:
       mov edi,offset bound3ypos 
       mov ecx,20
       ycheck:
        mov bl,[edi]
        cmp ypos,bl
        JE gameloop 
        inc edi
        loop ycheck
       moveleft1:
       call UpdatePlayer
       dec xPos
       call DrawPlayer
       call ScoreCount
       call LivesCount
       jmp gameLoop

        moveRight:
         cmp xpos,78
        JGE gameloop
        cmp xpos,9
        JE checkboundRight1
        cmp xpos,69
        JE checkboundRight1
        cmp xpos,39
        JE checkboundRight
        cmp xpos,58
        JE checkboundRight
        cmp xpos,21
        JE checkboundRight
        JMP moveRight1
        checkboundRight1:
        mov edi,offset bound3ypos1
        mov ecx,20
        JMP ycheck1
        checkboundRight:
       mov edi,offset bound3ypos 
       mov ecx,20
       ycheck1:
        mov bl,[edi]
        cmp ypos,bl
        JE gameloop 
        inc edi
        loop ycheck1
       moveRight1:
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        call ScoreCount
        call LivesCount
        jmp gameLoop

        Gamepause:
        call Readkey 
        jz Gamepause

    jmp gameLoop
    

RET 
gamestart3 Endp

;--------------------------------------------END GAME PROC--------------------------------------------------------
EndGame PROC 
call clrscr
        mov dl,40
        mov dh,10
        call Gotoxy
        mov edx,OFFSET namestr
        call WriteString
        mov edx,OFFSET name1
        call WriteString

        mov dl,40
        mov dh,12
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov al,score
        call WriteDec

        ; Write the buffer to the output file.
    mov eax, fileHandle
    mov edx, OFFSET name1
    mov ecx, 10
    call WriteToFile
 
        call readchar
exit
RET 
EndGame Endp

;---------------------------------------------MAIN PROC-----------------------------------------------------------
main PROC 
 mov edx,OFFSET filename
 call CreateOutputFile
  ;  mov fileHandle, eax
call DisplayTitle
call DisplayWelcome

call clrscr
mov edx,offset nameprompt 
call writestring 
mov edx,offset name1
mov ecx,100
call readstring
call clrscr

call MENU
    
main ENDP



END main