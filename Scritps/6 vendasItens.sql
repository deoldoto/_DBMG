USE [BDMG]
GO

/****** Object:  Table [dbo].[vendaItens]    Script Date: 16/02/2023 17:06:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[vendaItens](
	[id_pedido] [int] NOT NULL,
	[id_produto] [int] NOT NULL,
	[quantidade] [float] NULL,
	[valor_unitario] [float] NULL,
	[valor_total] [float] NULL,
 CONSTRAINT [PK_vendaItens] PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC,
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

