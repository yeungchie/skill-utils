;--------------------------
; Program  : skill-utils(alias/load.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycSkillAliasFuncEnable(bool "g")
    let((funcs)
        funcs = '(
            ( len           length               )
            ( uniq          removeListDuplicates )
            ( des           describe             )
            ( strincr       ycStringIncrease     )
            ( ciwforeach    ycForeachOnCIW       )
            ( d2b           ycDecimalToBinary    )
        )

        foreach(item funcs
            eval(if(bool
                cons('alias item)
                list('unalias car(item))
            ))
        )

        t
    )
)

; END