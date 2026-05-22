import 'package:flutter/material.dart';
import '../models/placement.dart';

class EditScreen extends StatefulWidget {
  final Placement placement;
  final Function(Placement) onEdit;
  final VoidCallback onSuccess;

  const EditScreen({
    super.key,
    required this.placement,
    required this.onEdit,
    required this.onSuccess,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _roleController;
  late TextEditingController _cityController;
  late TextEditingController _dateController;
  late TextEditingController _packageController;

  @override
  void initState() {
    super.initState();
    _roleController = TextEditingController(text: widget.placement.role);
    _cityController = TextEditingController(text: widget.placement.city);
    _dateController = TextEditingController(text: widget.placement.date);
    _packageController = TextEditingController(text: widget.placement.package);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onEdit(Placement(
        id: widget.placement.id,
        company: widget.placement.company, // Keep original company name
        role: _roleController.text.trim(),
        city: _cityController.text.trim(),
        date: _dateController.text.trim(),
        package: _packageController.text.trim(),
      ));
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Placement updated successfully!'), backgroundColor: Colors.blue),
      );
      
      widget.onSuccess();
    }
  }

  @override
  void dispose() {
    _roleController.dispose();
    _cityController.dispose();
    _dateController.dispose();
    _packageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Edit Placement',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1565C0),
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Company: ${widget.placement.company}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _buildTextField(_roleController, 'Role (e.g., Software Engineer)', Icons.work_outline),
              const SizedBox(height: 20),
              _buildTextField(_cityController, 'City', Icons.location_on_outlined),
              const SizedBox(height: 20),
              _buildTextField(_dateController, 'Date (e.g., Jun 15)', Icons.calendar_today_outlined),
              const SizedBox(height: 20),
              _buildTextField(_packageController, 'Package (e.g., 20 LPA)', Icons.monetization_on_outlined),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1565C0), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter this field';
        }
        return null;
      },
    );
  }
}
