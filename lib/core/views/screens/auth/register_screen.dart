import 'package:bazar_flow/core/viewmodels/auth_vm.dart';
import 'package:bazar_flow/core/views/widgets/custom_button.dart';
import 'package:bazar_flow/core/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  AuthVM authVM = AuthVM();

  String userType = 'wholesale';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      bool created = await authVM.createUserAccount(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (created) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم انشاء الحساب بنجاح.")),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل في إنشاء الحساب. تأكد من البيانات أو جرب لاحقًا.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
SizedBox(height: 70,),


                  // Form Section with Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: theme.colorScheme.primary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Text(
                                'إنشاء حساب جديد',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // User Type Selection
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.outline.withOpacity(0.3),
                                  ),
                                  color: theme.colorScheme.surfaceVariant.withOpacity(0.05),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => setState(() => userType = 'wholesale'),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            color: userType == 'wholesale'
                                                ? theme.colorScheme.primary.withOpacity(0.1)
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.storefront,
                                                  color: userType == 'wholesale'
                                                      ? theme.colorScheme.primary
                                                      : theme.iconTheme.color
                                              ),
                                              const SizedBox(height: 4),
                                              Text('تاجر جملة',
                                                // لا نحدد style هنا
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => setState(() => userType = 'retail'),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            color: userType == 'retail'
                                                ? theme.colorScheme.primary.withOpacity(0.1)
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.shopping_bag,
                                                  color: userType == 'retail'
                                                      ? theme.colorScheme.primary
                                                      : theme.iconTheme.color),
                                              const SizedBox(height: 4),
                                              Text('تاجر تجزئة',
                                                // لا نحدد style هنا
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Form Fields
                              CustomFormField(
                                hint: 'الاسم الكامل',
                                icon: Icons.person_outline,
                                controller: nameController,
                                validator: (value) => value == null || value.isEmpty ? 'يرجى إدخال الاسم' : null,
                              ),
                              const SizedBox(height: 8),
                              CustomFormField(
                                hint: 'البريد الإلكتروني',
                                icon: Icons.email_outlined,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'يرجى إدخال البريد';
                                  if (!value.contains('@')) return 'بريد إلكتروني غير صالح';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 8),
                              CustomFormField(
                                hint: 'كلمة المرور',
                                icon: Icons.lock_outlined,
                                controller: passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'يرجى إدخال كلمة المرور';
                                  if (value.length < 6) return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Register Button
                              CustomButton(
                                text: 'إنشاء الحساب',
                                onPressed: register,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Login Link
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('هل لديك حساب؟'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text('تسجيل الدخول',
                            // بدون style
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
