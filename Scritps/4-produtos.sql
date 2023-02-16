USE [BDMG]
GO

/****** Object:  Table [dbo].[produtos]    Script Date: 16/02/2023 17:05:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[produtos](
	[id] [int] NOT NULL,
	[descricao] [varchar](50) NULL,
	[valor] [float] NULL,
	[id_fornecedor] [int] NOT NULL,
	[status] [varchar](10) NULL,
 CONSTRAINT [PK_produtos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[produtos]  WITH CHECK ADD  CONSTRAINT [FK_produtos_produtos] FOREIGN KEY([id_fornecedor])
REFERENCES [dbo].[fornecedores] ([id])
GO

ALTER TABLE [dbo].[produtos] CHECK CONSTRAINT [FK_produtos_produtos]
GO

