USE [BDMG]
GO

/****** Object:  Table [dbo].[vendas]    Script Date: 16/02/2023 02:48:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[vendas](
	[id] [int] NOT NULL,
	[id_cliente] [int] NULL,
	[hora] datetime NULL,
	[valor_total] [float] NULL,
	[status] [varchar](10) NULL,
 CONSTRAINT [PK_vendas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[vendas]  WITH CHECK ADD  CONSTRAINT [FK_vendas_clientes] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[clientes] ([id])
GO

ALTER TABLE [dbo].[vendas] CHECK CONSTRAINT [FK_vendas_clientes]
GO


