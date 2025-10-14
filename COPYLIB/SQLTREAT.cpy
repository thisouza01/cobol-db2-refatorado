      * Tratamento de SQLCODE
       TRATA-SQLCODE.
           EVALUATE SQLCODE
               WHEN 0
                   MOVE 'S' TO WK-SQL-OK
                   MOVE 'SUCESSO' TO WK-SQL-STATUS
               WHEN 100
                   MOVE 'N' TO WK-SQL-OK
                   MOVE 'NAO-ENCONTRADO' TO WK-SQL-STATUS
               WHEN -803
                   MOVE 'N' TO WK-SQL-OK
                   MOVE 'JA-EXISTE' TO WK-SQL-STATUS
               WHEN -530
                   MOVE 'N' TO WK-SQL-OK
                   MOVE 'FK-INVALIDA' TO WK-SQL-STATUS
               WHEN OTHER
                   MOVE 'N' TO WK-SQL-OK
                   MOVE 'ERRO-FATAL' TO WK-SQL-STATUS
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                   MOVE 12 TO RETURN-CODE
                   EXEC SQL ROLLBACK END-EXEC
                   STOP RUN
           END-EVALUATE.