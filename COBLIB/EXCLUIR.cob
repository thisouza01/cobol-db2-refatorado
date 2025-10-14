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
           
           EVALUATE SQLCODE
               WHEN 0
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' FOI EXCLUIDO!'
               WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' NAO EXISTE!'
               WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO DELETE'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
           END-EVALUATE. 