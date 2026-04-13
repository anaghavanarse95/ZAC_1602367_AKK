CLASS LHC_ZR_BOOKSTORE_AKK DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR BookStore_AKK
        RESULT result,
      titleName FOR VALIDATE ON SAVE
            IMPORTING keys FOR BookStore_AKK~titleName,
      calDate FOR DETERMINE ON SAVE
            IMPORTING keys FOR BookStore_AKK~calDate.

ENDCLASS.

CLASS LHC_ZR_BOOKSTORE_AKK IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD titleName.

  READ ENTITIES OF ZR_BOOKSTORE_AKK IN LOCAL MODE
    ENTITY BookStore_AKK
      FIELDS ( Title )
      WITH CORRESPONDING #( keys )
    RESULT DATA(entities).

  LOOP AT entities INTO DATA(entity).
    IF entity-Title IS INITIAL.
      APPEND VALUE #(
          %tky        = entity-%tky
          %state_area = 'Validation'
          %msg        = new_message_with_text(
                          text     = 'Title field is mandatory'
                          severity = if_abap_behv_message=>severity-error
                        )
      ) TO reported-BookStore_AKK.
      APPEND VALUE #( %tky = entity-%tky ) TO failed-BookStore_AKK.
    ENDIF.
  ENDLOOP.

  ENDMETHOD.


  METHOD calDate.
"use EML/RAP to read the data from the database
"use EML/RAP to update the data on the database (for the date field)
    READ ENTITIES OF ZR_BOOKSTORE_AKK IN LOCAL MODE
      ENTITY BookStore_AKK
        FIELDS ( Title )
        WITH CORRESPONDING #( keys )
      RESULT DATA(entities).

    MODIFY ENTITIES OF ZR_BOOKSTORE_AKK IN LOCAL MODE
      ENTITY BookStore_AKK
        UPDATE FIELDS ( PublishedDate )
        WITH VALUE #( FOR entity IN entities ( %tky      = entity-%tky
                                               PublishedDate      = sy-datum )
                                               ).

  ENDMETHOD.

ENDCLASS.
