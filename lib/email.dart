class Email {
  int id;
  String title;
  String description;
  String time;
  bool favorite;

  Email({this.id,this.title, this.description, this.time, this.favorite = false}){
  }

  toggleFavorite(){
    favorite = !favorite;
  }
}