
-- ----------------------- USER TABLE ----------------------- 

DROP TABLE IF EXISTS  Users;
CREATE TABLE Users (
    iUserID INT IDENTITY(1, 1) PRIMARY KEY,
    vaUsername NVARCHAR(50) NOT NULL,
    vaEmail NVARCHAR(50) NOT NULL,
    vaPassword NVARCHAR(255) NOT NULL,
    vaRole NVARCHAR(30) NOT NULL,
    vaFirstName NVARCHAR(50),
    vaLastName NVARCHAR(50),
    dtCreateOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreateBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT,
    siStatus SMALLINT DEFAULT 0
);
GO


INSERT INTO Users (vaUsername, vaEmail, vaPassword, vaRole, iCreateBy)
VALUES 
    ('admin', 'admin@admin.com', 'daef4953b9783365cad6615223720506cc46c5167cd16ab500fa597aa08ff964eb24fb19687f34d7665f778fcb6c5358fc0a5b81e1662cf90f73a2671c53f991', 'Administrator',  1),
    ('testuser', 'testuser@user.com', 'daef4953b9783365cad6615223720506cc46c5167cd16ab500fa597aa08ff964eb24fb19687f34d7665f778fcb6c5358fc0a5b81e1662cf90f73a2671c53f991', 'User',  1);
GO


-- -----------------------  <name> TABLE ----------------------- 
