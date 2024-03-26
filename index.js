import express from "express";
import bodyParser from "body-parser";
import pg from "pg";
import axios from "axios";

const app = express();
const port = 3000;
const OPEN_LIBRARY_COVERS_API_URL = "https://covers.openlibrary.org/b/isbn/";

const db = new pg.Client({
  user: "postgres",
  host: "localhost",
  password: "AcJEp&H3or3X!n&G?d8r88GM9M@ykFQstF&nLofg",
  database: "book_notes",
  port: 5432,
});

db.connect();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

let books = [];
let filteredBooks = [];

async function fetchCoverImageUrl(isbn) {
  try {
    const apiResponse = await axios.get(
      OPEN_LIBRARY_COVERS_API_URL + isbn + "-L.jpg?default=false"
    );
    return apiResponse.request.res.responseUrl;
  } catch (error) {
    throw error;
  }
}

async function enrichBooksWithCoverImageUrl() {
  const promises = books.map(async (book) => {
    try {
      const imageUrl = await fetchCoverImageUrl(book.isbn);
      book.image_url = imageUrl;
    } catch (error) {
      // Handle the error (e.g., log it or set a default image URL)
      console.error(
        `Error fetching cover image for ISBN ${book.isbn}:`,
        error.message
      );
    }
  });

  await Promise.all(promises);
}

function convertIsoDateToFormattedString(isoDate) {
  const date = new Date(isoDate);
  const year = date.getUTCFullYear();
  const month = String(date.getUTCMonth() + 1).padStart(2, "0"); // Months are 0-indexed
  const day = String(date.getUTCDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
}

async function fetchAllBooks() {
  try {
    const dbResult = await db.query(
      "SELECT books.id, books.title, books.isbn, notes.date_read, notes.summary, notes.notes, notes.rating, authors.name AS author_name FROM books JOIN notes ON books.id = notes.book_id JOIN authors ON books.author_id = authors.id;"
    );
    return dbResult.rows;
  } catch (error) {
    throw error;
  }
}

books = await fetchAllBooks();
await enrichBooksWithCoverImageUrl();
books.map((book) => {
  const formattedDate = convertIsoDateToFormattedString(book.date_read);
  book.date_read = formattedDate;
});

app.get("/", async (req, res) => {
  console.log(books);
  res.render("index.ejs", { books: books });
});

async function fetchBooksBasedOnSearchString(searchString) {
  try {
    const queryText =
      "SELECT books.title, books.isbn, notes.date_read, notes.summary, notes.rating, authors.name " +
      "FROM books " +
      "JOIN notes ON books.id = notes.book_id " +
      "JOIN authors ON books.author_id = authors.id " +
      "WHERE " +
      "books.title ILIKE '%' || $1 || '%' " +
      "OR notes.summary ILIKE '%' || $1 || '%' " +
      "OR authors.name ILIKE '%' || $1 || '%';";
    const dbResult = await db.query(queryText, [searchString]);
    console.log(dbResult.rows);
    return dbResult.rows;
  } catch (error) {
    throw error;
  }
}

app.get("/search", async (req, res) => {
  const searchString = req.query.search_string;

  const searchRegExp = new RegExp(searchString, "i");
  filteredBooks = books.filter((book) => {
    return (
      searchRegExp.test(book.title) ||
      searchRegExp.test(book.summary) ||
      searchRegExp.test(book.author_name)
    );
  });

  res.render("index.ejs", { books: filteredBooks });
});

async function fetchAndSortBooksBasedOnSortColumn(sortColumn) {
  try {
    const queryText =
      "SELECT books.title, books.isbn, notes.date_read, notes.summary, notes.rating, authors.name " +
      "FROM books " +
      "JOIN notes ON books.id = notes.book_id " +
      "JOIN authors ON books.author_id = authors.id " +
      "ORDER BY $1 DESC;";
    const dbResult = await db.query(queryText, [sortColumn]);
    console.log(dbResult.rows);
    return dbResult.rows;
  } catch (error) {
    throw error;
  }
}

app.get("/sort", async (req, res) => {
  const sortBy = req.query.sort_by;
  console.log(sortBy);

  switch (sortBy) {
    case "title":
      books.sort((a, b) => a.title.localeCompare(b.title));
      console.log("Sort by title");
      break;
    case "date_read":
      console.log("Sort by date_read");
      books.sort((a, b) => new Date(a.date_read) - new Date(b.date_read));
      break;
    case "rating":
      console.log("Sort by rating");
      books.sort((a, b) => b.rating - a.rating);
      break;  
    default:
      break;
  }
  // books = await fetchAndSortBooksBasedOnSortColumn(sortColumn);
  // await enrichBooksWithCoverImageUrl();

  // books.map((book) => {
  //   const formattedDate = convertIsoDateToFormattedString(book.date_read);
  //   book.date_read = formattedDate;
  // });

  res.render("index.ejs", { books: books });
});

async function fetchBookBasedOnBookId(bookId) {
  try {
    const queryText =
      "SELECT books.id, books.title, books.isbn, notes.date_read, notes.summary, notes.notes, notes.rating, authors.name " +
      "FROM books " +
      "JOIN notes ON books.id = notes.book_id " +
      "JOIN authors ON books.author_id = authors.id " +
      "WHERE books.id = $1;";
    const dbResult = await db.query(queryText, [bookId]);
    console.log(dbResult.rows);
    return dbResult.rows;
  } catch (error) {
    throw error;
  }
}

app.get("/book/:id", async (req, res) => {
  const bookId = parseInt(req.params.id);
  const filteredBook = books.find((book) => book.id === bookId);

  console.log(filteredBook);

  res.render("book.ejs", { book: filteredBook });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
