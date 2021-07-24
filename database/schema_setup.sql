/*
--------------------------------------------------------------------
© 2021 Badrul
--------------------------------------------------------------------
DB Name : app_db_dev
Author  : Badrul
--------------------------------------------------------------------
*/

-- ================================================================= 
--      CREATE TABLE
-- ==================================================================


-- Users
DROP TABLE IF EXISTS  Users;
CREATE TABLE Users (
    iUserID INT IDENTITY(1, 1) PRIMARY KEY,
    vaUsername NVARCHAR(50) NOT NULL,
    vaEmail NVARCHAR(50) NOT NULL,
    vaPassword NVARCHAR(255) NOT NULL,
    vaSalt NVARCHAR(255) NOT NULL,
    iLoginFailedCount INT DEFAULT 0,
    dtLockedExpiredOn DATETIME,
    dtLastLogin DATETIME,
    dtLastFailedLogin DATETIME,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT,
    siStatus SMALLINT DEFAULT 0
);
GO

INSERT INTO Users (vaUsername, vaEmail, vaPassword, vaSalt, iCreatedBy)
VALUES 
    ('admin', 'admin@admin.com', '686027CB1213F641BA6CE0BAC6A9345D3B1D93528A7783C98B844E8A8E251BE6E8CBDF602D0C7C868E0A42A7DFB47859F9A62A48B113231FB29666FBD23442FB', '5067F3602D07451E2B099655EFD60457D83316F44BA54E086B4CDA79FFAF28261CD71C0FDD5DD79FDCA668BC14A87E98BAF3E44D0555EA008DB72FFCBD2D05DD', 1),
    ('user', 'user@user.com', '686027CB1213F641BA6CE0BAC6A9345D3B1D93528A7783C98B844E8A8E251BE6E8CBDF602D0C7C868E0A42A7DFB47859F9A62A48B113231FB29666FBD23442FB', '5067F3602D07451E2B099655EFD60457D83316F44BA54E086B4CDA79FFAF28261CD71C0FDD5DD79FDCA668BC14A87E98BAF3E44D0555EA008DB72FFCBD2D05DD', 1),
    ('badrul', 'badrul@badrul.com', '686027CB1213F641BA6CE0BAC6A9345D3B1D93528A7783C98B844E8A8E251BE6E8CBDF602D0C7C868E0A42A7DFB47859F9A62A48B113231FB29666FBD23442FB', '5067F3602D07451E2B099655EFD60457D83316F44BA54E086B4CDA79FFAF28261CD71C0FDD5DD79FDCA668BC14A87E98BAF3E44D0555EA008DB72FFCBD2D05DD', 1);
GO

-- role

DROP TABLE IF EXISTS  Roles;
CREATE TABLE Roles (
    iRoleID INT IDENTITY(1, 1) PRIMARY KEY,
    vaRoleName NVARCHAR(50) NOT NULL,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT,
    siStatus SMALLINT DEFAULT 0
);
GO

INSERT INTO Roles (vaRoleName, iCreatedBy)
VALUES 
    ('administrator', 0),
    ('user', 0);
GO

-- UserRole
DROP TABLE IF EXISTS  UserRole;
CREATE TABLE UserRole (
    iUserID INT NOT NULL,
    iRoleID INT NOT NULL,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT,
    siStatus SMALLINT DEFAULT 0,
    PRIMARY KEY (iUserID, iRoleID)
);
GO

INSERT INTO UserRole (iUserID, iRoleID, iCreatedBy)
VALUES 
    (1, 1, 0),
    (2, 2, 0),
    (3, 2, 0);
GO

-- Permission
DROP TABLE IF EXISTS  Permission;
CREATE TABLE Permission (
    iPermissionID INT IDENTITY(1, 1) PRIMARY KEY,
    vaPermissionName NVARCHAR(50) NOT NULL,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT,
    siStatus SMALLINT DEFAULT 0
);
GO

INSERT INTO Permission (vaPermissionName, iCreatedBy)
VALUES 
    ('createUser', 0),
    ('viewUser', 0),
    ('updateUser', 0),
    ('manageRole', 0),
    ('manageSecurityPolicy', 0),

    ('createPost', 0),
    ('viewPost', 0),
    ('updatePost', 0),

    ('addComment', 0);
GO

-- RolePermission
DROP TABLE IF EXISTS  RolePermission;
CREATE TABLE RolePermission (
    iRoleID INT NOT NULL,
    iPermissionID INT NOT NULL,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT,
    siStatus SMALLINT DEFAULT 0,
    PRIMARY KEY (iRoleID, iPermissionID)
);
GO

INSERT INTO RolePermission (iRoleID, iPermissionID, iCreatedBy)
VALUES 
    (1, 1, 0),
    (1, 2, 0),
    (1, 3, 0),
    (1, 4, 0),
    (1, 5, 0),

    (2, 6, 0),
    (2, 7, 0),
    (2, 8, 0),
    (2, 9, 0);
GO


-- SecurityPolicy
DROP TABLE IF EXISTS  SecurityPolicy;
CREATE TABLE SecurityPolicy (
    iPolicyID INT IDENTITY(1, 1) PRIMARY KEY,
    vaPolicyName NVARCHAR(50) NOT NULL,
    iValue NVARCHAR(50) NOT NULL,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT
);
GO

INSERT INTO SecurityPolicy (vaPolicyName, iValue, iCreatedBy)
VALUES 
    ('minPasswordLength', 7, 0),
    ('disableLastPassword', 3, 0),
    ('lockOutPeriod', 30, 0),
    ('failLoginBeforeLock', 4, 0);
GO


-- Lookup
DROP TABLE IF EXISTS  Lookup;
CREATE TABLE Lookup (
    iLookupID INT IDENTITY(1, 1) PRIMARY KEY,
    vaLookupType NVARCHAR(50) NOT NULL,
    vaLookupName NVARCHAR(50) NOT NULL,
    iLookupValue INT NOT NULL
);
GO

INSERT INTO Lookup (vaLookupType, vaLookupName, iLookupValue)
VALUES 
    ('userStatusLookup', 'ACTIVE', 0),
    ('userStatusLookup', 'INACTIVE', 1),
    ('userStatusLookup', 'FIRST_LOGIN', 2),
    ('userStatusLookup', 'LOCKED', 3);
GO


DROP TABLE IF EXISTS  Post;
CREATE TABLE Post (
    iPostID INT IDENTITY(1, 1) PRIMARY KEY,
    vaTitle NVARCHAR(255) NOT NULL,
    vaContent TEXT NOT NULL,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT,
    siStatus SMALLINT DEFAULT 0
);
GO

INSERT INTO Post (vaTitle, vaContent, siStatus, iCreatedBy)
VALUES 
    ('First Post', 'lorem ipsum lalalalal lorem ipsum lalalalal lorem ipsum lalalalal lorem ipsum lalalalal', 0, 2),
    ('Second Post', 'lorem ipsum lalalalal lorem ipsum lalalalal lorem ipsum lalalalal lorem ipsum lalalalal', 0, 3);
GO


DROP TABLE IF EXISTS  Comment;
CREATE TABLE Comment (
    iCommentID INT IDENTITY(1, 1) PRIMARY KEY,
    iPostID INT NOT NULL,
    vaComment NVARCHAR(MAX) NOT NULL,
    siStatus SMALLINT DEFAULT 0 NOT NULL,
    dtCreatedOn DATETIME DEFAULT GETDATE() NOT NULL,
    iCreatedBy INT NOT NULL,
    dtModifiedOn DATETIME,
    iModifiedBy INT
);

INSERT INTO Comment (iPostID, vaComment, iCreatedBy)
VALUES 
    (1, 'First to comment. Lorem ipsum dolor, sit amet consectetur adipisicing elit. Repudiandae earum quae eaque praesentium reprehenderit ex, magni architecto quas. Neque explicabo nesciunt eum, cumque dicta rem vel consequuntur incidunt repudiandae numquam!', 2),
    (1, 'Second to comment. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi reiciendis, consectetur maxime sint distinctio hic vel deserunt excepturi qui laborum rerum fugiat officiis dolorem. Vitae cumque ipsam id veritatis tempora.', 3),
    (2, 'First to comment. Lorem ipsum dolor sit amet consectetur, adipisicing elit. Nobis nostrum eos, neque voluptatum at sed eius doloribus assumenda blanditiis atque magnam natus sequi consectetur inventore aliquam voluptatem exercitationem repellendus harum.', 2),
    (2, 'Second to comment. this comment should be in File and Review', 3);
GO