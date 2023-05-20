import 'package:flutter/material.dart';
import 'package:minesweeper/ui/theme/colors.dart';
import 'package:minesweeper/utils/game_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MineSweeperGame game = MineSweeperGame();

  @override
  void initState() {
    super.initState();
    game.generateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Сапер'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: AppColor.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.flag,
                        color: AppColor.accentColor,
                        size: 34.0,
                      ),
                      const Text(
                        '999',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: AppColor.lightPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.timer,
                        color: AppColor.accentColor,
                        size: 34.0,
                      ),
                      const Text(
                        '11:11',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 500.0,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MineSweeperGame.row,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: MineSweeperGame.cells,
              itemBuilder: (BuildContext context, index) {
                Color cellColor = game.gameMap[index].reveal
                    ? AppColor.clickedColor
                    : AppColor.lightPrimaryColor;
                return GestureDetector(
                  onTap: game.gameOver
                      ? null
                      : () {
                          setState(() {
                            game.getClickedCell(game.gameMap[index]);
                          });
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        game.gameMap[index].reveal
                            ? "${game.gameMap[index].content}"
                            : "",
                        style: TextStyle(
                            color: game.gameMap[index].reveal
                                ? game.gameMap[index].content == 'X'
                                    ? Colors.red
                                    : AppColor.letterColors[
                                        game.gameMap[index].content]
                                : Colors.transparent,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Text(
            game.gameOver ? 'Проиграл' : '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          RawMaterialButton(

            onPressed: () {
              setState(() {
                game.resetGame();
                game.gameOver = false;
              });
            },
            fillColor: AppColor.lightPrimaryColor,
            elevation: 0.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 64.0, vertical: 24.0),
            shape: const StadiumBorder(),
            child: const Text(
              'играть заново',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
