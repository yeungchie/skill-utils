;--------------------------
; Program  : skill-utils(ycCat.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycCat(fileName \@optional)
    prog((fh item strings)
        unless(isFile(fileName)
            ycWarn("no such file - %s\n" fileName)
            return()
        )
        unless(fh = infile(fileName)
            ycWarn("cannot open '%s' for reading: Permmission denied\n" fileName)
            return()
        )
        while(gets(item fh)
            when(chomp
                item = ycRegEx(item "\n$" "")
            )
            strings = cons(item strings)
        )
        close(fh)
        return(reverse(strings))
    ); prog
)

; END