; Sort_Strings_Driver.asm
;
; Author:               Bhavay Garg,
; Date:         12/04/2024
;
; Purpose:      This program sorts an array of names in reverse alphabetical
;                order by the student's first letter of their last name
;                in reverse alphabetical
;
;               For example, consider: Apple Pigeon Apple House
;
;               Sorted this would be: Pigeon House Apple Andrew
;
;               So, all of the names starting with an 'A' are together, but
;               those names are NOT themselves sorted into Andrew Apple
;               in this case.
;
;
; Sorting Algorithm Used:  <Bubble sort >
;
; Your solution starts here
;

        org     $1000 ; students name strating from this address
Names                  ; including the Lab_Section_302_Names.txt file
#include Lab_Section_301_Names.txt
EndNames
; reserving the space for the names names may occupy the max space 2240 bytes which
; are from 1000 to $18c0 so we are initializing the variables from 1900

bMemory equ     $1900 ; memory location which will be used for storing b to compare
prevString equ  $1902 ; memory location for previous 1 string
nextString equ  $1905 ; meoery location for next 1 string
TNames  equ     $1910 ; variable to store the total number of names
OuterLcv equ    $1915 ; variable to decide howm many times the outer loop run

        org     $2000  ; program data starts at 2000



outerLoop
        ldx     #Names  ; Load X with the beginning address of the student names array
        stx     prevString ;now the loop will run from starting again so we need
        ; to make prevstring the starting of the loop
         bra        MainLoop ; get into the inner main loop


MainLoop


        inc     TNames  ; this code increment the total names  but after the first
        ; time this loop exits we are going to  store it into lcv

        jsr     Find_Two_Strings ; calling the subroutine to find teh first letter of two string

        stx     nextString; storing the address of x in nextString variable as
        ; now x holds the memory address of next string first character


        stab    bMemory; register b holds the memory address of next string first character
        ;we going to store that to compare it with register a
        cmpa    bMemory ; compare value of a with b
        blt     SwappingBranch; if value at a < b then swap

        ldx    nextString ; if the swap did not happen then load x with next string --
        stx    prevString ; -- to compare with the end of the file and also store
        ; it in prev string to--
        cpx    #EndNames  ; -- move it by one string
        bhs     quitInner ; if end of the file memory address reached then quit this loop

        bra MainLoop ; else reapeat


quit:
        swi
        end
quitInner:

        ldaa OuterLcv; have value of loop counter variable in a to compare or initailize
        cmpa #$00 ; if it is zero then that means our program is running the first btime
        ; so we need to store the TNames in this variable
        bhi  OuterLoopCheker ; if not zero greateter than then verify if it is good
        ; verify the counter and mddify it
        movb TNames,OuterLcv ; this lines means program run first time meaning the
        ; inner loop eits for first time then stopre that total names into variable
        bra outerLoop  ; repeat from outerloop





OuterLoopCheker:
        suba    #$01 ; decfease the counter by one and a have outer loop counter variable
        staa    OuterLcv; save the new value again in it
        cmpa        #$01 ; check with 1 beacues if one then the names sorted
        beq     quit  ; sorted names so quit


        bra outerLoop ; if no then reapeat from outer loop


SwappingBranch:
        ldx  prevString ; load the first string pre condition for swap
        ldy  prevString ; load the first string pre condition for swap
        jsr     Swap_Two_Strings ;call the subroutine after it y will point to
        ; the new previous string
        sty     prevString ; save that into previous sring
        ldx     prevString ; now x also holds that new previous string becayse
        ; it is going to go back to main loop which which calls the find two
        ; and we need tx to hold the prev string
        bra         MainLoop




; #include statements go at the end of your code
#include    Find_Two_Strings.asm
; find two string pre condition x should have the prevString address and post
; it will store a and b with first letters resp. and x point to next string first
; character


#include    Swap_Two_Strings.asm
; x and y should point to start and then y will [point to the new prev string after
;swap
