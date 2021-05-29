import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.5.0"
}

group = "com.exerro"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
}

tasks.withType<KotlinCompile> {
    kotlinOptions.jvmTarget = "1.8"
    kotlinOptions.freeCompilerArgs += "-Xinline-classes"
    kotlinOptions.freeCompilerArgs += "-language-version"
    kotlinOptions.freeCompilerArgs += "1.5"
}

apply { plugin("application") }

configure<ApplicationPluginConvention> {
    mainClassName = "com.exerro.%PROJECT_NAME%.MainKt"
}
