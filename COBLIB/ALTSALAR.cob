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

      * Variáveis de controle SQL 
       COPY SQLVARS.
      *
       77  WK-SALARIO-EDIT           PIC ZZZ.ZZ9,99  VALUE ZEROS.

      *
       LINKAGE                       SECTION.
       01 LK-SALARIOFUN-ACCEPT       PIC 9(06)V99.
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-SALARIOFUN-ACCEPT.
      * Tratamento de SQLCODE 
           COPY SQLTREAT.  
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

           MOVE LK-SALARIOFUN-ACCEPT TO WK-SALARIO-EDIT.

           PERFORM TRATA-SQLCODE.

           EVALUATE WK-SQL-STATUS
           WHEN 'SUCESSO'
              EXEC SQL COMMIT END-EXEC              
              DISPLAY 'SALARIO DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-SALARIOFUN
           WHEN 'NAO-ENCONTRADO'
              DISPLAY 'ERRO NA VALIDACAO DO CODIGO DO FUNCIONARIO'
           WHEN OTHER
                EXEC SQL ROLLBACK END-EXEC
                STOP RUN  
           END-EVALUATE.
           
      
