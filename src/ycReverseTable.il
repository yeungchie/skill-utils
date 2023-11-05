;--------------------------
; Program  : skill-utils(ycReverseTable.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycReverseTable(table "o")
    let((map)
        unless(
            ycError("argument #1 should be a table - %A" table)
        )
        map = makeTable("" nil)
        foreach(x table
            map[table[x]] = x
        )
        map
    )
)

; END