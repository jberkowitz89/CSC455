import sqlite3
import os.path

print('''This python script (movies.py) will be used for creating the 3NF database movies.db. The following output will describe the 
    actions that the script is running in order to create the database, as well as some analysis regarding the queries used to analyze the
    database. Functions which create and populate the tables within the database are defined at the start of the script.
After the database is created, we then call these functions to create and populate these tables.
Then, once the tables are populated, queries are run to analyze the database.''')

def createAndPopulateAgeTable(conn):
    #Creates the age table, inserts the table values into the age table
    cursor = conn.cursor()
    query = "CREATE TABLE Age ("
    query += "AgeCode INT NOT NULL PRIMARY KEY ASC,"
    query += "Description VARCHAR(15) NOT NULL)" 
    cursor.execute(query)
    
    cursor.execute("INSERT INTO Age VALUES (1,'Under 18')")
    cursor.execute("INSERT INTO Age VALUES (18,'18-24')")
    cursor.execute("INSERT INTO Age VALUES (25,'25-34')")
    cursor.execute("INSERT INTO Age VALUES (35,'35-44')")
    cursor.execute("INSERT INTO Age VALUES (45,'45-49')")
    cursor.execute("INSERT INTO Age VALUES (50,'50-55')")
    cursor.execute("INSERT INTO Age VALUES (56,'56+')")
    conn.commit()

def createAndPopulateOccupationTable(conn):
    #Creates the Occupation table, inserts the values into the occupation table
    cursor = conn.cursor()
    query = "CREATE TABLE Occupation ("
    query += "OccupationId INT NOT NULL PRIMARY KEY ASC,"
    query += "Description VARCHAR(50) NOT NULL)" 
    cursor.execute(query)

    cursor.execute("INSERT INTO Occupation VALUES(0,'other')")
    cursor.execute("INSERT INTO Occupation VALUES(1,'academic/educator')")
    cursor.execute("INSERT INTO Occupation VALUES(2,'artist')")
    cursor.execute("INSERT INTO Occupation VALUES(3,'clerical/admin')")
    cursor.execute("INSERT INTO Occupation VALUES(4,'college/grad student')")
    cursor.execute("INSERT INTO Occupation VALUES(5,'customer service')")
    cursor.execute("INSERT INTO Occupation VALUES(6,'doctor/health care')")
    cursor.execute("INSERT INTO Occupation VALUES(7,'executive/managerial')")
    cursor.execute("INSERT INTO Occupation VALUES(8,'farmer')")
    cursor.execute("INSERT INTO Occupation VALUES(9,'homemaker')")
    cursor.execute("INSERT INTO Occupation VALUES(10,'K-12 student')")
    cursor.execute("INSERT INTO Occupation VALUES(11,'lawyer')")
    cursor.execute("INSERT INTO Occupation VALUES(12,'programmer')")
    cursor.execute("INSERT INTO Occupation VALUES(13,'retired')")
    cursor.execute("INSERT INTO Occupation VALUES(14,'sales/marketing')")
    cursor.execute("INSERT INTO Occupation VALUES(15,'scientist')")
    cursor.execute("INSERT INTO Occupation VALUES(16,'self-employed')")
    cursor.execute("INSERT INTO Occupation VALUES(17,'technician/engineer')")
    cursor.execute("INSERT INTO Occupation VALUES(18,'tradesman/craftsman')")
    cursor.execute("INSERT INTO Occupation VALUES(19,'unemployed')")
    cursor.execute("INSERT INTO Occupation VALUES(20,'writer')")

    conn.commit()

def createTables(conn):
    #Creates the Category table
    cursor = conn.cursor()
    query = "CREATE TABLE Category ("
    query += "CategoryId INT NOT NULL PRIMARY KEY ASC,"
    query += "Description VARCHAR(50) NOT NULL)" 
    cursor.execute(query)
    #Creates the Movies table
    cursor = conn.cursor()
    query = "CREATE TABLE Movies ("
    query += "MovieId INT NOT NULL PRIMARY KEY ASC,"
    query += "MovieTitle VARCHAR(500) NOT NULL," 
    query += "Year CHAR(4) NOT NULL)" 
    cursor.execute(query)
    #Creates the movie-category table
    cursor = conn.cursor()
    query = "CREATE TABLE [Movie-Category] ("
    query += "MovieId INT NOT NULL,"
    query += "CategoryId INT NOT NULL,"
    query += "PRIMARY KEY (MovieId,CategoryId),"
    query += "FOREIGN KEY (MovieId) REFERENCES Movies(MovieId),"
    query += "FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId))"
    cursor.execute(query)
    #Creates the Users table
    cursor = conn.cursor()
    query = "CREATE TABLE Users ("
    query += "UserId INT NOT NULL PRIMARY KEY ASC,"
    query += "Gender CHAR(1) NOT NULL CHECK (Gender = 'M' or Gender = 'F')," 
    query += "AgeCode INT NOT NULL," 
    query += "OccupationId INT NOT NULL,"
    query += "ZipCode CHAR(10) NOT NULL,"
    query += "FOREIGN KEY (AgeCode) REFERENCES Age(AgeCode)," 
    query += "FOREIGN KEY (OccupationId) REFERENCES Occupation(OccupationId))" 
    cursor.execute(query)
    #Creates the Ratings table
    cursor = conn.cursor()
    query = "CREATE TABLE Ratings ("
    query += "UserId INT NOT NULL,"
    query += "MovieId INT NOT NULL,"
    query += "Rating INT NOT NULL,"
    query += "Timestamp DATETIME NOT NULL,"
    query += "FOREIGN KEY (UserId) REFERENCES Users(UserId)," 
    query += "FOREIGN KEY (MovieId) REFERENCES Movies(MovieId)"
    query += "PRIMARY KEY (UserId,MovieId))"
    cursor.execute(query)

def insertUsers(conn):
    #inserts values into the Users table
    file = open('users.dat','r')
    cursor = conn.cursor()
    for line in file:
        splitLine = line.strip().split("::")
        cursor.execute("INSERT INTO Users VALUES (?,?,?,?,?)",splitLine)
    conn.commit()

def insertMovies(conn):
    #inserts values into the Movies table
    file = open('movies.dat','r')
    cursor = conn.cursor()
    categoryIdSeq = 1
    for line in file:
        splitLine = line.strip().split("::")
        movieID = splitLine[0]
        movieTitleAndMovieYear = splitLine[1]
        categories = splitLine[2]
        (title, year) = splitTitleAndYear(movieTitleAndMovieYear)
        
        cursor.execute("insert into movies values (?,?,?)", [movieID, title, year])
        
        splitCategories = categories.strip().split("|")
        for category in splitCategories:
            cursor.execute("select categoryId from category where description = ?", [category])
            data = cursor.fetchone()
            if data:
                categoryID = data[0]
            else:
                #inserts values into Category table
                cursor.execute("insert into category values (?,?)", [categoryIdSeq, category])
                categoryID = categoryIdSeq
                categoryIdSeq += 1
            
            cursor.execute("insert into [movie-category] values (?,?)", [movieID, categoryID])
            #inserts values into Movie-Category table
    conn.commit()
    
def insertRatings(conn):
    #inserts values into Ratings table
    file = open('ratings.dat','r')
    cursor = conn.cursor()
    for line in file:
        splitLine = line.strip().split("::")
        cursor.execute("insert into ratings values (?,?,?,?)", splitLine)
    conn.commit()
        
def setupDatabase():
    databaseFilename = 'movies.db'
    createDatabase = not os.path.isfile(databaseFilename)

    #create a connection to database (file movies.db)
    #if movies.db does not exists it gets created
    conn = sqlite3.connect(databaseFilename)

    if createDatabase == True:
        print ('''Database movies.db is created''')
        #create tables
        print('''Below, I will be detailing how I created the tables and passed the database     information into these tables.''')
        createAndPopulateAgeTable(conn)
        print("Create Age Table, 7 rows inserted")
        createAndPopulateOccupationTable(conn)
        print("Create Occupation Table, 21 rows inserted")
        createTables(conn)
        print('''For the following 5 tables, existing .dat files are parsed, and then inserted into the tables. This makes inserting these values different from the Age and Occupation tables.
At this stage, we are simply creating the tables, and not yet parsing in the data from the .dat files.''')
        print("Create Category Table")
        print("Create Movies Table")
        print("Create Movie-Category Table")
        print("Create Users Table")
        print("Create Ratings Table")

#Splits out the movie title and the movie year, using the '(' separator   

        #parse the files and insert the data into the tables
        insertUsers(conn)
        print('''In order to insert data into Users table, we must split apart the users.dat file
        by the separator '::'. This takes place using the insertUsers function in the script
        We split the data into a list, and then insert the values from the list
        into the Users table. 6040 rows are inserted.''')
    
        
        insertMovies(conn)
        print('''The insertMovies function in the script actually performs 3 different operations.
        First, we parse the movie ID, title and year (which are split apart using the splitTitleAndYear function) from movies.dat into the Movies table. 3883 rows are inserted. Next, we split apart the categories, which are found in the movies.dat file. The function will populate the categories table by assigning each category a number ID, beginning with 1. Then, for each line in the movies table, it checks to see if the category number already exists in the category table. If it does, it moves to the next line, and if not, it creates a new categoryID and description. 18 rows are inserted. Last, we create a movie-category table. The movie category matches each movieID with its corresponding categories in the movies.dat file. Since a movie may have multiple categories, this part of the function will create a new row for each movie-category record. 6408 rows are inserted.''')
        insertRatings(conn)
        print('''The insertRatings function uses the ratings takes data from the ratings.dat
        file and parses it into the Ratings table. We split the data into a list based on the
        "::" separator, and then insert the values from the list into the Ratings table. 
        1000209 rows are inserted.''' )
    #run queries

def splitTitleAndYear(movieTitleAndMovieYear):
        splitByParenthesis = movieTitleAndMovieYear.split("(")
        title = "(".join(splitByParenthesis[0:len(splitByParenthesis)-1])
        year = splitByParenthesis[len(splitByParenthesis)-1].replace(")","").strip()
    
        return (title, year)

def executeAndDisplayQuery(conn,query):
    cursor = conn.cursor()
    cursor.execute(query)
    
    rows = cursor.fetchall()

    for row in rows:
        print(row)
    
    
if __name__ == '__main__':
    try:
        os.remove('movies.db')
    except OSError:
        print ("movies.db does not exists")


    setupDatabase()
    
    
    databaseFilename = 'movies.db'
    conn = sqlite3.connect(databaseFilename)
    
    print('''Below are the queries I'm running to analyze my database. To view the results of the
    queries, un-comment out the 'executeAndDisplayQuery' commands.''')
    
    print("Count of movies per category ordered by count descending")
    query = "select category.Description, count(1) "
    query += "from movies join [movie-category] mc on movies.MovieId = mc.movieID join category on category.CategoryId = mc.categoryId "
    query += "group by category.CategoryId, category.Description order by count(1) desc;"
    #executeAndDisplayQuery(conn,query)
    
    print ("Comedies from the 90s ordered by average rating")
    #executeAndDisplayQuery(conn,"select MovieTitle,avg(rating) from movies join ratings on movies.MovieId = ratings.MovieId join [movie-category] mc on movies.MovieId = mc.movieID join category on category.CategoryId = mc.categoryId where movies.Year between '1990' and '1999' and category.Description = 'Comedy' group by  movies.MovieId,movies.MovieTitle order by avg(rating) desc;")
    
    print("Highest Rated movies in the database")   
    #executeAndDisplayQuery(conn,"select MovieTitle,avg(rating) from movies join ratings on movies.MovieId = ratings.MovieId group by  movies.MovieId,movies.MovieTitle order by avg(rating) desc;")
