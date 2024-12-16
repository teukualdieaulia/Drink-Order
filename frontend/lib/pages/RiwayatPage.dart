import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../component/BottomNavigaton.dart';

// Custom theme colors
final customColors = {
  'background': const Color(0xFF1A1B25),
  'surface': const Color(0xFF242632),
  'primary': const Color(0xFF6B4EFF),
  'secondary': const Color(0xFF9747FF),
  'accent': const Color(0xFF00E1FF),
  'text': const Color(0xFFE1E1E1),
  'textSecondary': const Color(0xFFB0B0B0),
  'success': const Color(0xFF4CAF50),
  'warning': const Color(0xFFFF9800),
  'error': const Color(0xFFFF5252),
};

class Riwayatpage extends StatefulWidget {
  const Riwayatpage({super.key});

  @override
  State<Riwayatpage> createState() => _RiwayatpageState();
}

class _RiwayatpageState extends State<Riwayatpage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;
  String selectedFilter = 'All Time';
  double _rating = 0;

  // Sample transaction data with enhanced details
  final List<Map<String, dynamic>> transactions = [
    {
      'id': '1',
      'drinkName': 'Fresh Orange',
      'date': '2024-03-15 14:30',
      'price': 30000,
      'status': 'Completed',
      'image': 'Images/DrinkWater/Jus-1.png',
      'quantity': 2,
      'rating': 4.5,
      'hasReview': true,
      'paymentMethod': 'Credit Card',
      'orderNotes': 'Less ice please',
    },
    {
      'id': '2',
      'drinkName': 'Mango Splash',
      'date': '2024-03-14 16:45',
      'price': 35000,
      'status': 'Processing',
      'image': 'Images/DrinkWater/Jus-2.png',
      'quantity': 1,
      'rating': null,
      'hasReview': false,
      'paymentMethod': 'Digital Wallet',
      'orderNotes': 'Extra sweet',
    },
  ];

  final List<String> filters = [
    'All Time',
    'This Week',
    'This Month',
    'Last 3 Months'
  ];

  final List<String> statusFilters = [
    'All',
    'Completed',
    'Processing',
    'Cancelled'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: statusFilters.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: customColors['background'],
        primaryColor: customColors['primary'],
      ),
      child: Scaffold(
        bottomNavigationBar: const Bottomnavigation(currentIndex: 1),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _buildAppBar(),
            _buildFilters(),
            _buildTabBar(),
          ],
          body: _buildTransactionList(),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAnalyticsBottomSheet(),
          backgroundColor: customColors['primary'],
          icon: const Icon(Icons.analytics_outlined),
          label: const Text('Analytics'),
        ).animate().fadeIn().scale().slide(),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      floating: true,
      pinned: true,
      backgroundColor: customColors['background'],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                customColors['primary']!.withOpacity(0.2),
                customColors['background']!,
              ],
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order History",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn().slideX(),
            Text(
              "${transactions.length} orders",
              style: TextStyle(
                fontSize: 14,
                color: customColors['textSecondary'],
              ),
            )
                .animate()
                .fadeIn(delay: const Duration(milliseconds: 200))
                .slideX(),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchModal(),
        ).animate().fadeIn().scale(),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () => _showFilterBottomSheet(),
        ).animate().fadeIn().scale(),
      ],
    );
  }

  Widget _buildFilters() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            final isSelected = selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            customColors['primary']!,
                            customColors['secondary']!,
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : customColors['primary']!.withOpacity(0.3),
                  ),
                ),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() => selectedFilter = filter);
                  },
                  backgroundColor: Colors.transparent,
                  selectedColor: Colors.transparent,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? customColors['text']
                        : customColors['textSecondary'],
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn()
                .scale(delay: Duration(milliseconds: index * 100));
          },
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        child: Container(
          color: customColors['background'],
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: statusFilters.map((status) {
              return Tab(
                child: Row(
                  children: [
                    _getStatusIcon(status),
                    const SizedBox(width: 8),
                    Text(status),
                  ],
                ),
              );
            }).toList(),
            labelColor: customColors['text'],
            unselectedLabelColor: customColors['textSecondary'],
            indicatorColor: customColors['primary'],
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'All':
        return const Icon(Icons.list, size: 20);
      case 'Completed':
        return Icon(Icons.check_circle,
            size: 20, color: customColors['success']);
      case 'Processing':
        return Icon(Icons.access_time,
            size: 20, color: customColors['warning']);
      case 'Cancelled':
        return Icon(Icons.cancel, size: 20, color: customColors['error']);
      default:
        return const Icon(Icons.help, size: 20);
    }
  }

  Widget _buildTransactionList() {
    return TabBarView(
      controller: _tabController,
      children: statusFilters.map((status) {
        final filteredTransactions = status == 'All'
            ? transactions
            : transactions.where((t) => t['status'] == status).toList();

        return RefreshIndicator(
          onRefresh: _refreshTransactions,
          color: customColors['primary'],
          child: filteredTransactions.isEmpty
              ? _buildEmptyState(status)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = filteredTransactions[index];
                    return _buildTransactionCard(transaction, index);
                  },
                ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState(String status) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64,
            color: customColors['textSecondary'],
          ).animate().scale().fade(),
          const SizedBox(height: 16),
          Text(
            'No $status Orders',
            style: TextStyle(
              fontSize: 18,
              color: customColors['textSecondary'],
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slide(),
          const SizedBox(height: 8),
          Text(
            'Your $status orders will appear here',
            style: TextStyle(
              color: customColors['textSecondary'],
            ),
          ).animate().fadeIn().slide(),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction, int index) {
    Color statusColor;
    IconData statusIcon;

    switch (transaction['status']) {
      case 'Completed':
        statusColor = customColors['success']!;
        statusIcon = Icons.check_circle;
        break;
      case 'Processing':
        statusColor = customColors['warning']!;
        statusIcon = Icons.access_time;
        break;
      case 'Cancelled':
        statusColor = customColors['error']!;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = customColors['textSecondary']!;
        statusIcon = Icons.help;
    }

    return Card(
      color: customColors['surface'],
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: customColors['primary']!.withOpacity(0.1),
        ),
      ),
      child: InkWell(
        onTap: () => _showTransactionDetails(transaction),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'image-${transaction['id']}',
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: customColors['primary']!.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          transaction['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transaction['drinkName'],
                              style: TextStyle(
                                color: customColors['text'],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    statusIcon,
                                    size: 16,
                                    color: statusColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    transaction['status'],
                                    style: TextStyle(
                                      color: statusColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: customColors['textSecondary'],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              transaction['date'],
                              style: TextStyle(
                                color: customColors['textSecondary'],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              size: 16,
                              color: customColors['textSecondary'],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              transaction['paymentMethod'],
                              style: TextStyle(
                                color: customColors['textSecondary'],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: customColors['textSecondary'],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Rp ${(transaction['price'] * transaction['quantity']).toStringAsFixed(0)}',
                        style: TextStyle(
                          color: customColors['primary'],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (!transaction['hasReview'] &&
                      transaction['status'] == 'Completed')
                    ElevatedButton.icon(
                      onPressed: () => _showReviewDialog(transaction),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColors['primary'],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.rate_review, size: 18),
                      label: const Text('Review'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: index * 100)).slideX();
  }

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: customColors['background'],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                autofocus: true,
                style: TextStyle(color: customColors['text']),
                decoration: InputDecoration(
                  hintText: 'Search orders...',
                  hintStyle: TextStyle(color: customColors['textSecondary']),
                  prefixIcon:
                      Icon(Icons.search, color: customColors['primary']),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: customColors['primary']!),
                  ),
                  filled: true,
                  fillColor: customColors['surface'],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: transactions.length,
                itemBuilder: (context, index) => _buildTransactionCard(
                  transactions[index],
                  index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: customColors['background'],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: customColors['textSecondary']!.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter Orders',
                    style: TextStyle(
                      color: customColors['text'],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFilterSection('Date Range', filters),
                  const SizedBox(height: 16),
                  _buildFilterSection('Status', statusFilters),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: customColors['primary']!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: customColors['primary'],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: customColors['text'],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedFilter == option;
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => selectedFilter = option);
              },
              backgroundColor: customColors['surface'],
              selectedColor: customColors['primary'],
              labelStyle: TextStyle(
                color:
                    isSelected ? Colors.white : customColors['textSecondary'],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showAnalyticsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: customColors['background'],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: customColors['textSecondary']!.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Analytics',
                      style: TextStyle(
                        color: customColors['text'],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildAnalyticsCard(),
                    const SizedBox(height: 24),
                    _buildOrderChart(),
                    const SizedBox(height: 24),
                    _buildPopularItems(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            customColors['primary']!,
            customColors['secondary']!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: customColors['primary']!.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Orders',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '128',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnalyticsStat('Completed', '108'),
              _buildAnalyticsStat('Processing', '15'),
              _buildAnalyticsStat('Cancelled', '5'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: customColors['surface'],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Order Trend Chart',
          style: TextStyle(color: customColors['text']),
        ),
      ),
    );
  }

  Widget _buildPopularItems() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: customColors['surface'],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Items',
            style: TextStyle(
              color: customColors['text'],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    transaction['image'],
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  transaction['drinkName'],
                  style: TextStyle(color: customColors['text']),
                ),
                subtitle: Text(
                  'Ordered ${transaction['quantity']} times',
                  style: TextStyle(color: customColors['textSecondary']),
                ),
                trailing: Text(
                  'Rp ${transaction['price']}',
                  style: TextStyle(
                    color: customColors['primary'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _refreshTransactions() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isLoading = false);
  }

  void _showReviewDialog(Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: customColors['surface'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Rate Your Order',
          style: TextStyle(color: customColors['text']),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: customColors['background'],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      transaction['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction['drinkName'],
                          style: TextStyle(
                            color: customColors['text'],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Order #${transaction['id']}',
                          style: TextStyle(
                            color: customColors['textSecondary'],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() => _rating = index + 1);
                  },
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: index < _rating
                        ? Colors.amber
                        : customColors['textSecondary'],
                    size: 32,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              style: TextStyle(color: customColors['text']),
              decoration: InputDecoration(
                hintText: 'Write your review...',
                hintStyle: TextStyle(color: customColors['textSecondary']),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: customColors['background'],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: customColors['textSecondary']),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Submit review logic here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: customColors['primary'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Submit Review'),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: customColors['background'],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: customColors['textSecondary']!.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(
                        color: customColors['text'],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildOrderStatusTimeline(transaction),
                    const SizedBox(height: 24),
                    _buildOrderDetailsCard(transaction),
                    const SizedBox(height: 24),
                    _buildPaymentDetailsCard(transaction),
                    if (transaction['status'] == 'Completed')
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            _showReOrderConfirmation(transaction);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customColors['primary'],
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reorder'),
                        ),
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

  Widget _buildOrderStatusTimeline(Map<String, dynamic> transaction) {
    final statuses = ['Processing', 'Completed'];
    final currentStatusIndex = statuses.indexOf(transaction['status']);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: customColors['surface'],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List.generate(statuses.length * 2 - 1, (index) {
          if (index.isEven) {
            final statusIndex = index ~/ 2;
            final isCompleted = statusIndex <= currentStatusIndex;
            return Expanded(
              child: Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? customColors['success']
                          : customColors['textSecondary']!.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : Icons.circle,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    statuses[statusIndex],
                    style: TextStyle(
                      color: isCompleted
                          ? customColors['text']
                          : customColors['textSecondary'],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          } else {
            final isCompleted = (index ~/ 2) <= currentStatusIndex - 1;
            return Expanded(
              child: Container(
                height: 2,
                color: isCompleted
                    ? customColors['success']
                    : customColors['textSecondary']!.withOpacity(0.3),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildOrderDetailsCard(Map<String, dynamic> transaction) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: customColors['surface'],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              color: customColors['text'],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  transaction['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['drinkName'],
                      style: TextStyle(
                        color: customColors['text'],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Quantity: ${transaction['quantity']}',
                      style: TextStyle(
                        color: customColors['textSecondary'],
                      ),
                    ),
                    if (transaction['orderNotes'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Note: ${transaction['orderNotes']}',
                        style: TextStyle(
                          color: customColors['textSecondary'],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          _buildDetailRow('Subtotal',
              'Rp ${transaction['price'] * transaction['quantity']}'),
          _buildDetailRow('Delivery Fee', 'Rp 5000'),
          _buildDetailRow(
            'Total',
            'Rp ${(transaction['price'] * transaction['quantity'] + 5000)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard(Map<String, dynamic> transaction) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: customColors['surface'],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: TextStyle(
              color: customColors['text'],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Payment Method', transaction['paymentMethod']),
          _buildDetailRow('Order ID', '#${transaction['id']}'),
          _buildDetailRow('Order Date', transaction['date']),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: customColors['textSecondary'],
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? customColors['primary'] : customColors['text'],
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showReOrderConfirmation(Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: customColors['surface'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Reorder Confirmation',
          style: TextStyle(color: customColors['text']),
        ),
        content: Text(
          'Would you like to place the same order again?',
          style: TextStyle(color: customColors['textSecondary']),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: customColors['textSecondary']),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Reordered ${transaction['drinkName']}'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: customColors['success'],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: customColors['primary'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  // Tinggi minimum header
  double get minExtent => 48.0;

  @override
  // Tinggi maksimum header
  double get maxExtent => 48.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
