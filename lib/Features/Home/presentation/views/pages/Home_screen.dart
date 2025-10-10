import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../core/utils/shimmer_generator.dart';

// ==================== Models ====================
class Book {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String genre;
  final int year;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.genre,
    required this.year,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Title',
      author: json['author'] ?? 'Unknown Author',
      coverUrl: json['cover_url'] ?? 'https://picsum.photos/seed/${json['id']}/200/300',
      genre: json['genre'] ?? 'General',
      year: json['publication_year'] ?? 2024,
    );
  }
}

// ==================== API Service ====================
class BooksApiService {
  // Free Fake API - https://fakerapi.it/
  static const String baseUrl = 'https://fakerapi.it/api/v1/books';
  
  static Future<List<Book>> fetchBooks({int quantity = 20}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?_quantity=$quantity'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['data'] as List? ?? [];
        return items.map((json) => Book.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }
}

// ==================== Home Screen ====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> allBooks = [];
  List<Book> displayedBooks = [];
  bool isLoading = true;
  String selectedCategory = 'All';
  
  final List<String> categories = [
    'All',
    'Fiction',
    'Science',
    'History',
    'Technology',
    'Business',
    'Art',
  ];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    setState(() => isLoading = true);
    
    // محاكاة network delay عشان نشوف الـ shimmer بوضوح
    await Future.delayed(Duration(seconds: 2));
    
    final books = await BooksApiService.fetchBooks(quantity: 20);
    
    setState(() {
      allBooks = books;
      displayedBooks = books;
      isLoading = false;
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        displayedBooks = allBooks;
      } else {
        displayedBooks = allBooks
            .where((book) => book.genre.toLowerCase().contains(category.toLowerCase()))
            .toList();
        // لو مفيش نتائج، نعرض الكل
        if (displayedBooks.isEmpty) {
          displayedBooks = allBooks;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Color(0xFF6C63FF),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '📚 Book Store',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search, size: 28, color: Colors.white),
                onPressed: () => _showSearchDialog(),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, size: 28, color: Colors.white),
                onPressed: () {},
              ),
              SizedBox(width: 8),
            ],
          ),

          // Categories with Smart Shimmer
          SliverToBoxAdapter(
            child: isLoading
                ? _buildCategoriesShimmer()
                : _buildCategories(),
          ),

          // Books Grid with Smart Shimmer Generator
          if (isLoading)
            SliverFillRemaining(
              child: SmartShimmerGenerator.fromLayout(ShimmerLayout.grid),
            )
          else if (displayedBooks.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      'No books found',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => selectedCategory = 'All'),
                      icon: Icon(Icons.refresh),
                      label: Text('Show All Books'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6C63FF),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final book = displayedBooks[index];
                    return _BookCard(book: book);
                  },
                  childCount: displayedBooks.length,
                ),
              ),
            ),
        ],
      ),
      
      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loadBooks,
        backgroundColor: Color(0xFF6C63FF),
        icon: Icon(Icons.refresh, color: Colors.white),
        label: Text('Refresh', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // Categories Shimmer باستخدام Extension
  Widget _buildCategoriesShimmer() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 12),
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
          ).toShimmer(); // 🌟 استخدام Extension
        },
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          
          return GestureDetector(
            onTap: () => _filterByCategory(category),
            child: Container(
              margin: EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF6C63FF) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF6C63FF)),
            SizedBox(width: 8),
            Text('Search Books'),
          ],
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter book name or author...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF6C63FF), width: 2),
            ),
          ),
          onSubmitted: (query) {
            Navigator.pop(context);
            setState(() {
              if (query.trim().isEmpty) {
                displayedBooks = allBooks;
              } else {
                displayedBooks = allBooks
                    .where((book) =>
                        book.title.toLowerCase().contains(query.toLowerCase()) ||
                        book.author.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              }
              selectedCategory = 'All';
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Color(0xFF6C63FF))),
          ),
        ],
      ),
    );
  }
}

// ==================== Book Card Widget ====================
class _BookCard extends StatelessWidget {
  final Book book;

  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBookDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  book.coverUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Color(0xFF6C63FF).withOpacity(0.1),
                      child: Icon(
                        Icons.book,
                        size: 50,
                        color: Color(0xFF6C63FF),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    // 🌟 استخدام toShimmer Extension للصور
                    return Container(
                      color: Colors.grey[300],
                    ).toShimmer();
                  },
                ),
              ),
            ),
            
            // Book Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    
                    // Author
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Genre & Year
                    Row(
                      children: [
                        Icon(Icons.category, size: 14, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            book.genre,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFF6C63FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${book.year}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover & Basic Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'book_${book.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              book.coverUrl,
                              width: 120,
                              height: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 120,
                                  height: 180,
                                  color: Color(0xFF6C63FF).withOpacity(0.1),
                                  child: Icon(Icons.book, size: 50),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                book.author,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Color(0xFF6C63FF).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  book.genre,
                                  style: TextStyle(
                                    color: Color(0xFF6C63FF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Details
                    _DetailRow(
                      icon: Icons.calendar_today,
                      label: 'Published',
                      value: '${book.year}',
                    ),
                    _DetailRow(
                      icon: Icons.numbers,
                      label: 'Book ID',
                      value: '#${book.id}',
                    ),
                    _DetailRow(
                      icon: Icons.category_outlined,
                      label: 'Genre',
                      value: book.genre,
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Description Placeholder
                    Text(
                      'About this book',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This is a wonderful book written by ${book.author}. '
                      'Published in ${book.year}, it explores themes in ${book.genre} '
                      'that will captivate readers from start to finish.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.grey[700],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${book.title} added to cart! 🛒'),
                                  backgroundColor: Color(0xFF6C63FF),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.shopping_cart),
                            label: Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6C63FF),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added to favorites! ❤️'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: Icon(Icons.favorite_border),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            padding: EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF6C63FF), size: 20),
          SizedBox(width: 12),
          Text(
            '$label:',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 15,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}