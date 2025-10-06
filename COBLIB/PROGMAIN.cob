        IDENTIFICATION DIVISION.
        PROGRAM-ID.    PROGMAIN.
        AUTHOR.        THIAGO.
      **************************************************
      * INCLUSAO, EXCLUSAO E ALTERACAO DE FUNCIONARIOS *
      **************************************************
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
          DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
           EXEC SQL
              INCLUDE BOOKFUNC
           END-EXEC.
           EXEC SQL
              INCLUDE SQLCA
           END-EXEC.
       77  WK-SALARIO-EDIT           PIC ZZZ.ZZ9,99  VALUE ZEROS.
       77  WK-SQLCODE-EDIT           PIC -999        VALUE ZEROS.
       77  WK-POSICAO                PIC 99          VALUE ZEROS.
       
       COPY CPYACEP.
      *
       PROCEDURE DIVISION.
       000-PRINCIPAL SECTION.
       001-PRINCIPAL.
          PERFORM 101-INICIAR.
          PERFORM 201-PROCESSAR.
          PERFORM 901-FINALIZAR.
          STOP RUN.
       *******************************************************
       100-INICIAR SECTION.
       101-INICIAR.
          ACCEPT WK-ACCEPT FROM SYSIN.
          ACCEPT WK-ACCEPT FROM SYSIN.
          ACCEPT WK-EMAILFUN-ACCEPT FROM SYSIN.
       *******************************************************
       200-PROCESSAR SECTION.
       201-PROCESSAR.
          EVALUATE WK-FUNCAO-ACCEPT
             WHEN 'I'
                   PERFORM 202-INCLUSAO
             WHEN 'E'
                   PERFORM 203-EXCLUSAO
             WHEN 'A'
                   PERFORM 204-ALTERACAO
             WHEN OTHER
                   DISPLAY 'FUNCAO ' WK-FUNCAO-ACCEPT ' INVALIDA!'
          END-EVALUATE.
       *
       202-INCLUSAO.
          MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.
          MOVE WK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.
      *   Conta quantidade de caracteres e atualiza DB2-NOMEFUN-LEN.
          CALL "CONTNOME"           USING DB2-NOMEFUN.
          MOVE WK-SALARIOFUN-ACCEPT TO DB2-SALARIOFUN.
          MOVE WK-DEPTOFUN-ACCEPT   TO DB2-DEPTOFUN.
          MOVE WK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.
          MOVE WK-IDADEFUN-ACCEPT   TO DB2-IDADEFUN.
          MOVE WK-EMAILFUN-ACCEPT   TO DB2-EMAILFUN-TEXT.
      *   Conta quantidade de caracteres e atualiza DB2-EMAILFUN-LEN.
          CALL "CONTMAIL"           USING DB2-EMAILFUN.
          EXEC SQL
             INSERT INTO EAD719.FUNCIONARIOS
             VALUES(:DB2-CODFUN,
                      :DB2-NOMEFUN,
                      :DB2-SALARIOFUN,
                      :DB2-DEPTOFUN,
                      :DB2-ADMISSFUN,
                      :DB2-IDADEFUN,
                      :DB2-EMAILFUN)
          END-EXEC.
          EVALUATE SQLCODE
             WHEN 0
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' FOI INCLUIDO!'
             WHEN -803
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' JA EXISTE!'
             WHEN -530
                   DISPLAY 'DEPARTAMENTO ' DB2-DEPTOFUN
                         ' NAO EXISTE!'
             WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO INSERT'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
          END-EVALUATE.
       *
       203-EXCLUSAO.
          MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.
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
       *
       204-ALTERACAO.
          MOVE WK-CODFUN-ACCEPT     TO DB2-CODFUN.
          IF   WK-NOMEFUN-ACCEPT    NOT = SPACES
             PERFORM 210-ALTERA-NOME
          END-IF.
          IF   WK-SALARIOFUN-ACCEPT IS NUMERIC
             PERFORM 211-ALTERA-SALARIO
          END-IF.
          IF   WK-DEPTOFUN-ACCEPT   NOT = SPACES
             PERFORM 212-ALTERA-DEPARTAMENTO
          END-IF.
          IF   WK-ADMISSFUN-ACCEPT  NOT = SPACES
             PERFORM 213-ALTERA-ADMISSAO
          END-IF.
          IF   WK-IDADEFUN-ACCEPT   IS NUMERIC
             PERFORM 214-ALTERA-IDADE
          END-IF.
          IF   WK-EMAILFUN-ACCEPT   NOT = SPACES
             PERFORM 215-ALTERA-EMAIL
          END-IF.
      *
       210-ALTERA-NOME.
          MOVE WK-NOMEFUN-ACCEPT    TO DB2-NOMEFUN-TEXT.
      *   Conta quantidade de caracteres e atualiza DB2-NOMEFUN-LEN.
          CALL "CONTNOME"                 USING DB2-NOMEFUN.
          EXEC SQL
             UPDATE EAD719.FUNCIONARIOS
                   SET NOMEFUN = :DB2-NOMEFUN
                   WHERE CODFUN = :DB2-CODFUN
          END-EXEC.
          EVALUATE SQLCODE
             WHEN 0
                   DISPLAY 'NOME DO FUNCIONARIO ' DB2-CODFUN
                         ' FOI ALTERADO PARA ' DB2-NOMEFUN-TEXT
             WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' NAO EXISTE!'
             WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO UPDATE'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
          END-EVALUATE.
      *
       211-ALTERA-SALARIO.
          MOVE WK-SALARIOFUN-ACCEPT    TO DB2-SALARIOFUN.
          EXEC SQL
             UPDATE EAD719.FUNCIONARIOS
                   SET SALARIOFUN = :DB2-SALARIOFUN
                   WHERE CODFUN = :DB2-CODFUN
          END-EXEC.
          EVALUATE SQLCODE
             WHEN 0
                   MOVE WK-SALARIOFUN-ACCEPT TO WK-SALARIO-EDIT
                   DISPLAY 'SALARIO DO FUNCIONARIO ' DB2-CODFUN
                         ' FOI ALTERADO PARA ' WK-SALARIO-EDIT
             WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' NAO EXISTE!'
             WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO UPDATE DO SALARIO'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
          END-EVALUATE.
      *
       212-ALTERA-DEPARTAMENTO.
          MOVE WK-DEPTOFUN-ACCEPT TO DB2-DEPTOFUN.
          EXEC SQL
             UPDATE EAD719.FUNCIONARIOS
                   SET DEPTOFUN = :DB2-DEPTOFUN
                   WHERE CODFUN = :DB2-CODFUN
          END-EXEC.
          EVALUATE SQLCODE
             WHEN 0
                   DISPLAY 'DEPARTAMENTO DO FUNCIONARIO ' DB2-CODFUN
                         ' FOI ALTERADO PARA ' DB2-DEPTOFUN
             WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' NAO EXISTE!'
             WHEN -530
                   DISPLAY 'DEPARTAMENTO ' WK-DEPTOFUN-ACCEPT
                         ' NAO EXISTE!'
             WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO UPDATE DO DEPARTAMENTO'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
          END-EVALUATE.
      *
       213-ALTERA-ADMISSAO.
          MOVE WK-ADMISSFUN-ACCEPT  TO DB2-ADMISSFUN.
          EXEC SQL
             UPDATE EAD719.FUNCIONARIOS
                   SET ADMISSFUN = :DB2-ADMISSFUN
                   WHERE CODFUN = :DB2-CODFUN
          END-EXEC.
          EVALUATE SQLCODE
             WHEN 0
                   DISPLAY 'ADMISSAO DO FUNCIONARIO ' DB2-CODFUN
                         ' FOI ALTERADO PARA ' DB2-DEPTOFUN
             WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' NAO EXISTE!'
             WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO UPDATE DA ADMISSAO'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
          END-EVALUATE.
      *
       214-ALTERA-IDADE.
          MOVE WK-IDADEFUN-ACCEPT  TO DB2-IDADEFUN.
          EXEC SQL
             UPDATE EAD719.FUNCIONARIOS
                   SET IDADEFUN = :DB2-IDADEFUN
                   WHERE CODFUN = :DB2-CODFUN
          END-EXEC.
          EVALUATE SQLCODE
             WHEN 0
                   DISPLAY 'IDADE DO FUNCIONARIO ' DB2-CODFUN
                         ' FOI ALTERADO PARA ' DB2-IDADEFUN
             WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' NAO EXISTE!'
             WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO UPDATE DA IDADE'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
          END-EVALUATE.
      *
       215-ALTERA-EMAIL.
          MOVE WK-EMAILFUN-ACCEPT  TO DB2-EMAILFUN.
      *   Conta quantidade de caracteres e atualiza DB2-EMAILFUN-LEN.
          CALL "CONTMAIL"           USING DB2-EMAILFUN.
          EXEC SQL
             UPDATE EAD719.FUNCIONARIOS
                   SET EMAILFUN = :DB2-EMAILFUN
                   WHERE CODFUN = :DB2-CODFUN
          END-EXEC.
          EVALUATE SQLCODE
             WHEN 0
                   DISPLAY 'EMAIL DO FUNCIONARIO ' DB2-CODFUN
                         ' FOI ALTERADO PARA ' DB2-EMAILFUN
             WHEN 100
                   DISPLAY 'FUNCIONARIO ' DB2-CODFUN
                         ' NAO EXISTE!'
             WHEN OTHER
                   MOVE SQLCODE TO WK-SQLCODE-EDIT
                   DISPLAY 'ERRO ' WK-SQLCODE-EDIT
                         ' NO COMANDO UPDATE DA EMAIL'
                   MOVE 12 TO RETURN-CODE
                   STOP RUN
          END-EVALUATE.
      *******************************************************
       300-LER-FUNCIONARIOS SECTION.
       301-LER-FUNCIONARIOS.
          EXIT.
      *******************************************************
       900-FINALIZAR SECTION.
       901-FINALIZAR.
          EXIT.
