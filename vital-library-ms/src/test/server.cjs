const express = require('express');
const app = express();
const PORT = 3000;

// 示例书籍数据
const books = [
  { id: 1, title: 'Book 1' },
  { id: 2, title: 'Book 2' },
  { id: 3, title: 'Book 3' }
];

// 处理查询请求
app.get('/books', (req, res) => {
  const query = req.query.q;
  // 如果没有查询参数，则返回所有书籍
  if (!query) {
    return res.json(books);
  }
  // 模拟简单的搜索功能，返回包含查询关键字的书籍
  const results = books.filter(book => book.title.toLowerCase().includes(query.toLowerCase()));
  res.json(results);
});

// 启动服务
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
