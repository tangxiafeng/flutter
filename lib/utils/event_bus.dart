import 'dart:async';

class EventBus {

    static final EventBus _singleton = EventBus._init();
    StreamController _streamController;

    static EventBus getInstance() {
        return _singleton;
    }

    factory EventBus() {
        return _singleton;
    }

    EventBus._init() {
        _streamController = StreamController.broadcast();
    }

    StreamSubscription<T> register<T>(void onData(T event)) {
        if (T == dynamic) {
            return _streamController.stream.listen(onData);
        } else {
            Stream<T>stream = _streamController.stream
                .where((type) => type is T)
                .cast<T>();
            return stream.listen(onData);
        }
    }

    void post(event) {
        _streamController.add(event);
    }

    void unregister() {
        _streamController.close();
    }

}