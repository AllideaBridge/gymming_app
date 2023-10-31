class ReasonContent{
  String _title;
  String _subtitle;
  List<String> _reasons;

  ReasonContent(this._title, this._subtitle, this._reasons);

  List<String> get reasons => _reasons;

  String get subtitle => _subtitle;

  String get title => _title;
}