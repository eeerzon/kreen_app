# --- Flutter Default Keep Rules ---
# Keep all Flutter-related classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# --- Keep rules untuk ImageIO ---
-keep class javax.imageio.** { *; }
-keep class com.github.jaiimageio.** { *; }

-dontwarn javax.imageio.**
-dontwarn com.github.jaiimageio.**

# Keep annotations
-keepattributes *Annotation*

# Optional tambahan
-keep class androidx.lifecycle.DefaultLifecycleObserver
-keep class androidx.lifecycle.ReportFragment
-keep class *.g.dart { *; }
-keep class *.model.* { *; }


# JSON / reflection
-keep class * extends java.lang.Object {
    <fields>;
}

# dio & http parser
-keep class com.fasterxml.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
