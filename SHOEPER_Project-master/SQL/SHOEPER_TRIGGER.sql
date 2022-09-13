--------------------------------------------------------
 
--------------------------------------------------------
DROP TRIGGER shopmaster."TRG_ORDER_STATUS_REVIEW";
DROP TRIGGER shopmaster."TRG_PRODUCT_STOCK";
--------------------------------------------------------
--  DDL for Table O_ORDER_LIST
--------------------------------------------------------

  CREATE TABLE shopmaster."O_ORDER_LIST" 
   (	"ORDER_SIZE" CHAR(1 BYTE), 
	"ORDER_QUANTITY" NUMBER, 
	"ORDER_NO" NUMBER, 
	"PRODUCT_NO" NUMBER, 
	"ORDER_STATUS" NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table REVIEW
--------------------------------------------------------

  CREATE TABLE shopmaster."REVIEW" 
   (	"REVIEW_NO" NUMBER, 
	"REVIEW_CONTENTS" VARCHAR2(1000 BYTE), 
	"REVIEW_DATE" DATE DEFAULT SYSDATE, 
	"REVIEW_TITLE" VARCHAR2(100 BYTE), 
	"MEMBER_NO" NUMBER, 
	"PRODUCT_NO" NUMBER, 
	"ORDER_NO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table PRODUCT
--------------------------------------------------------

  CREATE TABLE shopmaster."PRODUCT" 
   (	"PRODUCT_NO" NUMBER, 
	"PRODUCT_NAME" VARCHAR2(100 BYTE), 
	"PRODUCT_DETAIL" VARCHAR2(2000 BYTE), 
	"PRODUCT_SIZEINFO" VARCHAR2(2000 BYTE), 
	"PRODUCT_SIZE" VARCHAR2(10 BYTE), 
	"PRODUCT_PRICE" NUMBER, 
	"product_stock_240" NUMBER, 
	"product_stock_250" NUMBER, 
	"product_stock_260" NUMBER, 
	"PRODUCT_TYPE" NUMBER DEFAULT 2, 
	"MEMBER_NO" NUMBER, 
	"PRODUCT_STATUS" CHAR(1 BYTE) DEFAULT 'Y', 
	"PRODUCT_CATEGORY" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger TRG_ORDER_STATUS_REVIEW
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER shopmaster."TRG_ORDER_STATUS_REVIEW" 
AFTER INSERT
ON REVIEW
FOR EACH ROW
    BEGIN
        UPDATE O_ORDER_LIST
        SET ORDER_STATUS = 4
        WHERE :NEW.PRODUCT_NO = PRODUCT_NO
        AND :NEW.ORDER_NO = ORDER_NO;
    END;

/
ALTER TRIGGER shopmaster."TRG_ORDER_STATUS_REVIEW" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_PRODUCT_STOCK
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER shopmaster."TRG_PRODUCT_STOCK" 
AFTER INSERT
ON O_ORDER_LIST
FOR EACH ROW
    BEGIN
        IF :NEW.ORDER_SIZE = 'S'
        THEN 
            UPDATE PRODUCT
            SET product_stock_240 = 
            CASE 
                WHEN product_stock_240 - :NEW.ORDER_QUANTITY < 0 THEN 0
                WHEN product_stock_240 - :NEW.ORDER_QUANTITY >= 0 THEN product_stock_240 - :NEW.ORDER_QUANTITY
            END
            WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
        END IF;
        IF :NEW.ORDER_SIZE = 'M' 
        THEN 
            UPDATE PRODUCT
            SET product_stock_250 = 
            CASE 
                WHEN product_stock_250 - :NEW.ORDER_QUANTITY < 0 THEN 0
                WHEN product_stock_250 - :NEW.ORDER_QUANTITY >= 0 THEN product_stock_250 - :NEW.ORDER_QUANTITY
            END
            WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
        END IF;
        IF :NEW.ORDER_SIZE = 'L' 
        THEN 
            UPDATE PRODUCT
            SET product_stock_260 = 
            CASE 
                WHEN product_stock_260 - :NEW.ORDER_QUANTITY < 0 THEN 0
                WHEN product_stock_260 - :NEW.ORDER_QUANTITY >= 0 THEN product_stock_260 - :NEW.ORDER_QUANTITY
            END
            WHERE PRODUCT_NO = :NEW.PRODUCT_NO;
        END IF;
    END;

/
ALTER TRIGGER shopmaster."TRG_PRODUCT_STOCK" ENABLE;