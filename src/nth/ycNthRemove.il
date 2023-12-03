;--------------------------------
; Program  : skill-utils(ycNthRemove.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycNthRemove(i queue "xl")
    let((heads)
        i = ycNthRealIndex(i queue)
        when(length(queue) > i
            for(x 0 i
                heads = cons(car(queue) heads)
                queue = cdr(queue)
            )
            foreach(x cdr(heads)
                queue = cons(x queue)
            )
        )
        queue
    )
)

; END