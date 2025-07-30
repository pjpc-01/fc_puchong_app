// android/build.gradle.kts
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0") // 使用最新稳定版
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
        classpath("com.google.gms:google-services:4.4.0") // 如果使用Firebase
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    // 可选：统一配置所有子项目的构建目录
    afterEvaluate {
        if (project.hasProperty("android")) {
            project.extensions.configure<com.android.build.gradle.BaseExtension> {
                buildDir = rootProject.layout.buildDirectory.dir("build/${project.name}").get().asFile
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}