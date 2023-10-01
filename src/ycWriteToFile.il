;--------------------------
; Program  : skill-utils(ycWriteToFile.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycWriteToFile(fileName data \@key mode("w") "tgt")
    prog((fh)
        unless(fh = outfile(fileName mode)
            ycWarn("cannot open '%s' by mode '%s'" fileName mode)
            return()
        )

        unless(data
            return()
        )

        unless(listp(data)
            data = list(data)
        )

        foreach(row data
            row = case(type(row)
                (string
                    row
                )
                (t
                    lsprintf("%A" row)
                )
            )
            fprintf(fh "%s\n" row)
        )

        close(fh)
        return(t)
    ); prog
)

; END