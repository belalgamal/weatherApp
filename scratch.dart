import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2result = await task2();
  task3(task2result);
  task4();
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  Duration threeSecond = Duration(seconds: 5);
  // sleep(threeSecond);
  String result;
  await Future.delayed(threeSecond, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2data');
}

void task4() {
  print('Task 4 complete');
}

// import 'dart:io';
//
// Future<void> printOrderMessage() async {
//   print('Awaiting user order...');
//
//   var order = await fetchUserOrder();
//   // Duration threeSecond = Duration(seconds: 13);
//   // sleep(threeSecond);
//   print('Your order is: $order');
// }
//
// Future<String> fetchUserOrder() {
//   // Imagine that this function is more complex and slow.
//   return Future.delayed(Duration(seconds: 3), () => 'Large Latte');
// }
//
// Future<void> main() async {
//   countSeconds(4);
//   printOrderMessage();
//   print('11110');
// }
//
// // You can ignore this function - it's here to visualize delay time in this example.
// void countSeconds(int s) async {
//   for (var i = 1; i <= s; i++) {
//     Future.delayed(Duration(seconds: i), () => print(i));
//   }
// }
