;--------------------------
; Program  : skill-utils(ycWithOpen.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 自动关闭文件句柄
; ycWithOpen( p ">" "txt"
;     fprintf( p "write some thing\n" )
; )

defmacro( ycWithOpen (
        _ycWithOpen_formalVar
        _ycWithOpen_mode
        _ycWithOpen_fileName
      \@rest
        _ycWithOpen_expr
      "sggg"
    )
    `{
        ; open
        let((mode fileName port)
            unless(stringp(mode = eval(,_ycWithOpen_mode))
                ycError("argument #2 should be a string - %A" mode)
            )
            unless(stringp(fileName = eval(,_ycWithOpen_fileName))
                ycError("argument #3 should be a string - %A" fileName)
            )
            port = case(mode
                (("i" "in" "r" "read" "<")
                    infile(fileName)
                )
                (("o" "out" "w" "write" ">")
                    outfile(fileName "w")
                )
                (("a" "append" ">>")
                    outfile(fileName "a")
                )
                (t
                    ycError("invalid open mode -%A" mode)
                )
            ) || ycError("open failed, cannot access file - %A" fileName)
            setq(,_ycWithOpen_formalVar port)
        )

        prog1(
            ; expr
            car(errset({nil ,@_ycWithOpen_expr} t))

            ; close
            when(portp(,_ycWithOpen_formalVar) && openportp(,_ycWithOpen_formalVar)
                close(,_ycWithOpen_formalVar)
            )
        )
    }
)

; END
