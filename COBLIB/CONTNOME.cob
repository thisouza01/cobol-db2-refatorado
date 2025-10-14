       IDENTIFICATION                        DIVISION.
       PROGRAM-ID.                           CONTNOME.
      *
       ENVIRONMENT                           DIVISION.
      *
       DATA                                  DIVISION.
       WORKING-STORAGE                       SECTION.
       77  WK-POSICAO                        PIC 99    VALUE ZEROS.
      *
       LINKAGE                               SECTION.
       01  LK-NOMEFUN.
             05  LK-NOMEFUN-LEN              PIC S9(04).
             05  LK-NOMEFUN-TEXT             PIC X(30).
      *
       PROCEDURE                             DIVISION USING LK-NOMEFUN.
      
       PERFORM CONTA-NOME.
       GOBACK.

       CONTA-NOME.
          MOVE 30 TO LK-NOMEFUN-LEN.
          PERFORM VARYING WK-POSICAO FROM 30 BY -1
                   UNTIL LK-NOMEFUN-TEXT(WK-POSICAO:1) NOT EQUAL SPACES
             CONTINUE
          END-PERFORM.
          MOVE WK-POSICAO TO LK-NOMEFUN-LEN.
      
