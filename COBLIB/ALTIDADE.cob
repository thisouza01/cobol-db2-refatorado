       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   ALTIDADE.
      *************************************************
      * PROGRAMA DE ALTERACAO DA IDADE DO FUNCIONARIO *
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
       01 LK-IDADEFUN-ACCEPT         PIC 99.
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-IDADEFUN-ACCEPT.
                                                    
      *
       PERFORM ALTERA-IDADE.
       GOBACK.
      *
       ALTERA-IDADE.
           MOVE LK-IDADEFUN-ACCEPT TO DB2-IDADEFUN.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET IDADEFUN = :DB2-IDADEFUN
                   WHERE CODFUN = :LK-CODFUN
           END-EXEC.
           EVALUATE SQLCODE
           WHEN 0
              DISPLAY 'IDADE DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-IDADEFUN
           WHEN 100
              DISPLAY 'FUNCIONARIO ' LK-CODFUN
                      ' NAO EXISTE'
           WHEN OTHER
              MOVE SQLCODE TO RETORNO-SQLCODE
              DISPLAY 'ERRO ' RETORNO-SQLCODE
                      ' NO COMANDO UPDATE DA IDADE'
              MOVE 12 TO RETURN-CODE
              GOBACK
           END-EVALUATE.
      
