from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS  # 导入 CORS
import random

app = Flask(__name__)

# 更新为 PostgreSQL 的连接字符串
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:123456@localhost/Bookroom'
db = SQLAlchemy(app)

# 数据模型定义
class Book(db.Model):
    __tablename__ = 'books'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    author = db.Column(db.String(255), nullable=False)
    isbn = db.Column(db.String(20), unique=True)
    publication_year = db.Column(db.Integer)
    publisher = db.Column(db.String(255))
    genre = db.Column(db.String(100))
    description = db.Column(db.Text)
    language = db.Column(db.String(50))
    available = db.Column(db.Boolean, default=True)

# API路由
@app.route('/books', methods=['GET'])
def get_books():
    # 获取请求中的查询参数
    query = request.args.get('q', '')

    # 在数据库中查找匹配的书籍
    books = Book.query.filter(
        (db.func.lower(Book.title).like(f'%{query}%')) |
        (db.func.lower(Book.author).like(f'%{query}%')) |
        (db.func.lower(Book.isbn).like(f'%{query}%')) |
        (db.func.lower(Book.publisher).like(f'%{query}%')) |
        (db.func.lower(Book.genre).like(f'%{query}%')) |
        (db.func.lower(Book.description).like(f'%{query}%')) |
        (db.func.lower(Book.language).like(f'%{query}%'))
    ).all()

    # 返回匹配的书籍
    return jsonify([{'id': book.id, 'title': book.title, 'author': book.author, 'isbn': book.isbn} for book in books])

@app.route('/books/<int:book_id>', methods=['GET'])
def get_book(book_id):
    book = Book.query.get(book_id)
    if not book:
        return jsonify({'error': 'Book not found'}), 404
    return jsonify({'id': book.id, 'title': book.title, 'author': book.author, 'isbn': book.isbn, 'available':book.available, 'publication_year':book.publication_year, 'publisher':book.publisher, 'genre':book.genre, 'description':book.description, 'language':book.language})

@app.route('/books', methods=['POST'])
def add_book():
    data = request.get_json()
    new_book = Book(
        title=data['title'],
        author=data['author'],
        isbn=data['isbn'],
        publication_year=data['publication_year'],
        publisher=data['publisher'],
        genre=data['genre'],
        description=data['description'],
        language=data['language'],
        available=data.get('available', True)  # 默认值为 True
    )
    db.session.add(new_book)
    db.session.commit()
    return jsonify({'id': new_book.id, 'title': new_book.title}), 201


@app.route('/books/<int:book_id>', methods=['PUT'])
def update_book(book_id):
    book = Book.query.get(book_id)
    if book is None:
        return jsonify({'error': 'Book not found'}), 404

    # 打印收到的数据
    print("Received data:", request.json)

    data = request.get_json()
    book.title = data['title']
    book.author = data['author']
    book.isbn = data['isbn']
    book.publication_year = data['publication_year']
    book.publisher = data['publisher']
    book.genre = data['genre']
    book.description = data['description']
    book.language = data['language']
    book.available = data.get('available', True)
    db.session.commit()
    return jsonify({'message': 'Book updated successfully'}), 200

@app.route('/books/<int:book_id>', methods=['DELETE'])
def delete_book(book_id):
    book = Book.query.get(book_id)
    if book is None:
        return jsonify({'error': 'Book not found'}), 404
    db.session.delete(book)
    db.session.commit()
    return jsonify({'message': 'Book deleted successfully'}), 200

@app.route('/books/<int:book_id>/borrow', methods=['PUT'])
def borrow_book(book_id):
    book = Book.query.get(book_id)
    if not book.available:
        return jsonify({'error': 'Book is not available for borrowing'}), 400
    # 将书籍的 available 状态改为 False
    book.available = False
    db.session.commit()
    return jsonify({'message': 'Book borrowed successfully'}), 200

@app.route('/')
def welcome():
    return jsonify({'message': 'Welcome to the Book Management System!'}), 200

CORS(app, resources={r"/*": {"origins": "*"}})  # 允许所有域名跨域访问
if __name__ == '__main__':
    with app.app_context():
        db.create_all()  # 创建数据表
    app.run(host='0.0.0.0', port=5000, debug=True)
