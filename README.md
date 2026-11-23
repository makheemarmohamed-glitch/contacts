# Route Contacts App (Flutter)

تطبيق جهات اتصال "Route" مبني بـ Flutter حسب التصميم المرفق (Splash → Home → Bottom Sheet).

## الشاشات (مطابقة للتصميم)
1. **Splash Screen** — خلفية كحلية `#29384D` مع شعار Route (من ملف التصميم الأصلي).
2. **Home Screen** — شبكة (2 أعمدة) من كروت جهات الاتصال: صورة + شريط اسم كريمي، بريد وهاتف، وزر Delete أحمر `#F93A3A` + زر FAB عائم للإضافة. حالة فارغة: "There is No Contacts Added Here".
3. **Bottom Sheet (Enter User)** — كارت معاينة (صورة + اسم/بريد/هاتف يتحدثان مباشرة مع الكتابة)، حقل اختيار صورة من المعرض، ثلاثة حقول بإطار كريمي، وزر "Enter user".

## الوظائف
- إضافة جهة اتصال (اسم + بريد + هاتف + صورة من المعرض عبر `image_picker`) مع تحقق من صحة الإدخال.
- حذف جهة اتصال بزر Delete.
- حفظ جهات الاتصال محليًا بعد إغلاق التطبيق عبر `shared_preferences`.

## التشغيل
```bash
flutter pub get
flutter run
```

## البنية
```
lib/
  main.dart                     # نقطة البداية والثيم
  core/app_colors.dart          # ألوان التصميم
  models/contact.dart           # موديل جهة الاتصال
  screens/splash_screen.dart    # شاشة البداية (3 ثوان)
  screens/home_screen.dart      # الشبكة + الحالة الفارغة + الحفظ
  widgets/contact_card.dart     # كارت جهة الاتصال
  widgets/add_contact_sheet.dart# نموذج الإضافة السفلي
assets/images/logo.png          # الشعار المستخرج من التصميم
```

ملاحظة: لا يوجد Flutter SDK في هذه البيئة، لذا الكود لم يُشغَّل هنا — الصق المشروع في بيئة بها Flutter ونفّذ `flutter pub get` ثم `flutter run`.
