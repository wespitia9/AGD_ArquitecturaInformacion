/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     11/05/2021 12:28:06 a. m.                    */
/*==============================================================*/


drop index CATEGORIA_PK;

drop table CATEGORIA;

drop index RELATIONSHIP_3_FK;

drop index CIUDAD_PK;

drop table CIUDAD;

drop index RELATIONSHIP_1_FK;

drop index CLIENTE_PK;

drop table CLIENTE;

drop index DETALLE_ORDEN_FK;

drop index DETALLE_ORDEN2_FK;

drop index DETALLE_ORDEN_PK;

drop table DETALLE_ORDEN;

drop index ESTADO_PK;

drop table ESTADO;

drop index ESTADO_ORDEN_PK;

drop table ESTADO_ORDEN;

drop index ESTADO_ORDER_FK;

drop index CLIENTE_ORDEN_FK;

drop index ORDEN_PK;

drop table ORDEN;

drop index VENDEDOR_PRODUCTO_FK;

drop index CATEGORIA_PRODUCTO_FK;

drop index PRODUCTO_PK;

drop table PRODUCTO;

drop index RESENA_PRODUCTO_FK;

drop index RESENA_PK;

drop table RESENA;

drop index RELATIONSHIP_2_FK;

drop index UBICACION_PK;

drop table UBICACION;

drop index UBICACION_VENDEDOR_FK;

drop index VENDEDOR_PK;

drop table VENDEDOR;

/*==============================================================*/
/* Table: CATEGORIA                                             */
/*==============================================================*/
create table CATEGORIA (
   CATEGORY_ID          not null,
   CATEGORY_NAME        VARCHAR(100)         not null,
   constraint PK_CATEGORIA primary key (CATEGORY_ID)
);

/*==============================================================*/
/* Index: CATEGORIA_PK                                          */
/*==============================================================*/
create unique index CATEGORIA_PK on CATEGORIA (
CATEGORY_ID
);

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
create table CIUDAD (
   ID_CITY              SERIAL not null,
   ID_STATE             INT4                 null,
   CITY_NAME            VARCHAR(100)         not null,
   constraint PK_CIUDAD primary key (ID_CITY)
);

/*==============================================================*/
/* Index: CIUDAD_PK                                             */
/*==============================================================*/
create unique index CIUDAD_PK on CIUDAD (
ID_CITY
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_3_FK on CIUDAD (
ID_STATE
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CUSTOMER_ID          VARCHAR(500)         not null,
   ZIP_CODE_PREFIX      VARCHAR(20)          not null,
   CUSTOMER_UNIQUE_ID   VARCHAR(500)         not null,
   constraint PK_CLIENTE primary key (CUSTOMER_ID)
);

/*==============================================================*/
/* Index: CLIENTE_PK                                            */
/*==============================================================*/
create unique index CLIENTE_PK on CLIENTE (
CUSTOMER_ID
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_1_FK on CLIENTE (
ZIP_CODE_PREFIX
);

/*==============================================================*/
/* Table: DETALLE_ORDEN                                         */
/*==============================================================*/
create table DETALLE_ORDEN (
   ORDER_ITEM_ID        SERIAL not null,
   PRODUCT_ID           VARCHAR(500)         not null,
   ORDER_ID             VARCHAR(500)         not null,
   SHIPPING_LIMIT_DATE  DATE                 not null,
   PRICE                MONEY                not null,
   FREIGHT_VALUE        MONEY                not null,
   QUANTITY             INT4                 not null,
   constraint PK_DETALLE_ORDEN primary key (ORDER_ID, PRODUCT_ID, ORDER_ITEM_ID)
);

/*==============================================================*/
/* Index: DETALLE_ORDEN_PK                                      */
/*==============================================================*/
create unique index DETALLE_ORDEN_PK on DETALLE_ORDEN (
ORDER_ID,
PRODUCT_ID,
ORDER_ITEM_ID
);

/*==============================================================*/
/* Index: DETALLE_ORDEN2_FK                                     */
/*==============================================================*/
create  index DETALLE_ORDEN2_FK on DETALLE_ORDEN (
PRODUCT_ID
);

/*==============================================================*/
/* Index: DETALLE_ORDEN_FK                                      */
/*==============================================================*/
create  index DETALLE_ORDEN_FK on DETALLE_ORDEN (
ORDER_ID
);

/*==============================================================*/
/* Table: ESTADO                                                */
/*==============================================================*/
create table ESTADO (
   ID_STATE             SERIAL not null,
   STATE_NAME           VARCHAR(100)         not null,
   constraint PK_ESTADO primary key (ID_STATE)
);

/*==============================================================*/
/* Index: ESTADO_PK                                             */
/*==============================================================*/
create unique index ESTADO_PK on ESTADO (
ID_STATE
);

/*==============================================================*/
/* Table: ESTADO_ORDEN                                          */
/*==============================================================*/
create table ESTADO_ORDEN (
   STATUS_ID            SERIAL not null,
   STATUS_DESCRIPTION   VARCHAR(100)         not null,
   constraint PK_ESTADO_ORDEN primary key (STATUS_ID)
);

/*==============================================================*/
/* Index: ESTADO_ORDEN_PK                                       */
/*==============================================================*/
create unique index ESTADO_ORDEN_PK on ESTADO_ORDEN (
STATUS_ID
);

/*==============================================================*/
/* Table: ORDEN                                                 */
/*==============================================================*/
create table ORDEN (
   ORDER_ID             VARCHAR(500)         not null,
   CUSTOMER_ID          VARCHAR(500)         not null,
   STATUS_ID            INT4                 not null,
   ORDER_PURCHASE_TIMESTAMP DATE                 not null,
   ORDER_APPROVED_AT    DATE                 not null,
   ORDER_DELIVERED_CARRIER_DATE DATE                 not null,
   ORDER_DELIVERED_CUSTOMER_DATE DATE                 not null,
   ORDER_ESTIMATED_DELIVERY_DATE DATE                 not null,
   constraint PK_ORDEN primary key (ORDER_ID)
);

/*==============================================================*/
/* Index: ORDEN_PK                                              */
/*==============================================================*/
create unique index ORDEN_PK on ORDEN (
ORDER_ID
);

/*==============================================================*/
/* Index: CLIENTE_ORDEN_FK                                      */
/*==============================================================*/
create  index CLIENTE_ORDEN_FK on ORDEN (
CUSTOMER_ID
);

/*==============================================================*/
/* Index: ESTADO_ORDER_FK                                       */
/*==============================================================*/
create  index ESTADO_ORDER_FK on ORDEN (
STATUS_ID
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   PRODUCT_ID           VARCHAR(500)         not null,
   CATEGORY_ID          INT4                 not null,
   SELLER_ID            VARCHAR(500)         not null,
   PRODUCT_NAME_LENGHT  INT4                 not null,
   PRODUCT_DESCRIPTION_LENGHT INT4                 not null,
   PRODUCT_PHOTOS_QTY   INT4                 not null,
   PRODUCT_WEIGHT_G     INT4                 not null,
   PRODUCT_LENGHT_CM    INT4                 not null,
   PRODUCT_HEIGHT_CM    INT4                 not null,
   PRODUCT_WIDTH_CM     INT4                 not null,
   constraint PK_PRODUCTO primary key (PRODUCT_ID)
);

/*==============================================================*/
/* Index: PRODUCTO_PK                                           */
/*==============================================================*/
create unique index PRODUCTO_PK on PRODUCTO (
PRODUCT_ID
);

/*==============================================================*/
/* Index: CATEGORIA_PRODUCTO_FK                                 */
/*==============================================================*/
create  index CATEGORIA_PRODUCTO_FK on PRODUCTO (
CATEGORY_ID
);

/*==============================================================*/
/* Index: VENDEDOR_PRODUCTO_FK                                  */
/*==============================================================*/
create  index VENDEDOR_PRODUCTO_FK on PRODUCTO (
SELLER_ID
);

/*==============================================================*/
/* Table: RESENA                                                */
/*==============================================================*/
create table RESENA (
   REVIEW_ID            VARCHAR(500)         not null,
   ORDER_ITEM_ID        INT4                 not null,
   PRODUCT_ID           VARCHAR(500)         not null,
   ORDER_ID             VARCHAR(500)         not null,
   REVIEW_SCORE         FLOAT8               not null,
   REVIEW_COMMENT_TITLE VARCHAR(500)         not null,
   REVIEW_COMMENT_MESSAGE VARCHAR(2000)        not null,
   REVIEW_CREATION_DATE DATE                 not null,
   REVIEW_ANSWER_TIMESTAMP DATE                 not null,
   constraint PK_RESENA primary key (REVIEW_ID)
);

/*==============================================================*/
/* Index: RESENA_PK                                             */
/*==============================================================*/
create unique index RESENA_PK on RESENA (
REVIEW_ID
);

/*==============================================================*/
/* Index: RESENA_PRODUCTO_FK                                    */
/*==============================================================*/
create  index RESENA_PRODUCTO_FK on RESENA (
ORDER_ID,
PRODUCT_ID,
ORDER_ITEM_ID
);

/*==============================================================*/
/* Table: UBICACION                                             */
/*==============================================================*/
create table UBICACION (
   ZIP_CODE_PREFIX      VARCHAR(20)          not null,
   ID_CITY              INT4                 null,
   constraint PK_UBICACION primary key (ZIP_CODE_PREFIX)
);

/*==============================================================*/
/* Index: UBICACION_PK                                          */
/*==============================================================*/
create unique index UBICACION_PK on UBICACION (
ZIP_CODE_PREFIX
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_2_FK on UBICACION (
ID_CITY
);

/*==============================================================*/
/* Table: VENDEDOR                                              */
/*==============================================================*/
create table VENDEDOR (
   SELLER_ID            VARCHAR(500)         not null,
   ZIP_CODE_PREFIX      VARCHAR(20)          null,
   constraint PK_VENDEDOR primary key (SELLER_ID)
);

/*==============================================================*/
/* Index: VENDEDOR_PK                                           */
/*==============================================================*/
create unique index VENDEDOR_PK on VENDEDOR (
SELLER_ID
);

/*==============================================================*/
/* Index: UBICACION_VENDEDOR_FK                                 */
/*==============================================================*/
create  index UBICACION_VENDEDOR_FK on VENDEDOR (
ZIP_CODE_PREFIX
);

alter table CIUDAD
   add constraint FK_CIUDAD_RELATIONS_ESTADO foreign key (ID_STATE)
      references ESTADO (ID_STATE)
      on delete restrict on update restrict;

alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_UBICACIO foreign key (ZIP_CODE_PREFIX)
      references UBICACION (ZIP_CODE_PREFIX)
      on delete restrict on update restrict;

alter table DETALLE_ORDEN
   add constraint FK_DETALLE__DETALLE_O_ORDEN foreign key (ORDER_ID)
      references ORDEN (ORDER_ID)
      on delete restrict on update restrict;

alter table DETALLE_ORDEN
   add constraint FK_DETALLE__DETALLE_O_PRODUCTO foreign key (PRODUCT_ID)
      references PRODUCTO (PRODUCT_ID)
      on delete restrict on update restrict;

alter table ORDEN
   add constraint FK_ORDEN_CLIENTE_O_CLIENTE foreign key (CUSTOMER_ID)
      references CLIENTE (CUSTOMER_ID)
      on delete restrict on update restrict;

alter table ORDEN
   add constraint FK_ORDEN_ESTADO_OR_ESTADO_O foreign key (STATUS_ID)
      references ESTADO_ORDEN (STATUS_ID)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_CATEGORIA_CATEGORI foreign key (CATEGORY_ID)
      references CATEGORIA (CATEGORY_ID)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_VENDEDOR__VENDEDOR foreign key (SELLER_ID)
      references VENDEDOR (SELLER_ID)
      on delete restrict on update restrict;

alter table RESENA
   add constraint FK_RESENA_RESENA_PR_DETALLE_ foreign key (ORDER_ID, PRODUCT_ID, ORDER_ITEM_ID)
      references DETALLE_ORDEN (ORDER_ID, PRODUCT_ID, ORDER_ITEM_ID)
      on delete restrict on update restrict;

alter table UBICACION
   add constraint FK_UBICACIO_RELATIONS_CIUDAD foreign key (ID_CITY)
      references CIUDAD (ID_CITY)
      on delete restrict on update restrict;

alter table VENDEDOR
   add constraint FK_VENDEDOR_UBICACION_UBICACIO foreign key (ZIP_CODE_PREFIX)
      references UBICACION (ZIP_CODE_PREFIX)
      on delete restrict on update restrict;

