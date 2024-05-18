CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    type VARCHAR(50),
    author VARCHAR(255),
    cover_image VARCHAR(255),
    location VARCHAR(100),
    quantity INT DEFAULT 1,
    description TEXT,
    published_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION update_books_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER books_updated_at_trigger
BEFORE UPDATE ON books
FOR EACH ROW
EXECUTE FUNCTION update_books_updated_at();

INSERT INTO books (title, isbn, type, author, cover_image, location, quantity, description, published_date)
VALUES
    ('To Kill a Mockingbird', '978-0061120084', 'Novel', 'Harper Lee', 'http://localhost:5000/covers/to_kill_a_mockingbird.jpg', 'Fiction Section', 5, 'To Kill a Mockingbird is a novel by Harper Lee published in 1960. It was immediately successful, winning the Pulitzer Prize, and has become a classic of modern American literature.', '1960-07-11'),
    ('1984', '978-0451524935', 'Dystopian Fiction', 'George Orwell', 'http://localhost:5000/covers/1984.jpg', 'Classics Section', 3, '1984 is a dystopian novella by George Orwell published in 1949, which follows the life of Winston Smith, a low ranking member of "the Party", who is frustrated by the omnipresent eyes of the party, and its ominous ruler Big Brother.', '1949-06-08'),
    ('The Catcher in the Rye', '978-0316769488', 'Novel', 'J.D. Salinger', 'http://localhost:5000/covers/the_catcher_in_the_rye.jpg', 'Fiction Section', 7, 'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adults, but is often read by adolescents for its themes of angst, alienation, and as a critique on superficiality in society.', '1951-07-16'),
    ('The Great Gatsby', '978-0743273565', 'Novel', 'F. Scott Fitzgerald', '/covers/the_great_gatsby.jpg', 'Classics Section', 10, 'The Great Gatsby is a novel by F. Scott Fitzgerald that follows narrator Nick Carraway''s interactions with mysterious millionaire Jay Gatsby and Gatsby''s obsession with Nick''s cousin, Daisy Buchanan.', '1925-04-10'),
    ('Pride and Prejudice', '978-1503290563', 'Novel', 'Jane Austen', '/covers/pride_and_prejudice.jpg', 'Classics Section', 8, 'Pride and Prejudice is a romantic novel by Jane Austen, first published in 1813. The story charts the emotional development of protagonist Elizabeth Bennet, who learns the error of making hasty judgments and comes to appreciate the difference between the superficial and the essential.', '1813-01-28'),
    ('Moby-Dick', '978-1503280786', 'Novel', 'Herman Melville', '/covers/moby_dick.jpg', 'Classics Section', 6, 'Moby-Dick; or, The Whale is an 1851 novel by American writer Herman Melville. The book is the sailor Ishmael''s narrative of the obsessive quest of Ahab, captain of the whaling ship Pequod, for revenge on Moby Dick, a giant white sperm whale.', '1851-10-18');
