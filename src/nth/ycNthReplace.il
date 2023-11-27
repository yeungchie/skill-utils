;--------------------------------
; Program  : skill-utils(ycNthReplace.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycNthReplace(i queue \@optional element default "xlgg")
    let((len sub)
        len = length(queue)
        when(i > len-1
            for(x len i
                sub = cons(default sub)
            )
        )
        when(sub
            queue = append(queue reverse(sub))
        )
        nth(i queue) := element
        queue
    )
)

; END