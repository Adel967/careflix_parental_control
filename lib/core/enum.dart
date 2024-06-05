enum Gender { Male, Female }

Gender stringToGender(String gender) {
  switch (gender) {
    case "M":
      return Gender.Male;
    case "F":
      return Gender.Female;
    default:
      return Gender.Male;
  }
}

String genderToString(Gender gender) {
  switch (gender) {
    case Gender.Male:
      return "M";
    case Gender.Female:
      return "F";
    default:
      return "M";
  }
}

enum ShowType { TV_SHOW, MOVIE }

ShowType stringToShowType(String showType) {
  switch (showType) {
    case "series":
      return ShowType.TV_SHOW;
    case "movie":
      return ShowType.MOVIE;
    default:
      return ShowType.MOVIE;
  }
}

enum ShowLan { ENGLISH, ARABIC, ANIME }

ShowLan stringToShowLan(String showLan) {
  switch (showLan) {
    case "en":
      return ShowLan.ENGLISH;
    case "ar":
      return ShowLan.ARABIC;
    case "anime":
      return ShowLan.ANIME;
    default:
      return ShowLan.ENGLISH;
  }
}

enum WeekDay { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

extension WeekDayExtension on WeekDay {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

WeekDay fromString(String day) {
  return WeekDay.values
      .firstWhere((e) => e.toShortString().toLowerCase() == day.toLowerCase());
}

List<WeekDay> getWeekDaysList() {
  return WeekDay.values.map((e) => e).toList();
}
