;--------------------------------
; Program  : skill-utils(ycNthRemove.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycNthRemove(i queue "xl")
    let((heads)
        i = ycNthRealIndex(i queue)
        when(i && length(queue) > i
            ;       ┌─ 456789
            ; 123 <─┘
            for(x 0 i-1
                heads = tconc(heads car(queue))
                queue = cdr(queue)
            )

            ;         ┌ 4 ~
            ;       ┌─ 56789
            ; 123 <─┘
            queue = cdr(queue)

            ;           4 ~
            ; 12356789
            when(heads
                queue = car(nconc(heads queue))
            )
        )
        queue
    )
)

; END