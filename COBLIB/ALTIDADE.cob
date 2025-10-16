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
      * Variáveis de controle SQL 
       COPY SQLVARS.
      *
       LINKAGE                       SECTION.
       01 LK-IDADEFUN-ACCEPT         PIC 99.
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-IDADEFUN-ACCEPT.
                                                    
      * Tratamento de SQLCODE 
       COPY SQLTREAT.   
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

            PERFORM TRATA-SQLCODE.

           EVALUATE WK-SQL-STATUS
           WHEN 'SUCESSO'
              EXEC SQL COMMIT END-EXEC              
              DISPLAY 'IDADE DO FUNCIONARIO ' LK-CODFUN
                      ' FOI ALTERADO PARA ' DB2-IDADEFUN
           WHEN 'NAO-ENCONTRADO'
              DISPLAY 'ERRO NA VALIDACAO DO CODIGO DO FUNCIONARIO'
           WHEN OTHER
              CONTINUE
           END-EVALUATE.
      
