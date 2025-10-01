       IDENTIFICATION                        DIVISION.
       PROGRAM-ID.                           CONTNOME.
      *
       ENVIRONMENT                           DIVISION.
      *
       DATA                                  DIVISION.
       WORKING-STORAGE                       SECTION.
       77  WK-POSICAO              PIC 99    VALUE ZEROS.
      *
       LINKAGE                               SECTION.
       01  LK-NOMEFUN-LEN          PIC 9(30).
       01  LK-NOMEFUN-TEXT         PIC A(30).
      *
       PROCEDURE                             DIVISION USING LK-NOMEFUN-LEN
                                                            LK-NOMEFUN-TEXT.
       PERFORM CONTA-NOME.
       GOBACK.

       CONTA-NOME.
          MOVE 30 TO LK-NOMEFUN-LEN.
          PERFORM VARYING WK-POSICAO FROM 30 BY -1
                   UNTIL LK-NOMEFUN-TEXT(WK-POSICAO:1) NOT EQUAL SPACES
             SUBTRACT 1 FROM LK-NOMEFUN-LEN
          END-PERFORM.
      
