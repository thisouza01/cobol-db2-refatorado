       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   ALTNOME.
      ************************************************
      * PROGRAMA DE ALTERACAO DO NOME DO FUNCIONARIO *
      ************************************************
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
       01 LK-NOMEFUN-ACCEPT          PIC X(30).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-NOMEFUN-ACCEPT.
      *
       PERFORM ALTERA-NOME.
       GOBACK.
      *
       ALTERA-NOME.
           MOVE LK-NOMEFUN-ACCEPT TO DB2-NOMEFUN-TEXT.
           CALL "CONTNOME" USING DB2-NOMEFUN.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET NOMEFUN = :DB2-NOMEFUN
                     WHERE CODFUN = :LK-CODFUN
           END-EXEC.
           EVALUATE SQLCODE
           WHEN 0
              DISPLAY 'NOME DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-NOMEFUN-TEXT
           WHEN 100
              DISPLAY 'FUNCIONARIO ' LK-CODFUN
                      ' NAO EXISTE'
           WHEN OTHER
              MOVE SQLCODE TO RETORNO-SQLCODE
              DISPLAY 'ERRO ' RETORNO-SQLCODE
                      ' NO COMANDO UPDATE DO NOME'
              MOVE 12 TO RETURN-CODE
              GOBACK
           END-EVALUATE.
      
