; Find_Two_Strings.asm
;
;
; Author:               Bhavay Garg
;
; Date:       12/04/2024
;
; Purpose:      This subroutine vbasically going to have the first string in x
; then find when new string comes and point to that one the delimeter used
;for it is space character or the $20 value also loads a and b with first and second
;strings initials
;
; Preconditions: x should point to the first string character, initially it would be
; the beginning of the file
;
; Postconditions: now x will point to the next string first character
; and loads the register a with first string initail character and b
; with next string initail charcter
;
;
; Use:          After meeting Preconditions.
;               jsr Find_Two_Strings
;
; <any subroutine constants OR temporary storage must be placed before the
;  entry label for the subroutine>

DelimeterSpace  equ     $20     ; $20 is the space character



Find_Two_Strings
        ldaa    0,x    ; loading the first character of the string in a and to save it
        psha  ; push a onto the stack in order to save the first letter becuase we will
        ; modify the refistyer a
        bra     NextStringMove;   branch to move to next string
        



NextStringMove :
        ldaa 1,x+   ; storing x in a and moving it by one x is the previous string
        ;address and then it moves
        cmpa #DelimeterSpace; comparing it with the space charcter to know if
        ; we reached end of the prev string
        beq  LoadNextString   ; if same then call
        bra  NextStringMove     ; if not then continue
        





LoadNextString :
        ldab 0,x    ;load the next string into b


        pula ; pull value of a from stack
        rts ; end subroutine
        
        
