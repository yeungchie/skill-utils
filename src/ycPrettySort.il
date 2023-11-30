;--------------------------
; Program  : skill-utils(ycPrettySort.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPrettySort(strList "l")
    unless(forall(str strList stringp(str))
        yError("every element in the argument #1 should be a string - %A" strList)
    )
    sort(copy(strList) lambda((a b) alphaNumCmp(a b) < 0))
)

; END