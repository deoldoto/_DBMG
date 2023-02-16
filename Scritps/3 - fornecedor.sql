USE [BDMG]
GO

/****** Object:  Table [dbo].[fornecedores]    Script Date: 16/02/2023 17:05:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[fornecedores](
	[id] [int] NOT NULL,
	[id_pessoa] [int] NULL,
	[nome_fantasia] [varchar](50) NULL,
	[status] [varchar](4) NULL,
 CONSTRAINT [PK_fornecedores] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[fornecedores]  WITH CHECK ADD  CONSTRAINT [FK_fornecedores_fornecedores] FOREIGN KEY([id])
REFERENCES [dbo].[fornecedores] ([id])
GO

ALTER TABLE [dbo].[fornecedores] CHECK CONSTRAINT [FK_fornecedores_fornecedores]
GO

ALTER TABLE [dbo].[fornecedores]  WITH CHECK ADD  CONSTRAINT [FK_fornecedores_pessoa] FOREIGN KEY([id_pessoa])
REFERENCES [dbo].[pessoa] ([id])
GO

ALTER TABLE [dbo].[fornecedores] CHECK CONSTRAINT [FK_fornecedores_pessoa]
GO

