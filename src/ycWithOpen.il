;--------------------------
; Program  : skill-utils(ycWithOpen.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 自动关闭文件句柄
; ycWithOpen( p ">" "txt"
;     fprintf( p "write some thing\n" )
; )

defmacro( ycWithOpen ( s_formalVar t_mode t_fileName \@rest g_expr "sggg" )
    `let((,s_formalVar)
        ; open
        let((mode fileName port)
            unless(stringp(mode = eval(,t_mode))
                ycError("argument #2 should be a string - %A" mode
                    ?functionName "ycWithOpen"
                )
            )
            unless(stringp(fileName = eval(,t_fileName))
                ycError("argument #3 should be a string - %A" fileName
                    ?functionName "ycWithOpen"
                )
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
                    ycError("invalid open mode -%A" mode
                        ?functionName "ycWithOpen"
                    )
                )
            )
            unless(port
                ycError("open failed, cannot access file - %A" fileName
                    ?functionName "ycWithOpen"
                )
            )
            ,s_formalVar = port
        )

        prog1(
            ; expr
            car(errset({nil ,@g_expr} t))

            ; close
            when(portp(,s_formalVar) && openportp(,s_formalVar)
                close(,s_formalVar)
            )
        )
    )
)

; END
