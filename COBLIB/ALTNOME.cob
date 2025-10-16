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
      * Variáveis de controle SQL 
       COPY SQLVARS.
      *
       LINKAGE                       SECTION.
       01 LK-NOMEFUN-ACCEPT          PIC X(30).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-NOMEFUN-ACCEPT.
      * Tratamento de SQLCODE 
       COPY SQLTREAT.   
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

           PERFORM TRATA-SQLCODE.  

           EVALUATE WK-SQL-STATUS
           WHEN 'SUCESSO'
              EXEC SQL COMMIT END-EXEC              
              DISPLAY 'NOME DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-NOMEFUN-TEXT
           WHEN 'NAO-ENCONTRADO'
              DISPLAY 'ERRO NA VALIDACAO DO CODIGO DO FUNCIONARIO'
           WHEN OTHER
              CONTINUE
           END-EVALUATE.
           
