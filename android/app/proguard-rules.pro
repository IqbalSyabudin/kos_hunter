# Aturan umum untuk Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Aturan untuk menjaga anotasi
-keepattributes Signature
-keepattributes *Annotation*

# ATURAN PENTING UNTUK ERROR "Missing classes"
-keep class com.google.android.play.core.** { *; }

# Aturan untuk Supabase dan semua library di dalamnya
-keep class io.supabase.** { *; }
-keep class io.gotrue.** { *; }
-keep class io.postgrest.** { *; }
-keep class io.realtime.** { *; }
-keep class io.storage.** { *; }

# Aturan untuk library jaringan yang digunakan (OkHttp, dll.)
-keepnames class okhttp3.** { *; }
-keepnames interface okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# Aturan untuk menjaga model data Anda
-keep class com.flussy.koshunter.models.** { *; }