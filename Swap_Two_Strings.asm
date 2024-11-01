; Swap_Two_Stringss.asm
;
; Author(s):               Bhavay Garg
; Date:         12/04/2024
;
; Purpose:     this basically swaps two consecutive strings the first string should be pointed by x
; and then it will store that string in memory address of 1920 and find tnext strimng then
; put that string into starting and then fromtemp put this string in here
;
; Preconditions: x register should have the memory of the first string and
; y register also holds the memory address of the first string because our code in here
;is going to mke x point to the next string
;
; Postconditions:y will point to the first letter of the string which just became
;new prevString after swapping
; and the x will point to the end of the string of the temperory address
; and a will have the space scharacter basically garbage so we can say that
;its destroyed and b won't be changed
;
; Problem solution: the first string is pointed by x and then it will store that
; string in memory address of 1920 and to know that string is end it uses
; the delimete of 20 space character  and find next strimng then
; put that string into starting and then from temp storage which is MemeoryWordFirst
; put that string in here
;
;
; Use: After meeting Preconditions
;      jsr Swap_Two_Strings

; will swap the consecutive strigs and y point to the new next sting address
;
; <any subroutine constants OR temporary storage must be placed before the
;  entry label for the subroutine>


MemoryWordFirst        equ        $1920 ; temp memory to store first word
DelimeterSpace1  equ     $20     ; $20 is the space character

Swap_Two_Strings
        pshy  ; push y onto stack to save that value(previousString)
        ldy  #MemoryWordFirst ; point to beginning of temp storage

        bra  NextStringSave ; save the first string



NextStringSave :  ; code to save the string in temp memory
        ldaa 1,x+   ; storing x in a and moving it by one
        staa  1,y+; save that value in memeory by y and move by one


        cmpa #DelimeterSpace1        ; comparing it with the space
        beq  NextStringMoveStarter           ; if same then call
        bra  NextStringSave   ; if not then continue



NextStringMoveStarter: ; starter code to move next string to previous
; x is automatically pointing to next string

       puly ; puly to get y with prev string

        bra NextStringMovePrevious; move to the main branch


NextStringMovePrevious:  ; code to move next string t5o previos
         ldaa 1,x+      ; load the value at x(nextString) and move by one
         staa 1,y+      ; save the value at y(previousString) and move by one
         cmpa #DelimeterSpace1       ; compare if end space reached
         beq  FirstStringMoveStarter; if yeah then from temp move first string
         bra NextStringMovePrevious; if no then repeat


FirstStringMoveStarter:  ; starter moving the temp string/ first string into next string
; y points to the end of the first string after the space is reached
        ldx  #MemoryWordFirst  ; now x point to starting of the temp storage
        pshy   ; save y as y point to the new previous string

        bra  FirstStringMove; move to the main branch


FirstStringMove:   ;moving the temp string/ first string into next string
        ldaa        1,x+; load the value at first and move by one
        staa        1,y+; store value
        cmpa #DelimeterSpace1 ; cheack if 20
        beq     FinalBranch; if yes then quit
        bra     FirstStringMove  ; if no then repeat


FinalBranch:
        puly  ; pull y to load the previous string in y
        

        rts ; end subroutine



