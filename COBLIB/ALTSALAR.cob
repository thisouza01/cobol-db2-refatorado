       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   ALTSALAR.
      ***************************************************
      * PROGRAMA DE ALTERACAO DO SALARIO DO FUNCIONARIO *
      ***************************************************
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
       01 LK-SALARIOFUN-ACCEPT       PIC 9(06)V99.
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-SALARIOFUN-ACCEPT.
      *
       PERFORM ALTERA-SALARIO.
       GOBACK.
      *
       ALTERA-SALARIO.
           MOVE LK-SALARIOFUN-ACCEPT TO DB2-SALARIOFUN-TEXT.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET SALARIOFUN = :DB2-SALARIOFUN
                     WHERE CODFUN = :LK-CODFUN
           END-EXEC.
           EVALUATE SQLCODE
           WHEN 0
              DISPLAY 'SALARIO DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-SALARIOFUN
           WHEN 100
              DISPLAY 'FUNCIONARIO ' LK-CODFUN
                      ' NAO EXISTE'
           WHEN OTHER
              MOVE SQLCODE TO RETORNO-SQLCODE
              DISPLAY 'ERRO ' RETORNO-SQLCODE
                      ' NO COMANDO UPDATE DO SALARIO'
              MOVE 12 TO RETURN-CODE
              GOBACK
           END-EVALUATE.
      
