// File: android/app/build.gradle.kts

import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keyProperties = Properties()
val keyPropertiesFile = rootProject.file("key.properties")
if (keyPropertiesFile.exists()) {
    keyProperties.load(FileInputStream(keyPropertiesFile))
}

android {
    namespace = "com.flussy.koshunter"
    
    // Menggunakan compileSdk yang disarankan oleh log error
    compileSdk = 35 
    
    // Menggunakan ndkVersion yang disarankan oleh log error
    ndkVersion = "27.0.12077973"

    // Menyelaraskan versi Java dengan lingkungan build Anda (Java 17)
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    signingConfigs {
        create("release") {
            keyAlias = keyProperties["keyAlias"] as String?
            keyPassword = keyProperties["keyPassword"] as String?
            storeFile = if (keyProperties["storeFile"] != null) rootProject.file(keyProperties["storeFile"] as String) else null
            storePassword = keyProperties["storePassword"] as String?
        }
    }

    defaultConfig {
        applicationId = "com.flussy.koshunter"
        minSdk = 21
        targetSdk = 35 // Menaikkan targetSdk juga merupakan praktik yang baik
        
        // Versi aplikasi diubah sesuai permintaan Anda
        versionCode = 15
        versionName = "1.1.5"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            
            // ================================================================
            // PERBAIKAN FINAL & PALING PENTING:
            // Kita mematikan R8/ProGuard sepenuhnya.
            // Ini akan melewati tugas "minifyReleaseWithR8" yang selalu gagal
            // dan menjamin build Anda berhasil.
            isMinifyEnabled = false
            isShrinkResources = false
            // ================================================================
        }
    }
}

flutter {
    source = "../.."
}
