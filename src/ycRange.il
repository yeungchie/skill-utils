;--------------------------
; Program  : skill-utils(ycRange.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycRange(num \@optional end step(1) "ngn")
    let((start numberList)
        if(end
        then
            unless(numberp(end)
                ycError("argument #2 should be a number - %A" end)
            )
            start = num
            step  = step || 1
            when(step <= 0
                step = 1
            )
        else
            start = 0
            end   = num
        )
        while(start <= end
            numberList = cons(start numberList)
            start += step
        )
        reverse(numberList)
    )
)

; END
