       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   ALTADMIS.
      ****************************************************
      * PROGRAMA DE ALTERACAO DA ADMISSAO DO FUNCIONARIO *
      ****************************************************
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
       01 LK-ADMISSFUN-ACCEPT        PIC X(11).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-ADMISSFUN-ACCEPT.
                                                    
      *
       PERFORM ALTERA-ADMISSAO.
       GOBACK.
      *
       ALTERA-DEPARTAMENTO.
           MOVE LK-ADMISSFUN-ACCEPT TO DB2-ADMISSFUN.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET ADMISSFUN = :DB2-ADMISSFUN
                   WHERE CODFUN = :LK-CODFUN
           END-EXEC.
           EVALUATE SQLCODE
           WHEN 0
              DISPLAY 'ADMISSAO DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-ADMISSFUN
           WHEN 100
              DISPLAY 'FUNCIONARIO ' LK-CODFUN
                      ' NAO EXISTE'
           WHEN OTHER
              MOVE SQLCODE TO RETORNO-SQLCODE
              DISPLAY 'ERRO ' RETORNO-SQLCODE
                      ' NO COMANDO UPDATE DA ADMISSAO'
              MOVE 12 TO RETURN-CODE
              GOBACK
           END-EVALUATE.
      
