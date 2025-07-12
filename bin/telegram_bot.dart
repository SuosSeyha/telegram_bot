import 'package:telegram_bot/config/config.dart';
import 'package:telegram_bot/service/service.dart';
import 'package:televerse/televerse.dart';

void main(List<String> arguments) async {
  // Start the bot
  bot.command('start', (context) {
    context.reply('Hello! Welcome to the Coffee Shop Bot!☕️');
  });
  // Handle the /help command
  bot.command('order', (context) {
    final keyboard =
        Keyboard().addText('Hot Coffee').addText('Ice Coffee').oneTime();
    context.reply(
      'We have drinks like\n1.Hot Coffee\n2.Ice Coffee.\n\nWhich one would you like?',
      replyMarkup: keyboard,
    );
  });

  bot.help((context) {
    context.reply('1. Start bot -> /start\n2. Order Coffee -> /order');
  });

  // Handle Hot Coffee selection
  bot.text('Hot Coffee', (context) async {
    context.reply('You have selected Hot Coffee.');

    final listCoffee = await fetchCoffeeMenu(type: 'hot');

    if (listCoffee.isEmpty) {
      context.reply('No hot coffees available at the moment.');
      return;
    }

    var coffeeBoardHot = InlineKeyboard();
    for (var coffee in listCoffee) {
      print('Coffee: ${coffee.title}, ID: ${coffee.id}');
      coffeeBoardHot.add(coffee.title, 'iced-${coffee.id}');
      coffeeBoardHot.row();
    }

    await context.reply(
      'Here are the available hot coffees:',
      replyMarkup: coffeeBoardHot,
    );
  });

  // This is the section for Ice Coffee
  bot.text('Ice Coffee', (context) async {
    context.reply('You have selected Ice Coffee.');
    final listCoffee = await fetchCoffeeMenu(type: 'iced');
    if (listCoffee.isEmpty) {
      context.reply('No hot coffees available at the moment.');
      return;
    }
    final coffeeBoardIced = InlineKeyboard();

    coffeeBoardIced.row();
    for (var coffee in listCoffee) {
      print('Coffee: ${coffee.title}, ID: ${coffee.id}');
      coffeeBoardIced.add(coffee.title, 'iced-${coffee.id}');
    }
    await context.reply(
      'Here are the available ice coffees:',
      replyMarkup: coffeeBoardIced,
    );
  });
  bot.chatMember((ctx) {
    final userName = ctx.from?.firstName;

    if (userName!.isEmpty) {
      ctx.reply("👋 Welcome, $userName!");
    }
  });

  // check error
  bot.onError((e) {
    print("********Catch error: $e");
  });

  // bot.onCallbackQuery((item) async {
  //   print('=======> Hello Callback Query <=======');
  //   final element = item.callbackQuery?.data?.split('-');

  //   if (element == null) return;

  //   final type = element[0];
  //   final id = int.tryParse(element[1] ?? '');
  //   print('Type: $type, ID: $id');
  //   final coffee = await fetchCoffeeMenuById(type: type, id: id!);
  //   await item.replyWithPhoto(
  //     InputFile.fromUrl(coffee.image!),
  //     caption:
  //         '${coffee.title}\n\n${coffee.description}\n\nIngredients: ${coffee.ingredients?.join(', ')}',
  //   );
  // });

  await bot.start();
}
