
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 06/06/2020 19:35:59
-- Generated from EDMX file: C:\Users\P74Y3\source\repos\atinformstudy\atinformstudy\ATinform.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [atinformDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_CourseGroupCourse]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupSet] DROP CONSTRAINT [FK_CourseGroupCourse];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupGroupStudent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupStudentSet] DROP CONSTRAINT [FK_GroupGroupStudent];
GO
IF OBJECT_ID(N'[dbo].[FK_GroupContent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ContentSet] DROP CONSTRAINT [FK_GroupContent];
GO
IF OBJECT_ID(N'[dbo].[FK_ContentAttachment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[AttachmentSet] DROP CONSTRAINT [FK_ContentAttachment];
GO
IF OBJECT_ID(N'[dbo].[FK_TestTestResult]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TestResultSet] DROP CONSTRAINT [FK_TestTestResult];
GO
IF OBJECT_ID(N'[dbo].[FK_AtUserGroupStudent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupStudentSet] DROP CONSTRAINT [FK_AtUserGroupStudent];
GO
IF OBJECT_ID(N'[dbo].[FK_AtUserGroup]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupSet] DROP CONSTRAINT [FK_AtUserGroup];
GO
IF OBJECT_ID(N'[dbo].[FK_AtUserTestResult]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TestResultSet] DROP CONSTRAINT [FK_AtUserTestResult];
GO
IF OBJECT_ID(N'[dbo].[FK_AtUserContent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ContentSet] DROP CONSTRAINT [FK_AtUserContent];
GO
IF OBJECT_ID(N'[dbo].[FK_TestTestQuestion]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TestQuestionSet] DROP CONSTRAINT [FK_TestTestQuestion];
GO
IF OBJECT_ID(N'[dbo].[FK_CourseTest]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TestSet] DROP CONSTRAINT [FK_CourseTest];
GO
IF OBJECT_ID(N'[dbo].[FK_AtUserComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommentSet] DROP CONSTRAINT [FK_AtUserComment];
GO
IF OBJECT_ID(N'[dbo].[FK_CommentAttachment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[AttachmentSet] DROP CONSTRAINT [FK_CommentAttachment];
GO
IF OBJECT_ID(N'[dbo].[FK_ContentComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommentSet] DROP CONSTRAINT [FK_ContentComment];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[CourseSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CourseSet];
GO
IF OBJECT_ID(N'[dbo].[GroupSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupSet];
GO
IF OBJECT_ID(N'[dbo].[GroupStudentSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupStudentSet];
GO
IF OBJECT_ID(N'[dbo].[ContentSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ContentSet];
GO
IF OBJECT_ID(N'[dbo].[AttachmentSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AttachmentSet];
GO
IF OBJECT_ID(N'[dbo].[TestQuestionSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TestQuestionSet];
GO
IF OBJECT_ID(N'[dbo].[TestSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TestSet];
GO
IF OBJECT_ID(N'[dbo].[TestResultSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TestResultSet];
GO
IF OBJECT_ID(N'[dbo].[AtUserSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AtUserSet];
GO
IF OBJECT_ID(N'[dbo].[CommentSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CommentSet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'CourseSet'
CREATE TABLE [dbo].[CourseSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Hours] tinyint  NOT NULL,
    [Price] decimal(18,0)  NOT NULL
);
GO

-- Creating table 'GroupSet'
CREATE TABLE [dbo].[GroupSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Started] bit  NOT NULL,
    [Finished] bit  NOT NULL,
    [StartDate] datetime  NULL,
    [FinishDate] datetime  NULL,
    [Course_Id] int  NOT NULL,
    [Curator_Id] int  NULL
);
GO

-- Creating table 'GroupStudentSet'
CREATE TABLE [dbo].[GroupStudentSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Group_Id] int  NOT NULL,
    [Student_Id] int  NOT NULL
);
GO

-- Creating table 'ContentSet'
CREATE TABLE [dbo].[ContentSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [PostedDate] datetime  NOT NULL,
    [PostTheme] nvarchar(max)  NOT NULL,
    [Text] nvarchar(max)  NOT NULL,
    [Group_Id] int  NOT NULL,
    [AtUser_Id] int  NOT NULL
);
GO

-- Creating table 'AttachmentSet'
CREATE TABLE [dbo].[AttachmentSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [FilePath] nvarchar(max)  NOT NULL,
    [FileName] nvarchar(max)  NOT NULL,
    [Content_Id] int  NULL,
    [Comment_Id] int  NULL
);
GO

-- Creating table 'TestQuestionSet'
CREATE TABLE [dbo].[TestQuestionSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Text] nvarchar(max)  NOT NULL,
    [Ans1] nvarchar(max)  NOT NULL,
    [Ans2] nvarchar(max)  NOT NULL,
    [Ans3] nvarchar(max)  NOT NULL,
    [Ans4] nvarchar(max)  NOT NULL,
    [RightAns] tinyint  NOT NULL,
    [Test_Id] int  NOT NULL
);
GO

-- Creating table 'TestSet'
CREATE TABLE [dbo].[TestSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [PostedDate] datetime  NOT NULL,
    [QuesCount] tinyint  NOT NULL,
    [PercToPass] tinyint  NOT NULL,
    [Course_Id] int  NOT NULL
);
GO

-- Creating table 'TestResultSet'
CREATE TABLE [dbo].[TestResultSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Passed] bit  NOT NULL,
    [FinishDate] nvarchar(max)  NOT NULL,
    [RightAnsCount] tinyint  NOT NULL,
    [Test_Id] int  NOT NULL,
    [Student_Id] int  NOT NULL
);
GO

-- Creating table 'AtUserSet'
CREATE TABLE [dbo].[AtUserSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [AspNetID] nvarchar(128)  NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [LastName] nvarchar(max)  NOT NULL,
    [PatrName] nvarchar(max)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Role] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'CommentSet'
CREATE TABLE [dbo].[CommentSet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [PostedDate] datetime  NOT NULL,
    [Text] nvarchar(max)  NOT NULL,
    [AtUser_Id] int  NOT NULL,
    [Content_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'CourseSet'
ALTER TABLE [dbo].[CourseSet]
ADD CONSTRAINT [PK_CourseSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'GroupSet'
ALTER TABLE [dbo].[GroupSet]
ADD CONSTRAINT [PK_GroupSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'GroupStudentSet'
ALTER TABLE [dbo].[GroupStudentSet]
ADD CONSTRAINT [PK_GroupStudentSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ContentSet'
ALTER TABLE [dbo].[ContentSet]
ADD CONSTRAINT [PK_ContentSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'AttachmentSet'
ALTER TABLE [dbo].[AttachmentSet]
ADD CONSTRAINT [PK_AttachmentSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'TestQuestionSet'
ALTER TABLE [dbo].[TestQuestionSet]
ADD CONSTRAINT [PK_TestQuestionSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'TestSet'
ALTER TABLE [dbo].[TestSet]
ADD CONSTRAINT [PK_TestSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'TestResultSet'
ALTER TABLE [dbo].[TestResultSet]
ADD CONSTRAINT [PK_TestResultSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'AtUserSet'
ALTER TABLE [dbo].[AtUserSet]
ADD CONSTRAINT [PK_AtUserSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'CommentSet'
ALTER TABLE [dbo].[CommentSet]
ADD CONSTRAINT [PK_CommentSet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Course_Id] in table 'GroupSet'
ALTER TABLE [dbo].[GroupSet]
ADD CONSTRAINT [FK_CourseGroupCourse]
    FOREIGN KEY ([Course_Id])
    REFERENCES [dbo].[CourseSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CourseGroupCourse'
CREATE INDEX [IX_FK_CourseGroupCourse]
ON [dbo].[GroupSet]
    ([Course_Id]);
GO

-- Creating foreign key on [Group_Id] in table 'GroupStudentSet'
ALTER TABLE [dbo].[GroupStudentSet]
ADD CONSTRAINT [FK_GroupGroupStudent]
    FOREIGN KEY ([Group_Id])
    REFERENCES [dbo].[GroupSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupGroupStudent'
CREATE INDEX [IX_FK_GroupGroupStudent]
ON [dbo].[GroupStudentSet]
    ([Group_Id]);
GO

-- Creating foreign key on [Group_Id] in table 'ContentSet'
ALTER TABLE [dbo].[ContentSet]
ADD CONSTRAINT [FK_GroupContent]
    FOREIGN KEY ([Group_Id])
    REFERENCES [dbo].[GroupSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupContent'
CREATE INDEX [IX_FK_GroupContent]
ON [dbo].[ContentSet]
    ([Group_Id]);
GO

-- Creating foreign key on [Content_Id] in table 'AttachmentSet'
ALTER TABLE [dbo].[AttachmentSet]
ADD CONSTRAINT [FK_ContentAttachment]
    FOREIGN KEY ([Content_Id])
    REFERENCES [dbo].[ContentSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ContentAttachment'
CREATE INDEX [IX_FK_ContentAttachment]
ON [dbo].[AttachmentSet]
    ([Content_Id]);
GO

-- Creating foreign key on [Test_Id] in table 'TestResultSet'
ALTER TABLE [dbo].[TestResultSet]
ADD CONSTRAINT [FK_TestTestResult]
    FOREIGN KEY ([Test_Id])
    REFERENCES [dbo].[TestSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TestTestResult'
CREATE INDEX [IX_FK_TestTestResult]
ON [dbo].[TestResultSet]
    ([Test_Id]);
GO

-- Creating foreign key on [Student_Id] in table 'GroupStudentSet'
ALTER TABLE [dbo].[GroupStudentSet]
ADD CONSTRAINT [FK_AtUserGroupStudent]
    FOREIGN KEY ([Student_Id])
    REFERENCES [dbo].[AtUserSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AtUserGroupStudent'
CREATE INDEX [IX_FK_AtUserGroupStudent]
ON [dbo].[GroupStudentSet]
    ([Student_Id]);
GO

-- Creating foreign key on [Curator_Id] in table 'GroupSet'
ALTER TABLE [dbo].[GroupSet]
ADD CONSTRAINT [FK_AtUserGroup]
    FOREIGN KEY ([Curator_Id])
    REFERENCES [dbo].[AtUserSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AtUserGroup'
CREATE INDEX [IX_FK_AtUserGroup]
ON [dbo].[GroupSet]
    ([Curator_Id]);
GO

-- Creating foreign key on [Student_Id] in table 'TestResultSet'
ALTER TABLE [dbo].[TestResultSet]
ADD CONSTRAINT [FK_AtUserTestResult]
    FOREIGN KEY ([Student_Id])
    REFERENCES [dbo].[AtUserSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AtUserTestResult'
CREATE INDEX [IX_FK_AtUserTestResult]
ON [dbo].[TestResultSet]
    ([Student_Id]);
GO

-- Creating foreign key on [AtUser_Id] in table 'ContentSet'
ALTER TABLE [dbo].[ContentSet]
ADD CONSTRAINT [FK_AtUserContent]
    FOREIGN KEY ([AtUser_Id])
    REFERENCES [dbo].[AtUserSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AtUserContent'
CREATE INDEX [IX_FK_AtUserContent]
ON [dbo].[ContentSet]
    ([AtUser_Id]);
GO

-- Creating foreign key on [Test_Id] in table 'TestQuestionSet'
ALTER TABLE [dbo].[TestQuestionSet]
ADD CONSTRAINT [FK_TestTestQuestion]
    FOREIGN KEY ([Test_Id])
    REFERENCES [dbo].[TestSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TestTestQuestion'
CREATE INDEX [IX_FK_TestTestQuestion]
ON [dbo].[TestQuestionSet]
    ([Test_Id]);
GO

-- Creating foreign key on [Course_Id] in table 'TestSet'
ALTER TABLE [dbo].[TestSet]
ADD CONSTRAINT [FK_CourseTest]
    FOREIGN KEY ([Course_Id])
    REFERENCES [dbo].[CourseSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CourseTest'
CREATE INDEX [IX_FK_CourseTest]
ON [dbo].[TestSet]
    ([Course_Id]);
GO

-- Creating foreign key on [AtUser_Id] in table 'CommentSet'
ALTER TABLE [dbo].[CommentSet]
ADD CONSTRAINT [FK_AtUserComment]
    FOREIGN KEY ([AtUser_Id])
    REFERENCES [dbo].[AtUserSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_AtUserComment'
CREATE INDEX [IX_FK_AtUserComment]
ON [dbo].[CommentSet]
    ([AtUser_Id]);
GO

-- Creating foreign key on [Comment_Id] in table 'AttachmentSet'
ALTER TABLE [dbo].[AttachmentSet]
ADD CONSTRAINT [FK_CommentAttachment]
    FOREIGN KEY ([Comment_Id])
    REFERENCES [dbo].[CommentSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_CommentAttachment'
CREATE INDEX [IX_FK_CommentAttachment]
ON [dbo].[AttachmentSet]
    ([Comment_Id]);
GO

-- Creating foreign key on [Content_Id] in table 'CommentSet'
ALTER TABLE [dbo].[CommentSet]
ADD CONSTRAINT [FK_ContentComment]
    FOREIGN KEY ([Content_Id])
    REFERENCES [dbo].[ContentSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ContentComment'
CREATE INDEX [IX_FK_ContentComment]
ON [dbo].[CommentSet]
    ([Content_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------