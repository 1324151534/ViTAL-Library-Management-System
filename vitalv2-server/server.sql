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
    ('To Kill a Mockingbird', '978-0061120084', 'Novel', 'Harper Lee', 'http://localhost:5000/covers/to_kill_a_mockingbird.jpg', 'F1-101', 5, 'To Kill a Mockingbird is a novel by Harper Lee published in 1960. It was immediately successful, winning the Pulitzer Prize, and has become a classic of modern American literature.', '1960-07-11'),
    ('1984', '978-0451524935', 'Dystopian Fiction', 'George Orwell', 'http://localhost:5000/covers/1984.jpg', 'F2-213', 3, '1984 is a dystopian novella by George Orwell published in 1949, which follows the life of Winston Smith, a low ranking member of "the Party", who is frustrated by the omnipresent eyes of the party, and its ominous ruler Big Brother.', '1949-06-08'),
    ('The Catcher in the Rye', '978-0316769488', 'Novel', 'J.D. Salinger', 'http://localhost:5000/covers/the_catcher_in_the_rye.jpg', 'F3-304', 7, 'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adults, but is often read by adolescents for its themes of angst, alienation, and as a critique on superficiality in society.', '1951-07-16'),
    ('The Great Gatsby', '978-0743273565', 'Novel', 'F. Scott Fitzgerald', 'http://localhost:5000/covers/the_great_gatsby.jpg', 'F3-554', 10, 'The Great Gatsby is a novel by F. Scott Fitzgerald that follows narrator Nick Carraway''s interactions with mysterious millionaire Jay Gatsby and Gatsby''s obsession with Nick''s cousin, Daisy Buchanan.', '1925-04-10'),
    ('Pride and Prejudice', '978-1503290563', 'Novel', 'Jane Austen', 'http://localhost:5000/covers/pride_and_prejudice.jpg', 'F2-101', 8, 'Pride and Prejudice is a romantic novel by Jane Austen, first published in 1813. The story charts the emotional development of protagonist Elizabeth Bennet, who learns the error of making hasty judgments and comes to appreciate the difference between the superficial and the essential.', '1813-01-28'),
    ('Moby-Dick', '978-1503280786', 'Novel', 'Herman Melville', 'http://localhost:5000/covers/moby_dick.jpg', 'F2-442', 6, 'Moby-Dick; or, The Whale is an 1851 novel by American writer Herman Melville. The book is the sailor Ishmael''s narrative of the obsessive quest of Ahab, captain of the whaling ship Pequod, for revenge on Moby Dick, a giant white sperm whale.', '1851-10-18');

INSERT INTO books (title, isbn, type, author, cover_image, location, quantity, description, published_date)
VALUES
    ('The Hobbit', '978-0618260300', 'Fantasy', 'J.R.R. Tolkien', 'http://localhost:5000/covers/the_hobbit.jpg', 'F2-121', 5, 'The Hobbit follows the journey of the hobbit Bilbo Baggins as he sets out on an unexpected adventure.', '1937-09-21'),
    ('Harry Potter and the Philosopher''s Stone', '978-0747532743', 'Fantasy', 'J.K. Rowling', 'http://localhost:5000/covers/harry_potter_and_the_philosophers_stone.jpg', 'F2-233', 3, 'Harry Potter and the Philosopher''s Stone is the first novel in the Harry Potter series. It follows Harry Potter, a young wizard who discovers his magical heritage.', '1997-06-26'),
    ('The Da Vinci Code', '978-0307474278', 'Mystery', 'Dan Brown', 'http://localhost:5000/covers/the_da_vinci_code.jpg', 'F3-314', 7, 'The Da Vinci Code follows symbologist Robert Langdon and cryptologist Sophie Neveu as they investigate a murder in the Louvre Museum and discover a battle between the Priory of Sion and Opus Dei over the possibility of Jesus having been married to Mary Magdalene.', '2003-03-18'),
    ('The Hunger Games', '978-0439023481', 'Science Fiction', 'Suzanne Collins', 'http://localhost:5000/covers/the_hunger_games.jpg', 'F1-254', 10, 'The Hunger Games is a dystopian novel set in a post-apocalyptic future where the Capitol selects a boy and girl from the twelve districts to fight to the death on live television.', '2008-09-14'),
    ('The Lord of the Rings', '978-0618640157', 'Fantasy', 'J.R.R. Tolkien', 'http://localhost:5000/covers/the_lord_of_the_rings.jpg', 'F3-321', 8, 'The Lord of the Rings is an epic high fantasy novel by J.R.R. Tolkien, set in the world of Middle-earth and follows the quest to destroy the One Ring.', '1954-07-29'),
    ('The Alchemist', '978-0061122415', 'Fantasy', 'Paulo Coelho', 'http://localhost:5000/covers/the_alchemist.jpg', 'F2-242', 6, 'The Alchemist follows a young Andalusian shepherd named Santiago in his journey to Egypt, after having a recurring dream of finding treasure there.', '1988-09-01');

INSERT INTO books (title, isbn, type, author, cover_image, location, quantity, description, published_date)
VALUES
    ('The Picture of Dorian Gray', '978-0141439570', 'Gothic Fiction', 'Oscar Wilde', 'http://localhost:5000/covers/the_picture_of_dorian_gray.jpg', 'F3-141', 5, 'The Picture of Dorian Gray is a Gothic and philosophical novel by Oscar Wilde, first published complete in the July 1890 issue of Lippincott''s Monthly Magazine.', '1890-07-01'),
    ('Brave New World', '978-0060850524', 'Science Fiction', 'Aldous Huxley', 'http://localhost:5000/covers/brave_new_world.jpg', 'F2-253', 3, 'Brave New World is a dystopian novel by English author Aldous Huxley, published in 1932. Largely set in a futuristic World State, whose citizens are environmentally engineered into an intelligence-based social hierarchy.', '1932-01-01'),
    ('Jane Eyre', '978-0141441146', 'Gothic Fiction', 'Charlotte Brontë', 'http://localhost:5000/covers/jane_eyre.jpg', 'F2-344', 7, 'Jane Eyre is a novel by English writer Charlotte Brontë, published under the pen name "Currer Bell", on 16 October 1847.', '1847-10-16'),
    ('The Road', '978-0307387899', 'Post-Apocalyptic Fiction', 'Cormac McCarthy', 'http://localhost:5000/covers/the_road.jpg', 'F5-554', 10, 'The Road is a 2006 post-apocalyptic novel by American writer Cormac McCarthy. The book details the journey of a father and his young son over a period of several months across a landscape blasted by an unspecified cataclysm.', '2006-09-26'),
    ('Frankenstein', '978-0486282114', 'Gothic Fiction', 'Mary Shelley', 'http://localhost:5000/covers/frankenstein.jpg', 'F3-121', 8, 'Frankenstein; or, The Modern Prometheus is a novel written by English author Mary Shelley, published in 1818.', '1818-01-01'),
    ('The Road Less Traveled', '978-0743243155', 'Psychology', 'M. Scott Peck', 'http://localhost:5000/covers/the_road_less_traveled.jpg', 'F1-442', 6, 'The Road Less Traveled: A New Psychology of Love, Traditional Values and Spiritual Growth is a self-help book written by psychiatrist M. Scott Peck, first published in 1978.', '1978-01-01');
