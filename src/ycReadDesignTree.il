;--------------------------
; Program  : skill-utils(ycReadDesignTree.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycReadDesignTree(fileName "t")
    prog((rows uniq item topLibs topCells topViews lcvList)
        unless(isFile(fileName)
            ycWarn("no such file - %s" fileName)
            return()
        )
        unless(rows = ycCat(fileName t)
            ycWarn("cannot open '%s' for reading: Permmission denied" fileName)
            return()
        )
        uniq = makeTable("" nil)
        foreach(item rows
            let((lcv)
                ycRegExCase(item
                    (("^\\*" "^\\s+Design\\s+Hierarchy")
                        ; pass
                    )
                    ("^Library\\s*:\\s*(\\S+)\\s$"
                        topLibs = cons(ycRegExSub(1) topLibs)
                    )
                    ("^Cell\\s*:\\s*(\\S+)\\s$"
                        topCells = cons(ycRegExSub(1) topCells)
                    )
                    ("^View\\s*:\\s*(\\S+)\\s$"
                        topViews = cons(ycRegExSub(1) topViews)
                    )
                    (":"
                        ; pass
                    )
                    ("^\\s*(\\S+)\\s+(\\S+)\\s+(\\S+)"
                        lcv = mapcar('ycRegExSub '(1 2 3))
                        unless(uniq[lcv]
                            uniq[lcv] = t
                            lcvList = cons(lcv lcvList)
                        )
                    )
                )
            )
        )
        foreach((l c v) topLibs topCells topViews
            unless(uniq[list(l c v)]
                uniq[list(l c v)] = t
                lcvList = cons(list(l c v) lcvList)
            )
        )
        return(lcvList)
    )
)

; END