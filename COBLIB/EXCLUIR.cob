       IDENTIFICATION                DIVISION.
       PROGRAM-ID.                   EXCLUIR.
      ****************************************
      * PROGRAMA DE EXCLUSAO DO FUNCIONARIO  *
      ****************************************
       ENVIRONMENT                   DIVISION.
       CONFIGURATION                 SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      *
       DATA                          DIVISION.
      *
       WORKING-STORAGE               SECTION.
      * Variáveis de controle SQL 
       COPY SQLVARS.       
      *
       LINKAGE                       SECTION.
       01  LK-CODFUN-ACCEPT          PIC X(4). 
      *
       PROCEDURE                     DIVISION USING LK-CODFUN-ACCEPT.
      *
       PERFORM EXCLUI-FUNCIONARIO.
       GOBACK.
      *
       EXCLUI-FUNCIONARIO.
           MOVE LK-CODFUN-ACCEPT     TO DB2-CODFUN.
           EXEC SQL
               DELETE FROM EAD719.FUNCIONARIOS
                   WHERE CODFUN = :DB2-CODFUN
           END-EXEC.
           PERFORM TRATA-SQLCODE.

           EVALUATE WS-SQL-STATUS
              WHEN 'SUCESSO'
                  EXEC SQL COMMIT END-EXEC    
                  DISPLAY 'FUNCIONARIO ' DB2-CODFUN 
                          ' ALTERADO COM SUCESSO!'
              WHEN 'NAO-ENCONTRADO'
                  DISPLAY 'ERRO NA VALIDACAO DOS DADOS'
              WHEN OTHER
                  CONTINUE
           END-EVALUATE.
      