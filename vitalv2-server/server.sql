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

INSERT INTO books (title, isbn, type, author, cover_image, location, quantity, description, published_date)
VALUES
    ('The Adventures of Huckleberry Finn', '978-0142437179', 'Novel', 'Mark Twain', 'http://localhost:5000/covers/the_adventures_of_huckleberry_finn.jpg', 'F1-103', 5, 'The Adventures of Huckleberry Finn is a novel by Mark Twain, first published in the United Kingdom in December 1884 and in the United States in February 1885.', '1885-02-18'),
    ('The War of the Worlds', '978-1503295674', 'Science Fiction', 'H.G. Wells', 'http://localhost:5000/covers/the_war_of_the_worlds.jpg', 'F2-216', 3, 'The War of the Worlds is a science fiction novel by English author H. G. Wells, first serialized in 1897 by Pearson''s Magazine in the UK and by Cosmopolitan magazine in the US.', '1898-01-01'),
    ('Dracula', '978-1593080050', 'Gothic Fiction', 'Bram Stoker', 'http://localhost:5000/covers/dracula.jpg', 'F3-307', 7, 'Dracula is an 1897 Gothic horror novel by Irish author Bram Stoker. It introduced the character of Count Dracula and established many conventions of subsequent vampire fantasy.', '1897-05-26'),
    ('The Time Machine', '978-0486284729', 'Science Fiction', 'H.G. Wells', 'http://localhost:5000/covers/the_time_machine.jpg', 'F3-557', 10, 'The Time Machine is a science fiction novella by H. G. Wells, published in 1895 and written as a frame narrative. The work is generally credited with the popularization of the concept of time travel by using a vehicle or device to travel purposely and selectively forward or backward through time.', '1895-05-07'),
    ('The Adventures of Sherlock Holmes', '978-0486415871', 'Mystery', 'Arthur Conan Doyle', 'http://localhost:5000/covers/the_adventures_of_sherlock_holmes.jpg', 'F2-104', 8, 'The Adventures of Sherlock Holmes is a collection of twelve short stories by Arthur Conan Doyle, featuring his fictional detective Sherlock Holmes. It was first published on 14 October 1892.', '1892-10-14'),
    ('Alice''s Adventures in Wonderland', '978-0486275437', 'Fantasy', 'Lewis Carroll', 'http://localhost:5000/covers/alices_adventures_in_wonderland.jpg', 'F2-445', 6, 'Alice''s Adventures in Wonderland is an 1865 novel by Lewis Carroll, a work of children''s literature. It tells the story of a young girl named Alice who falls through a rabbit hole into a subterranean fantasy world populated by peculiar, anthropomorphic creatures.', '1865-11-26');

INSERT INTO books (title, isbn, type, author, cover_image, location, quantity, description, published_date)
VALUES
    ('The Scarlet Letter', '978-0393927733', 'Novel', 'Nathaniel Hawthorne', 'http://localhost:5000/covers/the_scarlet_letter.jpeg', 'F1-104', 5, 'The Scarlet Letter: A Romance is a work of historical fiction by American author Nathaniel Hawthorne, published in 1850. Set in Puritan Massachusetts Bay Colony during the years 1642 to 1649, it tells the story of Hester Prynne, who conceives a daughter through an affair and struggles to create a new life of repentance and dignity.', '1850-03-16'),
    ('Don Quixote', '978-0060934347', 'Novel', 'Miguel de Cervantes', 'http://localhost:5000/covers/don_quixote.jpg', 'F3-308', 7, 'Don Quixote is a Spanish novel by Miguel de Cervantes. Published in two parts, in 1605 and 1615, Don Quixote is considered the most influential work of literature from the Spanish Golden Age and the entire Spanish literary canon.', '1605-01-16'),
    ('War and Peace', '978-0143039990', 'Historical Fiction', 'Leo Tolstoy', 'http://localhost:5000/covers/war_and_peace.png', 'F3-558', 10, 'War and Peace is a novel by the Russian author Leo Tolstoy, first published serially, then published in its entirety in 1869. It is regarded as one of Tolstoy''s finest literary achievements.', '1869-01-01'),
    ('Les Misérables', '978-0140444308', 'Historical Fiction', 'Victor Hugo', 'http://localhost:5000/covers/les_miserables.jpg', 'F2-105', 8, 'Les Misérables is a French historical novel by Victor Hugo, first published in 1862, that is considered one of the greatest novels of the 19th century.', '1862-01-01'),
    ('The Divine Comedy', '978-0451208637', 'Epic Poetry', 'Dante Alighieri', 'http://localhost:5000/covers/the_divine_comedy.jpg', 'F2-446', 6, 'The Divine Comedy is a long Italian narrative poem by Dante Alighieri, begun c. 1308 and completed in 1320, a year before his death in 1321. It is widely considered to be the preeminent work in Italian literature and one of the greatest works of world literature.', '1320-01-01');

CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE shopping_cart (
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    PRIMARY KEY (user_id, book_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- 创建 reservations 表
CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- 确保 reservation_date 在插入时自动填充当前时间
CREATE OR REPLACE FUNCTION set_reservation_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.reservation_date = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_reservations
BEFORE INSERT ON reservations
FOR EACH ROW
EXECUTE FUNCTION set_reservation_date();
