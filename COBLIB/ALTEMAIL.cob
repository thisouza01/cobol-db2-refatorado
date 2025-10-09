       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   ALTEMAIL.
      *************************************************
      * PROGRAMA DE ALTERACAO DO EMAIL DO FUNCIONARIO *
      *************************************************
       ENVIRONMENT                   DIVISION.
       CONFIGURATION                 SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       DATA                          DIVISION.
      *
       WORKING-STORAGE               SECTION.
           EXEC SQL
               INCLUDE SQLCA
           END-EXEC.
           EXEC SQL
               INCLUDE BOOKFUNC
           END-EXEC.
      *
       77 RETORNO-SQLCODE            PIC -999   VALUE ZEROS.
      *
       LINKAGE                       SECTION.
       01 LK-EMAILFUN-ACCEPT         PIC X(30).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-EMAILFUN-ACCEPT,
                                                    LK-CODFUN.
      *
       PERFORM ALTERA-EMAIL.
       GOBACK.
      *
       ALTERA-EMAIL.
           MOVE LK-EMAILFUN-ACCEPT TO DB2-EMAILFUN-TEXT.
           CALL "CONTMAIL" USING DB2-EMAILFUN.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET EMAILFUN = :DB2-EMAILFUN
                     WHERE CODFUN = :LK-CODFUN
           END-EXEC.
           EVALUATE SQLCODE
           WHEN 0
              DISPLAY 'EMAIL DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-EMAILFUN-TEXT
           WHEN 100
              DISPLAY 'FUNCIONARIO ' LK-CODFUN
                      ' NAO EXISTE'
           WHEN OTHER
              MOVE SQLCODE TO RETORNO-SQLCODE
              DISPLAY 'ERRO ' RETORNO-SQLCODE
                      ' NO COMANDO UPDATE DO EMAIL'
              MOVE 12 TO RETURN-CODE
              GOBACK
           END-EVALUATE.
      
