import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:file/src/interface/directory.dart';
import 'package:file/src/interface/file.dart';
import 'package:file/src/interface/file_system.dart';
import 'package:file/src/interface/file_system_entity.dart';
import 'package:path/path.dart' as pathlib;

/// The flutter_cache_manager does not expose the necessary classes needed for their
/// special File implementation, which is required for mocking in unit testing.
class DelegateFile implements File {
  final io.File originalFile;

  const DelegateFile({required this.originalFile});

  @override
  File get absolute => originalFile.absolute as File;

  @override
  Future<File> copy(String newPath) {
    return originalFile.copy(newPath) as Future<File>;
  }

  @override
  File copySync(String newPath) {
    return originalFile.copySync(newPath) as File;
  }

  @override
  Future<File> create({bool recursive = false}) {
    return originalFile.create(recursive: recursive) as Future<File>;
  }

  @override
  void createSync({bool recursive = false}) {
    originalFile.createSync(recursive: recursive);
  }

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) {
    return originalFile.delete(recursive: recursive) as Future<FileSystemEntity>;
  }

  @override
  void deleteSync({bool recursive = false}) {
    originalFile.deleteSync(recursive: recursive);
  }

  @override
  Future<bool> exists() {
    return originalFile.exists();
  }

  @override
  bool existsSync() {
    return originalFile.existsSync();
  }

  @override
  bool get isAbsolute => originalFile.isAbsolute;

  @override
  Future<DateTime> lastAccessed() {
    return originalFile.lastAccessed();
  }

  @override
  DateTime lastAccessedSync() {
    return originalFile.lastAccessedSync();
  }

  @override
  Future<DateTime> lastModified() {
    return originalFile.lastModified();
  }

  @override
  DateTime lastModifiedSync() {
    return originalFile.lastAccessedSync();
  }

  @override
  Future<int> length() {
    return originalFile.length();
  }

  @override
  int lengthSync() {
    return originalFile.lengthSync();
  }

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) {
    return originalFile.open(mode: mode);
  }

  @override
  Stream<List<int>> openRead([int? start, int? end]) {
    return originalFile.openRead(start, end);
  }

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) {
    return originalFile.openSync(mode: mode);
  }

  @override
  IOSink openWrite({FileMode mode = FileMode.write, Encoding encoding = utf8}) {
    return originalFile.openWrite(mode: mode, encoding: encoding);
  }

  @override
  Directory get parent => originalFile.parent as Directory;

  @override
  String get path => originalFile.path;

  @override
  Future<Uint8List> readAsBytes() {
    return originalFile.readAsBytes();
  }

  @override
  Uint8List readAsBytesSync() {
    return originalFile.readAsBytesSync();
  }

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) {
    return originalFile.readAsLines(encoding: encoding);
  }

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) {
    return originalFile.readAsLinesSync(encoding: encoding);
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) {
    return originalFile.readAsString(encoding: encoding);
  }

  @override
  String readAsStringSync({Encoding encoding = utf8}) {
    return originalFile.readAsStringSync(encoding: encoding);
  }

  @override
  Future<File> rename(String newPath) {
    return originalFile.rename(newPath) as Future<File>;
  }

  @override
  File renameSync(String newPath) {
    return originalFile.renameSync(newPath) as File;
  }

  @override
  Future<String> resolveSymbolicLinks() {
    return originalFile.resolveSymbolicLinks();
  }

  @override
  String resolveSymbolicLinksSync() {
    return originalFile.resolveSymbolicLinksSync();
  }

  @override
  Future setLastAccessed(DateTime time) {
    return originalFile.setLastAccessed(time);
  }

  @override
  void setLastAccessedSync(DateTime time) {
    originalFile.setLastAccessedSync(time);
  }

  @override
  Future setLastModified(DateTime time) {
    return originalFile.setLastModified(time);
  }

  @override
  void setLastModifiedSync(DateTime time) {
    return originalFile.setLastModifiedSync(time);
  }

  @override
  Future<FileStat> stat() {
    return originalFile.stat();
  }

  @override
  FileStat statSync() {
    return originalFile.statSync();
  }

  @override
  Uri get uri => originalFile.uri;

  @override
  Stream<FileSystemEvent> watch({int events = FileSystemEvent.all, bool recursive = false}) {
    return originalFile.watch(events: events, recursive: recursive);
  }

  @override
  Future<File> writeAsBytes(List<int> bytes, {FileMode mode = FileMode.write, bool flush = false}) {
    return originalFile.writeAsBytes(bytes, mode: mode, flush: flush) as Future<File>;
  }

  @override
  void writeAsBytesSync(List<int> bytes, {FileMode mode = FileMode.write, bool flush = false}) {
    return originalFile.writeAsBytesSync(bytes, mode: mode, flush: flush);
  }

  @override
  Future<File> writeAsString(String contents,
      {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) {
    return originalFile.writeAsString(contents, mode: mode, encoding: encoding, flush: flush) as Future<File>;
  }

  @override
  void writeAsStringSync(String contents,
      {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) {
    return originalFile.writeAsStringSync(contents, mode: mode, encoding: encoding, flush: flush);
  }

  @override
  String get basename => pathlib.basename(originalFile.path);

  @override
  String get dirname => pathlib.dirname(originalFile.path);

  @override
  FileSystem get fileSystem => throw UnimplementedError();
}
