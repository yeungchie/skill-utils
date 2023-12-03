;--------------------------------
; Program  : skill-utils(ycNthRealIndex.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------------

procedure(ycNthRealIndex(i queue "xl")
    let((len)
        cond(
            (i >= 0
                i
            )
            (zerop(len = length(queue))
                nil
            )
            (t
                i = remainder(i len)
                when(i < 0
                    i += len
                )
                i
            )
        )
    )
)

; END