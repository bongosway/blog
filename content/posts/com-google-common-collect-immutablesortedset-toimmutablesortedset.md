---
title: "How to solve google toImmutableSet() NoSuchMethodError on a Maven project"
date: 2020-07-05T10:04:17+01:00
draft: true
toc: false
images:
tags:
  - maven, autoservice
---

## Introduction
Whilst building a demo application showcasing google 
[AutoService](https://github.com/google/auto/tree/master/service). 
Whilst searching through the internet I discoverd most solutions recommended upgrading the [Google Guava](https://github.com/google/guava) version, but upgrading the version did not resolve my problem.

In this guide, you will configure **AutoService** using `maven` to register the right implementation of types using META-INF metadata.

When you're finished, you'll be able to build jar files with the right 
`META-INF/services` information.

## Prerequisites

Before you begin this guide you'll need:

* Read up the difference between a maven dependency and plugin
    * This [Stackoverflow Post](https://stackoverflow.com/a/26293404) answer this question
    * Read Sonatype's book [Maven: A Complete Reference](https://books.sonatype.com/mvnref-book/reference/index.html) 

## Step 1 — Check what is in your dependency tree 

We need to establish what we have in our dependency tree, because maven might be pulling in a version of the jar as a transitive dependency which might not work with your project  

Run the following command to see the jar file in your tree:

```bash
$ mvn dependency:tree

```
if the below are missing then follow step 2;

`com.google.auto.service:auto-service:jar:<version>:compile`

`com.google.auto.service:auto-service-annotations:jar:<version>:compile`

## Step 2 — Add AutoService Annotation Dependency to POM file

Add the following compile-time dependency to your classpath so the project can compile

```xml
<dependencies>
  <dependency>
    <groupId>com.google.auto.service</groupId>
    <artifactId>auto-service-annotations</artifactId>
    <version>${auto-service.version}</version>
  </dependency>
</dependencies>
```
Run the below to ensure your project compiles:

```bash
$ mvn clean compile
```

Now run the package command to generate the jar file in your target directory

```bash
mvn clean package
```

Spy the content of the Jar file to view the generated `AutoService metadata`

```bash
$  jar tf target/<jar-filename>.jar | grep META-INF/services/
```

You should not get any results. 

Developers sometimes, forget to include the right metadata instructions when creating the  jar file and maven will not raise any error. 
This is the exact problem `Autoservice` solves for us, removing the need to tell maven of all your metadata rule. 

The next step will walk you through the process of adding the processor.

## Step 3 — Tell Maven to generate the Metadata

Add the following configuration to the compiler plugin

```xml
<plugins>
  <plugin>
    <artifactId>maven-compiler-plugin</artifactId>
    <configuration>
      <annotationProcessorPaths>
        <path>
          <groupId>com.google.auto.service</groupId>
          <artifactId>auto-service</artifactId>
          <version>${auto-service.version}</version>
        </path>
      </annotationProcessorPaths>
    </configuration>
  </plugin>
</plugins>
```
Now run the package again to generate the jar file in your target directory

```bash
mvn clean package
```

Spy the content of the Jar file again, to view the generated metadata

```bash
$  jar tf target/<jar-filename>.jar | grep META-INF/services/
```

Assuming our processor class is `org.ihq.MyAutoclass`, then the output should resemble below 

```
META-INF/services/
META-INF/services/org.ihq.MyAutoclass

```

## Conclusion
You’ve set up `Google AutoService` with `Maven` to autogenerate metadata without compile error(s).