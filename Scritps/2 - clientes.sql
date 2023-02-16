USE [BDMG]
GO

/****** Object:  Table [dbo].[clientes]    Script Date: 16/02/2023 17:05:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[clientes](
	[id] [int] NOT NULL,
	[id_pessoa] [int] NULL,
	[status] [varchar](10) NULL,
	[data_nascimento] [date] NULL,
 CONSTRAINT [PK_clientes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[clientes]  WITH CHECK ADD  CONSTRAINT [FK_clientes_pessoa] FOREIGN KEY([id_pessoa])
REFERENCES [dbo].[pessoa] ([id])
GO

ALTER TABLE [dbo].[clientes] CHECK CONSTRAINT [FK_clientes_pessoa]
GO

