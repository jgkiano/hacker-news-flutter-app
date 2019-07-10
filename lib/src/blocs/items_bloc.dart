import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item.dart';

class ItemsBloc {
  final _repository = Repository();
  final _itemsOutput = BehaviorSubject<List<Item>>();
  final _currentTopic = BehaviorSubject<String>();
  final _fetchingMoreItems = BehaviorSubject<bool>();
  final _fetchingMoreItemsOutput = BehaviorSubject<bool>();
  DocumentSnapshot _lastDocument;

  ItemsBloc() {
    _fetchingMoreItems
        .transform(new ThrottleStreamTransformer(
            (value) => TimerStream(value, const Duration(seconds: 1))))
        .listen(_fetchMoreItems);
    _currentTopic.listen(_onCurrentTopicChange);
    _currentTopic.sink.add("Stories");
  }

  Observable<List<Item>> get items => _itemsOutput.stream;
  Observable<String> get topic => _currentTopic.stream;
  Observable<bool> get isFetchingMoreItems => _fetchingMoreItemsOutput.stream;
  Function(String) get changeTopic => _currentTopic.sink.add;
  Function get fetchMoreItems => () => _fetchingMoreItems.add(true);
  Function get retryFetchItems =>
      () => _currentTopic.sink.add(_currentTopic.value);

  void _fetchMoreItems(bool value) async {
    try {
      if (value != true || _fetchingMoreItemsOutput.value == true) return;
      _fetchingMoreItemsOutput.sink.add(true);
      final String collection = _currentTopic.value.toLowerCase();
      final documents =
          await _repository.fetchItems(collection, startAfter: _lastDocument);
      final List<Item> items = documents.map((doc) {
        final item = new Item.fromDocumentSnapshot(doc);
        return item;
      }).toList();
      _itemsOutput.sink.add([..._itemsOutput.value, ...items]);
      _lastDocument = documents[documents.length - 1];
    } on RangeError catch (rangeError) {
      // TODO: handle no data message
    } catch (e) {
      // TODO: handle error
    } finally {
      _fetchingMoreItemsOutput.sink.add(false);
    }
  }

  _onCurrentTopicChange(String topic) async {
    try {
      _itemsOutput.sink.add(null);
      final String collection = topic.toLowerCase();
      final Map<String, dynamic> records = await _fetchItems(collection);
      final List<Item> items = records["items"];
      _lastDocument = records["lastDocument"];
      _itemsOutput.sink.add(items);
    } catch (error) {
      print(error);
      _itemsOutput.sink.addError(error);
    }
  }

  Future<Map<String, dynamic>> _fetchItems(collection) async {
    try {
      final documents = await _repository.fetchItems(collection);
      final List<Item> items = documents.map((doc) {
        final item = new Item.fromDocumentSnapshot(doc);
        return item;
      }).toList();
      return {"items": items, "lastDocument": documents[documents.length - 1]};
    } catch (e) {
      throw e;
    }
  }

  Future<void> refreshItems() async {
    try {
      final Map<String, dynamic> records =
          await _fetchItems(_currentTopic.value.toLowerCase());
      final List<Item> items = records["items"];
      _lastDocument = records["lastDocument"];
      _itemsOutput.sink.add(items);
    } catch (e) {
      print(e);
    }
  }

  dispose() {
    _itemsOutput.close();
    _currentTopic.close();
    _fetchingMoreItems.close();
    _fetchingMoreItemsOutput.close();
  }
}
