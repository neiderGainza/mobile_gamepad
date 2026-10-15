import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties().apply {
    if (keystorePropertiesFile.exists()) {
        keystorePropertiesFile.inputStream().use(::load)
    }
}

val requiredSigningProperties = listOf("keyAlias", "keyPassword", "storeFile", "storePassword")
val hasReleaseSigning = keystorePropertiesFile.exists() &&
    requiredSigningProperties.all { !keystoreProperties.getProperty(it).isNullOrBlank() }

android {
    namespace = "io.neiderGainza.mobileGamepad"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "io.neiderGainza.mobileGamepad"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = rootProject.file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName(if (hasReleaseSigning) "release" else "debug")
        }
    }
}

val verifyReleaseSigning = tasks.register("verifyReleaseSigning") {
    doLast {
        check(hasReleaseSigning) {
            "Missing or incomplete android/key.properties. Configure the upload keystore before building a release."
        }
    }
}

tasks.configureEach {
    if (name.endsWith("Release")) {
        dependsOn(verifyReleaseSigning)
    }
}

flutter {
    source = "../.."
}
