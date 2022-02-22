// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

class Jobcreated {
  Jobcreated(
      {this.time,
      this.jobid,
      this.audiopath,
      this.videopath,
      this.filepath,
      this.note,
      this.id});
  int? id;
  String? time;
  String? jobid;
  String? audiopath;
  String? videopath;
  String? filepath;
  String? note;

  factory Jobcreated.fromMap(Map<String, dynamic> json) => Jobcreated(
        id: json["id"],
        time: json["time"],
        jobid: json["jobid"],
        audiopath: json["audiopath"],
        videopath: json["videopath"],
        filepath: json["filepath"],
        note: json["note"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "time": time,
        "jobid": jobid,
        "audiopath": audiopath,
        "videopath": videopath,
        "filepath": filepath,
        "note": note,
      };
}
