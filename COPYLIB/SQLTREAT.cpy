           TRATA-SQLCODE.
               EVALUATE SQLCODE
                   WHEN 0
                        MOVE 'SUCESSO' TO WK-SQL-STATUS
                    WHEN 100
                        MOVE 'NAO-ENCONTRADO' TO WK-SQL-STATUS
                    WHEN -803
                        MOVE 'JA-EXISTE' TO WK-SQL-STATUS
                    WHEN -530
                        MOVE 'FK-INVALIDA' TO WK-SQL-STATUS
                    WHEN OTHER
                        MOVE 'ERRO-FATAL' TO WK-SQL-STATUS
                        MOVE SQLCODE TO WK-SQLCODE-EDIT
                        DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                        MOVE 12 TO RETURN-CODE
               END-EVALUATE.