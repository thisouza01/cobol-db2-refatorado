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

      * Variáveis de controle SQL 
       COPY SQLVARS.
      *
       LINKAGE                       SECTION.
       01 LK-ADMISSFUN-ACCEPT        PIC X(11).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-ADMISSFUN-ACCEPT.
      * Tratamento de SQLCODE 
           COPY SQLTREAT.                                                       
      *
           PERFORM ALTERA-ADMISSAO.
           GOBACK.
      *
       ALTERA-ADMISSAO.
           MOVE LK-ADMISSFUN-ACCEPT TO DB2-ADMISSFUN.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET ADMISSFUN = :DB2-ADMISSFUN
                   WHERE CODFUN = :LK-CODFUN
           END-EXEC.

           PERFORM TRATA-SQLCODE.

           EVALUATE WK-SQL-STATUS
           WHEN 'SUCESSO'
              EXEC SQL COMMIT END-EXEC              
              DISPLAY 'ADMISSAO DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-ADMISSFUN
           WHEN 'NAO-ENCONTRADO'
              DISPLAY 'ERRO NA VALIDACAO DO CODIGO DO FUNCIONARIO'
           WHEN OTHER
                EXEC SQL ROLLBACK END-EXEC
                STOP RUN  
           END-EVALUATE.
      
