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
      * Variáveis de controle SQL 
       COPY SQLVARS.           
      *
       LINKAGE                       SECTION.
       01 LK-EMAILFUN-ACCEPT         PIC X(30).
       01 LK-CODFUN                  PIC X(04).
      *
       PROCEDURE                     DIVISION USING LK-CODFUN,
                                                    LK-EMAILFUN-ACCEPT.
      * Tratamento de SQLCODE 
           COPY SQLTREAT.                                                           
      *
           PERFORM ALTERA-EMAIL.
           GOBACK.
      *
       ALTERA-EMAIL.
           MOVE LK-EMAILFUN-ACCEPT TO DB2-EMAILFUN-TEXT.
      *   Conta quantidade de caracteres e atualiza DB2-EMAILFUN-LEN.     
           CALL "CONTMAIL" USING DB2-EMAILFUN.
           EXEC SQL
               UPDATE IBMUSER.FUNCIONARIOS
               SET EMAILFUN = :DB2-EMAILFUN
                     WHERE CODFUN = :LK-CODFUN
           END-EXEC.
           PERFORM TRATA-SQLCODE.

           EVALUATE WS-SQL-STATUS
              WHEN 'SUCESSO'
                  EXEC SQL COMMIT END-EXEC                                
                  DISPLAY 'FUNCIONARIO ' DB2-CODFUN 
                          ' ALTERADO COM SUCESSO!'
              WHEN 'FK-INVALIDA'
                  EXEC SQL ROLLBACK END-EXEC                          
                  DISPLAY 'DEPARTAMENTO ' DB2-DEPTOFUN 
                          ' NAO EXISTE!'
              WHEN 'NAO-ENCONTRADO'
                  DISPLAY 'ERRO NA VALIDACAO DOS DADOS'            
              WHEN OTHER
                    EXEC SQL ROLLBACK END-EXEC
                    STOP RUN 
           END-EVALUATE.
      
