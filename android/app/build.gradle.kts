plugins {
    id("com.android.application")
    id("com.google.gms.google-services")  // FlutterFire
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")  // 必须放在 Android 和 Kotlin 插件之后
}

android {
    namespace = "com.example.afterschool_center"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"  // 注意 Kotlin DSL 语法

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.afterschool_center"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // 临时使用 debug 签名配置
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}


flutter {
    source = "../.."
}
