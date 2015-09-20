#README

Obsidian Web is a web application designed to record the data of a text book
library of a secondary school.

This repo holds the JSON-API compliant backend.

##Models
All model names, as well as attribute/relationship/link/etc. names, are supposed to be dasherised,
i.e. `baseSet` is accessed via the url `/base-sets`.
###School
- `name` (String) is the school's login name (and is case-insensitive)
- `encrypted-password` (String) holds the hashed password

When creating a school, only `name` and `password` should be provided. The password is automatically encrypted
and stored in `encrypted_password`.

###Student
- `name` (String) is the student's name (big surprise)
- `graduation_year` (Integer) and `class_letter` (Character) are used to determine a student's class (the form changes every year, the graduation year usually not)
- `school` (Relationship) is the id of the student's school

###Teacher
- `name` (String)
- `school` (Relationship)

###Book
- `title` (String) is the book's title (the only thing that will be displayed)
- `isbn` (String) holds the 13-character-long isbn of the book (mutable!!)
- `form` (String) contains the book's form(s) separated by whitespace (will not be displayed)
- `school` (Relationship)

Note that each book record is associated uniquely with a school. That way, a record acts more like
"Latin 7th class" instead of "Prima B 2 with the isbn xy" so that schools can replace books without having
to scan every single book they give out and take back.

###Alias
- `name` (String)
- `book` (Relationship)

Aliases are an easy way to enter books whose isbn you don't know by heart. Just set an alias "d8" for the
8th class's German book and you can just enter "d8" instead of the long isbn.

###BaseSet
- `student` (Relationship)
- `book` (Relationship)
- `created-at` (DateTime)

`BaseSet`s are lendings that occur at the end and beginning of term to provide students with their books they
usually use. More rigorously: `BaseSet`s are all the lendings that cause school reports to be withheld. A student
can only have one instance of a book as `BaseSet` at a time.

###Lendings
- `person` (Polymorphic relationship to either `Student` or `Teacher`)
- `book` (Relationship)
- `created-at` (DateTime)

`Lending`s are all other lendings (e.g. "Ferienausleihen") that do *not* cause school reports to be withheld.
`Lending`s can be made by either students or teachers (hence the polymorphic relationship) and are, contrary 
to `BaseSet`s, not necessarily unique. That is, a teacher (or student) can lend 20 copies of
"Lambacher Schweizer 10".

##Authentication
You can authenticate with the following request:

```http
POST /schools/sign_in HTTP/1.1
Content-Type: application/json
Accept: application/json

{
	"name": "[the school's name]",
	"password": "[the school's password]"
}
```

If name and password match, the server will respond with

```http
HTTP/1.1 201 CREATED
Content-Type: application/json

{
	"token": "[secret token]",
	"secret_id": "[secret id]"
}
```

The secret token along with its id has to be included in every request's `Authorization` header like this:

```http
Authorization: Token token=[secret token] secret_id=[secret id]
```

This way, the API can ensure, that only authorised users may access data.

Note that all tokens older than a day will be automatically deleted so that a session may last at most
a day.
