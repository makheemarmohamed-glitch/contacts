import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_colors.dart';
import '../models/contact.dart';
import '../widgets/add_contact_sheet.dart';
import '../widgets/contact_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _storageKey = 'route_contacts';

  List<Contact> _contacts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (!mounted) return;
    setState(() {
      _contacts = raw == null
          ? []
          : (jsonDecode(raw) as List)
              .map((e) => Contact.fromJson(e as Map<String, dynamic>))
              .toList();
      _loading = false;
    });
  }

  Future<void> _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(_contacts.map((c) => c.toJson()).toList()),
    );
  }

  void _openAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddContactSheet(
        onAdd: (contact) {
          setState(() => _contacts.add(contact));
          _saveContacts();
        },
      ),
    );
  }

  void _deleteContact(Contact contact) {
    setState(() => _contacts.removeWhere((c) => c.id == contact.id));
    _saveContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Image.asset('assets/images/logo.png',
                  width: 110, fit: BoxFit.contain),
              const SizedBox(height: 24),
              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.secondary))
                    : _contacts.isEmpty
                        ? const _EmptyState()
                        : GridView.builder(
                            padding: const EdgeInsets.only(bottom: 90),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.62,
                            ),
                            itemCount: _contacts.length,
                            itemBuilder: (context, index) => ContactCard(
                              contact: _contacts[index],
                              onDelete: () => _deleteContact(_contacts[index]),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.primary,
        shape: const CircleBorder(),
        onPressed: _openAddSheet,
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Simple empty-state illustration matching the design
          SizedBox(
            width: 180,
            height: 120,
            child: Stack(
              children: [
                Positioned(
                  top: 40,
                  left: 0,
                  child: _block(36, AppColors.secondarySoft),
                ),
                Positioned(
                  top: 44,
                  left: 44,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bar(70, 12),
                      const SizedBox(height: 8),
                      _bar(90, 12),
                    ],
                  ),
                ),
                Positioned(
                  top: 86,
                  left: 10,
                  child: _block(30, AppColors.secondary),
                ),
                Positioned(
                  top: 88,
                  left: 48,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bar(80, 12),
                      const SizedBox(height: 8),
                      _bar(100, 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'There is No Contacts Added Here',
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _block(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      );

  Widget _bar(double width, double height) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.secondarySoft,
          borderRadius: BorderRadius.circular(6),
        ),
      );
}
