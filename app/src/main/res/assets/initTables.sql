/*******************************************
*************** PREPARATION ****************
*******************************************/

-- SET FOREIGN KEYS ON
PRAGMA foreign_keys = "ON";

-- DROP TABLE
DROP TABLE IF EXISTS NOTES;
DROP TABLE IF EXISTS REMINDER;
DROP TABLE IF EXISTS BOOKMARKS;
DROP TABLE IF EXISTS USER;
DROP TABLE IF EXISTS CATEGORY;
DROP TABLE IF EXISTS NOTES_LINK;

/**********************************************
**************** CREATE TABLES ****************
**********************************************/
CREATE TABLE NOTES(
  NOTE_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  HEADING TEXT NOT NULL,
  CONTENT TEXT NULL,
  DATE_CREATED DATETIME NOT NULL DEFAULT (DATETIME('now', 'localtime')),
  DATE_LAST_UPDATED DATETIME NULL,
  DATE_DELETED DATETIME NULL,
  USER_ID INTEGER NOT NULL,
  CATEGORY_ID INTEGER NULL,
  VISIBLE BOOLEAN NOT NULL,
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE,
  FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
);-- INIT NOTE TABLE WITHOUT CONSTRAINTS

CREATE TABLE REMINDER(
  REMINDER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  HEADING TEXT NOT NULL,
  CONTENT TEXT NULL,
  DATE_CREATED DATETIME NOT NULL DEFAULT (DATETIME('now', 'localtime')),
  DATE_LAST_UPDATED DATETIME NULL,
  DATE_DELETED DATETIME NULL,
  USER_ID INTEGER NOT NULL,
  CATEGORY_ID INTEGER NULL,
  NOTES_LINK_ID INTEGER NULL,
  VISIBLE BOOLEAN NOT NULL,
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE,
  FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID),
  FOREIGN KEY (NOTES_LINK_ID) REFERENCES NOTES_LINK(NOTES_LINK_ID)
);-- INIT REMINDER TABLE

CREATE TABLE BOOKMARKS(
  BOOKMARK_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  HEADING TEXT NOT NULL,
  CONTENT TEXT NULL,
  DATE_CREATED DATETIME NOT NULL DEFAULT (DATETIME('now', 'localtime')),
  DATE_LAST_UPDATED DATETIME NULL,
  DATE_DELETED DATETIME NULL,
  USER_ID INTEGER NOT NULL,
  CATEGORY_ID INTEGER NULL,
  VISIBLE BOOLEAN NOT NULL,
  FOREIGN KEY (USER_ID) REFERENCES USER(USER_ID) ON DELETE CASCADE,
  FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID)
);-- INIT BOOKMARKS TABLE

CREATE TABLE USER(
    USER_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    FULLNAME TEXT NOT NULL,
    EMAIL TEXT NOT NULL,
    PROFILE_PICTURE NULL,
    DATE_CREATED DATETIME NOT NULL DEFAULT (DATETIME('now', 'localtime')),
    DATE_LAST_UPDATED DATETIME NULL,
    DATE_DELETED NULL
);-- INIT TABLE USER

CREATE TABLE CATEGORY(
    CATEGORY_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NAME TEXT NOT NULL,
    HEX_COLOR TEXT NULL DEFAULT '#000000',
    IMPORTANCE INTEGER NOT NULL DEFAULT 0
);-- INIT TABLE CATEGORY
-- 0=default 1=info 2=warning 3=critical

CREATE TABLE NOTES_LINK(
    NOTES_LINK_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    REMINDER_ID INTEGER NOT NULL,
    NOTE_ID INTEGER NOT NULL,
    FOREIGN KEY(REMINDER_ID) REFERENCES REMINDER(REMINDER_ID),
    FOREIGN KEY(NOTE_ID) REFERENCES NOTES(NOTE_ID)
);-- INIT NOTE_LINK TABLE
