class LevelItem{
  final String difficulty;
  final String level;
  final bool complete;

  LevelItem(this.difficulty, this.level, this.complete);

}

final easyItems = [
  new LevelItem("easy", "1", false),
  new LevelItem("easy", "2", false),
  new LevelItem("easy", "3", false),
  new LevelItem("easy", "4", false),
  new LevelItem("easy", "5", false),
  new LevelItem("easy", "6", false),
  new LevelItem("easy", "7", false),
  new LevelItem("easy", "8", false),
  new LevelItem("easy", "9", false)
];

final mediumItems = [
  new LevelItem("medium", "1", false),
  new LevelItem("medium", "2", false),
  new LevelItem("medium", "3", false),
  new LevelItem("medium", "4", false),
  new LevelItem("medium", "5", false),
  new LevelItem("medium", "6", false),
  new LevelItem("medium", "7", false),
  new LevelItem("medium", "8", false),
  new LevelItem("medium", "9", false)
];

final hardItems = [
  new LevelItem("hard", "1", false),
  new LevelItem("hard", "2", false),
  new LevelItem("hard", "3", false),
  new LevelItem("hard", "4", false),
  new LevelItem("hard", "5", false),
  new LevelItem("hard", "6", false),
  new LevelItem("hard", "7", false),
  new LevelItem("hard", "8", false),
  new LevelItem("hard", "9", false)
];

final category = [
  new LevelItem("easy", "1", false),
  new LevelItem("medium", "1", false),
  new LevelItem("hard", "1", false)
];