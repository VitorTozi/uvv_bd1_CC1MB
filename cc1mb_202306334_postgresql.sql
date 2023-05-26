drop database if exists uvv ;
drop user if exists vitor;
create user vitor with createdb createrole encrypted password 'tozi0905';

set role vitor;

create database uvv
with owner = vitor
template = template0
encoding = 'UTF8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true;


alter database uvv owner to vitor;

\c uvv vitor;

create schema lojas authorization vitor;

set search_path to lojas, '$user', public;

alter user vitor set search_path to lojas, '$user', public;

alter schema lojas owner to vitor;





              ----Tabela produtos----


CREATE TABLE lojas.Produtos (
                produto_id                          NUMERIC(38) NOT NULL,
                nome                                VARCHAR(255) NOT NULL,
                preco_unitario                      NUMERIC(10,2),
                detalhes                            BYTEA,
                imagem                              BYTEA,
                imagem_mime_type                    VARCHAR(512),
                imagem_arquivo                      VARCHAR(512),
                imagem_chaset                       VARCHAR(512),
                imagem_ultima_atualizacao           DATE,
                CONSTRAINT produtos_pk 
                PRIMARY KEY (produto_id),

                 
);


COMMENT ON COLUMN lojas.Produtos.produto_id                   IS                 'ID dos produtos';
COMMENT ON COLUMN lojas.Produtos.nome                         IS                 'Nome dos produtos';
COMMENT ON COLUMN lojas.Produtos.preco_unitario               IS                 'preco unitario';
COMMENT ON COLUMN lojas.Produtos.detalhes                     IS                 'Detalhes dos produtos';
COMMENT ON COLUMN lojas.Produtos.imagem                       IS                 'imagem dos produtos';
COMMENT ON COLUMN lojas.Produtos.imagem_mime_type             IS                 'imagem_mime_type';
COMMENT ON COLUMN lojas.Produtos.imagem_arquivo               IS                 'Imagem arquivo';
COMMENT ON COLUMN lojas.Produtos.imagem_chaset                IS                 'imagem chaset';
COMMENT ON COLUMN lojas.Produtos.imagem_ultima_atualizacao    IS                 'imagem ultima atualizacao';


              ----Tabela loja----


CREATE TABLE lojas.Lojas (
                loja_id                         NUMERIC(38) NOT NULL,
                nome                            VARCHAR(255) NOT NULL,
                endereco_web                    VARCHAR(100),
                endereco_fisico                 VARCHAR(512),
                latitude                        NUMERIC,
                longitude                       NUMERIC,
                logo                            BYTEA,
                logo_mime_type                  VARCHAR(512),
                logo_arquivo                    VARCHAR(512),
                logo_charset                    VARCHAR(512),
                logo_ultima_atualizacao         DATE,
                CONSTRAINT lojas_pk 
                PRIMARY KEY (loja_id),
);


COMMENT ON TABLE lojas.Lojas                           IS       'Tabela das lojas';
COMMENT ON COLUMN lojas.Lojas.loja_id                  IS       'ID da loja';
COMMENT ON COLUMN lojas.Lojas.nome                     IS       'nome da loja';
COMMENT ON COLUMN lojas.Lojas.endereco_web             IS       'endereço web da loja';
COMMENT ON COLUMN lojas.Lojas.endereco_fisico          IS       'Endereeço fisico da loja';
COMMENT ON COLUMN lojas.Lojas.latitude                 IS       'Latitude da loja';
COMMENT ON COLUMN lojas.Lojas.longitude                IS       'longitude da loja';
COMMENT ON COLUMN lojas.Lojas.logo                     IS       'logo da loja';
COMMENT ON COLUMN lojas.Lojas.logo_mime_type           IS       'Logo_mime_type';
COMMENT ON COLUMN lojas.Lojas.logo_arquivo             IS       'Logo_arquivo';
COMMENT ON COLUMN lojas.Lojas.logo_charset             IS       'Logo_charset';
COMMENT ON COLUMN lojas.Lojas.logo_ultima_atualizacao  IS       'Logo_ultima_atualizacao ';


              ----Tabela estoque----


CREATE TABLE lojas.Estoques (
                estoque_id                      NUMERIC(38) NOT NULL,
                loja_id                         NUMERIC(38) NOT NULL,
                produto_id                      NUMERIC(38) NOT NULL,
                quantidade                      NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk 
                PRIMARY KEY (estoque_id),
);


COMMENT ON COLUMN lojas.Estoques.estoque_id   IS     'ID do estoque';
COMMENT ON COLUMN lojas.Estoques.loja_id      IS     'ID da loja';
COMMENT ON COLUMN lojas.Estoques.produto_id   IS     'ID dos produtos';
COMMENT ON COLUMN lojas.Estoques.quantidade   IS     'quantidade do estoque';


                ----Tabela clientes----


CREATE TABLE lojas.clientes (
                cliente_id   NUMERIC(38)  NOT NULL,
                email        VARCHAR(255) NOT NULL,
                nomel        VARCHAR(255) NOT NULL,
                telefone1    VARCHAR(20),
                telefone2    VARCHAR(20),
                telefone3    VARCHAR(20),
                CONSTRAINT   clientes_id 
                PRIMARY KEY (cliente_id),
                
);
         

COMMENT ON TABLE lojas.clientes                 IS    'Informações dos clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id     IS    'Numero de clientes';
COMMENT ON COLUMN lojas.clientes.email          IS    'Email do cliente';
COMMENT ON COLUMN lojas.clientes.nomel          IS    'Nome do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1      IS    'Telefone1 do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2      IS    'Telefone2 do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3      IS    'Telefone3 do cliente';


               ----Tabela envios----


CREATE TABLE lojas.Envios (
                envio_id                           NUMERIC(38) NOT NULL,
                loja_id                            NUMERIC(38) NOT NULL,
                cliente_id                         NUMERIC(38) NOT NULL,
                endereco_entrega                   VARCHAR(512) NOT NULL,
                status                             VARCHAR(15) NOT NULL,
                CONSTRAINT   envios_pk 
                PRIMARY KEY (envio_id),
                CONSTRAINT check_status
                CHECK       (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'))

);


COMMENT ON COLUMN lojas.Envios.envio_id            IS          'Id dos envios';
COMMENT ON COLUMN lojas.Envios.loja_id             IS          'ID da loja';
COMMENT ON COLUMN lojas.Envios.cliente_id          IS          'Numero de clientes';
COMMENT ON COLUMN lojas.Envios.endereco_entrega    IS          'Endereço entrega';
COMMENT ON COLUMN lojas.Envios.status              IS          'Status do envio';


              ----Tabela pedidos----


CREATE TABLE lojas.Pedidos (
                pedidos_id                       NUMERIC(38) NOT NULL,
                data_hora                        TIMESTAMP NOT NULL,
                cliente_id                       NUMERIC(38) NOT NULL,
                status                           VARCHAR(15) NOT NULL,
                loja_id                          NUMERIC(38) NOT NULL,
                CONSTRAINT   pedidos_pk 
                PRIMARY KEY (pedidos_id),
                CONSTRAINT   check_status
                CHECK       (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'))
);


COMMENT ON COLUMN lojas.Pedidos.pedidos_id        IS     'ID dos pedidos';
COMMENT ON COLUMN lojas.Pedidos.data_hora         IS     'Data hora dos pedidos';
COMMENT ON COLUMN lojas.Pedidos.cliente_id        IS     'Id dos clientes do pedidos';
COMMENT ON COLUMN lojas.Pedidos.status            IS     'Status dos pedidos';
COMMENT ON COLUMN lojas.Pedidos.loja_id           IS     'ID da loja';


              ----Tabela pedidos_itens----


CREATE TABLE lojas.pedido_itens (
                pedido_id                   NUMERIC(38) NOT NULL,
                produto_id                  NUMERIC(38) NOT NULL,
                numero_da_linha             NUMERIC(38) NOT NULL,
                preco_unitario              NUMERIC(10,2) NOT NULL,
                quantidade                  NUMERIC(38) NOT NULL,
                envio_id                    NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_itens_pk 
                PRIMARY KEY (pedido_id, produto_id),
);


COMMENT ON COLUMN lojas.pedido_itens.pedido_id             IS     'ID dos pedidos';
COMMENT ON COLUMN lojas.pedido_itens.produto_id            IS     'ID dos produtos';
COMMENT ON COLUMN lojas.pedido_itens.numero_da_linha       IS     'numero da linha ';
COMMENT ON COLUMN lojas.pedido_itens.preco_unitario        IS     'preco unitario ';
COMMENT ON COLUMN lojas.pedido_itens.quantidade            IS     'quantidade';
COMMENT ON COLUMN lojas.pedido_itens.envio_id              IS     'ID do envio';


ALTER TABLE lojas.Estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedido_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.Pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.Estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.Envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.Pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.Envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedido_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.Envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedido_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.Pedidos (pedidos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;