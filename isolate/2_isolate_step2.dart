#import('dart:isolate');

main() {
  var name = "main";
  print("$name : start");
  // timer1 runs in an new isolate with its own heap
  SendPort sender1 = spawnFunction(timer1);
  sender1.call("Start !").then((msg) => print("main : $msg"));
  
  // if main isolate terminates, the entire VM terminates
  timer2();
  print("$name : end");
}

timer1() {
  String name = "First timer";
  port.receive((msg, reply) {
    print("$name : $msg");
    new Timer.repeating(1000, (t) {
       tick(name);
       reply.send("$name : $counter");
    });
  });
}

timer2() {
  var name = "Second timer";
  new Timer.repeating(3000, (t) => tick(name));
}

int counter = 0;
tick(String name) {
  print("$name : ${counter++}");
}