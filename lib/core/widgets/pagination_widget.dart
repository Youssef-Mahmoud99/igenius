import 'package:flutter/material.dart';

class PaginationConfig {
  final int initialPage;
  final int pageSize;
  final bool enablePullToRefresh;
  final bool showLoadingIndicator;
  final double scrollThreshold;
  
  const PaginationConfig({
    this.initialPage = 1,
    this.pageSize = 20,
    this.enablePullToRefresh = true,
    this.showLoadingIndicator = true,
    this.scrollThreshold = 200.0,
  });
}

class PaginationResponse<T> {
  final List<T> data;
  final int currentPage;
  final int? totalPages;
  final int? totalItems;
  final bool hasMore;
  
  PaginationResponse({
    required this.data,
    required this.currentPage,
    this.totalPages,
    this.totalItems,
    required this.hasMore,
  });
  
  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dataKey = json.containsKey('data') 
        ? 'data' 
        : json.containsKey('items') 
        ? 'items' 
        : json.containsKey('results')
        ? 'results'
        : 'data';
    
    final List<dynamic> dataList = json[dataKey] ?? [];
    final List<T> items = dataList.map((item) => fromJsonT(item as Map<String, dynamic>)).toList();
    
    final currentPage = json['current_page'] ?? json['page'] ?? json['currentPage'] ?? 1;
    final totalPages = json['total_pages'] ?? json['totalPages'] ?? json['last_page'];
    final totalItems = json['total'] ?? json['totalItems'] ?? json['count'];
    
    final hasMore = json['has_more'] ?? 
                    json['hasMore'] ?? 
                    (totalPages != null ? currentPage < totalPages : items.isNotEmpty);
    
    return PaginationResponse(
      data: items,
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      hasMore: hasMore,
    );
  }
}

typedef PaginationFetcher<T> = Future<PaginationResponse<T>> Function(int page, int pageSize);
typedef ItemBuilder<T> = Widget Function(BuildContext context, T item, int index);
typedef ErrorBuilder = Widget Function(BuildContext context, String error, VoidCallback retry);
typedef EmptyBuilder = Widget Function(BuildContext context);
typedef LoadingBuilder = Widget Function(BuildContext context);
typedef LoadMoreBuilder = Widget Function(BuildContext context);

class PaginationWidget<T> extends StatefulWidget {
  final PaginationFetcher<T> fetcher;
  final ItemBuilder<T> itemBuilder;
  final PaginationConfig config;
  final ErrorBuilder? errorBuilder;
  final EmptyBuilder? emptyBuilder;
  final LoadingBuilder? loadingBuilder;
  final LoadMoreBuilder? loadMoreBuilder;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollController? scrollController;
  final Widget? separator;
  final bool isGrid;
  final int? gridCrossAxisCount;
  final double? gridChildAspectRatio;
  final double? gridCrossAxisSpacing;
  final double? gridMainAxisSpacing;
  
  const PaginationWidget({
    Key? key,
    required this.fetcher,
    required this.itemBuilder,
    this.config = const PaginationConfig(),
    this.errorBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
    this.loadMoreBuilder,
    this.physics,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.scrollController,
    this.separator,
    this.isGrid = false,
    this.gridCrossAxisCount = 2,
    this.gridChildAspectRatio = 1.0,
    this.gridCrossAxisSpacing = 10,
    this.gridMainAxisSpacing = 10,
  }) : super(key: key);

  @override
  State<PaginationWidget<T>> createState() => _PaginationWidgetState<T>();
}

class _PaginationWidgetState<T> extends State<PaginationWidget<T>> {
  late ScrollController _scrollController;
  final List<T> _items = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _error;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.config.initialPage;
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchInitialData();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - widget.config.scrollThreshold) {
      if (!_isLoadingMore && _hasMore && _isInitialized) {
        _loadMore();
      }
    }
  }

  Future<void> _fetchInitialData() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await widget.fetcher(_currentPage, widget.config.pageSize);
      
      if (mounted) {
        setState(() {
          _items.clear();
          _items.addAll(response.data);
          _hasMore = response.hasMore;
          _isLoading = false;
          _isInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final response = await widget.fetcher(nextPage, widget.config.pageSize);
      
      if (mounted) {
        setState(() {
          _items.addAll(response.data);
          _currentPage = nextPage;
          _hasMore = response.hasMore;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load more: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _currentPage = widget.config.initialPage;
      _hasMore = true;
      _error = null;
    });
    await _fetchInitialData();
  }

  Widget _buildLoadingWidget() {
    if (widget.loadingBuilder != null) {
      return widget.loadingBuilder!(context);
    }
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder!(context, _error!, _refresh);
    }
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Error loading data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _error ?? 'Unknown error',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _refresh,
              icon: Icon(Icons.refresh),
              label: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    if (widget.emptyBuilder != null) {
      return widget.emptyBuilder!(context);
    }
    
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No data available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreWidget() {
    if (widget.loadMoreBuilder != null) {
      return widget.loadMoreBuilder!(context);
    }
    
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListView() {
    final itemCount = _items.length + (_isLoadingMore ? 1 : 0);
    
    if (widget.separator != null) {
      return ListView.separated(
        controller: _scrollController,
        physics: widget.physics,
        padding: widget.padding,
        scrollDirection: widget.scrollDirection,
        shrinkWrap: widget.shrinkWrap,
        itemCount: itemCount,
        separatorBuilder: (context, index) => widget.separator!,
        itemBuilder: (context, index) {
          if (index >= _items.length) {
            return _buildLoadMoreWidget();
          }
          return widget.itemBuilder(context, _items[index], index);
        },
      );
    }
    
    return ListView.builder(
      controller: _scrollController,
      physics: widget.physics,
      padding: widget.padding,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= _items.length) {
          return _buildLoadMoreWidget();
        }
        return widget.itemBuilder(context, _items[index], index);
      },
    );
  }

  Widget _buildGridView() {
    final itemCount = _items.length + (_isLoadingMore ? 1 : 0);
    
    return GridView.builder(
      controller: _scrollController,
      physics: widget.physics,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.gridCrossAxisCount!,
        childAspectRatio: widget.gridChildAspectRatio!,
        crossAxisSpacing: widget.gridCrossAxisSpacing!,
        mainAxisSpacing: widget.gridMainAxisSpacing!,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= _items.length) {
          return _buildLoadMoreWidget();
        }
        return widget.itemBuilder(context, _items[index], index);
      },
    );
  }

  Widget _buildContent() {
    if (_isLoading && !_isInitialized) {
      return _buildLoadingWidget();
    }
    
    if (_error != null && _items.isEmpty) {
      return _buildErrorWidget();
    }
    
    if (_items.isEmpty) {
      return _buildEmptyWidget();
    }
    
    final content = widget.isGrid ? _buildGridView() : _buildListView();
    
    if (widget.config.enablePullToRefresh) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: content,
      );
    }
    
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}