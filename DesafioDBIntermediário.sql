-- Criando DB
create database Loja;

use Loja;

create table ProdutoCategoria
(
	id_categoria int primary key not null auto_increment,
    nome_categoria varchar(100) not null,
    descricao varchar(120)
);

create table Produto
(
	id_produto int primary key not null auto_increment,
    id_categoria int not null,
	foreign key (id_categoria) references ProdutoCategoria(id_categoria),
	nome_produto varchar(100) not null,
	valor_custo numeric(10,2) not null,
	valor_venda numeric(10,2) not null,
    descricao varchar(400),
    imagem varchar(255),
    data_cadastro datetime not null,
    ativo boolean default true
);

create table ProdutoEstoque
(
	id_estoque int primary key not null auto_increment,
    id_produto int not null,
    foreign key (id_produto) references Produto(id_produto) on delete cascade,
    qtde_atual int default 0,
    qtde_max int default 0
);

create table Clientes (
    id int primary key not null auto_increment,
    titulo varchar(10),
    primeiro_nome varchar(50),
    meio_inicial varchar(1),
    ultimo_nome varchar(50)
);


-- Adicionando as informações
insert into ProdutoCategoria (nome_categoria, descricao) values
('Bebidas', 'Refrigerantes, sucos e águas'),
('Lanches', 'Salgados, sanduíches e petiscos'),
('Doces', 'Balas, chocolates e sobremesas'),
('Higiene', 'Produtos de uso pessoal e limpeza'),
('Roupas', 'Vestidos, camisetas, calças');

insert into Produto (id_categoria, nome_produto, valor_custo, valor_venda, descricao, imagem, ativo) values
(1, 'Refrigerante Coca-Cola 2L', 5.50, 8.99, 'Bebida gaseificada sabor cola', 'img/coca2l.png', TRUE),
(2, 'Hambúrguer artesanal', 7.00, 14.99, 'Hambúrguer com pão brioche e carne 180g', 'img/hamburguer.png', TRUE),
(3, 'Chocolate Lacta 90g', 3.20, 6.50, 'Chocolate ao leite 90g', 'img/lacta.png', TRUE),
(4, 'Sabonete Dove 90g', 2.00, 4.50, 'Sabonete hidratante para todos os tipos de pele', 'img/dove.png', TRUE),
(5, 'Vestido florido', 50.00, 70.00, 'Vestido florido estilo Farm', 'img/vestidoflorido.png', TRUE);

insert into ProdutoEstoque (id_produto, qtde_atual, qtde_max) values
(1, 120, 200),
(2, 35, 100),
(3, 80, 150),
(4, 50, 100),
(5, 100, 150);

insert into Clientes (titulo, primeiro_nome, meio_inicial, ultimo_nome) values
('Sr.', 'Diego', 'F', 'Junior'),
('Sra.', 'Ana', 'B', 'Silva'),
('Dr.', 'Vitoria', 'M', 'Porto'),
('Prof.', 'Ana', 'J', 'Conceição'),
('Sr.', 'Felipe', 'L', 'Pereira');

-- DESAFIO BANCO DE DADOS INTERMEDIÁRIO --

-- 1) Consulta para recuperar informações sobre produtos e suas carategorias
select 	p.nome_produto as "Produto",
		c.nome_categoria as "Categoria",
		e.qtde_atual as "Quantidade em Estoque"
from Produto p
inner join produtocategoria c on p.id_categoria = c.id_categoria
inner join produtoestoque e on p.id_produto = e.id_produto;

-- 2) Excluir produtos da categoria roupas utilizando a tabela ProdutoCategoria
delete from Produto
where id_categoria =
(
	select id_categoria 
	from ProdutoCategoria
	where nome_categoria = 'Roupas'
);

-- 3) Consulta para recuperar lista de nomes completos
select 
    case
        when meio_inicial is not null then concat(titulo, ' ', primeiro_nome, ' ', meio_inicial, '. ', ultimo_nome)
        else concat(titulo, ' ', primeiro_nome, ' ', ultimo_nome)
    end as NomeCompleto
from Clientes;